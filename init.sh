#/usr/bin/env bash
./jack.sh        
sleep 3 &&
./zynaddsubfx.sh 
sleep 1 &&
./fluidsynth.sh   
sleep 1 &&
./qmidiarp.sh
urxvt -hold -T 'MIDIdump' -e 'aseqdump' &
sleep 6 &&
./audio-connect.sh & 
./midi-connect.sh 
# cp midishrc /etc/midishrc &
# midish & 
clear &
$SHELL
