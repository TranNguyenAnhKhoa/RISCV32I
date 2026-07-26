# Bộ 10 thuật toán assembly RV32I

Mỗi file `.S` là một chương trình standalone, có entry `_start` riêng và không
link với `startup.S`. Tất cả chương trình chỉ dùng instruction RV32I thật,
không dùng RV32M, compressed instruction, CSR, trap, libc, stack, `.data` hoặc
`.rodata`. Makefile dùng `-x assembler`, vì vậy các file được đưa thẳng vào GNU
assembler và không chạy C preprocessor.

## Giao thức kết quả trong DMEM

| Địa chỉ | Ý nghĩa |
| --- | --- |
| `0x000` | Trạng thái: `0` đang chạy, `1` PASS, `0xFFFFFFFF` FAIL |
| `0x004` | Kết quả chính thực tế |
| `0x008` | Kết quả chính mong đợi |
| `0x00C` | ID thuật toán từ 1 đến 10 |
| `0x010` | Kết quả phụ thực tế nếu thuật toán cần |
| `0x014` | Kết quả phụ mong đợi nếu thuật toán cần |
| `0x100` trở lên | Workspace cho mảng và dữ liệu tạm |

Chương trình chỉ ghi PASS sau khi actual/expected đã khớp, rồi dừng trong vòng
lặp `jal zero, ...`. Nếu phát hiện lỗi sớm, chương trình có thể ghi FAIL trước
khi hoàn tất toàn bộ chữ ký phụ. Testbench có thể chờ word tại `0x000` khác 0
rồi đọc trạng thái và các giá trị chẩn đoán đã được ghi.

## Danh sách thuật toán

| ID | File | Thuật toán | Kết quả mong đợi |
| --- | --- | --- | --- |
| 1 | `01_arithmetic_series.S` | Tổng `1..100` | `5050` (`0x000013BA`) |
| 2 | `02_fibonacci.S` | Fibonacci lặp `F(12)` | `144` |
| 3 | `03_factorial_repeated_add.S` | `6!` bằng phép cộng lặp, không dùng MUL | `720` |
| 4 | `04_gcd_subtraction.S` | Euclid bằng phép trừ: `gcd(1071,462)` | `21` |
| 5 | `05_division_remainder.S` | Chia không dấu bằng phép trừ: `1000/37` | thương `27`, dư `1` |
| 6 | `06_popcount.S` | Popcount và parity của `0xF0F00F0F` | popcount `16`, parity `0` |
| 7 | `07_bubble_sort.S` | Bubble sort 8 số nguyên có dấu | checksum `18`, đầu `-8`, cuối `12` |
| 8 | `08_binary_search.S` | Tìm `23` trong mảng 9 phần tử | index `5` |
| 9 | `09_crc8.S` | CRC-8/ATM của `12 34 56 78` | `0x1C` (`28`) |
| 10 | `10_memory_copy_checksum.S` | Copy mixed-width và byte checksum | `1807` (`0x70F`) |

Test 7 để mảng đã sắp xếp tại `0x100..0x11C`. Test 8 để mảng tìm kiếm tại
`0x100..0x120`. Test 10 dùng source tại `0x100..0x10F`, destination tại
`0x140..0x14F`, đồng thời kiểm tra `LB/LBU/LH/LHU/SB/SH/SW/LW`, `JAL/JALR`
và marker `AUIPC` tại `0x018/0x01C`.

## Coverage chính

- Forwarding giữa các phép toán phụ thuộc liên tiếp.
- Load-use stall khi `LW/LBU/LHU` được dùng ngay sau load.
- Taken/not-taken và backward branch.
- Redirect/flush của `JAL` và `JALR`.
- Số âm và so sánh signed/unsigned.
- Load/store byte, halfword và word có alignment hợp lệ.
- `LUI`, `AUIPC`, ADD/SUB, shift, ANDI, XOR/XORI và address scaling.

## Build

Chạy từ `04_testbench/c_compiler`:

```text
mingw32-make test-list
mingw32-make test TEST_NAME=01_arithmetic_series
mingw32-make test-all
```

Mỗi test tạo:

```text
build/test/<TEST_NAME>/program.elf
build/test/<TEST_NAME>/program.map
build/test/<TEST_NAME>/program.dump
build/test/<TEST_NAME>/program.bin
build/test/<TEST_NAME>/IMEM.mem
```

Để chủ động ghi một test vào `01_data_mem/IMEM.mem`:

```text
mingw32-make test-deploy TEST_NAME=07_bubble_sort
```

`test-deploy` có ghi đè file IMEM của repository; target `test` và `test-all`
chỉ ghi trong thư mục `build`.
