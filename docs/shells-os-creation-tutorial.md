# Shells.com OS Creation Tutorial

**Source:** [https://www.shells.com/l/en-US/tutorial/Shells-com-OS-Creation-Tutorial](https://www.shells.com/l/en-US/tutorial/Shells-com-OS-Creation-Tutorial)

This tutorial will show you how to create an image suitable for Shells either from your existing Shell™, from your existing Virtual Machine or building it on your own.

## Create a Shells™ image from your existing Shell™

**Head over [Shells™ Console](https://console.shells.com/) and toggle 'Advanced Mode' on the left side.**

![Advanced Mode](https://cdn.shells.net/image/Ha_VjVQl--SPOiMV95yzVReYvDlHS3Xuv-Rq2dyixxr_6XMq0lqvWg3y1jG0Y7AA/e0273ee9f0e0c7f034aceceba0c13168fb9ff488)

**Navigate to "My OS" on the left navbar.**

![My OS](https://cdn.shells.net/image/xyMNO0DbbvCpt7SGxo2PlJGkjGGR_qoA3Jx4ZdUiHONIHDwNHOsW-v3MugKDy-q6/e0273ee9f0e0c7f034aceceba0c13168fb9ff488)

**Select '+Create' on the new page.**

**The first option will be 'CREATE FROM A SHELL'**

You will be able to choose from which of your Shells you want to create an image.

Fill in the rest of the information as needed.

This image will contain all your changes and installed software that you have on the Shell you chose from. It will be a mirrored version of your setup.

## Move from Virtual Machine

If you're trying to move your existing VM to Shells, you need to have that VM installed in your local environment, retrieve the hard drive file from it, and use qemu-img (or similar to convert the hard drive to raw format).

**Example for qcow2 format:**

```bash
qemu-img convert -f qcow2 -O raw in.qcow2 out.raw
```

Then, use the [Shells RBDCONV Tool](https://github.com/Shells-com/rbdconv) to convert the raw image to.shells and upload it to your Shells account by selecting the appropriate option.

## Run your own kernel

If you wish to run your own Kernel instead of Shells' provided one, be sure to have it in the image and make sure it is BIOS or UEFI ready and has disk resize capability integrated with it.

To build a Linux image from scratch, follow our guidelines at:

[https://github.com/Shells-com/linux-scripts](https://github.com/Shells-com/linux-scripts)

And pay attention to requirements that make sure images will work well with Shells™ infrastructure:

[https://github.com/Shells-com/linux-scripts/blob/master/os_requirements.md](https://github.com/Shells-com/linux-scripts/blob/master/os_requirements.md)

***DISCLAIMER: ISO images are currently not supported.***

## Available Image Configurations

For a complete list of supported image configurations that can be built using this repository, see:

- [Official Images List](../official_images.txt)
- [OS Requirements](../os_requirements.md)
- [Build Instructions](../README.md)

## Building Custom Images

To build any of the supported configurations:

```bash
./build_image.sh <configuration-name>
```

For example:
```bash
./build_image.sh ubuntu-focal-ubuntu-desktop
```

## Testing Images

Test your built images before deployment:

```bash
./test-linux.sh generated-disk-image.qcow2
```

This will run the disk image inside qemu with a configuration similar to what is used on Shells.