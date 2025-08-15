# GitHub Repository Structure for Shell Image Deployment

This document provides examples and templates for structuring GitHub repositories that can be easily deployed to Shells images, facilitating automated development environment setup.

## Overview

By structuring your project repositories with Shells deployment in mind, you can create reproducible development environments that can be easily shared and deployed.

## Repository Structure Examples

### 1. Basic Shell-Ready Project

```
my-project/
├── .shells/
│   ├── setup.sh              # Main setup script
│   ├── requirements.txt       # System packages
│   ├── python-requirements.txt # Python packages  
│   ├── config/               # Configuration files
│   │   ├── .bashrc.append    # Bash configuration
│   │   ├── .vimrc            # Editor configuration
│   │   └── desktop/          # Desktop shortcuts
│   └── README.md             # Shells-specific documentation
├── src/                      # Your project source code
├── docs/                     # Project documentation  
├── tests/                    # Test files
├── docker-compose.yml        # Optional: for container workflow
└── README.md                 # Main project documentation
```

### 2. Advanced Shell Deployment Structure

```
advanced-project/
├── .shells/
│   ├── images/               # Multiple image configurations
│   │   ├── development.sh    # Dev environment setup
│   │   ├── production.sh     # Production-like setup
│   │   └── ai-research.sh    # Specialized AI environment
│   ├── scripts/              # Helper scripts
│   │   ├── install-deps.sh   # Dependency installation
│   │   ├── configure-env.sh  # Environment configuration
│   │   └── post-setup.sh     # Post-installation tasks
│   ├── config/               # Configuration templates
│   │   ├── development/      # Dev-specific configs
│   │   ├── production/       # Prod-specific configs
│   │   └── shared/           # Shared configurations
│   └── docs/                 # Shell deployment docs
├── .github/
│   └── workflows/
│       └── shells-deploy.yml # GitHub Actions for Shells
└── [rest of project structure]
```

## Shell Setup Script Template

### Basic Setup Script (`.shells/setup.sh`)

```bash
#!/bin/bash
# Shell Environment Setup for My Project
set -e

SHELLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SHELLS_DIR")"

echo "🔧 Setting up development environment for $(basename "$PROJECT_ROOT")"

# Update system packages
if [ -f "$SHELLS_DIR/requirements.txt" ]; then
    echo "📦 Installing system packages..."
    sudo apt update
    sudo apt install -y $(cat "$SHELLS_DIR/requirements.txt" | tr '\n' ' ')
fi

# Install Python dependencies
if [ -f "$SHELLS_DIR/python-requirements.txt" ]; then
    echo "🐍 Installing Python packages..."
    pip3 install -r "$SHELLS_DIR/python-requirements.txt"
fi

# Install Node.js dependencies
if [ -f "$PROJECT_ROOT/package.json" ]; then
    echo "📦 Installing Node.js packages..."
    cd "$PROJECT_ROOT"
    npm install
fi

# Apply configuration files
if [ -d "$SHELLS_DIR/config" ]; then
    echo "⚙️ Applying configurations..."
    
    # Append to .bashrc if exists
    if [ -f "$SHELLS_DIR/config/.bashrc.append" ]; then
        cat "$SHELLS_DIR/config/.bashrc.append" >> ~/.bashrc
    fi
    
    # Copy configuration files
    find "$SHELLS_DIR/config" -type f -name ".*" -not -name ".bashrc.append" | while read file; do
        cp "$file" ~/
    done
fi

# Create desktop shortcuts
if [ -d "$SHELLS_DIR/config/desktop" ]; then
    echo "🖥️ Creating desktop shortcuts..."
    mkdir -p ~/Desktop
    cp "$SHELLS_DIR/config/desktop"/*.desktop ~/Desktop/
    chmod +x ~/Desktop/*.desktop
fi

# Project-specific setup
if [ -f "$SHELLS_DIR/scripts/configure-env.sh" ]; then
    echo "🔧 Running project-specific configuration..."
    bash "$SHELLS_DIR/scripts/configure-env.sh"
fi

echo "✅ Setup complete! Your development environment is ready."
echo "📁 Project location: $PROJECT_ROOT"

# Display quick start information
if [ -f "$SHELLS_DIR/README.md" ]; then
    echo ""
    echo "📋 Quick Start Information:"
    head -20 "$SHELLS_DIR/README.md"
fi
```

### Requirements Files Examples

**`.shells/requirements.txt`** (system packages):
```
git
curl
vim
build-essential
cmake
python3-dev
python3-pip
nodejs
npm
htop
tree
```

**`.shells/python-requirements.txt`**:
```
jupyter
pandas
numpy
matplotlib
requests
flask
django
pytest
black
flake8
```

### Configuration Examples

**`.shells/config/.bashrc.append`**:
```bash
# Project-specific aliases
alias proj='cd /path/to/project'
alias serve='python3 -m http.server 8000'
alias test='python3 -m pytest'

# Environment variables
export PROJECT_ENV=development
export DEBUG=1

# Custom prompt
export PS1="\[\033[01;32m\]\u@shells:\[\033[01;34m\]\w\[\033[00m\]\$ "

echo "🚀 Development environment loaded for $(basename $PWD)"
```

**`.shells/config/desktop/Project IDE.desktop`**:
```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Project IDE
Comment=Open project in preferred IDE
Exec=code /path/to/project
Icon=code
Terminal=false
Categories=Development;
```

## GitHub Actions Integration

### `.github/workflows/shells-deploy.yml`

```yaml
name: Shells Deployment Test

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test-shells-setup:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Test Shell Setup Script
      run: |
        # Test that setup script has valid syntax
        bash -n .shells/setup.sh
        
        # Test requirements files exist and are valid
        if [ -f .shells/requirements.txt ]; then
          echo "✓ System requirements file found"
        fi
        
        if [ -f .shells/python-requirements.txt ]; then
          echo "✓ Python requirements file found"
          # Test pip requirements syntax
          pip3 install --dry-run -r .shells/python-requirements.txt
        fi
    
    - name: Validate Configuration Files
      run: |
        # Check configuration files
        if [ -d .shells/config ]; then
          echo "✓ Configuration directory found"
          find .shells/config -name "*.desktop" -exec desktop-file-validate {} \;
        fi
    
    - name: Documentation Check
      run: |
        if [ -f .shells/README.md ]; then
          echo "✓ Shells documentation found"
          wc -l .shells/README.md
        fi
```

## Deployment Patterns

### Pattern 1: Direct Clone and Setup

```bash
# In your Shell environment
git clone https://github.com/username/my-project.git
cd my-project
bash .shells/setup.sh
```

### Pattern 2: One-Line Deployment

```bash
# Single command deployment
curl -fsSL https://raw.githubusercontent.com/username/my-project/main/.shells/setup.sh | bash -s -- --repo=https://github.com/username/my-project.git
```

### Pattern 3: Environment-Specific Setup

```bash
# Development environment
git clone https://github.com/username/my-project.git
cd my-project
bash .shells/images/development.sh

# Production-like environment  
bash .shells/images/production.sh
```

## Advanced Examples

### Web Development Project

```bash
# .shells/images/web-dev.sh
#!/bin/bash
set -e

echo "🌐 Setting up web development environment..."

# Install web dev tools
sudo apt update && sudo apt install -y \
    nginx \
    postgresql \
    redis-server \
    nodejs \
    npm

# Install global npm packages
npm install -g \
    @angular/cli \
    create-react-app \
    vue-cli \
    nodemon

# Configure services
sudo systemctl enable nginx
sudo systemctl enable postgresql
sudo systemctl enable redis-server

# Setup project
npm install
npm run build

echo "✅ Web development environment ready!"
echo "🚀 Start development server: npm run dev"
```

### AI/ML Research Project

```bash
# .shells/images/ai-research.sh
#!/bin/bash
set -e

echo "🧠 Setting up AI/ML research environment..."

# Use OpenCog base if available
if command -v python3 >/dev/null && python3 -c "import opencog" 2>/dev/null; then
    echo "✓ Using OpenCog base environment"
else
    # Install AI/ML stack
    pip3 install torch torchvision torchaudio
    pip3 install tensorflow
    pip3 install scikit-learn pandas numpy matplotlib
    pip3 install jupyter notebook spyder
fi

# Install project-specific ML libraries
pip3 install -r requirements-ml.txt

# Setup Jupyter kernels
python3 -m ipykernel install --user --name project-env

# Create workspace
mkdir -p ~/notebooks ~/datasets ~/models

echo "✅ AI/ML environment ready!"
echo "📊 Start Jupyter: jupyter notebook"
echo "🔬 Launch Spyder: spyder3"
```

## Best Practices

### 1. Repository Organization

- Keep shell-specific files in `.shells/` directory
- Use clear, descriptive script names
- Include documentation for each setup script
- Version your shell configurations

### 2. Script Design

- Make scripts idempotent (safe to run multiple times)
- Include error handling and validation
- Provide progress feedback to users
- Test scripts in clean environments

### 3. Documentation

- Include setup instructions in `.shells/README.md`
- Document system requirements
- Provide troubleshooting information
- Include examples of expected output

### 4. Configuration Management

- Use environment-specific configurations
- Avoid hardcoding paths and credentials
- Provide default configurations with overrides
- Include validation for critical configurations

## Integration with Shells Platform

### Custom Image Creation

For complex projects, consider creating custom Shells images:

```bash
# Create custom configuration in shells-linux-scripts
# oscfg/myproject.sh

myproject_distro() {
    case "$1" in
        ubuntu-jammy-myproject-dev)
            ubuntu_distro "ubuntu-jammy-ubuntu-desktop"
            myproject_cfg "$1"
            ;;
    esac
}

myproject_cfg() {
    echo "Setting up MyProject development environment..."
    
    # Clone and setup project
    run git clone https://github.com/username/myproject.git /home/ubuntu/myproject
    run bash /home/ubuntu/myproject/.shells/setup.sh
    
    # Additional image-specific setup
    # ...
}
```

This approach creates reproducible development environments that can be shared across teams and easily deployed to the Shells platform.