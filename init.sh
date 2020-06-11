#!/usr/bin/env bash

#BACKEND=onboard
#FW=$( lsfirewire | grep Focusrite )
#
#if [ -z "$FW" ]
#then
#	echo "No encotre FW." 
#else
#	echo "Encontre: $FW." 
#        BACKEND=firewire
#fi


# echo "################################"
# echo "# BACKEND: $BACKEND"
# echo "# GUI: $GUI"
# echo "# VERBOSE: $VERBOSE"
# echo "###############################"
# 
# modprobe -r snd-dice
# 
# case $BACKEND in
# onboard)
# 	echo "# JACK OBOARD #"
# 	jackd \
# 	-R \
# 	-d alsa \
# 	-r 48000 \
# 	-p 256 \
# 	-n 4 \
# 	-d hw:1 &
# 	;;
# 
# firewire)
# 	echo "# JACK FIREWIRE #"
# 	jackd \
# 	-R \
# 	-P 99 \
# 	-d firewire \
# 	-r 48000 \
# 	-p 256 \
# 	-n 4 \
# 	-d hw:Pro24DSP00058b \
# 	-i 4 \
# 	-o 2 &
# 	;;
# esac
# 
# sleep 3 &&

GUI=false
FLUID=true
AUDIO_CONECT=true

BPM=120
METRO="4/4"

while getopts ":t:m:" opt; do
  case $opt in
    t) BPM="$OPTARG"
    ;;
    m) METRO="$OPTARG"
    ;;
    #\?) echo "Invalid option -$OPTARG" >&2
    #;;
  esac
done

while [[ "$#" -gt 0 ]]
do
  case $1 in
    -g|--graphical)
      GUI=true
      ;;
    -v|--verbose)
      VERBOSE=true
      ;;
  esac
  shift
done

# MIDISH <JACK TRANSPORT SYNC> ECASOUND 
urxvt -T 'KLICK' -e sh -c "klick -T $METRO $BPM" &
jack_midi_clock &
jackctlmmc &
sleep 1 &&
jack_connect jack_midi_clock:mclk_out "alsa_midi:Midi Through Port-0 (in)"
#jack_connect klick:out system:playback_1
#jack_connect klick:out system:playback_2

echo "# MIXER "
#urxvt -T 'ECAsound' -e sh -c 'ecasound -f:f32_le,2,48000 -s:confs/mezcla-rec.ecs -c -Md:alsaseq,ECAmidi' &
urxvt -T 'ECAsound' -e sh -c 'ecasound -f:f32_le,2,48000 -s:confs/mezcla-rec.ecs -K -C' &
#urxvt -T 'ECAsound' -e sh -c 'ecasound -f:f32_le,2,48000 -s:confs/mezcla-rec.ecs -c' &
#urxvt -T 'ECAsound' -e sh -c 'ecasound -f:f32_le,2,48000 -s:confs/mezcla.ecs -c' &

# urxvt -T 'NAMA' -e sh -c 'nama ' &
if [ "$GUI" = true ]; then
	echo "# ANALOG SYNTH: GUI"

	a2jmidi_bridge &
 	
	yoshimiflags=' -I -C -j -J -R 48000 -b 256 -o 256'
	yoshimiflags+=' --jack-midi=a2j_bridge:capture --state=confs/yoshimi.state'
	yoshimiflags+=' --load-instrument=confs/yoshimi.xiz --load=confs/yoshimi.xmz'
	urxvt -T 'Yoshimi' -e sh -c 'yoshimi '$yoshimiflags &

	#-I -C -j -J -R 48000 -b 256 -o 256 --jack-midi=a2j_bridge:capture --state=confs/yoshimi.state  --load-instrument=confs/yoshimi.xiz --load=confs/yoshimi.xmz' &


	sleep 3 &&
	jack_connect a2j_bridge:capture yoshimi:midi\ in

	qjackctl &

fi
 
if [ "$GUI" = false ]; then

	echo "# ANALOG SYNTH: No GUI"
	a2jmidi_bridge > /dev/null 2>&1 &

 	yoshimi -i -c -j -J --samplerate 48000 -b 256 -o 256 --load=confs/yoshimi.xmz &
	sleep 3 &&
	jack_connect a2j_bridge:capture yoshimi:midi\ in

	sleep 1 &&
	echo "# DUMP: No GUI"
	aseqdump &
	DUMP_PID=$!
	echo "DUMOP ID:"$DUMP_PID

fi

if [ "$VERBOSE" = true ]; then
	echo "# DUMP: GUI"
 	urxvt -hold -T 'MIDIdump' -e 'aseqdump' &
fi

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
	-o synth.audio-channels=10 &
fi


# $SHELL

# jack_lsp 
# aconnect -l 


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
