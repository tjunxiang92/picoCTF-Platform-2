#!/bin/bash

# Shift to root
mkdir -p /vagrant
mv config /vagrant
mv example_problems /vagrant

# Home Folder
mkdir -p /home/vagrant
mv api web scripts /home/vagrant
mkdir -p /home/vagrant/problem_static

# Make Web Folder
mkdir -p /srv/http/ctf

# Call the setup file
/home/vagrant/scripts/vagrant_setup.sh

# Add Path Variable
echo "Setting Path Variable"
export PATH=$PATH:/home/vagrant/scripts
source /etc/profile

# Reset Pymonogo
echo "Reinstalling pymongo"
pip3 uninstall -y bson
pip3 uninstall -y pymongo
pip3 install pymongo==2.7.1

# Run User tests
echo "Running User Tests"
cd /home/vagrant/api
./run_tests.sh

echo "Updating Puzzles"
update_puzzles.sh

echo "Setup Complete"
echo "Please update IP in /home/vagrant/api/api/config.py api.app.session_cookie_domain"
echo "nano /home/vagrant/api/api/config.py"
