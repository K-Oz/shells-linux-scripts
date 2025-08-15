#!/bin/bash
# Script to generate templates for Shells image configurations
# This script reads from official_images.txt and creates template files for each configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
OFFICIAL_IMAGES="$SCRIPT_DIR/official_images.txt"

# Ensure templates directory exists
mkdir -p "$TEMPLATES_DIR"

# Function to extract distribution info from image name
extract_distro_info() {
    local image_name="$1"
    local distro=$(echo "$image_name" | cut -d'-' -f1)
    local version=$(echo "$image_name" | cut -d'-' -f2)
    local variant=$(echo "$image_name" | cut -d'-' -f3-)
    
    echo "$distro:$version:$variant"
}

# Function to create template for a specific image configuration
create_template() {
    local image_name="$1"
    local distro_info=$(extract_distro_info "$image_name")
    local distro=$(echo "$distro_info" | cut -d':' -f1)
    local version=$(echo "$distro_info" | cut -d':' -f2)
    local variant=$(echo "$distro_info" | cut -d':' -f3)
    
    # Create distro-specific directory
    local distro_dir="$TEMPLATES_DIR/$distro"
    mkdir -p "$distro_dir"
    
    # Template file path
    local template_file="$distro_dir/${image_name}.md"
    
    # Determine if it's a desktop or server image
    local image_type="server"
    if [[ "$variant" == *"desktop"* ]]; then
        image_type="desktop"
    fi
    
    # Create template content
    cat > "$template_file" << EOF
# $image_name Configuration Template

## Image Details
- **Distribution:** $distro
- **Version:** $version
- **Variant:** $variant
- **Type:** $image_type
- **Full Name:** $image_name

## Build Command
\`\`\`bash
./build_image.sh $image_name
\`\`\`

## Description
This configuration builds a $distro $version system with $variant.

EOF

    # Add type-specific information
    if [[ "$image_type" == "desktop" ]]; then
        cat >> "$template_file" << EOF
## Desktop Environment Features
- GUI desktop environment
- Pre-configured for Shells infrastructure
- Optimized for remote desktop access
- Includes necessary graphics drivers

## Requirements
- Spice-vdagent for enhanced graphics
- QXL graphics driver support
- Audio support configured
- Screen locking disabled
- Power management disabled

EOF
    else
        cat >> "$template_file" << EOF
## Server Features
- Command-line interface
- Minimal resource footprint
- SSH access configured
- Essential server tools included

## Requirements
- SSH server enabled
- Network configuration ready
- Basic system utilities

EOF
    fi

    # Add common configuration information
    cat >> "$template_file" << EOF
## Common Configuration
- Passwordless sudo enabled
- Auto-login configured
- QEMU guest agent installed
- Latest system updates applied
- Shells helper tools included

## Testing
Test the built image with:
\`\`\`bash
./test-linux.sh $image_name-\$(date +%Y%m%d).qcow2
\`\`\`

## Related Files
- Configuration script: \`oscfg/$distro.sh\`
- Base scripts: \`scripts/\`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
EOF

    echo "Created template: $template_file"
}

# Main execution
echo "Generating templates for Shells image configurations..."

# Check if official_images.txt exists
if [[ ! -f "$OFFICIAL_IMAGES" ]]; then
    echo "Error: $OFFICIAL_IMAGES not found!"
    exit 1
fi

# Create README for templates directory
cat > "$TEMPLATES_DIR/README.md" << EOF
# Shells Image Configuration Templates

This directory contains template documentation for all supported Shells image configurations.

## Directory Structure
- Each distribution has its own subdirectory
- Template files are named after their configuration (e.g., \`ubuntu-focal-ubuntu-desktop.md\`)

## Available Distributions
EOF

# Read official_images.txt and process each image
while IFS= read -r image_name || [[ -n "$image_name" ]]; do
    # Skip empty lines and comments
    [[ -z "$image_name" || "$image_name" =~ ^[[:space:]]*# ]] && continue
    
    # Create template for this image
    create_template "$image_name"
done < "$OFFICIAL_IMAGES"

# Update README with available distributions
distributions=$(find "$TEMPLATES_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | uniq)
for distro in $distributions; do
    echo "- **$distro**: $(find "$TEMPLATES_DIR/$distro" -name "*.md" | wc -l) configurations" >> "$TEMPLATES_DIR/README.md"
done

cat >> "$TEMPLATES_DIR/README.md" << EOF

## Usage
Each template contains:
- Build commands
- Configuration details
- Requirements
- Testing instructions
- Related files and references

To build any configuration:
\`\`\`bash
./build_image.sh <configuration-name>
\`\`\`

For more information, see the [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md).
EOF

echo "Template generation completed!"
echo "Generated templates in: $TEMPLATES_DIR"
echo "Total configurations: $(find "$TEMPLATES_DIR" -name "*.md" ! -name "README.md" | wc -l)"