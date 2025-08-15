#!/bin/sh

# Slackware Linux configuration
# Note: Slackware is a traditional Linux distribution that doesn't use package managers like APT/YUM
# This is an experimental template for building Slackware-based Shells images

slackware_distro() {
	case "$1" in
		slackware-current-desktop)
			slackware_get_base "current"
			slackware_cfg "$1"
			;;
		slackware-15-desktop)
			slackware_get_base "15.0"
			slackware_cfg "$1"
			;;
		slackware-current-server)
			slackware_get_base "current"
			slackware_cfg "$1"
			;;
		*)
			echo "Unknown Slackware configuration: $1"
			exit 1
			;;
	esac
}

slackware_get_base() {
	local VERSION="$1"
	local SLACKWARE_MIRROR="https://slackware.cs.utah.edu/pub/slackware"
	
	# For now, we'll create a minimal base using existing tools
	# In a real implementation, this would download and install Slackware packages
	create_empty
	
	# Install basic Slackware filesystem structure
	mkdir -p "$WORK"/{bin,boot,dev,etc,home,lib,lib64,mnt,opt,proc,root,run,sbin,sys,tmp,usr,var}
	mkdir -p "$WORK/usr"/{bin,lib,lib64,sbin,share,src,local}
	mkdir -p "$WORK/var"/{log,tmp,lib,spool}
	
	echo "Note: This is an experimental Slackware template"
	echo "A complete implementation would require downloading and installing Slackware packages"
	echo "For now, this creates a basic filesystem structure compatible with Slackware"
}

slackware_cfg() {
	# Basic Slackware configuration
	case "$1" in
		slackware-*-desktop)
			slackware_setup_desktop
			;;
		slackware-*-server)
			slackware_setup_server
			;;
	esac
	
	slackware_setup_common
}

slackware_setup_common() {
	# Set up basic Slackware system files
	cat > "$WORK/etc/slackware-version" << EOF
Slackware Linux (Shells Experimental Build)
EOF

	# Basic /etc/passwd
	cat > "$WORK/etc/passwd" << EOF
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
EOF

	# Basic /etc/group
	cat > "$WORK/etc/group" << EOF
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:
fax:x:21:
voice:x:22:
cdrom:x:24:
floppy:x:25:
tape:x:26:
sudo:x:27:
audio:x:29:
dip:x:30:
www-data:x:33:
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
gnats:x:41:
shadow:x:42:
utmp:x:43:
video:x:44:
sasl:x:45:
plugdev:x:46:
staff:x:50:
games:x:60:
users:x:100:
nogroup:x:65534:
shellsmgmt:x:999:
EOF

	# Basic hostname
	echo "slackware-shells" > "$WORK/etc/hostname"
	
	# Shells management group for sudo
	echo "%shellsmgmt ALL=(ALL) NOPASSWD: ALL" > "$WORK/etc/sudoers.d/01-shells"
	chmod 440 "$WORK/etc/sudoers.d/01-shells" 2>/dev/null || true
	
	# Basic network configuration
	cat > "$WORK/etc/resolv.conf" << EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

	# Create a note about this being experimental
	cat > "$WORK/etc/motd" << EOF

Welcome to Slackware Linux on Shells (Experimental)

This is an experimental Slackware template for the Shells platform.
Note: This template creates a basic Slackware-compatible environment.
For a complete Slackware system, additional package installation would be required.

For more information about Slackware: http://www.slackware.com/

EOF
}

slackware_setup_desktop() {
	echo "Setting up experimental Slackware desktop environment..."
	
	# Note about desktop setup
	cat > "$WORK/etc/X11/README" << EOF
Slackware Desktop Setup Notes:

This experimental template would normally include:
- X Window System
- Window manager (fvwm, KDE, XFCE, etc.)
- Display manager
- Essential desktop applications

A complete implementation would require downloading and installing
Slackware packages from official mirrors.
EOF
}

slackware_setup_server() {
	echo "Setting up experimental Slackware server environment..."
	
	# Basic server setup notes
	cat > "$WORK/etc/README.server" << EOF
Slackware Server Setup Notes:

This experimental template would normally include:
- SSH server
- Basic system utilities
- Network configuration tools
- Server administration tools

A complete implementation would require downloading and installing
Slackware packages from official mirrors.
EOF
}