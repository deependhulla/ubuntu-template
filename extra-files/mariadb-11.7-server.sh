#!/bin/bash


curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'
echo "deb [signed-by=/etc/apt/keyrings/mariadb-keyring.pgp] https://atl.mirrors.knownhost.com/mariadb/repo/11.rolling/ubuntu noble main" >  /etc/apt/sources.list.d/mariadb.list

