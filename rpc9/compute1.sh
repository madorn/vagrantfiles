# Update and System
apt-get update
apt-get upgrade

# Ensure RPC Supported Kernel Is Installed
apt-get install -y linux-image-extra-3.13.0-34-generic

# Install Necessary Base Packages
apt-get install -y bridge-utils lsof lvm2 ntp ntpdate openssh-server sudo tcpdump

# Create The 'lxc' Volume Group
pvcreate --metadatasize 2048 /dev/sdb
vgcreate lxc /dev/sdb

# Configure Networking
cat >> /etc/network/interfaces <<EOF

# eth1
auto eth1
iface eth1 inet manual

# eth2
auto eth2
iface eth2 inet manual

# eth3
auto eth3
iface eth3 inet manual

# Bridge - Management
auto br-mgmt
iface br-mgmt inet static
    bridge_stp off
    bridge_waitport 0
    bridge_fd 0
    bridge_ports eth1
    address 192.168.56.60
    netmask 255.255.255.0

# Bridge VXLAN
auto br-vxlan
iface br-vxlan inet static
    bridge_stp off
    bridge_waitport 0
    bridge_fd 0
    bridge_ports eth2
    address 192.168.57.60
    netmask 255.255.255.0

# Bridge VLAN
auto br-vlan
iface br-vlan inet manual
    bridge_stp off
    bridge_waitport 0
    bridge_fd 0
    bridge_ports eth3
EOF

# Reboot
reboot
