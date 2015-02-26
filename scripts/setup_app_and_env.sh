# NOTE: One or more vars are inherited from bootstrap.sh!!

# Get GEOMANCER project code
mkdir -p $HOME/code
cd $HOME/code
git clone https://github.com/associatedpress/geomancer.git
cd geomancer
git checkout $VERSION

# Activate and configure app
APP_CONFIG=$PROJECT_PATH/geomancer/app_config.py
cp $PROJECT_PATH/geomancer/app_config.py.example $APP_CONFIG
SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i "s/your secret key here/$SECRET_KEY/" $APP_CONFIG

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
