if [ -d $HOME/home ];then
mv $HOME/home $HOME/home_old
fi
mkdir $HOME/home
if [ -d /workfs/bes/${USER}/workarea ];then
mv /workfs/bes/${USER}/workarea /workfs/bes/${USER}/workarea_old
fi
if [ ! -d $HOME/workfs ];then
ln -s /workfs/bes/${USER} $HOME/workfs
fi
cp -r /afs/ihep.ac.cn/users/p/puqing/Src_tool/config  $HOME/home
mv $HOME/home/config/ $HOME/home/MyConfig
cd $HOME/home/MyConfig
source run.sh
