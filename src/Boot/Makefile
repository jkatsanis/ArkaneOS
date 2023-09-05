Bootloader.bin:Bootloader.asm Printf.asm ReadDisk.asm Printh.asm TestA20.asm Gdt.asm
	nasm -fbin Bootloader.asm -o Bootloader.bin

clean: 
	rm Bootloader.bin

run: 
	qemu-system-x86_64 Bootloader.bin