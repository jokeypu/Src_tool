#	pp='Charged_tc'
#	EEE='Rxy'
##	EEE='Rz'	#V#
#	EEE='costheta'
#	EEE='Ppippim'

#	pp='Neutral_tc'
#	EEE='alpha'	#V#
#	EEE='Egamma'
#	EEE='T'

#	pp='PID'
#	EEE='prob'

#	pp='Kinematic_fit'
#	EEE='4cchi2'
#	EEE='5cchi2'

	pp='Physics'
#	EEE='Etot'
##	EEE='mrh0Fit'

xx=0
if [ 1 -eq $xx ]; then

	bin1=200

	x1_min=0.4
	x1_max=3

	tree1='fit5c'
	branch1='mrh0'

	namex='m(#rho^{0}) / GeV/c^{2}'
	namey='Entries / "+bb+"GeV/c^{2}'
	namet='Invariant Mass of #rho^{0} Distribution'

cp .fit.sh $pp/.fit_${EEE}.sh
sed -i "s/#EEE#/$EEE/g;" $pp/.fit_${EEE}.sh
sed -i "s/#bin1#/$bin1/g;" $pp/.fit_${EEE}.sh
sed -i "s/#x1_min#/$x1_min/g;" $pp/.fit_${EEE}.sh
sed -i "s/#x1_max#/$x1_max/g;" $pp/.fit_${EEE}.sh
sed -i "s/#tree1#/$tree1/g;" $pp/.fit_${EEE}.sh
sed -i "s/#branch1#/$branch1/g;" $pp/.fit_${EEE}.sh
sed -i "s!#namex#!$namex!g;" $pp/.fit_${EEE}.sh
sed -i "s!#namey#!$namey!g;" $pp/.fit_${EEE}.sh
sed -i "s!#namet#!$namet!g;" $pp/.fit_${EEE}.sh
echo "Done!"
fi

cd $pp/
. .fit_${EEE}.sh
cd -
#.
#├── bes3fitstyle.C
#├── bes3fitstyle.h
#├── Charged_tc
#│   ├── Picture
#│   ├── fit_costheta.sh
#│   ├── fit_Ppippim.sh
#│   ├── fit_Rxy.sh
#│   └── fit_Rz.sh
#├── cp.sh
#├── gai.sh
#├── Kinematic_fit
#│   ├── Picture
#│   ├── fit_4cchi2.sh
#│   └── fit_5cchi2.sh
#├── Neutral_tc
#│   ├── Picture
#│   ├── fit_alpha.sh
#│   ├── fit_Egamma.sh
#│   └── fit_T.sh
#├── PID
#│   ├── Picture
#│   └── fit_prob.sh
#├── fit.sh
#├── Rhopi_inclusive.root
#├── Rhopi_sigal.root
#└── EEE.C
