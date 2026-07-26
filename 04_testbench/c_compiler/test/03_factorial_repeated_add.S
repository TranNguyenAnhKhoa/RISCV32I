    .option norvc
    .option norelax
    .section .text.startup
    .align  2
    .globl  _start
    .type   _start, @function

    .equ TEST_STATUS_ADDRESS,   0x000
    .equ TEST_ACTUAL_ADDRESS,   0x004
    .equ TEST_EXPECTED_ADDRESS, 0x008
    .equ TEST_ID_ADDRESS,       0x00C
    .equ TEST_PASS,             1
    .equ TEST_FAIL,            -1

_start:
    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 3
    sw      t0, TEST_ID_ADDRESS(zero)

    # Compute 6! without RV32M. Each multiplication is repeated addition.
    addi    t0, zero, 1
    addi    t1, zero, 2
    addi    t2, zero, 6

.Lfactorial_outer_loop:
    addi    t3, zero, 0
    addi    t4, t1, 0

.Lmultiply_loop:
    add     t3, t3, t0
    addi    t4, t4, -1
    bne     t4, zero, .Lmultiply_loop

    addi    t0, t3, 0
    addi    t1, t1, 1
    bge     t2, t1, .Lfactorial_outer_loop

    addi    t5, zero, 720
    sw      t0, TEST_ACTUAL_ADDRESS(zero)
    sw      t5, TEST_EXPECTED_ADDRESS(zero)
    bne     t0, t5, .Ltest_fail

.Ltest_pass:
    addi    t0, zero, TEST_PASS
    sw      t0, TEST_STATUS_ADDRESS(zero)
    jal     zero, .Ltest_done

.Ltest_fail:
    addi    t0, zero, TEST_FAIL
    sw      t0, TEST_STATUS_ADDRESS(zero)

.Ltest_done:
    jal     zero, .Ltest_done

    .size   _start, .-_start
