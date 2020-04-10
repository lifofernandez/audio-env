#/usr/bin/env bash
killall fluidsynth
killall yoshimi
killall a2j_bridge
pkill -f aseqdump
pkill -f ECAsound
pkill -f NAMA
killall ecasound
killall qjackctl
killall jackd

#killall MIDIdump 
#killall vmpk
#killall qmidiroute
#killall qmidiarp
$SHELL

