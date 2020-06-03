#!/bin/bash
#########################
let Sim_Evt=10
let Rec_Evt=10
let Ana_Evt=10
let N=2
NM=Rhopi
#########################
let S_Evt=Sim_Evt/N
let R_Evt=Rec_Evt/N
let A_Evt=Ana_Evt/N

rm list/*.txt
kk=0
for((i=0;i<N;i++))
do
kk=` expr $kk + 1`
if [ $kk -eq 5 ]; then
echo -e "\"${NM}_${i}.rtraw\",">>list/list_rtraw.txt
echo -e "\"${NM}_${i}.dst\",">>list/list_dst.txt
echo -e "\"${NM}_${i}.root\",">>list/list_root.txt
kk=0
else
echo -e "\"${NM}_${i}.rtraw\",\c">>list/list_rtraw.txt
echo -e "\"${NM}_${i}.dst\",\c">>list/list_dst.txt
echo -e "\"${NM}_${i}.root\",\c">>list/list_root.txt
fi
done

Sub=$(echo $(pwd))
sed "s#S_Evt#$S_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" TSource/sim.txt > cache/Nsim.txt
sed "s#R_Evt#$R_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" TSource/rec.txt > cache/Nrec.txt
sed "s#A_Evt#$A_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" TSource/ana.txt > cache/Nana.txt
sed "s#{Sub}#$Sub#g;" TSource/sub.txt > cache/Nsub.txt

for((i=0;i<N;i++))
do
	echo "------- $i -------"
	sed "s/NUM/$i/g;" cache/Nsim.txt > txt-Sim/Sim_$i.txt
	sed "s/NUM/$i/g;" cache/Nrec.txt > txt-Rec/Rec_$i.txt
	sed "s/NUM/$i/g;" cache/Nana.txt > txt-Ana/Ana_$i.txt
	sed "s/NUM/$i/g;" cache/Nsub.txt > txt-Sub/Sub_$i.txt
#	
########################### Method 1 ###########################
#                                                              #
#	sed -i "s/#ctrl#/echo "info";/g;" txt-Sub/Sub_$i.txt   #
#	chmod +x txt-Sub/Sub_$i.txt                            #
#	hep_sub -g physics  txt-Sub/Sub_$i.txt                 #
#	sed -i "s/echo "info";/#ctrl#/g;" txt-Sub/Sub_$i.txt   #
#                                                              #
################################################################
#

done

#
########################### Method 2 ########################################
#                                                                           #
#	let j=1     	# j=1:Sim   j=2:Rec  j=3:Ana #	                    #
#	for((i=0;i<N;i++)) do     	                                    #
#	sed -i "s/#step${j}/echo "step${j}_${i}:";/;" txt-Sub/Sub_${i}.txt  #
#	source txt-Sub/Sub_$i.txt                                           #
#	sed -i "s/echo "step${j}_${i}:";/#step${j}/;" txt-Sub/Sub_${i}.txt  #
#	done                                                                #
#############################################################################
#
