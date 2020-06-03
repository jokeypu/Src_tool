EEE=#EEE#

bin1=#bin1#

x1_min=#x1_min#
x1_max=#x1_max#

tree1=#tree1#
branch1=#branch1#

namex='#namex#'
namey='#namey#'
namet='#namet#'

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
