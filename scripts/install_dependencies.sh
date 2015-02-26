# Update repos
apt-add-repository -y ppa:chris-lea/redis-server
apt-get --yes update
apt-get --yes upgrade

# Install OS dependencies
apt-get install --yes git python2.7-dev nginx build-essential python-pip redis-server supervisor

# Install python dependencies
pip install --user virtualenv
pip install --user virtualenvwrapper
