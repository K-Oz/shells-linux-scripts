# ubuntu-jammy-opencog-desktop Configuration Template

## Image Details
- **Distribution:** ubuntu
- **Version:** jammy
- **Variant:** opencog-desktop
- **Type:** desktop
- **Full Name:** ubuntu-jammy-opencog-desktop

## Build Command
```bash
./build_image.sh ubuntu-jammy-opencog-desktop
```

## Description
This configuration builds a ubuntu jammy system with opencog-desktop.

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
./test-linux.sh ubuntu-jammy-opencog-desktop-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/ubuntu.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
