config_path=$(echo $(pwd))
if [ -f $HOME/.bashrc ];then
mv $HOME/.bashrc $HOME/.bashrc_old
fi
if [ -f $HOME/.profile ];then
mv $HOME/.profile $HOME/.profile_old
fi
cp $config_path/.bashrc_src $HOME/.bashrc
cp $config_path/.alias_src $HOME/.alias
cp $config_path/.tcell_src.sh $HOME/.tcell.sh
cp $config_path/.profile_src $HOME/.profile
cp $config_path/.cvs_log_src $HOME/.cvs_log
cp $config_path/.boss_config_src.sh $config_path/boss_config.sh
if [ ! -d $HOME/home ];then
mkdir $HOME/home
fi
source $HOME/.bashrc
cd $config_path
source boss_config.sh 
mv $config_path/run.sh $config_path/.run.sh
