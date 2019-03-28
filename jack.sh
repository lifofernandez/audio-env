#/usr/bin/env bash

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

#Parameters for driver 'alsa' (all parameters are optional):
#-C, --capture 	Provide capture ports.  Optionally set device (default: none)
#-P, --playback 	Provide playback ports.  Optionally set device (default: none)
#-d, --device 	ALSA device name (default: hw:0)
#-r, --rate 	Sample rate (default: 48000)
#-p, --period 	Frames per period (default: 1024)
#-n, --nperiods 	Number of periods of playback latency (default: 2)
#-H, --hwmon 	Hardware monitoring, if available (default: false)
#-M, --hwmeter 	Hardware metering, if available (default: false)
#-D, --duplex 	Provide both capture and playback ports (default: true)
#-s, --softmode 	Soft-mode, no xrun handling (default: false)
#-m, --monitor 	Provide monitor ports for the output (default: false)
#-z, --dither 	Dithering mode (default: n)
#-i, --inchannels 	Number of capture channels (defaults to hardware max) (default: 0)
#-o, --outchannels 	Number of playback channels (defaults to hardware max) (default: 0)
#-S, --shorts 	Try 16-bit samples before 32-bit (default: false)
#-I, --input-latency 	Extra input latency (frames) (default: 0)
#-O, --output-latency 	Extra output latency (frames) (default: 0)
#-X, --midi 	legacy (default: none)


#hw:Pro24DSP00058b|hw:Pro24DSP00058b|256|3|44100|0|0|nomon|swmeter|-|32bit
# -R \
# -P 99 \
#-r 48000 \
#-d alsa \
#-d hw:Pro24DSP00058b \
#-C \
#-i 16 \
#-P \
#-o 8 \
