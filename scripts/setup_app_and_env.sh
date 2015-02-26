# Get GEOMANCER project code
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
