C_SOURCES = $(shell find . -name "*.c")
C_OBJECTS = $(patsubst %.c,%.o,${C_SOURCES})
S_SOURCES = $(shell find . -name "*.s")
S_OBJECTS = $(patsubst %.s, %.o,$(S_SOURCES))
CC = gcc
LD = ld
ASM = nasm

C_FLAGS = -c -Wall -m32 -ggdb -gstabs+ -nostdinc -fno-builtin -fno-stack-protector -I include
LD_FLAGS = -T script/kernel.ld  -m elf_i386 -nostdlib
ASM_FLAGS = -f elf -g -F stabs

all: $(S_OBJECTS) $(C_OBJECTS) link

# The automatic variable '$<' is just the first prerequisite
.c.o:
	@echo compile c $< ...
	$(CC) $(C_FLAGS) $< -o $@

.s.o:
	@echo compile assemble
	$(ASM) $(ASM_FLAGS) $<

link:
	@ echo link
	$(LD) $(LD_FLAGS) $(S_OBJECTS) $(C_OBJECTS) -o hx_kernel

.PHONY:clean
clean:
	rm $(S_OBJECTS) $(C_OBJECTS) hx_kernel

.PHONY:update_image
update_image:
	mount floppy.img /mnt/kernel
	cp hx_kernel  /mnt/kernel/hx_kernel
	sleep 1
	umount /mnt/kernel

.PHONY:mount_image
mount_image:
	mount floppy.img  /mnt/kernel

.PHONY:umount_image
umount_image:
	umount /mnt/kernel

.PHONY:qemu
qemu:
	qemu-system-i386 -fda floppy.img  -boot a

