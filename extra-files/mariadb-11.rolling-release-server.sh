#!/bin/bash


#curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'
#echo "deb [signed-by=/etc/apt/keyrings/mariadb-keyring.pgp] https://atl.mirrors.knownhost.com/mariadb/repo/11.rolling/ubuntu noble main" >  /etc/apt/sources.list.d/mariadb.list

#curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash

apt-get update
apt-get -y install mariadb-server

sed -i "s/LimitNOFILE=32768/LimitNOFILE=62768/"   /usr/lib/systemd/system/mariadb.service
systemctl daemon-reload

MYSQLPASSVPOP=`pwgen -c -1 15`
echo $MYSQLPASSVPOP > /usr/local/src/mariadb-mydbadmin-pass
echo "mydbadmin password in /usr/local/src/mariadb-mydbadmin-pass"

echo "GRANT ALL PRIVILEGES ON *.* TO mydbadmin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" with grant option | mariadb -uroot
mariadb-admin -uroot reload
mariadb-admin -uroot refresh

systemctl restart  mariadb

#mysqladmin -u root -ptmppassword status
#mysqladmin -u root -p extended-status
#mysqladmin -u root -p processlist

echo "Database Password Setup done."
