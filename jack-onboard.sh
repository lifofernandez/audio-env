#/usr/bin/env bash

modprobe -r snd-dice

jackd \
-R \
-d alsa \
-r 48000 \
-p 256 \
-n 4 \
-d hw:0 \
&

qjackctl &

