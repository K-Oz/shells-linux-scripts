# Shells Image Configuration Templates

This directory contains template documentation for all supported Shells image configurations.

## Directory Structure
- Each distribution has its own subdirectory
- Template files are named after their configuration (e.g., `ubuntu-focal-ubuntu-desktop.md`)

## Available Distributions
- **arch**: 1 configurations
- **debian**: 8 configurations
- **fedora**: 2 configurations
- **manjaro**: 3 configurations
- **opensuse**: 4 configurations
- **ubuntu**: 14 configurations

## Usage
Each template contains:
- Build commands
- Configuration details
- Requirements
- Testing instructions
- Related files and references

To build any configuration:
```bash
./build_image.sh <configuration-name>
```

For more information, see the [Shells.com OS Creation Tutorial](../docs/shells-os-creation-tutorial.md).
