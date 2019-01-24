#!/bin/bash
# miguel.ortiz
# as an answer for https://stackoverflow.com/questions/54353965/changing-two-lines-of-a-text-file/54354995#54354995

ORIGFILE='original.txt'  # original text file
PROCFILE='processed.txt' # copy of the original file to be proccesed
CHGL1=`sed "$1q;d" $ORIGFILE`	  # get original $1 line
CHGL2=`sed "$2q;d" $ORIGFILE`	  # get original $2 line

`cat $ORIGFILE > $PROCFILE`

sed -i "$2s/^.*/$CHGL1/" $PROCFILE # replace 
sed -i "$1s/^.*/$CHGL2/" $PROCFILE # replace
