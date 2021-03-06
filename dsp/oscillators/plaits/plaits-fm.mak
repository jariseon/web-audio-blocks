# korg logue-sdk WASM makefile
# Jari Kleimola 2019 (jari@webaudiomodules.org)
# usage: emmake make -f plaits-fm.mak

TARGET = plaits-fm.js

OSC = ../../oscs/macro-oscillator2
SRC = $(OSC)/eurorack
MANIFEST = $(OSC)/manifest_fm.json

SOURCES =  $(OSC)/macro-oscillator2.cc
SOURCES += $(SRC)/plaits/dsp/engine/fm_engine.cc
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

CFLAGS  =  -DOSC_FM -DTEST $(HEADERS) -std=c++11 -Wall -Wno-unknown-attributes
LDFLAGS =  -O2
EMFLAGS =  -s WASM=1 -s ALLOW_MEMORY_GROWTH=1 -s BINARYEN_ASYNC_COMPILATION=0 --bind
EMFLAGS += -s EXPORT_NAME="'WABModule'" -s SINGLE_FILE=1
EMFLAGS += --pre-js pre.js
LIBS =

$(TARGET): $(OBJECTS)
	echo 'WABModule.manifest = ' > pre.js
	cat $(MANIFEST) >> pre.js
	$(CC) $(CFLAGS) $(LDFLAGS) $(EMFLAGS) $(LIBS) -o $@ $(SOURCES)
