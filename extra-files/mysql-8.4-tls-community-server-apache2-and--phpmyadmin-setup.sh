#!/bin/bash
wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb -O /tmp/mysql-apt-config_0.8.33-1_all.deb

echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/mysql-apt-config_0.8.33-1_all.deb
apt-get update
apt-get -y install mysql-server

## auto install apache2 and phpmyadmin
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y phpmyadmin

