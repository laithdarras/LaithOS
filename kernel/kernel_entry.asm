c[BITS 32]                ; 32-bit protected mode
[GLOBAL _start]
[EXTERN kernel_main]

_start:
    call kernel_main    ; call C kernel
    cli                 ; disable interrupts
.hang:
    hlt                  ; Halt the CPU
    jmp .hang            ; Infinite loop