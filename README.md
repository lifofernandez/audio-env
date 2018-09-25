# Entorno de Produccion de Audio (Sonido y MIDI) para la terminal

Seteos, configs, notas, scripts, etc.

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

bank offset

http://lists.nongnu.org/archive/html/fluid-dev/2004-06/msg00007.html
bank select metod (gm para GM soundfonts)
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


