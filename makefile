PROJECT=arc-234311-565a33b7a2
SRC_FILES = $(shell find app/ ! -iname "*.png" ! -iname "*.tga")
PNG_FILES = $(shell find app/ -type f -iname "*.png")
TGA_FILES = $(shell find app/ -type f -iname "*.tga")

.PHONY: default help build clean

default: build

help:
	@echo "'make': Build the project."
	@echo "'make clean': Cleans up generated files."
	@echo "'make rename': Rename PNG to TGA."
	@echo

build: $(PROJECT).bin

rename: $(PNG_FILES:.png=.tga)

$(PROJECT).bin: $(SRC_FILES) $(TGA_FILES:.tga=.png)
	@echo "Compiling..."
	@(cd app && zip -r ../$(PROJECT).bin .)
	@echo "Done!"
	@echo

%.png: %.tga
	@echo "Renaming TGA to PNG..."
	@echo " > renaming '$<'..."
	@mv $< $@ 2>/dev/null
	@echo "Done!"
	@echo

%.tga: %.png
	@echo "Renaming PNG to TGA..."
	@echo " > renaming '$<'..."
	@mv $< $@ 2>/dev/null
	@echo "Done!"
	@echo

clean:
	@echo "Cleaning up generated files..."
	@rm -f *.bin
	@echo "Done!"
	@echo
