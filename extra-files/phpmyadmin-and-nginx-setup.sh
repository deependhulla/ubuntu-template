#!/bin/bash

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password" | sudo debconf-set-selections
#echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections

apt install -y nginx-full certbot python3-certbot-nginx 
 apt install -y phpmyadmin
 apt-get -y remove apache2
