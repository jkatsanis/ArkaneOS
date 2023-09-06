BIN_DIR = Source/Bin/
BOOT_DIR = Source/Boot/
KERNEL_DIR = Source/Kernel/

SRC_FILES := $(shell find $(KERNEL_DIR) -name '*.cpp')

compile:
	make clean
	./build.sh
	@echo Compiling assembly....
	nasm -fbin  -I$(BOOT_DIR) $(BOOT_DIR)Boot.asm -o $(BIN_DIR)/Boot.bin 
	nasm $(BOOT_DIR)KernelEntry.asm -f elf -o $(BIN_DIR)/KernelEntry.o
	nasm $(BOOT_DIR)Zeroes.asm -f bin -o $(BIN_DIR)/Zeroes.bin
	@echo ================

	@echo Linking object files....
	i386-elf-ld -o $(BIN_DIR)/FullKernel.bin -Ttext 0x1000 $(BIN_DIR)/KernelEntry.o $(BIN_DIR)/Kernel.o --oformat binary
	@echo ================
	@echo Creating the final binary...
	cat $(BIN_DIR)/Boot.bin $(BIN_DIR)/FullKernel.bin $(BIN_DIR)/Zeroes.bin  > $(BIN_DIR)/OS.bin
	@echo ================
	@echo OS build complete
run: 
	qemu-system-x86_64 $(BIN_DIR)/OS.bin

clean: 
	rm -f $(BIN_DIR)/*.o
	rm -f $(BIN_DIR)/*.bin