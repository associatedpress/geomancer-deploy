# Activate process control, which manages gunicorn and worker processes
cp $CONFIG_PATH/files/supervisor.conf /etc/supervisor/conf.d/geomancer.conf
supervisorctl reread
supervisorctl update
