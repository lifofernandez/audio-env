#/usr/bin/env bash
./jack.sh        
sleep 3 &&
./zynaddsubfx.sh 
./fluidsynth.sh   
./qmidiarp.sh
sleep 6 &&
./audio-connect.sh & 
urxvt -hold -T 'MIDIdump' -e 'aseqdump' &
#./midi-connect.sh 
# cp midishrc /etc/midishrc &
# midish & 
clear &
$SHELL
