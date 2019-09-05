#/usr/bin/env bash

BACKEND=${1:-firewire}
./jack-${BACKEND}.sh &&
sleep 3 &&
./zynaddsubfx.sh &&
sleep 1 &&
./fluidsynth.sh &&  
sleep 6 &&
./audio-connect.sh &&
./midi-connect.sh &&
clear &&
$SHELL
