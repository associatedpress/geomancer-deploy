# Debugging script. Does not restore environment to a totally clean state.
# Command must be run as sudo!
set -x

echo "Geomancer uninstall process beginning."
rm -rf $HOME/code/geomancer

rm -f /etc/nginx/sites-enabled/geomancer.conf
ln -nsf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx reload

rm -f /etc/supervisor/conf.d/geomancer.conf
supervisorctl reread
supervisorctl update

source $HOME/.local/bin/virtualenvwrapper.sh
rmvirtualenv geomancer

cat $HOME/.bashrc_backup > $HOME/.bashrc

echo "Geomancer uninstall process complete"
