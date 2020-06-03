if [ $master == 'master' ]&&[ -f "$My_Cmthome/cmthome/cmthome-$VN/setup.sh" ];then
source $My_Cmthome/cmthome/cmthome-$VV/cleanup.sh;
source $My_Cmthome/cmthome/cmthome-$VN/setup.sh;
sed -i "s/VV=$VV/VV=$VN/g" $HOME/.bashrc;
sed -i "s/OV=$OV/OV=$TV/g" $HOME/.bashrc;
master="s";
echo $CMTPATH
echo "Already switched to BOSS-$VN!"
source $HOME/.bashrc;
else
echo "Error!";
fi
