# Testing Experimental Image Configurations

This document provides guidance for testing the experimental image configurations added to the Shells platform.

## Overview

The experimental configurations include:
- **Slackware Linux** variants (experimental status)
- **OpenCog AI environments** (specialized Ubuntu variants)

## Prerequisites

Before testing experimental images, ensure you have:

```bash
# Required packages for building and testing
sudo apt install git qemu qemu-utils qemu-system php8.1 debootstrap squashfs-tools jq

# For Docker examples (optional)
sudo apt install docker.io docker-compose
```

## Testing Slackware Configurations

### Build Testing

⚠️ **Important**: Slackware configurations are experimental and create basic filesystem structures rather than complete Slackware installations.

```bash
# Test building Slackware desktop (experimental)
./build_image.sh slackware-current-desktop

# Test building Slackware server (experimental)  
./build_image.sh slackware-current-server

# Test the built image
./test-linux.sh slackware-current-desktop-$(date +%Y%m%d).qcow2
```

### Expected Behavior

The Slackware experimental builds will:
- ✅ Create basic Slackware-compatible directory structure
- ✅ Generate `/etc/slackware-version` file
- ✅ Set up basic user and group files
- ✅ Display experimental status in MOTD
- ⚠️ **Not** install complete Slackware packages (requires additional implementation)

### Limitations

- Package management not fully implemented
- Desktop environment requires manual installation
- Intended primarily for educational purposes

## Testing OpenCog Configurations

### Build Testing

```bash
# Build OpenCog environment on Ubuntu 22.04
./build_image.sh ubuntu-jammy-opencog-desktop

# Build OpenCog environment on Ubuntu 20.04
./build_image.sh ubuntu-focal-opencog-desktop

# Test the built image
./test-linux.sh ubuntu-jammy-opencog-desktop-$(date +%Y%m%d).qcow2
```

### Verification Steps

Once the OpenCog image is running, verify the installation:

```bash
# Check OpenCog Python bindings
python3 -c "import opencog; print('OpenCog available')"

# Check AI/ML libraries
python3 -c "import torch, tensorflow, sklearn, nltk; print('AI libraries OK')"

# Check development tools
cmake --version
jupyter --version
spyder3 --version

# Check example workspace
ls -la /home/opencog/
cat /home/opencog/README.md
```

### Expected Environment

The OpenCog environments should include:
- ✅ Ubuntu desktop environment (GNOME/Unity)
- ✅ OpenCog framework and Python bindings
- ✅ AI/ML stack (PyTorch, TensorFlow, scikit-learn)
- ✅ Development tools (CMake, Git, GCC, Boost)
- ✅ Interactive environments (Jupyter, Spyder)
- ✅ Pre-configured workspace and documentation

## Docker Integration Testing

### Test Docker Examples

```bash
# Start a Shell with Docker support
# (if you have ubuntu-*-opencog-* running)

# Test basic Docker functionality
docker --version
docker run hello-world

# Test development container
docker run -it -v ~/workspace:/workspace ubuntu:22.04 /bin/bash

# Test Jupyter in container
docker run -d -p 8888:8888 jupyter/base-notebook:latest
# Access at http://localhost:8888
```

## Performance and Resource Testing

### Resource Requirements

Monitor resource usage during testing:

```bash
# Check memory usage
free -h

# Check disk space
df -h

# Monitor during build (in another terminal)
htop
```

### Expected Resource Usage

- **Slackware builds**: Low resource usage (basic filesystem)
- **OpenCog builds**: Higher resource usage due to AI/ML packages
  - Memory: 2GB+ recommended
  - Disk: 4GB+ for packages
  - Build time: 30-60 minutes depending on network speed

## Troubleshooting

### Common Issues

#### Build Failures

```bash
# Check build script syntax
bash -n build_image.sh
bash -n oscfg/slackware.sh
bash -n oscfg/opencog.sh

# Check dependencies
./build_image.sh --help 2>&1 | head -10
```

#### OpenCog Package Installation Issues

```bash
# If pip packages fail to install
# Check network connectivity in chroot environment
# Verify package names and versions

# Manual verification
sudo chroot /path/to/work /bin/bash
pip3 install opencog
```

#### Slackware Filesystem Issues

```bash
# Check filesystem structure
ls -la work/
cat work/etc/slackware-version
cat work/etc/motd
```

### Debug Mode

Enable debug output for troubleshooting:

```bash
# Enable verbose output
set -x
./build_image.sh ubuntu-jammy-opencog-desktop
set +x
```

## Test Reports

### Example Test Session

```bash
# Full test session example
cd /path/to/shells-linux-scripts

# 1. Build experimental Slackware
echo "Building Slackware experimental..."
time ./build_image.sh slackware-current-desktop 2>&1 | tee slackware-build.log

# 2. Test Slackware image
echo "Testing Slackware image..."
./test-linux.sh slackware-current-desktop-$(date +%Y%m%d).qcow2

# 3. Build OpenCog environment  
echo "Building OpenCog environment..."
time ./build_image.sh ubuntu-jammy-opencog-desktop 2>&1 | tee opencog-build.log

# 4. Test OpenCog image
echo "Testing OpenCog environment..."
./test-linux.sh ubuntu-jammy-opencog-desktop-$(date +%Y%m%d).qcow2

# 5. Generate final report
echo "Build completed. Check logs:"
echo "- Slackware: slackware-build.log"
echo "- OpenCog: opencog-build.log"
```

## Validation Checklist

### Slackware Experimental
- [ ] Build completes without errors
- [ ] Basic filesystem structure created
- [ ] `/etc/slackware-version` exists
- [ ] MOTD shows experimental warning
- [ ] Image boots in QEMU
- [ ] Basic shell access available

### OpenCog Environment
- [ ] Ubuntu base system builds successfully
- [ ] OpenCog packages install without conflicts
- [ ] Python bindings import correctly
- [ ] Jupyter notebook starts
- [ ] Spyder IDE launches
- [ ] AI/ML libraries available
- [ ] Desktop environment functional
- [ ] Example workspace created

### Docker Integration
- [ ] Docker installation examples work
- [ ] Container workflows documented
- [ ] Integration patterns clear
- [ ] Limitations documented

## Reporting Issues

When reporting issues with experimental configurations:

1. **Include build logs** (`2>&1 | tee build.log`)
2. **Specify configuration** (exact image name)
3. **Include system info** (`uname -a`, `free -h`, `df -h`)
4. **Describe expected vs actual behavior**
5. **Include error messages** (full output)

## Contributing Improvements

To improve experimental configurations:

1. **Test thoroughly** on different systems
2. **Document limitations** clearly
3. **Provide specific error reports**
4. **Suggest concrete improvements**
5. **Follow existing code patterns**

Remember: Experimental configurations are learning tools and may not provide production-ready environments. They serve educational and research purposes while exploring different approaches to system configuration.