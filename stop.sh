#/usr/bin/env bash
pkill -f aseqdump
killall jack_midi_clock
pkill -f KLICK
killall klick
killall ecasound
pkill -f ECAsound
pkill -f NAMA
pkill -f Yoshimi
killall fluidsynth
killall yoshimi
killall a2jmidi_bridge
killall qjackctl

#killall jackd
#systemctl stop jackd.service

#killall MIDIdump 
#killall vmpk
#killall qmidiroute
#killall qmidiarp
$SHELL

