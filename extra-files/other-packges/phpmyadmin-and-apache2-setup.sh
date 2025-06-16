#!/bin/bash

## auto install apache2 and phpmyadmin
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y phpmyadmin libapache2-mod-php libapache2-mod-php8.3 libconfig-inifiles-perl  php-intl php-json php8.3-intl tnef php-pear php-apcu php-phpdbg poppler-utils

a2enmod actions > /dev/null 2>&1
a2enmod proxy_fcgi > /dev/null 2>&1
a2enmod fcgid > /dev/null 2>&1
a2enmod alias > /dev/null 2>&1
a2enmod suexec > /dev/null 2>&1
a2enmod rewrite > /dev/null 2>&1
a2enmod ssl > /dev/null 2>&1
a2enmod actions > /dev/null 2>&1
a2enmod include > /dev/null 2>&1
a2enmod dav_fs > /dev/null 2>&1
a2enmod dav > /dev/null 2>&1
a2enmod auth_digest > /dev/null 2>&1
a2enmod cgi > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
a2enmod proxy_http > /dev/null 2>&1
systemctl stop apache2

systemctl start apache2
