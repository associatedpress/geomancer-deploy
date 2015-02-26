#!/bin/bash

# GEOMANCER server setup script for Ubuntu 14.04
# Run this script as sudo!!
set -x
exec 1> >(tee /var/log/geomancer-install.log) 2>&1

echo "Geomancer dependency installation beginning."

# Update repos
apt-add-repository -y ppa:chris-lea/redis-server
apt-get --yes update
apt-get --yes upgrade

# Install OS dependencies
apt-get install --yes git python2.7-dev nginx build-essential python-pip redis-server supervisor libxml2 libxml2-dev libxslt1-dev zlib1g-dev

# Install python dependencies
pip install --user virtualenv
pip install --user virtualenvwrapper

# Update BASHRC with virtualenv and path settings
cp $HOME/.bashrc $HOME/.bashrc_backup
cat files/bashrc_extras.sh >> $HOME/.bashrc

echo "Geomancer dependency installation ending."
