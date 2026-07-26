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
    addi    t0, zero, 2
    sw      t0, TEST_ID_ADDRESS(zero)

    # Iteratively compute F(12), with F(0)=0 and F(1)=1.
    addi    t0, zero, 0
    addi    t1, zero, 1
    addi    t2, zero, 12

.Lfibonacci_loop:
    add     t3, t0, t1
    addi    t0, t1, 0
    addi    t1, t3, 0
    addi    t2, t2, -1
    bne     t2, zero, .Lfibonacci_loop

    addi    t4, zero, 144
    sw      t0, TEST_ACTUAL_ADDRESS(zero)
    sw      t4, TEST_EXPECTED_ADDRESS(zero)
    bne     t0, t4, .Ltest_fail

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
