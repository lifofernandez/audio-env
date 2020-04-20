#/usr/bin/env bash
pkill -f aseqdump
killall ecasound
pkill -f ECAsound
pkill -f NAMA
pkill -f Yoshimi
killall fluidsynth
killall yoshimi
killall a2j_bridge
killall qjackctl
killall jackd

#killall MIDIdump 
#killall vmpk
#killall qmidiroute
#killall qmidiarp
$SHELL

