# -----------------------------------------------------------------------------
# Copyright © 2020 Lee Fastenau
# Tetris™️ is copyright © The Tetris Company, LLC
# Game Boy™️ is copyright © Nintendo Co., Ltd.
#
# This file is part of GB Tetris for Apple II.
#
# GB Tetris for Apple II is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or any later version.
#
# GB Tetris for Apple II is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GB Tetris for Apple II.  If not, see:
# https://choosealicense.com/licenses/gpl-3.0/
# -----------------------------------------------------------------------------

# The final name of the binary product (no spaces)
# NOTE: If there is not a corresponding [PRODUCT_NAME].asm in the src folder, then the BRUN command will fail
PRODUCT_NAME = tetris

# Apple file name (uppercase product name with underscores translated to spaces)
APPLE_OBJ_NAME = $(shell echo $(PRODUCT_NAME) | tr a-z A-Z | tr '_' ' ')

# Apple II command issued by the "run" recipe after booting the disk image.
APPLE_RUN_CMD = BRUN $(APPLE_OBJ_NAME)

# Source folder. Each file in this folder will be assembled and generate a corresponding object file in the build folder.
# Changes to files in this folder will invalidate the current build. (No subfolders)
SOURCE_DIR = src

# Include folder. Place INCLUDE files here.
# Changes to files in this folder will invalidate the current build. (No subfolders)
INCLUDE_DIR = include

include $(INCLUDE_DIR)/version.txt

GEN_TILES_DIR = codegen

GEN_MUSIC_DIR = codegen_music

# Output folder for built objects/product
BUILD_DIR = build

# Resource folder. Contains any resources required by this makefile.
RESOURCE_DIR = res

# Paths and flags for build/processing applications
DASM = dasm
DASM_FLAGS = -v0 -f2 -I"$(SOURCE_DIR)" -I"$(INCLUDE_DIR)" -I"$(GEN_TILES_DIR)" -I"$(GEN_MUSIC_DIR)" -E2 -S
APPLE_COMMANDER = java -jar ~/bin/ac.jar

# Path to the runner script
RUNNER = osascript $(RESOURCE_DIR)/runner.scpt

# Path to the blank bootable disk images
DOS33_BOOT_IMAGE = $(RESOURCE_DIR)/dos3.3bootable.dsk
PRODOS_BOOT_IMAGE = $(RESOURCE_DIR)/prodosbootable.dsk

# Paths to source files
_SOURCE_FILES = $(shell ls $(SOURCE_DIR))
SOURCE_FILES = $(patsubst %,$(SOURCE_DIR)/%,$(_SOURCE_FILES))

# Paths to object files
OBJECT_FILES = $(patsubst %.asm,$(BUILD_DIR)/%,$(_SOURCE_FILES))

# Paths to INCLUDE files
INCLUDE_FILES = $(shell find $(INCLUDE_DIR) -type f)

# Paths to generated graphics files
GENFILES = $(shell find $(GEN_TILES_DIR) -type f)

# Paths to generated graphics files
GENMUSICFILES = $(shell find $(GEN_MUSIC_DIR) -type f)

# Paths to all dependencies. Any changes to these files will trigger rebuild.
ALL_DEPENDENCIES = $(SOURCE_FILES) $(INCLUDE_FILES) $(GENFILES) $(GENMUSICFILES)

# Path to disk image
TARGET_VERSION = $(shell echo $(VERSION) | tr A-Z a-z | tr '"' ' ')
TARGET_IMAGE = $(abspath $(BUILD_DIR)/gbt_$(TARGET_VERSION)_dos3.3.dsk)
TARGET_PRODOS_IMAGE = $(abspath $(BUILD_DIR)/gbt_$(TARGET_VERSION)_prodos.dsk)
TARGET_ZIP = $(abspath $(BUILD_DIR)/gbt_$(TARGET_VERSION).zip)

# Shell commands to copy object files to the disk image
COPY_DOS33_OBJ = $(foreach FN,$(OBJECT_FILES),$(APPLE_COMMANDER) -dos $(TARGET_IMAGE) "$(shell echo $(notdir $(FN)) | tr a-z A-Z | tr '_' ' ')" B < $(FN);)
COPY_PRODOS_OBJ = $(foreach FN,$(OBJECT_FILES),$(APPLE_COMMANDER) -dos $(TARGET_PRODOS_IMAGE) "$(shell echo $(notdir $(FN)) | tr a-z A-Z | tr '_' ' ')" bin < $(FN);)

.PHONY: clean all disk run

# Build all object files
all: $(OBJECT_FILES)
$(OBJECT_FILES): $(ALL_DEPENDENCIES)
	$(eval OBJNAME = $(notdir $@))
	@mkdir -p $(BUILD_DIR)
	$(DASM) $(SOURCE_DIR)/$(OBJNAME).asm -o$@ -l$@.lst $(DASM_FLAGS)

# Create disk image
disk: $(TARGET_IMAGE)
$(TARGET_IMAGE): $(OBJECT_FILES)
	cp $(DOS33_BOOT_IMAGE) $(TARGET_IMAGE)
	$(COPY_DOS33_OBJ)
	cp $(PRODOS_BOOT_IMAGE) $(TARGET_PRODOS_IMAGE)
	$(COPY_PRODOS_OBJ)
	zip -j -r $(TARGET_ZIP) $(TARGET_IMAGE) $(TARGET_PRODOS_IMAGE)

# Delete all build output
clean:
	@rm -rf $(BUILD_DIR)
	@echo All clean.

# Boot disk image in emulator
run: $(TARGET_IMAGE)
	$(RUNNER) $(TARGET_IMAGE) "$(APPLE_RUN_CMD)"
	@echo Running...
