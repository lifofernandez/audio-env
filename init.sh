#/usr/bin/env bash
./jack.sh &&
sleep 3 &&
./zynaddsubfx.sh &&
sleep 1 &&
./fluidsynth.sh &&  
#sleep 1 &&
#./qmidiarp.sh
sleep 6 &&
./audio-connect.sh &&
./midi-connect.sh &&
# cp midishrc /etc/midishrc &
# midish & 
clear &&
$SHELL
