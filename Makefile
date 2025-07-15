# Makefile by Laith

BUILD_DIR = build 
ISO = $(BUILD_DIR)/laithos.iso 
KERNEL = $(BUILD_DIR)/kernel 

all: $(ISO) 

$(BUILD_DIR)/kernel_entry.o: kernel/kernel_entry.asm
	mkdir -p $(BUILD_DIR)
	nasm -f elf32 $< -o $@

$(BUILD_DIR)/kernel.o: kernel/kernel.c
	gcc -m32 -ffreestanding -c $< -o $@

$(KERNEL): $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o
	ld -m elf_i386 -Ttext 0x1000 -o $@ $^

$(ISO): $(KERNEL) boot/grub.cfg
	mkdir -p $(BUILD_DIR)/iso/boot/grub
	cp $(KERNEL) $(BUILD_DIR)/iso/boot/kernel
	cp boot/grub.cfg $(BUILD_DIR)/iso/boot/grub/
	grub-mkrescue -o $@ $(BUILD_DIR)/iso

run: $(ISO)
	qemu-system-i386 -cdrom $<

clean:
	rm -rf $(BUILD_DIR)