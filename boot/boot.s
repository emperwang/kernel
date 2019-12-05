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
    dd end                      ; end od kernel
    dd start                    ; kernel entry point(initial EIP)

[GLOBAL start]
[GLOBAL glb_mboot_ptr]
[EXTERN kern_entry]

start:
    ; execute kernel
    cli                         ; disable interrupts
    
    mov esp, STACK_TOP          ; 设置内核栈地址
    mov ebp, 0                  ; 栈指针修改为0
    and esp, 0FFFFFFF0H         ; 栈地址按照 16 字节对齐
    mov [glb_mboot_ptr], ebx    ; 将 ebx 中存储的指针存入全局变量

    call kern_entry             ; call our main() function
                                    ; executing whatever rubbish is in the memory after our kernel
stop:
    hlt
    jmp stop
;----------------------------------------

section .bss
stack:
    resb 32768
glb_mboot_ptr:
    resb 4

STACK_TOP equ $-stack-1     ; 内核栈顶 , $ 符号表示当前地址
