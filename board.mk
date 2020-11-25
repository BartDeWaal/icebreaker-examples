# This file is meant to be included in the project Makefile.
# It will set the build parameters based on the target board selected

ifneq ($(MAKECMDGOALS), clean)
ifeq ($(BOARD), icebreaker)
PIN_DEF = ../icebreaker.pcf
YOSYS_READ_ARGS += -DBOARD_ICEBREAKER=1
PROG = iceprog
else ifeq ($(BOARD), bitsy0)
PIN_DEF = ../icebreaker-bitsy0.pcf
YOSYS_READ_ARGS += -DBOARD_BITSY0=1
PROG = dfu
else ifeq ($(BOARD), bitsy)
PIN_DEF = ../icebreaker-bitsy.pcf
YOSYS_READ_ARGS += -DBOARD_BITSY=1
PROG = dfu
else ifeq ($(BOARD), bitsy-pmod)
PIN_DEF = ../icebreaker-bitsy-pmod.pcf
YOSYS_READ_ARGS += -DBOARD_BITSY_PMOD=1
PROG = dfu
else
$(error Please specify BOARD, options are "icebreaker", "bitsy" or "bitsy-pmod")
endif
endif
DEVICE = up5k
PACKAGE = sg48
FREQ = 13
