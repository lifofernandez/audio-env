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

#fluidsynth \
#-is \
#-r48000 \
#-f fluidsynthrc &


fluidsynth -f fluidsynthrc \
-m alsa_seq \
-c 1024 \
-a jack \
-O s32 \
-T wav \
-r 48000 \
-R 0 \
-C 0 \
-g 0.5 \
-j \
-is \
-o shell.port=9800 \
-o audio.period-size=256 \
-o audio.periods=3 \
-o midi.alsa_seq.id='fluidsynthmidi' \
-o audio.jack.id='fluidsynthaudio' \
-o synth.midi-bank-select='gm' \
-o audio.output-channels=16 \
-o audio.jack.multi='yes' \
-o synth.audio-channels=16 \
-o synth.audio-groups=16 &

sleep 5 &&

jack_lsp &&

jack_connect fluidsynthaudio:l_00 system:playback_1 
jack_connect fluidsynthaudio:r_00 system:playback_2 

jack_connect fluidsynthaudio:l_01 system:playback_1 
jack_connect fluidsynthaudio:r_01 system:playback_2 

jack_connect fluidsynthaudio:l_02 system:playback_1 
jack_connect fluidsynthaudio:r_02 system:playback_2 

jack_connect fluidsynthaudio:l_03 system:playback_1 
jack_connect fluidsynthaudio:r_03 system:playback_2 

jack_connect fluidsynthaudio:l_04 system:playback_1 
jack_connect fluidsynthaudio:r_04 system:playback_2 

jack_connect fluidsynthaudio:l_05 system:playback_1 
jack_connect fluidsynthaudio:r_05 system:playback_2 

jack_connect fluidsynthaudio:l_06 system:playback_1 
jack_connect fluidsynthaudio:r_06 system:playback_2 

jack_connect fluidsynthaudio:l_07 system:playback_1 
jack_connect fluidsynthaudio:r_07 system:playback_2 

jack_connect fluidsynthaudio:l_08 system:playback_1 
jack_connect fluidsynthaudio:r_08 system:playback_2 

jack_connect fluidsynthaudio:l_09 system:playback_1 
jack_connect fluidsynthaudio:r_09 system:playback_2 

jack_connect fluidsynthaudio:l_10 system:playback_1 
jack_connect fluidsynthaudio:r_10 system:playback_2 

jack_connect fluidsynthaudio:l_11 system:playback_1 
jack_connect fluidsynthaudio:r_11 system:playback_2 

jack_connect fluidsynthaudio:l_12 system:playback_1 
jack_connect fluidsynthaudio:r_12 system:playback_2 

jack_connect fluidsynthaudio:l_13 system:playback_1 
jack_connect fluidsynthaudio:r_13 system:playback_2 

jack_connect fluidsynthaudio:l_14 system:playback_1 
jack_connect fluidsynthaudio:r_14 system:playback_2 

jack_connect fluidsynthaudio:l_15 system:playback_1 
jack_connect fluidsynthaudio:r_15 system:playback_2 


qmidiroute -p3 ruteo.qmr &
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

