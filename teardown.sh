# Command must be run as sudo!
set -x

echo "Geomancer uninstall process beginning."
rm -rf $HOME/code/geomancer

rm /etc/nginx/sites-enabled/geomancer.conf
ln -s /etc/nginx/sites-available/defaul
/etc/nginx/sites-enabled/default
service nginx reload

cp /etc/supervisor/conf.d/geomancer.conf
supervisorctl reread
supervisorctl update

rmvirtualenv geomancer

cat $HOME/.bashrc_backup > $HOME/.bashrc
source $HOME/.bashrc

echo "Geomancer uninstall process complete"
