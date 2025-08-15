# ubuntu-jammy-openssh-server Configuration Template

## Image Details
- **Distribution:** ubuntu
- **Version:** jammy
- **Variant:** openssh-server
- **Type:** server
- **Full Name:** ubuntu-jammy-openssh-server

## Build Command
```bash
./build_image.sh ubuntu-jammy-openssh-server
```

## Description
This configuration builds a ubuntu jammy system with openssh-server.

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
./test-linux.sh ubuntu-jammy-openssh-server-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/ubuntu.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
