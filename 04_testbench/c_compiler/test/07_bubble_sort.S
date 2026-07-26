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
    .equ ARRAY_BASE_ADDRESS,          0x100
    .equ TEST_PASS,                   1
    .equ TEST_FAIL,                  -1

_start:
    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 7
    sw      t0, TEST_ID_ADDRESS(zero)

    # Initialize [7, -3, 12, 0, 5, -8, 4, 1].
    addi    s0, zero, ARRAY_BASE_ADDRESS
    addi    t0, zero, 7
    sw      t0, 0(s0)
    addi    t0, zero, -3
    sw      t0, 4(s0)
    addi    t0, zero, 12
    sw      t0, 8(s0)
    sw      zero, 12(s0)
    addi    t0, zero, 5
    sw      t0, 16(s0)
    addi    t0, zero, -8
    sw      t0, 20(s0)
    addi    t0, zero, 4
    sw      t0, 24(s0)
    addi    t0, zero, 1
    sw      t0, 28(s0)

    addi    s1, zero, 7

.Lbubble_outer_loop:
    addi    s2, s0, 0
    addi    s3, s1, 0

.Lbubble_inner_loop:
    lw      t0, 0(s2)
    lw      t1, 4(s2)
    bge     t1, t0, .Lno_swap
    sw      t1, 0(s2)
    sw      t0, 4(s2)

.Lno_swap:
    addi    s2, s2, 4
    addi    s3, s3, -1
    bne     s3, zero, .Lbubble_inner_loop
    addi    s1, s1, -1
    bne     s1, zero, .Lbubble_outer_loop

    # Verify monotonic order and checksum.
    lw      t2, 0(s0)
    addi    t3, t2, 0
    addi    s2, s0, 0
    addi    s3, zero, 7

.Lverify_sort_loop:
    lw      t4, 4(s2)
    blt     t4, t2, .Ltest_fail
    add     t3, t3, t4
    addi    t2, t4, 0
    addi    s2, s2, 4
    addi    s3, s3, -1
    bne     s3, zero, .Lverify_sort_loop

    addi    t5, zero, 18
    sw      t3, TEST_ACTUAL_ADDRESS(zero)
    sw      t5, TEST_EXPECTED_ADDRESS(zero)
    lw      t4, 0(s0)
    addi    t6, zero, -8
    sw      t4, TEST_EXTRA_ACTUAL_ADDRESS(zero)
    sw      t6, TEST_EXTRA_EXPECTED_ADDRESS(zero)
    bne     t3, t5, .Ltest_fail
    bne     t4, t6, .Ltest_fail
    addi    t6, zero, 12
    bne     t2, t6, .Ltest_fail

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
