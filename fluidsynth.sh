#/usr/bin/env bash

fluidsynth -f fluidsynthrc \
-m alsa_seq \
-c 1024 \
-a jack \
-O s32 \
-T wav \
-r 48000 \
-R 0 \
-C 0 \
-g 0.5 \
-j \
-is \
-o shell.port=9800 \
-o audio.period-size=256 \
-o audio.periods=3 \
-o midi.alsa_seq.id='fluidsynthmidi' \
-o audio.jack.id='fluidsynthaudio' \
-o synth.midi-bank-select='gm' \
-o audio.output-channels=10 \
-o audio.jack.multi='yes' \
-o synth.midi-channels=10 \
-o synth.audio-channels=10 &
$SHELL

