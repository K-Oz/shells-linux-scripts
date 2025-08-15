# slackware-15-desktop Configuration Template

## Image Details
- **Distribution:** slackware
- **Version:** 15
- **Variant:** desktop
- **Type:** desktop
- **Full Name:** slackware-15-desktop

## Build Command
```bash
./build_image.sh slackware-15-desktop
```

## Description
This configuration builds a slackware 15 system with desktop.

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

## Common Configuration
- Passwordless sudo enabled
- Auto-login configured
- QEMU guest agent installed
- Latest system updates applied
- Shells helper tools included

## Testing
Test the built image with:
```bash
./test-linux.sh slackware-15-desktop-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/slackware.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
