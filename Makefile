BIN_DIR = Source/Bin/
BOOT_DIR = Source/Boot/
KERNEL_DIR = Source/Kernel/

SRC_FILES := KernelMain.cpp TextRenderer/TextRenderer.cpp 

compile:
	make clean
	nasm -fbin  -I$(BOOT_DIR) $(BOOT_DIR)Boot.asm -o $(BIN_DIR)/Boot.bin 
	nasm $(BOOT_DIR)KernelEntry.asm -f elf -o $(BIN_DIR)/KernelEntry.o
	
	$(foreach src, $(SRC_FILES), i386-elf-gcc -ffreestanding -m32 -g -c $(KERNEL_DIR)/$(src) -o $(BIN_DIR)/$(basename $(notdir $(src))).o;)

	ld -m elf_i386 -r -o $(BIN_DIR)/Kernel.o Source/Bin/*.o

	nasm $(BOOT_DIR)Zeroes.asm -f bin -o $(BIN_DIR)/Zeroes.bin

	i386-elf-ld -o $(BIN_DIR)/FullKernel.bin -Ttext 0x1000 $(BIN_DIR)/KernelEntry.o $(BIN_DIR)/Kernel.o --oformat binary
	cat $(BIN_DIR)/Boot.bin $(BIN_DIR)/FullKernel.bin $(BIN_DIR)/Zeroes.bin  > $(BIN_DIR)/OS.bin

run: 
	qemu-system-x86_64 $(BIN_DIR)/OS.bin

clean: 
	rm $(BIN_DIR)/*.o
	rm $(BIN_DIR)/*.bin