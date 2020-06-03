config_path=$(echo $(pwd))
cp $config_path/.bashrc_src $HOME/.bashrc
cp $config_path/.tcell_src.sh $HOME/.tcell.sh
cp $config_path/.profile_src $HOME/.profile
cp $config_path/.cvs_log_src $HOME/.cvs_log
cp $config_path/.boss_config_src.sh $config_path/boss_config.sh
if [ ! -d $HOME/home ];then
mkdir $HOME/home
fi
source $HOME/.bashrc
source $config_path/boss_config.sh 
