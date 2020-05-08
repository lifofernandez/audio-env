#/usr/bin/env bash

BACKEND=onboard
FW=$( lsfirewire | grep Focusrite )
GUI=false
FLUID=true
AUDIO_CONECT=true

if [ "$AUDIO_CONECT" = true ]; then

        #ffmpeg -f jack -i ffmpeg -y out.wav

	echo "# ESPERO CONECCIONES #" 
	sleep 3 &&

	echo "# JACK: CONECCIONES"

	# TO DO: PASAR POR ECASOUND

	jack_connect fluidsynth:l_00 ffmpeg:input_1 
	jack_connect fluidsynth:r_00 ffmpeg:input_2 
	jack_connect fluidsynth:l_01 ffmpeg:input_1 
	jack_connect fluidsynth:r_01 ffmpeg:input_2 
	jack_connect fluidsynth:l_02 ffmpeg:input_1 
	jack_connect fluidsynth:r_02 ffmpeg:input_2 
	jack_connect fluidsynth:l_03 ffmpeg:input_1 
	jack_connect fluidsynth:r_03 ffmpeg:input_2 
	jack_connect fluidsynth:l_04 ffmpeg:input_1 
	jack_connect fluidsynth:r_04 ffmpeg:input_2 
	jack_connect fluidsynth:l_05 ffmpeg:input_1 
	jack_connect fluidsynth:r_05 ffmpeg:input_2 
	jack_connect fluidsynth:l_06 ffmpeg:input_1 
	jack_connect fluidsynth:r_06 ffmpeg:input_2 
	jack_connect fluidsynth:l_07 ffmpeg:input_1 
	jack_connect fluidsynth:r_07 ffmpeg:input_2 

	jack_connect yoshimi:left    ffmpeg:input_1 
	jack_connect yoshimi:right   ffmpeg:input_2 

fi

jack_lsp 
aconnect -l 

$SHELL
