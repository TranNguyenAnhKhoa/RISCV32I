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
    addi    t0, zero, 4
    sw      t0, TEST_ID_ADDRESS(zero)

    # Euclidean GCD using subtraction: gcd(1071, 462) = 21.
    addi    t0, zero, 1071
    addi    t1, zero, 462

.Lgcd_loop:
    beq     t0, t1, .Lgcd_done
    bltu    t0, t1, .La_is_smaller
    sub     t0, t0, t1
    jal     zero, .Lgcd_loop

.La_is_smaller:
    sub     t1, t1, t0
    jal     zero, .Lgcd_loop

.Lgcd_done:
    addi    t2, zero, 21
    sw      t0, TEST_ACTUAL_ADDRESS(zero)
    sw      t2, TEST_EXPECTED_ADDRESS(zero)
    bne     t0, t2, .Ltest_fail

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
