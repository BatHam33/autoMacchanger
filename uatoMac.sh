#!/bin/bash
ip=$(/sbin/ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)
baseip=`echo $ip | cut -d"." -f1-3`
baseip+=.0/24
MACS=$(nmap -sP  "$baseip")
declare -a arr
while IFS= read -r line
do
if [[ ${line:0:1} == "M" ]]
then
    mac=$(echo $line | cut -d' ' -f 3 | cut -d':' -f 1-3)
    arr+=("$mac")
fi
done <<< "$MACS"
declare -a arrNums
finalMac=00:00:00
finalNum=0
for i in "${!arr[@]}"
do
    finalMac="${arr[$i]}"
    finalNum=0
    for j in "${!arr[@]}"
    do
        if [[ "$finalMac" == "${arr[$j]}" ]]
        then
            finalNum+=1
        fi
    done
    arrNums[$i]=$finalNum
done
finalMac=00:00:00
finalNum=0
for i in "${!arrNums[@]}"
do
    if [[ "${arrNums[$i]}" -gt "$finalNum" ]]
    then
        finalNum="${arrNums[$i]}"
        finalMac="${arr[$i]}"
        fi
done
macEnding=""
chars=123456789abcdef
for i in {1..6} ; 
do
   newVal=$( echo -n "${chars:RANDOM%${#chars}:1}")
   macEnding="${macEnding}$newVal"
done
final=$(echo $macEnding | sed 's/../&:/g; s/:$//')
finalMac+= $final
#ifconfig eth0 down
#macchanger -m $finalMac eth0
#macchanger -e eth0
#ifconfig eth0 up
echo $finalMac