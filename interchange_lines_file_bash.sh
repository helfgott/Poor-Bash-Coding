#!/bin/bash
# miguel.ortiz
# as an answer for https://stackoverflow.com/questions/54353965/changing-two-lines-of-a-text-file/54354995#54354995
# Create a file, then select two lines to be interchanged and pass them as parameters
# Example: interchange_lines_file_bash.sh 3 7 (this would interchange line 7 for 3 and 3 for 7 in the output file). 

ORIGFILE='original.txt'  # original text file
PROCFILE='processed.txt' # copy of the original file to be proccesed
CHGL1=`sed "$1q;d" $ORIGFILE`	  # get original $1 line
CHGL2=`sed "$2q;d" $ORIGFILE`	  # get original $2 line

`cat $ORIGFILE > $PROCFILE`

sed -i "$2s/^.*/$CHGL1/" $PROCFILE # replace 
sed -i "$1s/^.*/$CHGL2/" $PROCFILE # replace
