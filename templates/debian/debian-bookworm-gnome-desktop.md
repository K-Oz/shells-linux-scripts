# debian-bookworm-gnome-desktop Configuration Template

## Image Details
- **Distribution:** debian
- **Version:** bookworm
- **Variant:** gnome-desktop
- **Type:** desktop
- **Full Name:** debian-bookworm-gnome-desktop

## Build Command
```bash
./build_image.sh debian-bookworm-gnome-desktop
```

## Description
This configuration builds a debian bookworm system with gnome-desktop.

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
./test-linux.sh debian-bookworm-gnome-desktop-$(date +%Y%m%d).qcow2
```

## Related Files
- Configuration script: `oscfg/debian.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
