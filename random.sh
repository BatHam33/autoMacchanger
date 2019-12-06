#!/bin/bash
chars=ABCDEFGHIJKLMNOPQRSTUVWXYZ124567890
for j in {1..3} ; do
    for i in {1..2} ; do
        echo -n "${chars:RANDOM%${#chars}:1}"
        if [[ $j < 3 && $i == 2 ]]
        then
            echo -n ":"
        fi
    done
    theMac=$(echo)
done
echo $theMac
