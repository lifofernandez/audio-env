#!/usr/bin/env bash
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
-o synth.audio-groups=16 \
-o synth.audio-channels=16 &
