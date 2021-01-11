bits 32

global start

extern printf
import printf msvcrt.dll
extern scanf
import scanf msvcrt.dll
extern exit
import exit msvcrt.dll

segment data use32 class=data
        format db "%d", 0
        endl db `\n`, 0
        n dd 0
        suma dd 0
        curent dd 0
        nr dd 0

segment code use32 class=code
        start:
                mov eax, 2
                mov [suma], eax

                mov eax, 10
                mov edx, [suma]
                add eax, edx
                mov [curent], eax

                push dword [curent]
                push dword format
                call [printf]
                add esp, 4 * 2
                

                push dword endl
                call [printf]
                add esp, 4

                push dword 0
                call [exit]