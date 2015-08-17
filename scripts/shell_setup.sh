#!/bin/bash

apt-get -y update
apt-get -y upgrade

apt-get -y install software-properties-common

apt-get -y update
apt-get -y upgrade

cd /vagrant/ctf-shell-manager
./install.sh

# modify config.py
DEPLOY_SECRET="@@@ChAnGeMe@@@"
echo -e "\nHOSTNAME = '192.168.2.3'\n" >> /opt/hacksports/config.py
echo -e "\nWEB_SERVER = 'http://192.168.2.2'\n" >> /opt/hacksports/config.py
echo -e "\nDEPLOY_SECRET = '$DEPLOY_SECRET'\n" >> /opt/hacksports/config.py

echo "Done"

echo "Setting permissions."
chmod -R 1710 /vagrant
chmod -R 1710 /var/cache/apt
chmod 1710 /etc/apt/sources.list
