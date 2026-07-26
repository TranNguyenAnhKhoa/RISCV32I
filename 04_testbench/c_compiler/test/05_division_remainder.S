    .option norvc
    .option norelax
    .section .text.startup
    .align  2
    .globl  _start
    .type   _start, @function

    .equ TEST_STATUS_ADDRESS,        0x000
    .equ TEST_ACTUAL_ADDRESS,        0x004
    .equ TEST_EXPECTED_ADDRESS,      0x008
    .equ TEST_ID_ADDRESS,            0x00C
    .equ TEST_EXTRA_ACTUAL_ADDRESS,  0x010
    .equ TEST_EXTRA_EXPECTED_ADDRESS, 0x014
    .equ TEST_PASS,                  1
    .equ TEST_FAIL,                 -1

_start:
    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 5
    sw      t0, TEST_ID_ADDRESS(zero)

    # Unsigned divmod without RV32M: 1000 / 37 = 27 remainder 1.
    addi    t0, zero, 1000
    addi    t1, zero, 37
    addi    t2, zero, 0

.Ldivision_loop:
    bltu    t0, t1, .Ldivision_done
    sub     t0, t0, t1
    addi    t2, t2, 1
    jal     zero, .Ldivision_loop

.Ldivision_done:
    addi    t3, zero, 27
    addi    t4, zero, 1
    sw      t2, TEST_ACTUAL_ADDRESS(zero)
    sw      t3, TEST_EXPECTED_ADDRESS(zero)
    sw      t0, TEST_EXTRA_ACTUAL_ADDRESS(zero)
    sw      t4, TEST_EXTRA_EXPECTED_ADDRESS(zero)
    bne     t2, t3, .Ltest_fail
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
