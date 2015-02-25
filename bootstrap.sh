#!/bin/bash

# GEOMANCER server setup script for Ubuntu 14.04
# Must be executed with sudo!

set -x
exec 1> >(tee /var/log/geomancer-install.log) 2>&1

echo "Geomancer installation beginning."

GEO_USER="ubuntu"
# This config will be written to nginx vhost"
VERSION="master"
REDIS_VER="2.8.9"
CONFIG_PATH="$HOME/code/geomancer-deploy"
PROJECT_PATH="$HOME/code/geomancer"

# Update repos
apt-add-repository -y ppa:chris-lea/redis-server
apt-get --yes update
apt-get --yes upgrade

# Install OS dependencies
apt-get install --yes git python2.7-dev nginx build-essential python-pip redis-server supervisor

# Install python dependencies
pip install --user virtualenv
pip install --user virtualenvwrapper

# Add bashrc config vars
cat $CONFIG_PATH/bashrc_extras.sh >> $HOME/.bashrc
source $HOME/.bashrc

# Get GEOMANCER project code
mkdir $HOME/code
cd $HOME/code
git clone https://github.com/associatedpress/geomancer.git
cd geomancer
git checkout $VERSION

# Activate and configure app
APP_CONFIG=$PROJECT_PATH/geomancer/app_config.py
cp $PROJECT_PATH/app_config.py.example $APP_CONFIG
SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i '' "s/your secret key here/$SECRET_KEY/" $APP_CONFIG

# Create virtualenv, link to project code, and install reqs
mkvirtualenv -a $PROJECT_PATH -r $PROJECT_PATH/requirements.txt geomancer

# Activate process control, which manages gunicorn and worker processes
cp $CONFIG_PATH/files/supervisor.conf /etc/supervisor/conf.d/geomancer.conf
supervisorctl reread
supervisorctl update

# Customize and activate web configuration
NGINX_CONF=/etc/nginx/sites-available/geomancer.conf
cp $CONFIG_PATH/files/nginx.conf $NGINX_CONF
sed -i '' "s/STUB_SERVER_NAME/$GEOMANCER_SERVER_NAME/" $NGINX_CONF
ln -s $NGINX_CONF /etc/nginx/sites-enabled/geomancer.conf
rm /etc/nginx/sites-enabled/default
service nginx restart

echo "GEOMANCER installation complete."
