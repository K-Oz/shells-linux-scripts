# debian-bookworm-ssh-server Configuration Template

## Image Details
- **Distribution:** debian
- **Version:** bookworm
- **Variant:** ssh-server
- **Type:** server
- **Full Name:** debian-bookworm-ssh-server

## Build Command
```bash
./build_image.sh debian-bookworm-ssh-server
```

## Description
This configuration builds a debian bookworm system with ssh-server.

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
./test-linux.sh debian-bookworm-ssh-server-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/debian.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
