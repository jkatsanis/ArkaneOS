SOURCE_DIR = Source/Bin/
BOOT_DIR = Source/Boot/
KERNEL_DIR = Source/Kernel/

compile: 
	nasm $(BOOT_DIR)Boot.asm -f bin -o $(SOURCE_DIR)/Boot.bin
	nasm $(BOOT_DIR)KernelEntry.asm -f elf -o $(SOURCE_DIR)/KernelEntry.o
	i386-elf-gcc -ffreestanding -m32 -g -c $(KERNEL_DIR)Kernel.cpp -o $(SOURCE_DIR)/Kernel.o
	nasm $(BOOT_DIR)Zeroes.asm -f bin -o $(SOURCE_DIR)/Zeroes.bin

	i386-elf-ld -o $(SOURCE_DIR)/full_kernel.bin -Ttext 0x1000 $(SOURCE_DIR)/KernelEntry.o $(SOURCE_DIR)/Kernel.o --oformat binary
	cat $(SOURCE_DIR)/Boot.bin $(SOURCE_DIR)/full_kernel.bin $(SOURCE_DIR)/Zeroes.bin  > $(SOURCE_DIR)/OS.bin

run: 
	qemu-system-x86_64 $(SOURCE_DIR)/OS.bin

clean: 
	rm $(SOURCE_DIR)/*.o
	rm $(SOURCE_DIR)/*.bin