# manjaro-desktop Configuration Template

## Image Details
- **Distribution:** manjaro
- **Version:** desktop
- **Variant:** 
- **Type:** server
- **Full Name:** manjaro-desktop

## Build Command
```bash
./build_image.sh manjaro-desktop
```

## Description
This configuration builds a manjaro desktop system with .

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
./test-linux.sh manjaro-desktop-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/manjaro.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
