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
This configuration builds a ubuntu jammy system with opencog-desktop. This is a specialized environment optimized for OpenCog AI development and cognitive science research, including pre-installed AI/ML libraries, development tools, and the OpenCog framework.

## OpenCog Features
- OpenCog AtomSpace and CogUtil libraries
- Python OpenCog bindings
- PyTorch, TensorFlow, and scikit-learn
- Jupyter Notebook and Spyder IDE
- Natural Language Toolkit (NLTK)
- Development tools (CMake, Git, GCC, Boost)
- Pre-configured workspace and examples

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
- Configuration script: `oscfg/opencog.sh`
- Base scripts: `scripts/`
- Requirements: [os_requirements.md](../os_requirements.md)

## References
- [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md)
- [Official Images List](../official_images.txt)
- [Build Instructions](../README.md)
