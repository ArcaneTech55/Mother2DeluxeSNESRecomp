# Diagnostic NRO only; generated SNES code is not linked.
ifeq ($(strip $(DEVKITPRO)),)
$(error DEVKITPRO not set; open devkitPro MSYS2)
endif
.SUFFIXES:
include $(DEVKITPRO)/libnx/switch_rules
TARGET := Mother2Deluxe_Diagnostic
BUILD := build
SOURCES := source
INCLUDES :=
APP_TITLE := Mother 2 Deluxe Diagnostic
APP_AUTHOR := Community port project
APP_VERSION := 0.1.0
ARCH := -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE
CFLAGS := -g -Wall -Wextra -O2 -ffunction-sections $(ARCH) $(DEFINES)
CFLAGS += $(INCLUDE) -D__SWITCH__
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions
ASFLAGS := -g $(ARCH)
LDFLAGS := -specs=$(DEVKITPRO)/libnx/switch.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)
LIBS := -lnx
LIBDIRS := $(PORTLIBS) $(LIBNX)
ifneq ($(BUILD),$(notdir $(CURDIR)))
export OUTPUT := $(CURDIR)/$(TARGET)
export TOPDIR := $(CURDIR)
export VPATH := $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export DEPSDIR := $(CURDIR)/$(BUILD)
CFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
export LD := $(CC)
export OFILES_BIN :=
export OFILES_SRC := $(CFILES:.c=.o)
export OFILES := $(OFILES_SRC)
export HFILES_BIN :=
export INCLUDE := $(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) $(foreach dir,$(LIBDIRS),-I$(dir)/include) -I$(CURDIR)/$(BUILD)
export LIBPATHS := $(foreach dir,$(LIBDIRS),-L$(dir)/lib)
export APP_ICON := $(DEVKITPRO)/libnx/default_icon.jpg
export NROFLAGS := --icon=$(APP_ICON) --nacp=$(CURDIR)/$(TARGET).nacp
.PHONY: all clean $(BUILD)
all: $(BUILD)
$(BUILD):
	@mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile
clean:
	@rm -rf $(BUILD) $(TARGET).nro $(TARGET).elf $(TARGET).nacp
else
DEPENDS := $(OFILES:.o=.d)
.PHONY: all
all: $(OUTPUT).nro
$(OUTPUT).nro: $(OUTPUT).elf $(OUTPUT).nacp
$(OUTPUT).elf: $(OFILES)
-include $(DEPENDS)
endif
