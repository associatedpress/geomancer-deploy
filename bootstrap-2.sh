#!/bin/bash

# GEOMANCER server setup script for Ubuntu 14.04
# Run this script as a normal user (not sudo!)

set -x
exec 1> >(tee /var/log/geomancer-install.log) 2>&1

echo "Geomancer app install and configuration beginning."

VERSION="master"
PROJECT_PATH=$HOME/code/geomancer

# Get GEOMANCER project code
cd $HOME/code
git clone https://github.com/associatedpress/geomancer.git
cd geomancer
git checkout $VERSION

# Activate and configure app
APP_CONFIG=$PROJECT_PATH/geomancer/app_config.py
cp $PROJECT_PATH/geomancer/app_config.py.example $APP_CONFIG
SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i "s/your secret key here/$SECRET_KEY/" $APP_CONFIG

source $HOME/.local/bin/virtualenvwrapper.sh
# PATH export makes virtualenv binary visible to virtualenvwrapper shell functions
export PATH=$PATH:$HOME/.local/bin

# Create virtualenv, link to project code, and install reqs
mkvirtualenv -a $PROJECT_PATH -r $PROJECT_PATH/requirements.txt geomancer

echo "Geomancer app install and configuration ending."
