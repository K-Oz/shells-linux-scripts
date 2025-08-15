#!/bin/sh

# OpenCog-optimized Ubuntu configuration
# This creates a specialized Ubuntu environment with OpenCog and related AI/cognitive science tools pre-installed

opencog_distro() {
	case "$1" in
		ubuntu-jammy-opencog-desktop)
			# Extract suite from the image name, then call ubuntu_distro to build base
			ubuntu_distro "ubuntu-jammy-ubuntu-desktop"
			opencog_cfg "$1"
			;;
		ubuntu-focal-opencog-desktop)
			# Extract suite from the image name, then call ubuntu_distro to build base
			ubuntu_distro "ubuntu-focal-ubuntu-desktop"
			opencog_cfg "$1"
			;;
		*)
			echo "Unknown OpenCog configuration: $1"
			exit 1
			;;
	esac
}

opencog_cfg() {
	echo "Configuring OpenCog environment..."
	
	# Install essential development tools and dependencies for OpenCog
	run apt-get update
	run apt-get install -y build-essential cmake git
	run apt-get install -y libboost-all-dev libcogutil-dev libatomspace-dev
	run apt-get install -y python3-dev python3-pip python3-numpy python3-scipy
	run apt-get install -y cython3 python3-matplotlib python3-pandas
	run apt-get install -y guile-3.0-dev libgsl-dev libbz2-dev libzmq3-dev
	
	# Install additional AI/ML tools that complement OpenCog
	run apt-get install -y jupyter-notebook spyder3
	run apt-get install -y octave gnuplot
	
	# Python packages for AI/ML
	run pip3 install --upgrade pip
	run pip3 install opencog
	run pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
	run pip3 install tensorflow
	run pip3 install scikit-learn
	run pip3 install nltk
	
	# Create opencog user workspace
	mkdir -p "$WORK/home/opencog"
	chown 1000:1000 "$WORK/home/opencog"
	
	# Set up OpenCog development environment
	cat > "$WORK/home/opencog/README.md" << 'EOF'
# OpenCog Development Environment

This Shells image is optimized for OpenCog development and AI/cognitive science research.

## Pre-installed Tools

### OpenCog Framework
- OpenCog AtomSpace
- OpenCog CogUtil libraries
- Python OpenCog bindings

### Development Tools
- CMake build system
- Git version control
- GCC/G++ compiler suite
- Boost C++ libraries

### AI/ML Libraries
- PyTorch (CPU version)
- TensorFlow
- Scikit-learn
- NLTK (Natural Language Toolkit)
- NumPy, SciPy, Pandas, Matplotlib

### Interactive Environments
- Jupyter Notebook
- Spyder IDE
- Octave (MATLAB alternative)

## Getting Started

1. Open a terminal
2. Navigate to `/home/opencog` for your workspace
3. Start Jupyter notebook: `jupyter notebook`
4. Or start Spyder IDE: `spyder3`

## OpenCog Resources

- Official Website: https://opencog.org/
- GitHub: https://github.com/opencog
- Documentation: https://wiki.opencog.org/
- Forum: https://groups.google.com/g/opencog

## Example Usage

```python
# Basic OpenCog Python example
from opencog.atomspace import AtomSpace, types
from opencog.utilities import initialize_opencog

# Initialize
atomspace = AtomSpace()
initialize_opencog(atomspace)

# Create some atoms
cat = atomspace.add_node(types.ConceptNode, "cat")
animal = atomspace.add_node(types.ConceptNode, "animal") 
inheritance_link = atomspace.add_link(types.InheritanceLink, [cat, animal])

print(f"Created atoms: {cat}, {animal}, {inheritance_link}")
```

Happy cognitive computing!
EOF

	# Desktop shortcut for OpenCog resources
	mkdir -p "$WORK/etc/skel/Desktop"
	cat > "$WORK/etc/skel/Desktop/OpenCog Resources.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Link
Name=OpenCog Resources
Comment=Links to OpenCog documentation and resources
Icon=applications-science
URL=https://opencog.org/
EOF

	# Jupyter desktop shortcut
	cat > "$WORK/etc/skel/Desktop/Jupyter Notebook.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Jupyter Notebook
Comment=Interactive Python notebook environment
Exec=jupyter notebook
Icon=applications-science
Terminal=true
Categories=Development;Science;
EOF

	# Spyder desktop shortcut
	cat > "$WORK/etc/skel/Desktop/Spyder.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Spyder
Comment=Scientific Python Development Environment
Exec=spyder3
Icon=spyder
Terminal=false
Categories=Development;Science;
EOF

	# Custom MOTD for OpenCog system
	cat > "$WORK/etc/motd" << 'EOF'

 ██████╗ ██████╗ ███████╗███╗   ██╗ ██████╗ ██████╗  ██████╗ 
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██╔═══██╗██╔════╝ 
██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║     ██║   ██║██║  ███╗
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║     ██║   ██║██║   ██║
╚██████╔╝██║     ███████╗██║ ╚████║╚██████╗╚██████╔╝╚██████╔╝
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝  ╚═════╝ 

Welcome to your OpenCog-optimized development environment!

This system includes:
✓ OpenCog framework and libraries
✓ Python AI/ML stack (PyTorch, TensorFlow, scikit-learn)
✓ Jupyter Notebook and Spyder IDE
✓ Development tools (CMake, Git, GCC)

Quick start:
• Open Jupyter: 'jupyter notebook'
• Launch Spyder: 'spyder3'  
• Check OpenCog: 'python3 -c "import opencog; print(opencog.__version__)"'

Documentation: https://opencog.org | https://wiki.opencog.org

Happy cognitive computing! 🧠

EOF

	# Environment setup for development
	cat >> "$WORK/etc/skel/.bashrc" << 'EOF'

# OpenCog environment setup
export OPENCOG_HOME=/usr/local
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3/site-packages

# AI/ML development aliases
alias jnb='jupyter notebook'
alias spyder='spyder3'
alias octave='octave --no-gui'

# Show OpenCog info on login
echo ""
echo "🧠 OpenCog framework ready!"
if command -v python3 >/dev/null 2>&1; then
    python3 -c "
try:
    import opencog
    print(f'✓ OpenCog version: {opencog.__version__ if hasattr(opencog, \"__version__\") else \"available\"}')
except ImportError:
    print('⚠ OpenCog not found in Python path')
" 2>/dev/null || echo "⚠ OpenCog installation needs verification"
fi
echo ""
EOF

	echo "OpenCog environment configuration complete!"
}