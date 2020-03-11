#/usr/bin/env bash

BACKEND=onboard
FW=$( lsfirewire | grep Focusrite )
GUI=false
FLUID=true
AUDIO_CONECT=true

while [[ "$#" -gt 0 ]]
do
  case $1 in
    #-fw|--firewire)
    #  BACKEND=firewire
    #  ;;
    -g|--graphical)
      GUI=true
      ;;
    -v|--verbose)
      VERBOSE=true
      ;;
  esac
  shift
done


if [ -z "$FW" ]
then
	echo "No encotre FW." 
else
	echo "Encontre: $FW." 
        BACKEND=firewire
fi

echo "################################"
echo "# BACKEND: $BACKEND"
echo "# GUI: $GUI"
echo "# VERBOSE: $VERBOSE"
echo "###############################"

modprobe -r snd-dice

case $BACKEND in
onboard)
	echo "# JACK OBOARD #"
	jackd \
	-R \
	-d alsa \
	-r 48000 \
	-p 256 \
	-n 4 \
	-d hw:0 &
	;;

firewire)
	echo "# JACK FIREWIRE #"
	jackd \
	-R \
	-P 99 \
	-d firewire \
	-r 48000 \
	-p 256 \
	-n 4 \
	-d hw:Pro24DSP00058b \
	-i 16 \
	-o 8 &
	;;
esac

sleep 5 &&
if [ "$GUI" = true ]; then
	echo "# ANALOG SYNTH: GUI"
 	#urxvt -T 'zynaddsubfx' -e sh -c 'zynaddsubfx -I alsa -O jack-multi -l confs/zynadd.xmz' &
	a2jmidi_bridge &
 	urxvt -T 'yoshimi' -e sh -c 'yoshimi -I -C -j -J --samplerate 48000 -b 256 -o 256 --load=confs/yoshimi.xmz' &

	echo "# DUMP: GUI"
	qjackctl &
 	urxvt -hold -T 'MIDIdump' -e 'aseqdump' &
fi
 
if [ "$GUI" = false ]; then

	echo "# ANALOG SYNTH: No GUI"
	#zynaddsubfx -U -I alsa -O jack-multi -l confs/zynadd.xmz &
	a2jmidi_bridge &
 	yoshimi -i -c -j -J --samplerate 48000 -b 256 -o 256 --load=confs/yoshimi.xmz &

	echo "# DUMP: No GUI"
	aseqdump &
	DUMP_PID=$!
	echo "DUMOP ID:"$DUMP_PID

	#sleep 5 &&

	if [ "$FLUID" = true ]; then
		echo "# WAVETABLE SYNTH: No GUI"
		fluidsynth \
		-f confs/fluidsynthrc \
		-a jack \
		-m alsa_seq \
		-c 3 \
		-O s32 \
		-T wav \
		-r 48000 \
		-R 0 \
		-C 0 \
		-g 0.5 \
		-is \
		-o shell.port=9800 \
		-o audio.jack.id='fluidsynth' \
		-o audio.jack.multi='yes' \
		-o midi.alsa_seq.id='fluidsynth' \
		-o synth.midi-bank-select='gm' \
		-o synth.audio-channels=9 &
	fi
fi


if [ "$AUDIO_CONECT" = true ]; then

	if [ "$BACKEND" = firewire ]; then
		echo "ALSA LOOPBACK"
		alsa_in -j cloop -dcloop > /dev/null 2>&1 &
		alsa_out -j ploop -dploop > /dev/null 2>&1 & 

	        echo "# ESPERA]NDO LOOPBACK#" 
		sleep 3 &&
        	jack_connect cloop:capture_1 system:playback_1
        	jack_connect cloop:capture_2 system:playback_2

		jack_connect system:capture_1 system:playback_1
		jack_connect system:capture_1 system:playback_2
	fi

	echo "# ESPERA]NDO CONECCIONES #" 
	echo "# JACK: CONECCIONES"

	# TO DO: PASAR POR ECASOUND
	jack_connect fluidsynth:l_00 system:playback_1 
	jack_connect fluidsynth:r_00 system:playback_2 
	jack_connect fluidsynth:l_01 system:playback_1 
	jack_connect fluidsynth:r_01 system:playback_2 
	jack_connect fluidsynth:l_02 system:playback_1 
	jack_connect fluidsynth:r_02 system:playback_2 
	jack_connect fluidsynth:l_03 system:playback_1 
	jack_connect fluidsynth:r_03 system:playback_2 
	jack_connect fluidsynth:l_04 system:playback_1 
	jack_connect fluidsynth:r_04 system:playback_2 
	jack_connect fluidsynth:l_05 system:playback_1 
	jack_connect fluidsynth:r_05 system:playback_2 
	jack_connect fluidsynth:l_06 system:playback_1 
	jack_connect fluidsynth:r_06 system:playback_2 
	jack_connect fluidsynth:l_07 system:playback_1 
	jack_connect fluidsynth:r_07 system:playback_2 

	jack_connect yoshimi:left system:playback_1 
	jack_connect yoshimi:right system:playback_2 
	jack_connect a2j_bridge:capture yoshimi:midi\ in

fi


if [ "$VERBOSE" ]; then
	jack_lsp 
	aconnect -l 
fi

$SHELL


# MIDI

#alsa_through=14
#
#yoshimi=$(aconnect -l | grep "yoshimi" | cut -f 1 -d ":" | cut -f 2 -d " ")
#if [ "$tr" ] && [ "$yoshimi" ]
#then
#	aconnect $alsa_through $yoshimi
#	echo "CONECTADO: $alsa_through:$yoshimi"
#fi

# qmidiroute -p1 confs/qmidiroute.qmr &
# qmidiroute -p2 confs/filter.qmr &

# VIRTUALES
# vkeybd &
# vmpk &

# vmpk_i=$(aconnect -l | grep "VMPK Input" | cut -f 1 -d ":" | cut -f 2 -d " ")
# vmpk_o=$(aconnect -l | grep "VMPK Output" | cut -f 1 -d ":" | cut -f 2 -d " ")
# vkeybd=$(aconnect -l | grep "Virtual" | cut -f 1 -d ":" | cut -f 2 -d " ")
# origin49=$(aconnect -l | grep "Origin49" | cut -f 1 -d ":" | cut -f 2 -d " ")
# router=$(aconnect -l | grep "qmidiroute" | cut -f 1 -d ":" | cut -f 2 -d " ")
# fluidsynth=$(aconnect -l | grep "FLUID" | cut -f 1 -d ":" | cut -f 2 -d " ")
# dump=$(aconnect -l | grep "aseqdump" | cut -f 1 -d ":" | cut -f 2 -d " ")


# if [ "$origin49" ] && [ "$zynadd" ]
# then
# 	aconnect $origin49 $zynadd
# 	echo "CONECTADO: $origin49:$zynadd"
# fi
# if [ "$vmpk_o" ]
# then
# 	aconnect $vmpk_o $alsa_through
# 	echo "CONECTADO: $vmpk_o:$alsa_through"
# fi
# 
# if [ "$origin49" ] && [ "$router" ]
# then
# 	aconnect $origin49 $router
# 	echo "CONECTADO: $origin49:$router"
# fi
# if [ "$router" ] && [ "$fluidsynth" ]
# then
# 	aconnect $router:\1 $fluidsynth
# 	echo "CONECTADO: $router:$fluidsynth"
# fi
# if [ "$router" ] && [ "$zynadd" ]
# then
# 	aconnect $router:\1 $zynadd
# 	echo "CONECTADO: $router:$zynadd"
# fi
# 
# if [ "$router" ] && [ "$alsa_through" ]
# then
# 	aconnect $router:\1 $alsa_through
# 	#aconnect $router\:2 $fluidsynth
# 	echo "CONECTADO: $router:$alsa_through"
# fi
# 
# if [ "$dump" ]
# then
# 	aconnect $alsa_through $dump
# 	echo "CONECTADO: $alsa_through:$dump"
# fi

#./jack-${BACKEND}.sh &&
#sleep 3 &&
#./zynaddsubfx.sh &&
#sleep 1 &&
#./fluidsynth.sh &&  
#sleep 6 &&
#./audio-connect.sh &&
#./midi-connect.sh &&
#clear &&
#midish

#$SHELL
#/usr/bin/env bash


#-j \
#-K 24 \
#-o synth.midi-channels=24 \
#-o audio.output-channels=10 \
#-o audio.period-size=256 \


# foo() {
#   while [[ "$#" -gt 0 ]]
#   do
#     case $1 in
#       -f|--follow)
#         local FOLLOW="following"
#         ;;
#       -t|--tail)
#         local TAIL="tail=$2"
#         ;;
#     esac
#     shift
#   done
# 
#   echo "FOLLOW: $FOLLOW"
#   echo "TAIL: $TAIL"
# }

# Example usage:
# 
# foo -f
# foo -t 10
# foo -f --tail 10
# foo --follow --tail 10
