#!/bin/bash
mkdir work
dir=/home/$USER/work
current_user=$(whoami)

if [ "$(ls -A $dir)" ]; then
echo "folder has file"
max_num_file="$(ls -A $dir | wc -l)"
echo "$max_num_file"
new_num=$max_num_file+25
for(( c=$max_num_file; c<=$new_num ;c++ ));
do
touch $dir/$current_user-$c.txt
done
else 
echo "folder is empty"
for (( i=1;i<=25;i++ ));
do
touch $dir/$current_user-$i.txt
done

fi
