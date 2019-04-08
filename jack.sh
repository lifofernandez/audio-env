#/usr/bin/env bash

modprobe -r snd-dice

jackd \
-R \
-P 99 \
-d firewire \
-r 48000 \
-p 256 \
-n 4 \
-d hw:Pro24DSP00058b \
-i 16 \
-o 8 \
&
qjackctl &
#$SHELL

