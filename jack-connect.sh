#/usr/bin/env bash

jack_lsp &

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

jack_connect zynaddsubfx:out_1 system:playback_1 
jack_connect zynaddsubfx:out_2 system:playback_2 

$SHELL

