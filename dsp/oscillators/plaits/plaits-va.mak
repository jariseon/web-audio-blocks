# korg logue-sdk WASM makefile
# Jari Kleimola 2019 (jari@webaudiomodules.org)
# usage: emmake make -f plaits-va.mak

TARGET = plaits-va.js

OSC = ../../oscs/macro-oscillator2
SRC = $(OSC)/eurorack
MANIFEST = $(OSC)/manifest_va.json

SOURCES =  $(OSC)/macro-oscillator2.cc
SOURCES += $(SRC)/plaits/dsp/engine/virtual_analog_engine.cc
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

CFLAGS  =  -DOSC_VA -DTEST $(HEADERS) -std=c++11 -Wall -Wno-unknown-attributes
LDFLAGS =  -O2
EMFLAGS =  -s WASM=1 -s ALLOW_MEMORY_GROWTH=1 -s BINARYEN_ASYNC_COMPILATION=0 --bind
EMFLAGS += -s EXPORT_NAME="'WABModule'" -s SINGLE_FILE=1
EMFLAGS += --pre-js pre.js
LIBS =

$(TARGET): $(OBJECTS)
	echo 'WABModule.manifest = ' > pre.js
	cat $(MANIFEST) >> pre.js
	$(CC) $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)
