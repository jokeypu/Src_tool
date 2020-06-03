#	pp='Charged_tc'
##	SSS='Rxy'	#V#
##	SSS='Rz'	#V#
##	SSS='costheta'	#V#
#	SSS='Ppippim'

#	pp='Neutral_tc'
#	SSS='alpha'	#V#
#	SSS='Egamma'	#V#
#	SSS='T'		#V#

#	pp='PID'
##	SSS='Prob'	#V#

	pp='Kinematic_fit'
##	SSS='chi2_4C'	#V#
	SSS='chi2_5C'

##	pp='Physics'
##	SSS='Etot'	#V#
##	SSS='mrh0'	#V#
##	SSS='Ngood'	#V#
##	SSS='Nchag'	#V#
##	SSS='Ngam'	#V#

xx=1
if [ 1 -eq $xx ]; then

	bin1=200
	bin2=$bin1

	x1_min=0
	x1_max=200
	x2_min=$x1_min
	x2_max=$x1_max

	tree1='fit5c'
	branch1='chi2'
	tree2=$tree1
	branch2=$branch1

	namex='#chi^{2}_{5C}'
        namey='Entries ("+bb+")'

#	x2_min=
#	x2_max=
#	tree2=''
#	branch2=''

cp .plot.sh $pp/.plot_${SSS}.sh
sed -i "s/#SSS#/$SSS/g;" $pp/.plot_${SSS}.sh
sed -i "s/#bin1#/$bin1/g;" $pp/.plot_${SSS}.sh
sed -i "s/#bin2#/$bin2/g;" $pp/.plot_${SSS}.sh
sed -i "s/#x1_min#/$x1_min/g;" $pp/.plot_${SSS}.sh
sed -i "s/#x1_max#/$x1_max/g;" $pp/.plot_${SSS}.sh
sed -i "s/#x2_min#/$x2_min/g;" $pp/.plot_${SSS}.sh
sed -i "s/#x2_max#/$x2_max/g;" $pp/.plot_${SSS}.sh
sed -i "s/#tree1#/$tree1/g;" $pp/.plot_${SSS}.sh
sed -i "s/#branch1#/$branch1/g;" $pp/.plot_${SSS}.sh
sed -i "s/#tree2#/$tree2/g;" $pp/.plot_${SSS}.sh
sed -i "s/#branch2#/$branch2/g;" $pp/.plot_${SSS}.sh
sed -i "s!#namex#!$namex!g;" $pp/.plot_${SSS}.sh
sed -i "s!#namey#!$namey!g;" $pp/.plot_${SSS}.sh
echo "Done!"
fi

cd $pp/
. .plot_${SSS}.sh
cd -
#.
#├── bes3plotstyle.C
#├── bes3plotstyle.h
#├── Charged_tc
#│   ├── Picture
#│   ├── plot_costheta.sh
#│   ├── plot_Ppippim.sh
#│   ├── plot_Rxy.sh
#│   └── plot_Rz.sh
#├── cp.sh
#├── gai.sh
#├── Kinematic_fit
#│   ├── Picture
#│   ├── plot_4cchi2.sh
#│   └── plot_5cchi2.sh
#├── Neutral_tc
#│   ├── Picture
#│   ├── plot_alpha.sh
#│   ├── plot_Egamma.sh
#│   └── plot_T.sh
#├── PID
#│   ├── Picture
#│   └── plot_prob.sh
#├── plot.sh
#├── Rhopi_inclusive.root
#├── Rhopi_sigal.root
#└── SSS.C
