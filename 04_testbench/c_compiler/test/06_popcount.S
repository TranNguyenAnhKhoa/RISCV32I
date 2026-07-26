    .option norvc
    .option norelax
    .section .text.startup
    .align  2
    .globl  _start
    .type   _start, @function

    .equ TEST_STATUS_ADDRESS,         0x000
    .equ TEST_ACTUAL_ADDRESS,         0x004
    .equ TEST_EXPECTED_ADDRESS,       0x008
    .equ TEST_ID_ADDRESS,             0x00C
    .equ TEST_EXTRA_ACTUAL_ADDRESS,   0x010
    .equ TEST_EXTRA_EXPECTED_ADDRESS, 0x014
    .equ TEST_PASS,                   1
    .equ TEST_FAIL,                  -1

_start:
    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 6
    sw      t0, TEST_ID_ADDRESS(zero)

    # Count set bits and parity in 0xF0F00F0F.
    lui     t0, 0xF0F01
    addi    t0, t0, -241
    addi    t1, zero, 0
    addi    t2, zero, 32
    addi    t4, zero, 0
    addi    t5, zero, 1

.Lpopcount_loop:
    andi    t3, t0, 1
    add     t1, t1, t3
    xor     t4, t4, t3
    srl     t0, t0, t5
    addi    t2, t2, -1
    bne     t2, zero, .Lpopcount_loop

    addi    t6, zero, 16
    sw      t1, TEST_ACTUAL_ADDRESS(zero)
    sw      t6, TEST_EXPECTED_ADDRESS(zero)
    sw      t4, TEST_EXTRA_ACTUAL_ADDRESS(zero)
    sw      zero, TEST_EXTRA_EXPECTED_ADDRESS(zero)
    bne     t1, t6, .Ltest_fail
    bne     t4, zero, .Ltest_fail

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
