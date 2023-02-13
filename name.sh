#! /bin/bash

#name="patricia"

#echo "enter you name"
#read name
name=$1
vari=$2
city=$3

user=$(whoami)
date=$(date)
wherami=$(pwd)
ipadd=$(hostname -i)
allipaddr=$(hostname -I)
weather=$(curl wttr.in/$city)
echo "my name is $name"
sleep 1
echo "my new bash schript by $name"
sleep 1
echo "this my variable $vari displayed $name"
sleep 2
echo "i am logged in as $user and i am in this directort $wherami and the date is $date"
 sleep 1
echo "$ipadd and $allipaddr"
sleeo 1
echo "$weather"
