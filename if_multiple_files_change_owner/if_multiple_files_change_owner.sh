#! /bin/bash
# miguel.ortiz
# This scripts evaluate if specific files: file_a, file_b and file_c exists in the directory and change
# owner/group to root
# For all files in a directory use metacharacter "*" instead brace expansion.

# directory to check
DIR_TO_CHECK='/home/mortiz/Documents/projects/Poor-Bash-Coding/if_multiple_files_change_owner'

# array of files, using brace expansion
files_to_check=($DIR_TO_CHECK/{file_a,file_b,file_c})

# -f (file exists)
# ${files[@]}  # Elements on the array (the full path of each file)
# ${#files[@]} # Use this if you want to access the number of files in the path

for i in ${files_to_check[@]}; do if [ -f $i ]; then chown root: "$i"; fi; done

