#--------------------------
#Author:puqing
#email:puqing@ihep.ac.cn
#2019.12.5
#--------------------------
#Config
#
##############################################################
#1#VN=6.6.4;            AD=''                    let TV=80;  #
#2#VN=6.6.4.p01;        AD=''                    let TV=80;  #
#3#VN=6.6.4.p02;        AD=''                    let TV=80;  #
#4#VN=6.6.4.p03;        AD=''                    let TV=80;  #
#5#VN=6.6.5.p01;        AD='-Slc6Centos7Compat'; let TV=86;  #
#6#VN=7.0.3;            AD='-Slc6Centos7Compat'; let TV=86;  #
#7#VN=7.0.3.p01;        AD='-Slc6Centos7Compat'; let TV=86;  #
#8#VN=7.0.3.p02;        AD='-Slc6Centos7Compat'; let TV=86;  #
#9#VN=7.0.4;            AD='-Slc6Centos7Compat'; let TV=86;  #
#10#VN=7.0.5;           AD='-Slc6Centos7Compat'; let TV=86;  #
#------------------------------------------------------------#
export MyWorkarea="/workfs/bes/${USER}";                     #
export MyCmthome="$HOME/home";                               #
##############################################################
#
#
#
config_path=$(echo $(pwd));
echo WN=$VN  > $HOME/.cash;
sed -i "s/\.//g" $HOME/.cash;
source $HOME/.cash;
rm -f $HOME/.cash;
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
cp /cvmfs/bes3.ihep.ac.cn/bes3sw/cmthome/cmthome-${VN}${AD}/* $MyCmthome/cmthome/cmthome-$VN;
cd $MyCmthome/cmthome/cmthome-$VN;
if [ $TV -eq 80 ];then
	OLD='#set WorkArea "/ihepbatch/bes/maqm/workarea"';
	NEW="set WorkArea \"$MyWorkarea/workarea/workarea-$VN\"";
else
	OLD='#macro WorkArea "/ihepbatch/bes/maqm/workarea"';
	NEW="macro WorkArea \"$MyWorkarea/workarea/workarea-$VN\"";
fi
sed -i "/#Add your worarea to CMTPATH/a${NEW}" requirements;
sed -i 's/#path_prepend CMTPATH "${WorkArea}"/path_prepend CMTPATH "${WorkArea}"/g' requirements;
sed -i 's/#path_remove CMTPATH  "${WorkArea}"/path_remove CMTPATH  "${WorkArea}"/g' requirements;
sed -i 's/maqm@/bes3@/g' setupCVS.sh;
source setupCMT.sh;
source setupCVS.sh;
aa=$(which expect);
if [ -z $aa ];then
if [ -f $HOME/.cvs_log ];then
rm -f $HOME/.cvs_log;
echo "------********|| CVS password: bes3charm ||********------";
cvs login;
fi
else
echo 'set timeout 10
spawn cvs login
expect "password:"
send "bes3charm\r"
interact' > $config_path/.log.expect;
expect $config_path/.log.expect;
rm -rf $config_path/.log.expect;
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
echo "alias Boss$WN=\"VN=$VN;let TV=$TV;master=master;source $HOME/.tcell.sh\"" >> $HOME/.alias;
sort -u $HOME/.alias -o $HOME/.alias;
echo "Boss $VN";
echo "$MyWorkarea/workarea/workarea-$VN";
echo "$MyCmthome/cmthome/cmthome-$VN";
source $HOME/.bashrc;
echo "Done!";
cd $config_path;
#End config
