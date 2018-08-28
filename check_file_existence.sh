#!/bin/bash
# miguel.ortiz
# Problem: https://www.codewars.com/kata/582d7d22081ed3342d0000a7

if [ -z ${1} ] 
  then
    echo "Nothing to find"
elif [ -e $1 ] 
   then
    echo "\"Found "$1\"
else 
    echo "\"Can't find "$1\"
fi
