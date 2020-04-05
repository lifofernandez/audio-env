#/usr/bin/env bash

BACKEND=onboard
FW=$( lsfirewire | grep Focusrite )
GUI=false
FLUID=true
AUDIO_CONECT=true

if [ "$AUDIO_CONECT" = true ]; then

        #alsa_in -j cloop -dcloop > /dev/null 2>&1 &
        #alsa_out -j ploop -dploop > /dev/null 2>&1 & 
        alsa_out -j ploop -dploop &
        #alsa_in -j cloop -dcloop &

	echo "# ESPERO CONECCIONES #" 
	sleep 3 &&

	echo "# JACK: CONECCIONES"

	# TO DO: PASAR POR ECASOUND

	jack_connect fluidsynth:l_00 ploop:playback_1 
	jack_connect fluidsynth:r_00 ploop:playback_2 
	jack_connect fluidsynth:l_01 ploop:playback_1 
	jack_connect fluidsynth:r_01 ploop:playback_2 
	jack_connect fluidsynth:l_02 ploop:playback_1 
	jack_connect fluidsynth:r_02 ploop:playback_2 
	jack_connect fluidsynth:l_03 ploop:playback_1 
	jack_connect fluidsynth:r_03 ploop:playback_2 
	jack_connect fluidsynth:l_04 ploop:playback_1 
	jack_connect fluidsynth:r_04 ploop:playback_2 
	jack_connect fluidsynth:l_05 ploop:playback_1 
	jack_connect fluidsynth:r_05 ploop:playback_2 
	jack_connect fluidsynth:l_06 ploop:playback_1 
	jack_connect fluidsynth:r_06 ploop:playback_2 
	jack_connect fluidsynth:l_07 ploop:playback_1 
	jack_connect fluidsynth:r_07 ploop:playback_2 

	jack_connect yoshimi:left    ploop:playback_1 
	jack_connect yoshimi:right   ploop:playback_2 

fi

jack_lsp 
aconnect -l 

$SHELL
