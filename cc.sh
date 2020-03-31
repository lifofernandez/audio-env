#/usr/bin/env bash

BACKEND=onboard
FW=$( lsfirewire | grep Focusrite )
GUI=false
FLUID=true
AUDIO_CONECT=true

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

jack_lsp 
aconnect -l 

$SHELL
