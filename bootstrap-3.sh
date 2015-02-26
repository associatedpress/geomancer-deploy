#!/bin/bash

# GEOMANCER server setup script for Ubuntu 14.04
# Run this script as sudo!

set -x
exec 1> >(tee /var/log/geomancer-install.log) 2>&1

echo "Geomancer app activation beginning."

# Activate process control, which manages gunicorn and worker processes
cp files/supervisor.conf /etc/supervisor/conf.d/geomancer.conf
supervisorctl reread
supervisorctl update

# Customize and activate web configuration
NGINX_CONF=/etc/nginx/sites-available/geomancer.conf
cp files/nginx.conf $NGINX_CONF
sed -i "s/STUB_SERVER_NAME/$1/" $NGINX_CONF
ln -s $NGINX_CONF /etc/nginx/sites-enabled/geomancer.conf
rm /etc/nginx/sites-enabled/default
service nginx restart

echo "Geomancer app activation ending."
