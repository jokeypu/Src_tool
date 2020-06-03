#!Bash
NM=Rhopi
rm -rf x_merge/*
hadd x_merge/${NM}_ana.root x_root/${NM}_ana*
