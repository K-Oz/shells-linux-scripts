# slackware-current-server Configuration Template

## Image Details
- **Distribution:** slackware
- **Version:** current
- **Variant:** server
- **Type:** server
- **Full Name:** slackware-current-server

## Build Command
```bash
./build_image.sh slackware-current-server
```

## Description
This configuration builds a slackware current system with server.

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
./test-linux.sh slackware-current-server-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/slackware.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
