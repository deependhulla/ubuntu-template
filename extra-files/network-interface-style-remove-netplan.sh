#!/bin/bash
apt purge -y netplan.io
rm -rf /etc/netplan/

systemctl disable systemd-networkd-wait-online.service --now
systemctl disable NetworkManager-wait-online.service --now 2>/dev/null
systemctl disable systemd-networkd.service --now
systemctl disable systemd-networkd.socket --now
/bin/rm /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf

systemctl disable systemd-resolved.service --now

systemctl disable ifupdown-wait-online.service --now
systemctl enable networking
apt -y autoremove

# 1. Create the systemd drop-in directory if it doesn't exist
sudo mkdir -p /etc/systemd/system/networking.service.d

# 2. Write the dependency configurations directly to the override file
sudo bash -c "cat <<EOF > /etc/systemd/system/networking.service.d/override.conf
[Unit]
After=udev.service network-pre.target systemd-sysctl.service
Wants=network-pre.target
EOF"

# 3. Reload the systemd engine to apply the new boot sequence ordering
sudo systemctl daemon-reload

