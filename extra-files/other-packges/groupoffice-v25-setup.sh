#!/bin/bash


echo "deb http://repo.group-office.com/ twentyfivezero main" > /etc/apt/sources.list.d/groupoffice.list
wget -qO - https://repo.group-office.com/downloads/groupoffice.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/groupoffice.gpg
apt-get update
apt-get install groupoffice --install-recommends
