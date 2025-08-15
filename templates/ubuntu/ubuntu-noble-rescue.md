# ubuntu-noble-rescue Configuration Template

## Image Details
- **Distribution:** ubuntu
- **Version:** noble
- **Variant:** rescue
- **Type:** server
- **Full Name:** ubuntu-noble-rescue

## Build Command
```bash
./build_image.sh ubuntu-noble-rescue
```

## Description
This configuration builds a ubuntu noble system with rescue.

## Server Features
- Command-line interface
- Minimal resource footprint
- SSH access configured
- Essential server tools included

## Requirements
- SSH server enabled
- Network configuration ready
- Basic system utilities

## Common Configuration
- Passwordless sudo enabled
- Auto-login configured
- QEMU guest agent installed
- Latest system updates applied
- Shells helper tools included

## Testing
Test the built image with:
```bash
./test-linux.sh ubuntu-noble-rescue-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/ubuntu.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
