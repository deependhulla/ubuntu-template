#!/bin/bash

## only to change from default (ubuntu24-template) -- not for reassign -- 

HOSTNAME=myweb.deependhulla.com

sed -i -e "s/ubuntu24-template/$HOSTNAME/" /etc/hosts
sed -i -e "s/ubuntu24-template/$HOSTNAME/" /etc/hostname
hostnamectl hostname $HOSTNAME

echo "HostName:"
hostname -f 
ping -c 2 $HOSTNAME
