# Customize and activate web configuration
NGINX_CONF=/etc/nginx/sites-available/geomancer.conf
cp $CONFIG_PATH/files/nginx.conf $NGINX_CONF
sed -i '' "s/STUB_SERVER_NAME/$GEOMANCER_SERVER_NAME/" $NGINX_CONF
ln -s $NGINX_CONF /etc/nginx/sites-enabled/geomancer.conf
rm /etc/nginx/sites-enabled/default
service nginx restart
