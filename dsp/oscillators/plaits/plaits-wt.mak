# korg logue-sdk WASM makefile
# Jari Kleimola 2019 (jari@webaudiomodules.org)
# usage: emmake make -f plaits-wt.mak

OSC = ../../oscs/macro-oscillator2
SRC = $(OSC)/eurorack

SOURCES =  $(OSC)/macro-oscillator2.cc
SOURCES += $(SRC)/plaits/dsp/engine/wavetable_engine.cc
SOURCES += $(SRC)/plaits/resources.cc
SOURCES += $(SRC)/stmlib/dsp/units.cc

# -- SDKs
SDK = ../../logue-sdk-050a6ec
LOG = $(SDK)/platform/minilogue-xd
WEB = ../cpp
WAB = $(WEB)

SOURCES += $(WEB)/osc_api.cpp
SOURCES += $(WAB)/logue_wrapper.cpp
SOURCES += $(WAB)/wab_processor.cpp

HEADERS =  -I$(SRC) -I$(LOG)/osc/inc -I$(LOG)/inc -I$(LOG)/inc/dsp -I$(LOG)/inc/utils

CFLAGS  =  -DTEST $(HEADERS) -std=c++11 -Wall -Wno-unknown-attributes
LDFLAGS =  -O2
EMFLAGS =  -s WASM=1 -s ALLOW_MEMORY_GROWTH=1 -s BINARYEN_ASYNC_COMPILATION=0 --bind
EMFLAGS += -s EXPORT_NAME="'WABModule'" -s SINGLE_FILE=1
EMFLAGS += --pre-js pre.js
LIBS =

all: plaits-wta.js plaits-wtb.js plaits-wtc.js plaits-wtd.js plaits-wte.js plaits-wtf.js

plaits-wta.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wta.json >> pre.js
	$(CC) -DOSC_WTA -DOSCILLATOR_TYPE=wta  $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)

plaits-wtb.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wtb.json >> pre.js
	$(CC) -DOSC_WTB -DOSCILLATOR_TYPE=wtb $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)

plaits-wtc.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wtc.json >> pre.js
	$(CC) -DOSC_WTC -DOSCILLATOR_TYPE=wtc $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)

plaits-wtd.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wtd.json >> pre.js
	$(CC) -DOSC_WTD -DOSCILLATOR_TYPE=wtd $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)

plaits-wte.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wte.json >> pre.js
	$(CC) -DOSC_WTE -DOSCILLATOR_TYPE=wte $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)

plaits-wtf.js:
	echo 'WABModule.manifest = ' > pre.js
	cat $(OSC)/manifest_wtf.json >> pre.js
	$(CC) -DOSC_WTF -DOSCILLATOR_TYPE=wtf $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)
