#/usr/bin/env bash

#jackd \
#-R \
#-P99\
#-dhw: 0:0\
#-r48000 \
#-dalsa \
#-p256 \
#-n3 

# -dhw:Pro24DSP00058b \
# card 0: PCH [HDA Intel PCH], device 0: CX20590 Analog [CX20590 Analog]


#sleep 3 &&

fluidsynth \
-is \
-r48000 \
-f fluidsynthrc &

sleep 5 &&

jack_lsp &&

jack_connect fluidsynth:left system:playback_1 
jack_connect fluidsynth:right system:playback_2 

qmidiroute ruteo.qmr &
#vmpk &
urxvt -hold -e 'aseqdump' &
sleep 5 &&

aconnect -l &&
alsa_through=14
kb=$(aconnect -l | grep "Origin49" | cut -f 1 -d ":" | cut -f 2 -d " ")
vkb_o=$(aconnect -l | grep "VMPK Output" | cut -f 1 -d ":" | cut -f 2 -d " ")
vkb_i=$(aconnect -l | grep "VMPK Input" | cut -f 1 -d ":" | cut -f 2 -d " ")
router=$(aconnect -l | grep "qmidiroute" | cut -f 1 -d ":" | cut -f 2 -d " ")
wavetablesynth=$(aconnect -l | grep "FLUID" | cut -f 1 -d ":" | cut -f 2 -d " ")
dump=$(aconnect -l | grep "aseqdump" | cut -f 1 -d ":" | cut -f 2 -d " ")

if [ "$vkb_o" ]
then
	echo "Conectando $vkb_o:$alsa_through"
	aconnect $vkb_o $alsa_through
	echo "Lizteilor!"
fi

if [ "$kb" ] && [ "$router" ]
then
	echo "Conectando $kb:$router"
	aconnect $kb $router
	echo "Lizteilor!"
fi
if [ "$router" ] && [ "$wavetablesynth" ]
then
	echo "Conectando $router:$alsa_through"
	aconnect $router\:1 $alsa_through
	aconnect $router\:2 $wavetablesynth
	echo "Lizteilor!"
fi

if [ "$wavetablesynth" ]
then
	aconnect $alsa_through $wavetablesynth
	echo "Lizteilor!"
fi
if [ "$dump" ]
then
	aconnect $alsa_through $dump
	echo "Lizteilor!"
fi
$SHELL

