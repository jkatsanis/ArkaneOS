OS.bin:boot.asm
	nasm boot.asm -f bin -o Source/boot.bin
	nasm kernel_entry.asm -f elf -o Source/kernel_entry.o
	i386-elf-gcc -ffreestanding -m32 -g -c kernel.cpp -o Source/kernel.o
	nasm zeroes.asm -f bin -o Source/zeroes.bin

	i386-elf-ld -o Source/full_kernel.bin -Ttext 0x1000 Source/kernel_entry.o Source/kernel.o --oformat binary
	cat Source/boot.bin Source/full_kernel.bin Source/zeroes.bin  > Source/OS.bin

run: 
	qemu-system-x86_64 Source/OS.bin

clean: 
	rm Source/*.o
	rm Source/*.bin