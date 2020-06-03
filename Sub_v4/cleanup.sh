rm -rf x_rtraw
rm -rf x_dst
rm -rf x_root
rm -rf txt-Sub
rm -rf txt-Sim
rm -rf txt-Rec
rm -rf txt-Ana

if [ -e fort.16 ];then
rm -rf fort*
fi

if [ -e phokhara_9.1.ffwarn ];then
rm -rf phokhara*
fi

mkdir x_rtraw
mkdir x_dst
mkdir x_root
mkdir txt-Sub
mkdir txt-Sim
mkdir txt-Rec
mkdir txt-Ana
