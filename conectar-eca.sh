
#ecasound -f:f32_le,2,48000 -s:confs/mezcla.ecs

jack_connect fluidsynth:l_00   ECA_mix:fluid_1_1 
jack_connect fluidsynth:r_00   ECA_mix:fluid_1_2 
jack_connect fluidsynth:l_01   ECA_mix:fluid_2_1 
jack_connect fluidsynth:r_01   ECA_mix:fluid_2_2 
jack_connect fluidsynth:l_02   ECA_mix:fluid_3_1 
jack_connect fluidsynth:r_02   ECA_mix:fluid_3_2 
jack_connect fluidsynth:l_03   ECA_mix:fluid_4_1 
jack_connect fluidsynth:r_03   ECA_mix:fluid_4_2 
jack_connect fluidsynth:l_04   ECA_mix:fluid_5_1 
jack_connect fluidsynth:r_04   ECA_mix:fluid_5_2 
jack_connect fluidsynth:l_05   ECA_mix:fluid_6_1 
jack_connect fluidsynth:r_05   ECA_mix:fluid_6_2 
jack_connect fluidsynth:l_06   ECA_mix:fluid_7_1 
jack_connect fluidsynth:r_06   ECA_mix:fluid_7_2 
jack_connect fluidsynth:l_07   ECA_mix:fluid_8_1 
jack_connect fluidsynth:r_07   ECA_mix:fluid_8_2 

jack_connect yoshimi:track_1_l ECA_mix:yoshi_1_1 
jack_connect yoshimi:track_1_r ECA_mix:yoshi_1_2 
jack_connect yoshimi:track_2_l ECA_mix:yoshi_2_1 
jack_connect yoshimi:track_2_r ECA_mix:yoshi_2_2 
jack_connect yoshimi:track_3_l ECA_mix:yoshi_3_1 
jack_connect yoshimi:track_3_r ECA_mix:yoshi_3_2 
jack_connect yoshimi:track_4_l ECA_mix:yoshi_4_1 
jack_connect yoshimi:track_4_r ECA_mix:yoshi_4_2 
jack_connect yoshimi:track_5_l ECA_mix:yoshi_5_1 
jack_connect yoshimi:track_5_r ECA_mix:yoshi_5_2 
jack_connect yoshimi:track_6_l ECA_mix:yoshi_6_1 
jack_connect yoshimi:track_6_r ECA_mix:yoshi_6_2 
jack_connect yoshimi:track_7_l ECA_mix:yoshi_7_1 
jack_connect yoshimi:track_7_r ECA_mix:yoshi_7_2 
jack_connect yoshimi:track_8_l ECA_mix:yoshi_8_1 
jack_connect yoshimi:track_8_r ECA_mix:yoshi_8_2 

#jack_connect yoshimi:left    ffmpeg:input_1 
#jack_connect yoshimi:right   ffmpeg:input_2 


