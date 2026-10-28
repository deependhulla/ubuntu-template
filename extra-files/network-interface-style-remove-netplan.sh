
apt purge -y netplan.io
rm -rf /etc/netplan/

systemctl disable systemd-networkd-wait-online.service --now
systemctl disable NetworkManager-wait-online.service --now
systemctl disable systemd-networkd.service --now
systemctl disable systemd-networkd.socket --now

systemctl disable ifupdown-wait-online.service --now
systemctl enable networking

