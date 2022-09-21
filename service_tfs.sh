#!/bin/sh
cd /home/mao/retibia

if [ -f ./console.log ]
then
mv ./console.log "./old_logs/console_$(date +%y%m%d%H%M%S).log"
fi

stdbuf -oL "./tfs" > console.log 2>&1
