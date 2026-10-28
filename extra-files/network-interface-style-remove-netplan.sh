#!/bin/bash
apt purge -y netplan.io
rm -rf /etc/netplan/

systemctl disable systemd-networkd-wait-online.service --now
systemctl disable NetworkManager-wait-online.service --now
systemctl disable systemd-networkd.service --now
systemctl disable systemd-networkd.socket --now
/bin/rm /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf

systemctl disable systemd-resolved.service --now

systemctl disable ifupdown-wait-online.service --now
systemctl enable networking
apt -y autoremove
