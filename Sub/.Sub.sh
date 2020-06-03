#!/bin/bash
#
if [ $method -eq 2 ];then
case $j in
	1)
	echo 'Processing...   [Sim]'
	;;
	2)
	echo 'Processing...   [Rec]'
	;;
	3)
	echo 'Processing...   [Ana]'
	;;
	*)
	echo 'ERROR'
	;;
esac
else
echo 'Processing...'
sed -i "/^let j=/d" run.sh
sed -i "/method=1/alet j=1" run.sh
fi

Sub=$(echo $(pwd -LP))
if [ $method -eq 1 ]||([ $method -eq 2 ]&&[ $j -eq 1 ]);then

let S_Evt=Sim_Evt/N
let R_Evt=Rec_Evt/N
let A_Evt=Ana_Evt/N
source cleanup.sh

sed -i '/^NM=/d' Merge.sh
sed -i "/#!Bash/aNM=${NM}" Merge.sh

sed "s#S_Evt#$S_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" src/sim.txt > .cache/Nsim.txt
sed "s#R_Evt#$R_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" src/rec.txt > .cache/Nrec.txt
sed "s#A_Evt#$A_Evt#g;s#{NM}#$NM#g;s#{Sub}#$Sub#g;" src/ana.txt > .cache/Nana.txt
sed "s#{Sub}#$Sub#g;" src/sub.txt > .cache/Nsub.txt
for((i=0;i<N;i++))
do
	echo "------- $i -------"
	sed "s/NUM/$i/g;" .cache/Nsim.txt > txt-Sim/Sim_$i.txt
	sed "s/NUM/$i/g;" .cache/Nrec.txt > txt-Rec/Rec_$i.txt
	sed "s/NUM/$i/g;" .cache/Nana.txt > txt-Ana/Ana_$i.txt
	sed "s/NUM/$i/g;" .cache/Nsub.txt > txt-Sub/Sub_$i.txt

if [ $method -eq 1 ]; then                                                      
	sed -i "s/#ctrl#/boss.exe/g;" txt-Sub/Sub_$i.txt   
	chmod +x txt-Sub/Sub_$i.txt                            
	hep_sub -g physics txt-Sub/Sub_$i.txt    
fi                                                             

done

fi

if [ $method -eq 2 ]; then 
	for((i=0;i<N;i++)) do     	                                    
	sed -i "s/boss.exe/#ctrl#/g;" txt-Sub/Sub_$i.txt
	sed -i "s/#step${j}/echo \"step${j}_${i}:\";/;" txt-Sub/Sub_${i}.txt  
	source txt-Sub/Sub_$i.txt                                           
	sed -i "s/echo \"step${j}_${i}:\";/#step${j}/;" txt-Sub/Sub_${i}.txt  
	done                                                                
        nj=` expr ${j} % 3 + 1`
        sed -i "s/j=${j}/j=${nj}/g;" run.sh
fi
#
