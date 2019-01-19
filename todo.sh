#/usr/bin/env bash
./jack.sh        
sleep 5
./fluidsynth.sh   
./zynaddsubfx.sh 
./qmidiarp.sh
sleep 5 
./audio-connect.sh & 
#./midi-connect.sh 
# cp midishrc /etc/midishrc &
# midish & 
clear &
$SHELL
