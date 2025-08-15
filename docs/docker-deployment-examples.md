# Docker Deployment Examples for Shells Images

This document provides examples and guidance for deploying Shells images to Docker containers and integrating Docker workflows with the Shells platform.

## Overview

The Shells platform primarily focuses on VM-based environments, but there are several ways to integrate Docker containers and containerized applications into your Shells workflows.

## Use Cases

### 1. Testing Images in Docker Before Shell Deployment

You can test certain aspects of your Shells images using Docker, though note that Docker containers have different characteristics than full VMs:

```bash
# Convert a Shells qcow2 image to a Docker-testable format
# Note: This is experimental and may not capture all VM-specific features

# Extract filesystem from qcow2
sudo qemu-nbd -c /dev/nbd0 your-image.qcow2
sudo mount /dev/nbd0p1 /mnt/image
sudo tar -czf image-rootfs.tar.gz -C /mnt/image .
sudo umount /mnt/image
sudo qemu-nbd -d /dev/nbd0

# Create Docker image from filesystem
docker import image-rootfs.tar.gz your-shells-image:test
docker run -it your-shells-image:test /bin/bash
```

### 2. Running Containerized Applications Inside Shells

Deploy and run Docker containers within your Shells environment:

```bash
# Install Docker in your Shell
sudo apt update && sudo apt install docker.io
sudo systemctl start docker
sudo usermod -aG docker $USER

# Example: Run a web development environment
docker run -d -p 8080:80 --name nginx-dev nginx:alpine
docker run -d -p 3000:3000 --name node-app node:18-alpine sh -c "npm init -y && npm install express && node -e 'const express = require(\"express\"); const app = express(); app.get(\"/\", (req, res) => res.send(\"Hello from Shells + Docker!\")); app.listen(3000);'"
```

### 3. Development Containers in Shells

Use Shells as a Docker development environment:

```bash
# Create a development container with mounted workspace
mkdir -p ~/workspace
docker run -it -v ~/workspace:/workspace -p 8000:8000 ubuntu:22.04 /bin/bash

# Inside container - set up development environment
apt update && apt install -y python3 python3-pip git curl
pip3 install flask
cd /workspace
# Your development work here
```

## Docker-Optimized Shells Configuration

If you want to create a Shells image optimized for Docker development, you can create a custom configuration:

### Example: Docker Developer Desktop

```bash
# Build a Ubuntu desktop with Docker pre-installed
./build_image.sh ubuntu-jammy-docker-desktop
```

This would require creating a custom configuration in `oscfg/docker.sh`:

```bash
#!/bin/sh

docker_distro() {
    case "$1" in
        ubuntu-jammy-docker-desktop)
            ubuntu_distro "ubuntu-jammy-ubuntu-desktop"
            docker_cfg "$1"
            ;;
        ubuntu-focal-docker-desktop)
            ubuntu_distro "ubuntu-focal-ubuntu-desktop"
            docker_cfg "$1"
            ;;
        *)
            echo "Unknown Docker configuration: $1"
            exit 1
            ;;
    esac
}

docker_cfg() {
    echo "Configuring Docker development environment..."
    
    # Install Docker CE
    run apt-get update
    run apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o "$WORK/usr/share/keyrings/docker-archive-keyring.gpg"
    
    # Set up Docker repository
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > "$WORK/etc/apt/sources.list.d/docker.list"
    
    run apt-get update
    run apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    
    # Install additional tools
    run apt-get install -y docker-compose kubernetes-client
    
    # Enable Docker service
    run systemctl enable docker
    
    # Set up user permissions (will be applied during firstrun)
    echo "# Add user to docker group during firstrun" > "$WORK/etc/shells-firstrun.d/docker-setup.sh"
    echo "usermod -aG docker \$(id -nu 1000)" >> "$WORK/etc/shells-firstrun.d/docker-setup.sh"
    chmod +x "$WORK/etc/shells-firstrun.d/docker-setup.sh"
    
    # Desktop shortcuts for Docker tools
    mkdir -p "$WORK/etc/skel/Desktop"
    
    cat > "$WORK/etc/skel/Desktop/Docker Desktop.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Docker Dashboard
Comment=Open Docker container dashboard
Exec=x-www-browser http://localhost:9000
Icon=docker
Terminal=false
Categories=Development;
EOF

    # Install Portainer for container management
    cat > "$WORK/etc/skel/start-portainer.sh" << 'EOF'
#!/bin/bash
# Start Portainer container management UI
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
EOF
    chmod +x "$WORK/etc/skel/start-portainer.sh"
    
    # Custom MOTD
    cat > "$WORK/etc/motd" << 'EOF'

🐳 Docker Development Environment on Shells

This system includes:
✓ Docker CE with Docker Compose
✓ Kubernetes client tools  
✓ Portainer container management UI
✓ Ubuntu desktop environment

Quick start:
• Check Docker: 'docker --version'
• Run Portainer UI: '~/start-portainer.sh' then visit http://localhost:9000
• Docker Compose: 'docker-compose --version'
• Kubernetes: 'kubectl version --client'

Happy containerizing! 🚀

EOF
}
```

## Limitations and Considerations

### VM vs Container Differences

- **Shells VMs** provide full operating system isolation, custom kernels, and complete hardware virtualization
- **Docker containers** share the host kernel and provide process-level isolation
- Some Shells features (like custom kernels) cannot be replicated in Docker
- GPU passthrough, specialized hardware, and certain system-level features work differently

### When to Use Each

**Use Shells VMs for:**
- Full OS environments
- Custom kernel requirements  
- Hardware-specific development
- GUI applications requiring full desktop
- System administration learning
- Security research requiring isolation

**Use Docker containers for:**
- Microservices development
- CI/CD pipelines
- Application deployment
- Development environment consistency
- Resource-efficient scaling

## Integration Patterns

### 1. Shells as Docker Development Host

Use Shells as your primary development environment with Docker for application deployment:

```bash
# In your Shell
git clone https://github.com/your-project/app
cd app
docker-compose up -d
# Develop using Shell's desktop environment
# Deploy using Docker containers
```

### 2. Hybrid Workflows

Combine VM benefits with container efficiency:

```bash
# Use Shells for development
# Export applications to containers for deployment
docker build -t myapp .
docker save myapp > myapp.tar
# Transfer to production environment
```

## Example Projects

### Web Development Stack

```yaml
# docker-compose.yml for Shells development
version: '3.8'
services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  
  app:
    image: node:18-alpine
    working_dir: /app
    volumes:
      - ./app:/app
    ports:
      - "3000:3000"
    command: npm start
  
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: devdb
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: devpass
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

### AI/ML Development

```bash
# Run Jupyter in container with GPU support (if available in Shell)
docker run -it --rm \
  -p 8888:8888 \
  -v ~/notebooks:/notebooks \
  jupyter/tensorflow-notebook:latest
```

This provides a practical bridge between Shells' VM-based environment and modern containerized development workflows.