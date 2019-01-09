#/usr/bin/env bash

jackd \
-R \
-P99\
-dhw: 0:0\
-r48000 \
-dalsa \
-p256 \
-n3 &
# -dhw:Pro24DSP00058b \

qjackctl &
$SHELL

