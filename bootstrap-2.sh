#!/bin/bash

# GEOMANCER server setup script for Ubuntu 14.04
# Must be executed with sudo!

set -x
exec 1> >(tee /var/log/geomancer-install.log) 2>&1

echo "Geomancer installation beginning."

VERSION="master"
REDIS_VER="2.8.9"
export CONFIG_PATH=$HOME/code/geomancer-deploy
export SCRIPTS=$CONFIG_PATH/scripts
export PROJECT_PATH=$HOME/code/geomancer

$SCRIPTS/install_dependencies.sh
sudo -u ubuntu $SCRIPTS/update_bashrc.sh
source $HOME/.bashrc
sudo -u ubuntu $SCRIPTS/setup_app_and_env.sh
$SCRIPTS/activate_process_control.sh
$SCRIPTS/activate_vhost.sh

echo "GEOMANCER installation complete."
