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
    .equ ARRAY_BASE_ADDRESS,    0x100
    .equ TEST_PASS,             1
    .equ TEST_FAIL,            -1

_start:
    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 8
    sw      t0, TEST_ID_ADDRESS(zero)

    # Initialize [2, 5, 8, 12, 16, 23, 38, 56, 72].
    addi    s0, zero, ARRAY_BASE_ADDRESS
    addi    t0, zero, 2
    sw      t0, 0(s0)
    addi    t0, zero, 5
    sw      t0, 4(s0)
    addi    t0, zero, 8
    sw      t0, 8(s0)
    addi    t0, zero, 12
    sw      t0, 12(s0)
    addi    t0, zero, 16
    sw      t0, 16(s0)
    addi    t0, zero, 23
    sw      t0, 20(s0)
    addi    t0, zero, 38
    sw      t0, 24(s0)
    addi    t0, zero, 56
    sw      t0, 28(s0)
    addi    t0, zero, 72
    sw      t0, 32(s0)

    addi    s1, zero, 0
    addi    s2, zero, 8
    addi    s3, zero, -1
    addi    s4, zero, 23

.Lsearch_loop:
    blt     s2, s1, .Lsearch_done
    add     t0, s1, s2
    srli    t0, t0, 1
    slli    t1, t0, 2
    add     t2, s0, t1
    lw      t3, 0(t2)
    beq     t3, s4, .Lsearch_found
    blt     t3, s4, .Lsearch_right
    addi    s2, t0, -1
    jal     zero, .Lsearch_loop

.Lsearch_right:
    addi    s1, t0, 1
    jal     zero, .Lsearch_loop

.Lsearch_found:
    addi    s3, t0, 0

.Lsearch_done:
    addi    t4, zero, 5
    sw      s3, TEST_ACTUAL_ADDRESS(zero)
    sw      t4, TEST_EXPECTED_ADDRESS(zero)
    bne     s3, t4, .Ltest_fail

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
