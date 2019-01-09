#/usr/bin/env bash

qmidiroute -p1 qmidiroute-offset.qmr &
#qmidiroute -p2 filter.qmr &

#vkeybd &
#vmpk &

#urxvt -hold -e 'aseqdump' &

sleep 1 &&
aconnect -l &&
alsa_through=14
origin49=$(aconnect -l | grep "Origin49" | cut -f 1 -d ":" | cut -f 2 -d " ")
vmpk_i=$(aconnect -l | grep "VMPK Input" | cut -f 1 -d ":" | cut -f 2 -d " ")
vmpk_o=$(aconnect -l | grep "VMPK Output" | cut -f 1 -d ":" | cut -f 2 -d " ")
vkeybd=$(aconnect -l | grep "Virtual" | cut -f 1 -d ":" | cut -f 2 -d " ")
router=$(aconnect -l | grep "qmidiroute" | cut -f 1 -d ":" | cut -f 2 -d " ")
wavetablesynth=$(aconnect -l | grep "FLUID" | cut -f 1 -d ":" | cut -f 2 -d " ")
zynadd=$(aconnect -l | grep "ZynAddSubFX" | cut -f 1 -d ":" | cut -f 2 -d " ")
dump=$(aconnect -l | grep "aseqdump" | cut -f 1 -d ":" | cut -f 2 -d " ")

if [ "$vmpk_o" ]
then
	aconnect $vmpk_o $alsa_through
	echo "CONECTADO: $vmpk_o:$alsa_through"
fi

if [ "$origin49" ] && [ "$router" ]
then
	aconnect $origin49 $router
	echo "CONECTADO: $origin49:$router"
fi
if [ "$router" ] && [ "$wavetablesynth" ]
then
	aconnect $router\:1 $alsa_through
	#aconnect $router\:2 $wavetablesynth
	echo "CONECTADO: $router:$alsa_through"
fi

if [ "$wavetablesynth" ]
then
	aconnect $alsa_through $wavetablesynth
	echo "CONECTADO: $alsa_through:$wavetablesynth"
fi
if [ "$zynadd" ]
then
	aconnect $alsa_through $zynadd
	echo "CONECTADO: $alsa_through:$zynadd"
fi
if [ "$dump" ]
then
	aconnect $alsa_through $dump
	echo "CONECTADO: $alsa_through:$dump"
fi
$SHELL

