#!/bin/bash

apt purge snapd -y
apt purge -y gnome-software-plugin-snap

touch /etc/cloud/cloud-init.disabled
systemctl disable --now cloud-init cloud-init-local cloud-config cloud-final
systemctl disable --now apport
systemctl disable --now multipathd
systemctl disable --now ModemManager
systemctl disable --now packagekit
systemctl disable --now networkd-dispatcher
systemctl disable --now udisks2.service
systemctl disable --now postfix
systemctl disable --now polkit.service
systemctl disable --now unattended-upgrades.service
rm -rf /var/cache/snapd/
rm -rf ~/snap

echo "" > /etc/apt/preferences.d/nosnap.pref
echo "Package: snapd" >> /etc/apt/preferences.d/nosnap.pref
echo "Pin: release a=*" >> /etc/apt/preferences.d/nosnap.pref
echo "Pin-Priority: -10" >> /etc/apt/preferences.d/nosnap.pref


sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches

#sudo vi /etc/sysctl.conf
#vm.vfs_cache_pressure = 200
#sysctl -p

##docker system prune -a --volumes 


systemctl disable systemd-time-wait-sync.service
systemctl disable gnome-remote-desktop.service
sudo systemctl disable cups.service

sudo systemctl stop apport.service whoopsie.service
sudo systemctl disable apport.service whoopsie.service

sudo systemctl stop unattended-upgrades
sudo systemctl disable unattended-upgrades

sudo systemctl mask packagekit
sudo systemctl mask apport
sudo systemctl mask atd
sudo systemctl mask multipathd


