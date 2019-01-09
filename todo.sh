#/usr/bin/env bash
./jack.sh        
sleep 5
./fluidsynth.sh   
./zynaddsubfx.sh 
sleep 5 &&
./midi-connect.sh 
./audio-connect.sh & 
$SHELL
