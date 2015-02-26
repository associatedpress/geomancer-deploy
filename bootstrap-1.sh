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
apt-get install --yes git python2.7-dev nginx build-essential python-pip redis-server supervisor

# Install python dependencies
pip install --user virtualenv
pip install --user virtualenvwrapper

echo "Geomancer dependency installation ending."
