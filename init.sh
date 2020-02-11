#/usr/bin/env bash

BACKEND=onboard
GUI=false
FLUID=true
AUDIO_CONECT=true

while [[ "$#" -gt 0 ]]
do
  case $1 in
    #-b|--backend)
    #  BACKEND="$2"
    #  ;;
    -fw|--firewire)
      BACKEND=firewire
      ;;
    -g|--graphical)
      GUI=true
      ;;
    -v|--verbose)
      VERBOSE=true
      ;;
  esac
  shift
done

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

sleep 10 &&
if [ "$GUI" = true ]; then
	echo "# ANALOG: GUI"
 	#urxvt -T 'zynaddsubfx' -e sh -c 'zynaddsubfx -I alsa -O jack-multi -l confs/zynadd.xmz' &
	a2jmidi_bridge &
 	urxvt -T 'yoshimi' -e sh -c 'yoshimi -I -C -j -J --samplerate 48000 -b 256 -o 256 --load=confs/yoshimi.xmz' &

	echo "# DUMP: GUI"
	qjackctl &
 	urxvt -hold -T 'MIDIdump' -e 'aseqdump' &
fi
 
if [ "$GUI" = false ]; then

	echo "# ANALOG: NO GUI"
	#zynaddsubfx -U -I alsa -O jack-multi -l confs/zynadd.xmz &
	a2jmidi_bridge &
 	yoshimi -i -c -j -J --samplerate 48000 -b 256 -o 256 --load=confs/yoshimi.xmz &
 	#yoshimi -i -c -j -J --samplerate 48000 -b 256 -o 256 &

	echo "# DUMP: NO GUI"
	aseqdump &
	DUMP_PID=$!
	echo "dump ID:"$DUMP_PID
fi

sleep 10 &&
if [ "$FLUID" = true ]; then
	echo "# WAVETABLE: NO GUI"
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
	-o audio.jack.id='fluidsynthaudio' \
	-o audio.jack.multi='yes' \
	-o midi.alsa_seq.id='fluidsynthmidi' \
	-o synth.midi-bank-select='gm' \
	-o synth.audio-channels=8 &
fi

echo "# ESPERA]NDO CONECCIONES #" &&
sleep 5 &&
if [ "$AUDIO_CONECT" = true ]; then
	echo "# JACK: CONECCIONES"

	if [ "$BACKEND" = firewire ]; then
		jack_connect system:capture_1 system:playback_1
		jack_connect system:capture_1 system:playback_2
	fi

	#jack_connect zynaddsubfx:out-L system:playback_1 
	#jack_connect zynaddsubfx:out-R system:playback_2 
	#jack_connect zynaddsubfx:part0/out-L system:playback_1
	#jack_connect zynaddsubfx:part0/out-R system:playback_2
	#jack_connect zynaddsubfx:part1/out-L system:playback_1
	#jack_connect zynaddsubfx:part1/out-R system:playback_2
	#jack_connect zynaddsubfx:part2/out-L system:playback_1
	#jack_connect zynaddsubfx:part2/out-R system:playback_2
	#jack_connect zynaddsubfx:part3/out-L system:playback_1
	#jack_connect zynaddsubfx:part3/out-R system:playback_2
	#jack_connect zynaddsubfx:part4/out-L system:playback_1
	#jack_connect zynaddsubfx:part4/out-R system:playback_2
	#jack_connect zynaddsubfx:part5/out-L system:playback_1
	#jack_connect zynaddsubfx:part5/out-R system:playback_2
	#jack_connect zynaddsubfx:part6/out-L system:playback_1
	#jack_connect zynaddsubfx:part6/out-R system:playback_2
	#jack_connect zynaddsubfx:part7/out-L system:playback_1
	#jack_connect zynaddsubfx:part7/out-R system:playback_2
	#jack_connect zynaddsubfx:part8/out-L system:playback_1
	#jack_connect zynaddsubfx:part8/out-R system:playback_2
	#jack_connect zynaddsubfx:part9/out-L system:playback_1
	#jack_connect zynaddsubfx:part9/out-R system:playback_2
	#jack_connect zynaddsubfx:part10/out-L system:playback_1 
	#jack_connect zynaddsubfx:part10/out-R system:playback_2 
	#jack_connect zynaddsubfx:part11/out-L system:playback_1 
	#jack_connect zynaddsubfx:part11/out-R system:playback_2 
	#jack_connect zynaddsubfx:part12/out-L system:playback_1 
	#jack_connect zynaddsubfx:part12/out-R system:playback_2 
	#jack_connect zynaddsubfx:part13/out-L system:playback_1 
	#jack_connect zynaddsubfx:part15/out-L system:playback_1 
	#jack_connect zynaddsubfx:part15/out-R system:playback_2 
	
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

	#jack_connect fluidsynthaudio:l_08 system:playback_1 
	#jack_connect fluidsynthaudio:r_08 system:playback_2 
	#jack_connect fluidsynthaudio:l_09 system:playback_1 
	#jack_connect fluidsynthaudio:r_09 system:playback_2 
	#jack_connect fluidsynthaudio:l_10 system:playback_1 
	#jack_connect fluidsynthaudio:r_10 system:playback_2 
	#jack_connect fluidsynthaudio:l_11 system:playback_1 
	#jack_connect fluidsynthaudio:r_11 system:playback_2 
	#jack_connect fluidsynthaudio:l_12 system:playback_1 
	#jack_connect fluidsynthaudio:r_12 system:playback_2 
	#jack_connect fluidsynthaudio:l_13 system:playback_1 
	#jack_connect fluidsynthaudio:r_13 system:playback_2 
	#jack_connect fluidsynthaudio:l_14 system:playback_1 
	#jack_connect fluidsynthaudio:r_14 system:playback_2 
	#jack_connect fluidsynthaudio:l_15 system:playback_1 
	#jack_connect fluidsynthaudio:r_15 system:playback_2 

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
