#!/bin/bash
cd /home/vagrant/api
python3 api_manager.py -v problems load /vagrant/example_problems/ graders/ ../problem_static/
python3 api_manager.py autogen build 100
devploy