SOURCES=boot.o
CFLAGS=
LDFLAGS=-Tkernel.ld
ASFLAGS=-flef

all: $(SOURCES) link

clean:
	rm *.o kernel

link:
	ld $(LDFLAGS) -o kernel $(SOURCES)

*.s.o
	nasm $(ASFLAGS) $<