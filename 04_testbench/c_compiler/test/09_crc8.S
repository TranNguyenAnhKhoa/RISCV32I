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
    addi    t0, zero, 9
    sw      t0, TEST_ID_ADDRESS(zero)

    # CRC-8/ATM over bytes 0x12, 0x34, 0x56, 0x78.
    # Polynomial=0x07, initial value=0x00, no final XOR.
    lui     t0, 0x12345
    addi    t0, t0, 1656
    addi    t1, zero, 0
    addi    t2, zero, 4

.Lcrc_byte_loop:
    srli    t3, t0, 24
    xor     t1, t1, t3
    addi    t4, zero, 8

.Lcrc_bit_loop:
    andi    t5, t1, 0x80
    beq     t5, zero, .Lcrc_shift_only
    slli    t1, t1, 1
    xori    t1, t1, 0x07
    jal     zero, .Lcrc_mask

.Lcrc_shift_only:
    slli    t1, t1, 1

.Lcrc_mask:
    andi    t1, t1, 0xFF
    addi    t4, t4, -1
    bne     t4, zero, .Lcrc_bit_loop
    slli    t0, t0, 8
    addi    t2, t2, -1
    bne     t2, zero, .Lcrc_byte_loop

    addi    t6, zero, 28
    sw      t1, TEST_ACTUAL_ADDRESS(zero)
    sw      t6, TEST_EXPECTED_ADDRESS(zero)
    bne     t1, t6, .Ltest_fail

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
