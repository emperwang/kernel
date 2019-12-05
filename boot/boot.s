MBOOT_PAGE_ALIGN    equ 1<<0  ; load kernel and modules on page boundary
MBOOT_MEM_INFO      equ 1<<1  ; provide your kernel with memeory info 
MBOOT_HEADER_MAGIC  equ 0x1BADB002 ; multiboot magic value

MBOOT_HEADER_FLAGS  equ MBOOT_PAGE_ALIGN | MBOOT_MEM_INFO
MBOOT_CHECKSUM      equ -(MBOOT_HEADER_MAGIC + MBOOT_HEADER_FLAGS)

[BITS 32]                       ; All instructions should be 32-bit

[GLOBAL mboot]                  ; make 'mboot' accessible from C
[EXTERN code]                   ; start of the '.text' section
[EXTERN bss]                    ; start of the '.bss'  section
[EXTERN end]                    ; End of the last loadable section

mboot:
    dd MBOOT_HEADER_MAGIC       ; GRUB will search for this value on each 4-byte boundary in your kernel file
    dd MBOOT_HEADER_FLAGS       ; how GRUB should load your file / settings
    dd MBOOT_CHECKSUM           ; To ensure that the above values are correct
    
    dd mboot                    ; Location of the descriptor
    dd code                     ; Start of the kernel '.text' (code) section
    dd bss                      ; End of the kernel '.data' section
    dd end                      ; 
    dd start                    ;

[GLOBAL start]
[EXTERN main]