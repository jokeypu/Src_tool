EEE=mrh0Fit

bin1=200

x1_min=0.4
x1_max=3

tree1=fit5c
branch1=mrh0

namex='m(#rho^{0}) / GeV/c^{2}'
namey='Entries / 0.013GeV/c^{2}'
namet='Invariant Mass of #rho^{0} Distribution'

cp ../EEE.cxx ${EEE}.cxx
sed -i "s/@EEE@/$EEE/g;" ${EEE}.cxx
sed -i "s/@bin1@/$bin1/g;" ${EEE}.cxx
sed -i "s/@x1_min@/$x1_min/g;" ${EEE}.cxx
sed -i "s/@x1_max@/$x1_max/g;" ${EEE}.cxx
sed -i "s/@tree1@/$tree1/g;" ${EEE}.cxx
sed -i "s/@branch1@/$branch1/g;" ${EEE}.cxx
sed -i "s!@namex@!$namex!g;" ${EEE}.cxx
sed -i "s!@namey@!$namey!g;" ${EEE}.cxx
sed -i "s!@namet@!$namet!g;" ${EEE}.cxx

root ${EEE}.cxx
