#!/bin/bash

## please note it would remove mariadb

wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb -O /tmp/mysql-apt-config_0.8.33-1_all.deb

echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/mysql-apt-config_0.8.33-1_all.deb
apt-get update
apt-get  install mysql-server



