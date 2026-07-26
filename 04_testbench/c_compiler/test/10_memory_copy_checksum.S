    .option norvc
    .option norelax
    .section .text.startup
    .align  2
    .globl  _start
    .type   _start, @function

    .equ TEST_STATUS_ADDRESS,          0x000
    .equ TEST_ACTUAL_ADDRESS,          0x004
    .equ TEST_EXPECTED_ADDRESS,        0x008
    .equ TEST_ID_ADDRESS,              0x00C
    .equ TEST_AUIPC_ACTUAL_ADDRESS,    0x018
    .equ TEST_AUIPC_EXPECTED_ADDRESS,  0x01C
    .equ SOURCE_BASE_ADDRESS,          0x100
    .equ DESTINATION_BASE_ADDRESS,     0x140
    .equ TEST_PASS,                    1
    .equ TEST_FAIL,                   -1

_start:
    # _start is linked at PC=0, so AUIPC with an immediate of zero returns 0.
    auipc   t6, 0
    sw      t6, TEST_AUIPC_ACTUAL_ADDRESS(zero)
    sw      zero, TEST_AUIPC_EXPECTED_ADDRESS(zero)

    addi    t0, zero, 0
    sw      t0, TEST_STATUS_ADDRESS(zero)
    addi    t0, zero, 10
    sw      t0, TEST_ID_ADDRESS(zero)
    bne     t6, zero, .Ltest_fail

    addi    s0, zero, SOURCE_BASE_ADDRESS
    addi    s1, zero, DESTINATION_BASE_ADDRESS

    # Initialize four words without using a data section.
    lui     t0, 0x80FF8
    addi    t0, t0, -255
    sw      t0, 0(s0)
    lui     t0, 0x12345
    addi    t0, t0, 1656
    sw      t0, 4(s0)
    lui     t0, 0xA5A56
    addi    t0, t0, -1446
    sw      t0, 8(s0)
    lui     t0, 0x00020
    addi    t0, t0, -257
    sw      t0, 12(s0)

    # Copy the first eight bytes with LBU/SB.
    addi    t0, s0, 0
    addi    t1, s1, 0
    addi    t2, zero, 8

.Lcopy_byte_loop:
    lbu     t3, 0(t0)
    sb      t3, 0(t1)
    addi    t0, t0, 1
    addi    t1, t1, 1
    addi    t2, t2, -1
    bne     t2, zero, .Lcopy_byte_loop

    # Copy the remaining eight bytes with LHU/SH.
    addi    t0, s0, 8
    addi    t1, s1, 8
    addi    t2, zero, 4

.Lcopy_halfword_loop:
    lhu     t3, 0(t0)
    sh      t3, 0(t1)
    addi    t0, t0, 2
    addi    t1, t1, 2
    addi    t2, t2, -1
    bne     t2, zero, .Lcopy_halfword_loop

    # Call a byte-checksum routine using architectural JAL/JALR.
    addi    a0, s1, 0
    addi    a1, zero, 16
    jal     ra, .Lchecksum_bytes
    addi    s2, a0, 0

    # Verify the copied words.
    addi    t0, s0, 0
    addi    t1, s1, 0
    addi    t2, zero, 4

.Lverify_word_loop:
    lw      t3, 0(t0)
    lw      t4, 0(t1)
    bne     t3, t4, .Ltest_fail
    addi    t0, t0, 4
    addi    t1, t1, 4
    addi    t2, t2, -1
    bne     t2, zero, .Lverify_word_loop

    # Check signed and unsigned byte/halfword behavior.
    lb      t0, 3(s0)
    addi    t1, zero, -128
    bne     t0, t1, .Ltest_fail
    lhu     t0, 2(s0)
    lui     t1, 0x00008
    addi    t1, t1, 255
    bne     t0, t1, .Ltest_fail
    lh      t0, 2(s0)
    lui     t1, 0xFFFF8
    addi    t1, t1, 255
    bne     t0, t1, .Ltest_fail

    addi    t5, zero, 1807
    sw      s2, TEST_ACTUAL_ADDRESS(zero)
    sw      t5, TEST_EXPECTED_ADDRESS(zero)
    bne     s2, t5, .Ltest_fail

.Ltest_pass:
    addi    t0, zero, TEST_PASS
    sw      t0, TEST_STATUS_ADDRESS(zero)
    jal     zero, .Ltest_done

.Ltest_fail:
    addi    t0, zero, TEST_FAIL
    sw      t0, TEST_STATUS_ADDRESS(zero)

.Ltest_done:
    jal     zero, .Ltest_done

.Lchecksum_bytes:
    addi    t0, zero, 0

.Lchecksum_loop:
    lbu     t1, 0(a0)
    add     t0, t0, t1
    addi    a0, a0, 1
    addi    a1, a1, -1
    bne     a1, zero, .Lchecksum_loop
    addi    a0, t0, 0
    jalr    zero, 0(ra)

    .size   _start, .-_start
