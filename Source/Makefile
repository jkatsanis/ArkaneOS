OS_NAME := ArkaneOS
RELEASE_DIR := ../Bin/Release
DEBUG_DIR := ../Bin/Debug
INCLUDE := -IBoot -IKernel Boot/Bootloader.asm

# RELEASE

compile: 
	nasm -f bin $(INCLUDE) -o $(RELEASE_DIR)/$(OS_NAME).bin

run:
	qemu-system-x86_64 $(RELEASE_DIR)/$(OS_NAME).bin

# DEBUG

compile_debug:
	nasm -f bin $(INCLUDE) -g -o $(DEBUG_DIR)/$(OS_NAME).bin

run_debug: 
	qemu-system-x86_64 -s -S -hda $(DEBUG_DIR)/$(OS_NAME).bin

run_gdb:
	gdb ../Bin/Debug/ArkaneOS.bin

# CLEAN

clean: 
	rm -f ../Bin/Debug/*.bin
	rm -f ../Bin/Release/*.bin


