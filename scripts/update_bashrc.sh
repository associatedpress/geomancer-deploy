# NOTE: One or more vars are inherited from bootstrap.sh!!

cp $HOME/.bashrc $HOME/.bashrc_backup
cat $CONFIG_PATH/files/bashrc_extras.sh >> $HOME/.bashrc
source $HOME/.bashrc
