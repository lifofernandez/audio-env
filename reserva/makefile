jack:
	jackd \
	-R \
	-P99\
	-r48000 \
   	-dalsa \
	-p256 \
	-n3 \
	&
	
fluid:
	fluidsynth \
	-r48000 \
	-f fluidsynthrc \

FLUID_PORT := $(shell aconnect -l | grep "FLUID" | cut -f 1 -d ":" | cut -f 2 -d " ")
VMPK_PORT := $(shell aconnect -l | grep "VMPK Output" | cut -f 1 -d ":" | cut -f 2 -d " ")
conexiones:	
	@echo fluid port: $(FLUID_PORT)
	@echo vmpk port: $(VMPK_PORT)
	aconnect $(VMPK_PORT):0 $(FLUID_PORT):0
	jack_connect fluidsynth:left system:playback_1
	jack_connect fluidsynth:right system:playback_2

#-s \
#-g0.8 -C0 -R0 \

