#!/bin/bash

apt install -y ifupdown

# 1. Detect the primary active network interface
IFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

if [ -z "$IFACE" ]; then
    echo "Error: No active interface with a default gateway found."
    exit 1
fi

# 2. Read current network settings from the live interface
CURRENT_IP=$(ip addr show dev "$IFACE" | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
CURRENT_MASK=$(ip addr show dev "$IFACE" | grep 'inet ' | awk '{print $2}' | cut -d/ -f2)
CURRENT_GW=$(ip route | grep default | awk '{print $3}')
CURRENT_DNS=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}')

# Fallback to a public DNS if none is found in resolv.conf
if [ -z "$CURRENT_DNS" ]; then
    CURRENT_DNS="8.8.8.8 1.1.1.1"
fi

# Convert CIDR mask prefix (like /24) to dotted decimal netmask
case $CURRENT_MASK in
    16) NETMASK="255.255.0.0" ;;
    24) NETMASK="255.255.255.0" ;;
    *)  NETMASK="255.255.255.0" ;; # Default fallback
esac

echo "Detected Interface: $IFACE"
echo "Read Current IP:     $CURRENT_IP"
echo "Read Netmask:        $NETMASK"
echo "Read Gateway:        $CURRENT_GW"
echo "Read DNS:            $CURRENT_DNS"

# 3. Generate the static /etc/network/interfaces file
sudo bash -c "cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto $IFACE
iface $IFACE inet static
    address $CURRENT_IP
    netmask $NETMASK
    gateway $CURRENT_GW
    dns-nameservers $CURRENT_DNS
EOF"

echo "Static configuration generated successfully!"
