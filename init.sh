#/usr/bin/env bash

jackd \
-R \
-P99\
-r48000 \
-dalsa \
-p256 \
-n3 &

sleep 3 &&

fluidsynth \
-is \
-r48000 \
-f fluidsynthrc &

sleep 5 &&

jack_lsp &&

jack_connect fluidsynth:left system:playback_1 
jack_connect fluidsynth:right system:playback_2 

vmpk &

sleep 5 &&

aconnect -l &&
alsa_through=14
kb=$(aconnect -l | grep "Origin49" | cut -f 1 -d ":" | cut -f 2 -d " ")
vkb_o=$(aconnect -l | grep "VMPK Output" | cut -f 1 -d ":" | cut -f 2 -d " ")
vkb_i=$(aconnect -l | grep "VMPK Input" | cut -f 1 -d ":" | cut -f 2 -d " ")
synth=$(aconnect -l | grep "FLUID" | cut -f 1 -d ":" | cut -f 2 -d " ")

if [ "$vkb_o" ] && [ "$synth" ]
then
	echo "Conectando $vkb_o:$alsa_through"
	aconnect $vkb_o $alsa_through
	echo "Conectando $alsa_through:$synth"
	aconnect $alsa_through $synth
	echo "Lizteilor!"
fi
if [ "$kb" ] && [ "$vkb_i" ]
then
	echo "Conectando $kb:$vkb_i"
	aconnect $kb $vkb_i
	echo "Lizteilor!"
fi


