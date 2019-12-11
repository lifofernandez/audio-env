# Entorno de Produccion de Audio (Sonido y MIDI) para la terminal

Seteos, configs, notas, scripts, etc.

## Dependencias
pacman -S a2jmidid

## JACK1 y TiMIDIty + controlador externo 

## AUDIO
### Listar entradas y salidas JACK 
```bash
jack_lsp

```
### Conectar dispoitivos de audio (pares cliente:puerto)
```bash
jack_connect IN OUT
jack_connect zynaddsubfx:out_1 system:playback_1

# para bash scripts necesita escapar los : (dos putos)
jack_connect zynaddsubfx\:out_1 system\:playback_1
```

### Iniciar y exponer Ecasound a JACK
```bash
ecasound -f:f32_le,2,48000 -i jack -o jack,system -G:jack,eca_slave,recv 
# JACK transport tienen que estar "rodando" por el parametro "recv"
```
```bash
ecasound -f:f32_le,2,48000 -s:mezcla.ecs 
# cargar chainsetup: mezcla.ecs
```

```bash
# some reverb
ecasound -f:f32_le,2,48000 -i jack -o jack,system -G:jack,eca_slave -etr:40,0,55 

```
### Metronomo JACK 
```bash
jack_metro -f440 -b120
jack_connect metro:120_bpm system:playback_1
```


## SYNTHES Y SAMPLERS

### Iniciar FLuidSynth a travez de JACK 

#### Load command configuration file (shell commands)
f, --load-config

#### Bank Offset
http://lists.nongnu.org/archive/html/fluid-dev/2004-06/msg00007.html


For example, consider two soundfonts, first.fs2 and second.fs2, which
contain all presets in bank 0.

Load first.fs2 with bank offset 0:

> load /my/soundfonts/first.sf2 1 0
loaded SoundFont has ID 1

Load second.fs2 with bank offset 1:

> load /my/soundfonts/second.fs2 1 1
loaded SoundFont has ID 2

Fluidsynth now assigns soundfont IDs starting with 1 instead of 0.
The soundfont ID value 0 can be used in the revised implementation of the
"select" command to simulate a MIDI bank-select and program change
message sequence for a given channel and should have the same effect
as sending MIDI bank select and program change.  I.e., when using
soundfont ID 0 in "select" the soundfont list is searched for the
first existing specified preset in the given bank.

For example, assign a preset 3 from bank 1 (second.fs2) to channel 5
without using soundfont ID 2:

> select 5 0 1 3

#### Bank select method ('gm' para GM soundfonts)

http://www.fluidsynth.org/api/fluidsettings.xml#synth.midi-bank-select


```bash
fluidsynth  \
	-is -ajack -l \
	/usr/share/soundfonts/FluidR3_GM.sf2 \
	-g0.8 -C0 -R0 -c16 \
	-Twav -Os32 -r48000 \
	-o audio.jack.id=FluidGM \
	-o midi.alsa_seq.id=FluidGM \
	-o shell.port=1301
```


### Iniciar YOSHIMI con alsamidi 
```bash
yoshimi -i --alsa-midi
```

### Iniciar TiMIDIty server a travez de JACK 
```bash
timidity -iAD -Oj -B 2,6
```

## MIDI

### Listar entradas y salidas MIDI

```bash
aconnect -l
```

### Conectar dispositivos MIDI 

```bash
aconnect IN OUT
```
### MIDI dump

```bash
aseqdump
```

### Reproducir un archivo MIDI 

#### Con ALSA aplaymidi a traves de puerto Trough

```bash
aplaymidi -p14 ARCHIVO.mid
```

#### Con tiMIDIty a travez del dispositivo default  

```bash
timidity ~/midi-simple/MIDI_sample.mid -Os 
```

### Grabar MIDI del puerto Through de ALSA

*Graba todo lo que se envie a ese puero, algo similar a un  MIDI merge* 
```bash
arecordmidi -b100 -t3 -p14:0 -m129:0 -i9:8 REC.mid
```
(no conseguí escuchar el metronomo -m 129:0).


### Timidity confs path

/etc/timidity++

### MIDI over LAN/WIFI
```bash
qmidinet -p 666
```


## INVESTIGAR, PROBAR y TO DO

### Synths

AMS AlsaModularSynth 

http://alsamodular.sourceforge.net/

startBristol -mini -jack -midi alsa -cli -window

https://wiki.linuxaudio.org/apps/all/amsynth


### Arpegiadores
https://sourceforge.net/projects/arpage/

http://qmidiarp.sourceforge.net/

### Ruter MIDI 

https://wiki.linuxaudio.org/apps/all/amidmap

qmidiroute

http://das.nasophon.de/mididings/

https://github.com/tiwai/aseqview
(lo probe, medio q no hace naa)

https://wiki.linuxaudio.org/apps/all/alsa_patch_bay

http://pkl.net/~node/software/alsa-patch-bay/

https://wiki.linuxaudio.org/apps/all/alsa_midi_kommander


https://wiki.linuxaudio.org/apps/categories/alsa_seq


fw anduvo despues de instalar esto linux-firewire-utils
ecasound -c -f:f32_le,2,48000 -i jack -o jack,system -G:jack
