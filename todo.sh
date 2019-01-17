#/usr/bin/env bash
./jack.sh        
sleep 5
./fluidsynth.sh   
./zynaddsubfx.sh 
./qmidiarp.sh
sleep 5 
./midi-connect.sh 
# cp midishrc /etc/midishrc &
# midish & 
./audio-connect.sh & 
clear &
$SHELL
