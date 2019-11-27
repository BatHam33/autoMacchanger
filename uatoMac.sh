#!/bin/bash
ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
baseip=`echo $ip | cut -d"." -f1-3`
#ifconfig eth0 down
#macchanger -r eth0
#ifconfig eth0 up
echo $baseip
baseip+=.0/24
echo $baseip
MACS=$(nmap -sP  "$baseip")
declare -a arr
while IFS= read -r line
do
if [[ ${line:0:1} == "M" ]]
then
    #echo $line | cut -d' ' -f 3 | cut -d':' -f 1-3
    mac=$("$line" | cut -d' ' -f 3 | cut -d':' -f 1-3)
    arr+=("$mac")
fi
done <<< "$MACS"
declare -p arr
#echo "$MACS"
