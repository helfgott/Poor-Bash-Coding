#!/bin/bash
# remove anchor of an URL 
# Problem:  https://www.codewars.com/kata/51f2b4448cadf20ed0000386

echo ${1/"#"*/} #parameter substitution
