config_path=$(echo $(pwd))
if [ -f $CMThome/cleanup.sh ];then
source $CMThome/cleanup.sh
fi
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
sed -i "s/#1#/echo '------ 10% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 10% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#2#/echo '------ 20% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 20% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#3#/echo '------ 30% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 30% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#4#/echo '------ 40% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 40% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#5#/echo '------ 50% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 50% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#6#/echo '------ 60% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 60% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#7#/echo '------ 70% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 70% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#8#/echo '------ 80% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 80% ------'; /#/g" $config_path/boss_config.sh;

cd $config_path
sed -i "s/#9#/echo '------ 90% ------'; /g" boss_config.sh;
source boss_config.sh 
sed -i "s/echo '------ 90% ------'; /#/g" $config_path/boss_config.sh;

echo '------ 100% ------'
mv $config_path/run.sh $config_path/.run.sh
