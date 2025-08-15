# Linux scripts for Shells™

This repository includes scripts used for building Linux images used on Shells™.

To run these scripts you need to have relevant packages installed on your machine:

	sudo apt install git qemu qemu-utils qemu-system php8.1 debootstrap squashfs-tools jq

After which you clone this repo and run the build (and test scripts).

# build_image.sh

This script will build an image for a given distibution.

For example:

	./build_image.sh ubuntu-focal-ubuntu-desktop
	
For list of currently available builds, take a look at [official_images.txt](https://github.com/Shells-com/linux-scripts/blob/master/official_images.txt).

## Experimental Configurations

This repository now includes experimental support for additional operating systems and specialized environments:

### 🧪 Experimental Systems
- **Slackware Linux**: Traditional Linux distribution templates (`slackware-*`)
- **OpenCog Environment**: AI/cognitive science optimized Ubuntu (`ubuntu-*-opencog-*`)

### 📚 Documentation for Advanced Use Cases
- [Docker Deployment Examples](docs/docker-deployment-examples.md) - Using Shells with containerized workflows
- [Experimental Operating Systems](docs/experimental-operating-systems.md) - Research into unusual OS support
- [Testing Experimental Images](docs/testing-experimental-images.md) - How to test experimental configurations
- [GitHub Repo Deployment Structure](docs/github-repo-deployment-structure.md) - Structure repos for Shell deployment

**Note**: Experimental configurations may have limitations and are primarily intended for educational and research purposes.

For detailed configuration information and templates, see the [templates directory](templates/).

## OS Creation Tutorial

For comprehensive guidance on creating Shells images, see our detailed tutorial:
- [Shells.com OS Creation Tutorial](docs/shells-os-creation-tutorial.md)

This tutorial covers:
- Creating images from existing Shells
- Moving from Virtual Machines
- Running your own kernel
- Available configurations and templates

## Configuration Templates

Each supported image configuration has a detailed template with build instructions, requirements, and testing guidance. Templates are automatically generated and organized by distribution in the [templates/](templates/) directory.

# Submit/maintain your distribution

Shells wants to help Linux community as much as it can, so if you would like to see your own distribution on the list, submit PR with it and we will gladly merge it. Be sure to read about some simple rules around how to build images for Shells at [os_requirements.md](https://github.com/Shells-com/linux-scripts/blob/master/os_requirements.md).

# Testing

It is possible to test Shells images prior to shipping.

	$ ./test-linux.sh generated-disk-image.qcow2

This will run the disk image inside qemu with a configuration similar to what is used on Shells. The machine will run with a special UUID recognized by first run that will create a "test" user with password "test".

During testing, an overlay with the name `xxx_test.qcow2` will be generated and changes will be written there (the original .qcow2 file won't be modified in test mode). Erasing this file allows returning to the initial state.
