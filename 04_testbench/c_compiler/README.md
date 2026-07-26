# C compiler flow cho RISCV32I

Thư mục này cung cấp flow GNU Make để biên dịch một file C bare-metal thành assembly RISC-V và, khi cần, tạo ELF, disassembly cùng file `IMEM.mem` phù hợp với memory model của core.

Flow không gọi Vivado và không phụ thuộc thư viện UVM.

## Yêu cầu

- GNU RISC-V bare-metal toolchain có các chương trình `gcc`, `objcopy`, `objdump` và `size`.
- Toolchain phải hỗ trợ target `rv32i` với ABI `ilp32`.
- Trên Windows có thể dùng `mingw32-make`; máy hiện tại có tại `C:/MinGW/bin/mingw32-make.exe`.
- PowerShell 5 trở lên để chuyển raw binary sang định dạng IMEM.

Makefile mặc định tìm prefix `riscv64-unknown-elf-` trong `PATH`. Các toolchain xPack thường dùng prefix `riscv-none-elf-`.

## Source RISC-V GNU Toolchain trong repo

Source chính thức được đặt tại:

```text
tools/riscv-gnu-toolchain
```

Repository điều phối được clone từ `https://github.com/riscv-collab/riscv-gnu-toolchain.git`. Ba submodule cần cho bare-metal C đã được lấy đúng revision mà repository chính khóa: `binutils`, `gcc` và `newlib`. Thư mục source này được `.gitignore` của repo chính bỏ qua để tránh vô tình commit nhiều GB source/build output.

Clone source chưa tạo ra compiler executable. Để build bản Newlib chỉ dành cho `rv32i/ilp32`, dùng Linux hoặc WSL có đầy đủ dependency rồi chạy:

```bash
cd 04_testbench/c_compiler
bash tools/build_riscv_toolchain.sh
```

Compiler được cài vào `tools/riscv-gnu-toolchain/install/bin`. Makefile tự nhận thư mục này nếu executable phù hợp với hệ điều hành đang chạy tồn tại. Toolchain build trong WSL là Linux executable, vì vậy phải chạy cả `make` compiler flow trong cùng WSL; nó không chạy trực tiếp bằng `mingw32-make.exe` của Windows.

Nếu cần chạy compiler trực tiếp từ PowerShell/Vivado trên Windows, dùng toolchain build cho Windows như xPack hoặc build source bằng MSYS2/Cygwin hiện đại, sau đó đặt `TOOLCHAIN_BIN` trong `toolchain.mk`.

## Cấu hình toolchain

Nếu toolchain đã nằm trong `PATH`:

```text
mingw32-make doctor
```

Nếu muốn dùng toolchain portable ngay trong repo, giải nén sao cho compiler nằm tại `04_testbench/c_compiler/toolchain/bin`. Makefile tự nhận thư mục này và `.gitignore` ngăn binary toolchain bị commit. Với prefix khác `riscv64-unknown-elf-`, vẫn cần đặt `CROSS_COMPILE` trong `toolchain.mk`.

Nếu compiler nằm ở một thư mục riêng, sao chép `toolchain.mk.example` thành `toolchain.mk`, sau đó sửa đường dẫn bằng dấu `/`:

```makefile
TOOLCHAIN_BIN := C:/Tools/riscv/bin
CROSS_COMPILE := riscv64-unknown-elf-
```

Với xPack:

```makefile
TOOLCHAIN_BIN := C:/Tools/xpack-riscv-none-elf-gcc/bin
CROSS_COMPILE := riscv-none-elf-
```

`toolchain.mk` và thư mục `toolchain/` đã được ignore để không commit binary toolchain hoặc đường dẫn riêng của máy.

## Biên dịch C thành assembly

Từ `04_testbench/c_compiler`:

```text
mingw32-make asm
```

Kết quả mặc định:

```text
build/example.s
```

Biên dịch file khác:

```text
mingw32-make asm C_SOURCE=my_program.c
```

Makefile tự lấy tên output từ `C_SOURCE`. Có thể override thêm `PROGRAM`, `ARCH`, `ABI` và `OPTIMIZATION`:

```text
mingw32-make asm C_SOURCE=my_program.c PROGRAM=test_01 ARCH=rv32i ABI=ilp32 OPTIMIZATION=-O1
```

Khi core đã thực sự hỗ trợ extension M, có thể dùng:

```text
mingw32-make asm C_SOURCE=my_program.c ARCH=rv32im
```

Không đặt `ARCH=rv32im` cho RTL hiện tại nếu datapath chưa thực thi các lệnh M.

## Tạo chương trình dùng cho IMEM

Target `program` chạy toàn bộ flow:

```text
mingw32-make program
```

Các output:

| File | Nội dung |
| --- | --- |
| `build/example.s` | Assembly do GCC sinh ra |
| `build/example.elf` | Executable bare-metal, entry `_start` tại địa chỉ 0 |
| `build/example.map` | Linker map |
| `build/example.dump` | Disassembly đã link kèm mã máy |
| `build/example.bin` | Raw bytes của section `.text` |
| `build/example_IMEM.mem` | Byte hex theo đúng thứ tự mà `IMEM.v` đọc |

GNU objcopy sinh instruction byte theo little-endian. `tools/bin_to_imem.ps1` đảo byte trong từng word 32 bit, ví dụ raw bytes `93 02 50 00` trở thành:

```text
00 50 02 93
```

Đây là định dạng mà `IMEM.v` của repo ghép thành instruction `0x00500293`.

Để chủ động thay `01_data_mem/IMEM.mem` bằng kết quả mới:

```text
mingw32-make deploy-imem
```

Target này có ghi đè file IMEM hiện tại; `asm`, `program` và `imem` chỉ ghi trong thư mục `build`.

## Bộ test thuật toán assembly RV32I

Thư mục [`test`](test) chứa 10 chương trình assembly standalone để kiểm tra
pipeline bằng các thuật toán thực tế: tổng dãy số, Fibonacci, factorial không
dùng MUL, GCD, chia lấy dư không dùng DIV/REM, popcount, bubble sort, binary
search, CRC-8 và memory copy/checksum.

```text
mingw32-make test-list
mingw32-make test TEST_NAME=01_arithmetic_series
mingw32-make test-all
mingw32-make test-deploy TEST_NAME=10_memory_copy_checksum
```

Mỗi test tạo ELF, map, disassembly và `IMEM.mem` riêng trong
`build/test/<TEST_NAME>`. Các chương trình ghi trạng thái PASS/FAIL cùng
actual/expected vào DMEM; xem [`test/README.md`](test/README.md) để biết địa
chỉ chữ ký và kết quả mong đợi.

## Giới hạn của runtime tối thiểu

- IMEM chỉ có 1024 byte; linker sẽ báo lỗi nếu `.text` vượt quá giới hạn.
- `startup.S` đặt stack pointer tại địa chỉ DMEM `2048` rồi gọi `main`.
- Không có libc, syscall, heap, interrupt hoặc startup khởi tạo `.data/.bss`.
- Linker chủ động từ chối global/static data trong `.data`, `.bss`, `.rodata`, TLS, GOT/PLT và các constructor. Core tách IMEM/DMEM nên chuỗi, mảng `const`, jump table hoặc dữ liệu tĩnh cần một flow tạo ảnh DMEM riêng.
- `-lgcc` được link để cung cấp một số helper arithmetic cho RV32I, nhưng có thể làm chương trình vượt 1024 byte.
- Không dùng floating point, atomic, compressed instruction hoặc CSR khi RTL chưa hỗ trợ.
- Chương trình mẫu ghi tổng `1..10` (`55`) vào DMEM tại địa chỉ `0x100`.
- Makefile chủ động biên dịch lại output mỗi lần chạy để thay đổi `ARCH`, `ABI`, optimization hoặc cờ bổ sung không tái sử dụng object cũ.

## Các target hữu ích

```text
mingw32-make help
mingw32-make print-config
mingw32-make doctor
mingw32-make asm
mingw32-make disasm
mingw32-make imem
mingw32-make program
mingw32-make clean
```
