OS_NAME := ArkaneOS
RELEASE_DIR := ../Bin/Release
DEBUG_DIR := ../Bin/Debug

# RELEASE

compile: 
	nasm -f bin -IBoot -IKernel -IKernel/KeyBoard -IKernel/Terminal Boot/Bootloader.asm -o $(RELEASE_DIR)/$(OS_NAME).bin

run:
	qemu-system-x86_64 $(RELEASE_DIR)/$(OS_NAME).bin

# DEBUG

compile_debug:
	nasm -f bin -IBoot -IKernel -g Boot/Bootloader.asm -o $(DEBUG_DIR)/$(OS_NAME).bin

run_debug: 
	qemu-system-x86_64 -s -S -hda $(DEBUG_DIR)/$(OS_NAME).bin

# CLEAN

clean: 
	rm -f ../Bin/Debug/*.bin
	rm -f ../Bin/Release/*.bin


