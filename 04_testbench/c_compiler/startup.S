    .section .text.startup
    .align  2
    .globl  _start
    .type   _start, @function

_start:
    li      sp, 2048
    call    main

.Lsimulation_done:
    j       .Lsimulation_done

    .size   _start, .-_start

