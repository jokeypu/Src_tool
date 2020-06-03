SSS=Ngood

bin1=14
bin2=14

x1_min=0
x1_max=14
x2_min=0
x2_max=14

tree1=AAA
branch1=nGood
tree2=AAA
branch2=nGood

namex='N_{Good}'
namey='Entries ("+bb+")'

cp ../SSS.C ${SSS}.C
sed -i "s/@SSS@/$SSS/g;" ${SSS}.C
sed -i "s/@bin1@/$bin1/g;" ${SSS}.C
sed -i "s/@bin2@/$bin2/g;" ${SSS}.C
sed -i "s/@x1_min@/$x1_min/g;" ${SSS}.C
sed -i "s/@x1_max@/$x1_max/g;" ${SSS}.C
sed -i "s/@x2_min@/$x2_min/g;" ${SSS}.C
sed -i "s/@x2_max@/$x2_max/g;" ${SSS}.C
sed -i "s/@tree1@/$tree1/g;" ${SSS}.C
sed -i "s/@branch1@/$branch1/g;" ${SSS}.C
sed -i "s/@tree2@/$tree2/g;" ${SSS}.C
sed -i "s/@branch2@/$branch2/g;" ${SSS}.C
sed -i "s!@namex@!$namex!g;" ${SSS}.C
sed -i "s!@namey@!$namey!g;" ${SSS}.C

root ${SSS}.C
