OS_NAME := ArkaneOS.bin

compile: 
	nasm -fbin -IBoot -IKernel Boot/Bootloader.asm -o ../Bin/$(OS_NAME)

clean: 
	rm Bin/$(OS_NAME)

run:
	qemu-system-x86_64 ../Bin/$(OS_NAME)
