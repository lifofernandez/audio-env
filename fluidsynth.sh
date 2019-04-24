#/usr/bin/env bash

fluidsynth \
-f fluidsynthrc \
-a jack \
-m alsa_seq \
-c 256 \
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
-o synth.audio-channels=10 &

#-j \
#-K 24 \
#-o synth.midi-channels=24 \
#-o audio.output-channels=10 \
#-o audio.period-size=256 \


