#cgn=('5000' '5001' '5002')
cgn=('' '' '')
#
#
#
NNN=${#cgn[@]}
for((i=0;i<NNN;i++))
do
hep_sub -g physics txt-Sub/Sub_${cgn[$i]}.txt
done
