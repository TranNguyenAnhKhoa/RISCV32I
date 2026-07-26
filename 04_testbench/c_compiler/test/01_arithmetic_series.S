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
    addi    t0, zero, 1
    sw      t0, TEST_ID_ADDRESS(zero)

    # Compute 1 + 2 + ... + 100.
    addi    t0, zero, 1
    addi    t1, zero, 100
    addi    t2, zero, 0

.Lsum_loop:
    add     t2, t2, t0
    addi    t0, t0, 1
    bge     t1, t0, .Lsum_loop

    lui     t3, 0x00001
    addi    t3, t3, 954
    sw      t2, TEST_ACTUAL_ADDRESS(zero)
    sw      t3, TEST_EXPECTED_ADDRESS(zero)
    bne     t2, t3, .Ltest_fail

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
