#/usr/bin/env bash

fluidsynth \
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
-o audio.period-size=256 \
-o midi.alsa_seq.id='fluidsynthmidi' \
-o audio.jack.id='fluidsynthaudio' \
-o synth.midi-bank-select='gm' \
-o audio.jack.multi='yes' \
-o synth.audio-channels=10 &

#$SHELL
#-j \
#-K 24 \
#-o synth.midi-channels=24 \
#-o audio.output-channels=10 \


