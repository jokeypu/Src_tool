cp .bashrc_src $HOME/.bashrc
cp .tcell_src.sh $HOME/.tcell.sh
cp .profile_src $HOME/.profile
cp .cvs_log_src $HOME/.cvs_log
if [ ! -d $HOME/home ];then
mkdir $HOME/home
fi
source $HOME/.bashrc
