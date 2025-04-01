#!/bin/bash

## auto install apache2 and phpmyadmin
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y phpmyadmin libapache2-mod-php libapache2-mod-php8.3 libconfig-inifiles-perl  php-intl php-json php8.3-intl tnef php-pear php-apcu

