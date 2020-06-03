#--------------------------
#Author:puqing
#email:puqing@ihep.ac.cn
#2019.12.5
#--------------------------
#Config
#
#################################################
#VN=7.0.5;	let TV=86;			#
VN=7.0.4;	let TV=86;			#
#VN=7.0.3;	let TV=86;			#
#VN=6.6.5;	let TV=86;			#
#VN=6.6.4;	let TV=80;			#
#-----------------------------------------------#
export MyWorkarea="$HOME/home";	        	#
export MyCmthome="$HOME/home";            	#
#################################################
#
#
#
if [ -f run.sh ];then
mv run.sh .run.sh;
fi
if [ -f $My_Cmthome/cmthome/cmthome-$VV/cleanup.sh ];then
source $My_Cmthome/cmthome/cmthome-$VV/cleanup.sh;
fi
if [ ! -d $MyCmthome/cmthome ];then
	mkdir $MyCmthome/cmthome;
fi
if [ ! -d $MyWorkarea/workarea ];then
	mkdir $MyWorkarea/workarea;
fi
cd $MyCmthome/cmthome;
if [ -d cmthome-$VN ];then
	rm -rf cmthome-$VN;
fi
mkdir $MyCmthome/cmthome/cmthome-$VN;
cd $MyWorkarea/workarea;
if [ -d workarea-$VN ];then
	rm -rf workarea-$VN;
fi
mkdir $MyWorkarea/workarea/workarea-$VN;
cp /afs/ihep.ac.cn/bes3/offline/Boss/cmthome/cmthome-$VN/* $MyCmthome/cmthome/cmthome-$VN;
cd $MyCmthome/cmthome/cmthome-$VN;
if [ $TV -eq 80 ];then
	OLD='#set WorkArea "/ihepbatch/bes/maqm/workarea"';
	NEW="set WorkArea \"$MyWorkarea/workarea/workarea-$VN\"";
else
	OLD='#macro WorkArea "/ihepbatch/bes/maqm/workarea"';
	NEW="macro WorkArea \"$MyWorkarea/workarea/workarea-$VN\"";
fi
sed -i "s:${OLD}:${NEW}:g" requirements;
sed -i 's/#path_prepend CMTPATH "${WorkArea}"/path_prepend CMTPATH "${WorkArea}"/g' requirements;
sed -i 's/#path_remove CMTPATH  "${WorkArea}"/path_remove CMTPATH  "${WorkArea}"/g' requirements;
sed -i 's/maqm@/bes3@/g' setupCVS.sh;
source setupCMT.sh;
source setupCVS.sh;
if [ -f $HOME/.cvs_log ];then
rm -f $HOME/.cvs_log;
echo "------********|| CVS password: bes3charm ||********------";
cvs login;
fi
cmt config;
source setup.sh;
cd $MyWorkarea/workarea/workarea-$VN;
cmt co -r TestRelease-00-00-$TV TestRelease;
cmt co -r RhopiAlg-00-00-23 Analysis/Physics/RhopiAlg;
source $MyWorkarea/workarea/workarea-$VN/TestRelease/TestRelease-00-00-$TV/cmt/setup.sh;
echo '$CMTPATH:'
echo $CMTPATH;
sed -i "s/VV=$VV/VV=$VN/g" $HOME/.bashrc;
sed -i "s/OV=$OV/OV=$TV/g" $HOME/.bashrc;
sed -i "s:export My_Workarea=\"$My_Workarea\":export My_Workarea=\"$MyWorkarea\":g" $HOME/.bashrc;
sed -i "s:export My_Cmthome=\"$My_Cmthome\":export My_Cmthome=\"$MyCmthome\":g" $HOME/.bashrc;
echo "Boss $VN";
echo "$MyWorkarea/workarea/workarea-$VN";
echo "$MyCmthome/cmthome/cmthome-$VN";
source $HOME/.bashrc;
echo "Done!";
#End config
