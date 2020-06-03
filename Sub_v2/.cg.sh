#cgn=('5000' '5001' '5002')
cgn=('' '' '')



NNN=${#cgn[@]}
for((i=0;i<NNN;i++))
do
sed -i "s/\"Rhopi_bkg_${cgn[$i]}.dst\",//g;" list_dst.txt
sed -i "s/\"Rhopi_bkg_${cgn[$i]}.dst\",//g;" ../x_dst/ana_ONE.txt
done
