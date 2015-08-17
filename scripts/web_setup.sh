#!/bin/bash

ROOT="/vagrant/ctf-infrastructure"

# Updates
apt-get -y update
apt-get -y upgrade

# CTF-Platform Dependencies
apt-get -y install python3-pip
apt-get -y install nginx
apt-get -y install mongodb
apt-get -y install gunicorn
apt-get -y install git
apt-get -y install libzmq-dev
apt-get -y install nodejs-legacy
apt-get -y install npm
apt-get -y install ruby-dev
apt-get -y install dos2unix
apt-get -y install tmux
apt-get -y install jekyll
apt-get -y install phantomjs

npm install -g coffee-script
npm install -g react-tools
npm install -g jsxhint
npm install -g coffee-react

pip3 install --upgrade $ROOT
# Configure Environment
echo "PATH=\$PATH:$ROOT/scripts" >> /etc/profile

# Configure Nginx
rm /etc/nginx/sites-enabled/default
cp $ROOT/config/ctf.nginx /etc/nginx/sites-enabled/ctf
mkdir -p /srv/http/ctf
service nginx restart

cp /vagrant/scripts/ctf.service /lib/systemd/system/
systemctl enable ctf.service
systemctl start ctf.service

api_manager database clear problems,bundles,submissions,users,teams,groups,shell_servers

python3 /vagrant/scripts/load_problems.py
python3 /vagrant/scripts/start_competition.py
