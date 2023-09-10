OS_NAME := ArkaneOS.bin
RELEASE_DIR := ../Bin/Release
DEBUG_DIR := ../Bin/Debug

compile: 
	nasm -fbin -IBoot -IKernel Boot/Bootloader.asm -o $(RELEASE_DIR)/$(OS_NAME)

clean: 
	rm -f ../Bin/Debug/*.bin
	rm -f ../Bin/Release/*.bin

run:
	qemu-system-x86_64 $(RELEASE_DIR)/$(OS_NAME) 

compile_debug:
	nasm -fbin -IBoot -IKernel -g Boot/Bootloader.asm -o $(DEBUG_DIR)/$(OS_NAME)

run_debug: 
	qemu-system-x86_64 -s -S $(DEBUG_DIR)/$(OS_NAME)


