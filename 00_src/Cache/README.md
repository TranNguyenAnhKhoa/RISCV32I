# Fully-associative L1 Cache theo style ASIC

Thư mục này chứa L1 instruction cache và data cache dạng blocking dành cho
CPU RISC-V 32-bit. RTL dùng Verilog-2001, không phụ thuộc UVM hoặc thư viện
SystemVerilog.

## Các file

| File | Module | Chức năng |
| --- | --- | --- |
| `l1_icache_fa.v` | `l1_icache_fa` | I-cache read-only, read-allocate |
| `l1_dcache_fa.v` | `l1_dcache_fa` | D-cache write-back, write-allocate, byte strobe và flush |
| `cache_backing_memory.v` | `cache_backing_memory` | Memory model chỉ dùng cho testbench |
| `cache_l1_tb.v` | `cache_l1_tb` | Testbench tự kiểm tra I-cache và D-cache |
| `cache_filelist.f` | - | File list dùng cho simulator |

Mỗi file `.v` chứa đúng một module. Mỗi cổng input/output được khai báo trên
một dòng riêng.

## Quy tắc RTL dành cho ASIC

- Không dùng vòng `for` trong RTL hoặc testbench.
- Không dùng `initial` trong các module RTL.
- Lookup tag và victim selection được viết rõ ràng cho bốn way.
- Tag/data array không nằm trên reset tree.
- Reset chỉ tác động tới FSM, valid bit, dirty bit, pointer, counter và các
  thanh ghi điều khiển cần thiết.
- I-cache invalidate được ghi nhớ bằng `invalidate_pending_q` nếu pulse đến khi
  cache đang busy.
- D-cache flush được ghi nhớ bằng `flush_pending_q` nếu pulse đến khi cache đang
  xử lý request.
- Byte write được merge bằng bốn lane cố định, không dùng loop.
- Địa chỉ write-back được dựng lại ở độ rộng `ADDRESS_WIDTH`, tránh mất các bit
  địa chỉ cao.

Việc không reset tag/data là có chủ đích. Sau reset, valid bit bằng 0 nên dữ
liệu chưa khởi tạo không được sử dụng làm cache hit.

Reset đang dùng kiểu asynchronous assert với `rstn_i`. Top-level ASIC nên đồng
bộ quá trình nhả reset theo clock. Reset trong lúc D-cache còn dirty sẽ loại bỏ
dirty metadata; hệ thống phải flush trước một controlled reset nếu dữ liệu cần
được giữ lại.

## Cấu hình được hỗ trợ

| Parameter | Giá trị hỗ trợ |
| --- | --- |
| `ADDRESS_WIDTH` | Mặc định 32 |
| `DATA_WIDTH` | 32 |
| `LINE_COUNT` | 1, 2, 3 hoặc 4 |
| `WORDS_PER_LINE` | 1, 2, 4, 8 hoặc 16 |

RTL unroll cứng tối đa bốn way để có diện tích và timing dễ dự đoán. Không sử
dụng giá trị parameter ngoài bảng trên.

Cấu hình mặc định là bốn line, mỗi line bốn word 32-bit:

```text
4 way × 4 word × 32 bit = 512 bit data cho mỗi cache
```

Tag được so sánh song song như một CAM nhỏ. Replacement ưu tiên line invalid;
khi mọi line đều valid thì dùng round-robin.

## Lưu ý về SRAM macro

Các `data_way*_q` hiện đọc bất đồng bộ và ghi đồng bộ. Với cấu hình nhỏ
4-way × 4-word, ASIC synthesis có thể triển khai bằng standard-cell register và
mux.

Nếu cache được tăng kích thước và cần SRAM compiler:

1. Thay từng data array bằng wrapper của SRAM macro.
2. Dùng read đồng bộ theo timing của macro.
3. Thêm state hoặc pipeline stage cho chu kỳ đọc.
4. Chạy lại protocol và timing verification.

RTL hiện tại không giả định một SRAM macro hoặc technology library cụ thể.

## CPU protocol

CPU giữ `cpu_request_valid_i`, address và write fields ổn định cho tới cạnh lên
có `cpu_request_ready_o = 1`. Cache chỉ nhận một request đang outstanding và
sau đó pulse `cpu_response_valid_o` trong một chu kỳ.

D-cache nhận raw word 32-bit cùng `cpu_write_strobe_i[3:0]`. Adapter phía core
phải đặt byte/halfword store vào đúng byte lane. Load trả raw word; LB/LBU/LH/LHU
và sign extension được xử lý ở adapter của core.

## Backing-memory protocol

Cache giữ `memory_request_valid_o`, address, write data và strobe ổn định cho
tới khi `memory_request_ready_i = 1` tại cạnh lên.

- Write hoàn tất tại request handshake.
- Read nhận response sau đó qua `memory_response_valid_i`.
- Chỉ có một memory transaction outstanding.
- Giao thức hiện không có response-ready, transaction ID hoặc error response.

`cache_backing_memory` chỉ là model mô phỏng. Đây không phải memory macro dùng
cho ASIC.

## Invalidate và flush

- Pulse `invalidate_i` để thực hiện `FENCE.I`.
- Pulse `flush_i` để write-back và invalidate toàn bộ D-cache.
- Pulse đến khi cache đang busy được pending và xử lý sau request hiện tại.
- Không giữ `flush_i` hoặc `invalidate_i` ở mức 1 lâu dài. Tín hiệu giữ mức cao
  có thể yêu cầu thao tác mới sau khi cache trở lại IDLE.

Nên flush D-cache trước DMA handoff hoặc trước khi dữ liệu dirty phải nhìn thấy
ở backing memory. Với self-modifying code, flush D-cache trước rồi invalidate
I-cache.

## Giới hạn tích hợp

Cache chưa gồm:

- cacheable/MMIO address filter;
- coherence hoặc snoop interface;
- ECC/parity;
- atomic operation;
- multi-request hoặc non-blocking miss support.

MMIO phải bypass cache. Core hiện tại cũng phải bổ sung pipeline stall: giữ PC
và các pipeline register liên quan từ khi request được nhận tới khi
`cpu_response_valid_o` xuất hiện.

## Regression

Testbench dùng cấu hình mặc định `LINE_COUNT=4`, `WORDS_PER_LINE=4` và kiểm tra:

- cold miss, same-line hit và round-robin replacement;
- sử dụng đủ bốn way;
- memory backpressure;
- invalidate/flush pulse trong lúc cache busy;
- byte và halfword write-strobe merge;
- dirty victim write-back;
- write-allocate replay;
- flush và post-flush miss;
- địa chỉ refill/write-back có bit 31 bằng 1;
- hit, miss và writeback counter.

Kết quả mong đợi:

```text
CACHE TEST SUMMARY: PASS=38 FAIL=0 TOTAL=38
```

### QuestaSim

```powershell
vlib work
vlog -vlog01compat -lint -work work `
  l1_icache_fa.v `
  l1_dcache_fa.v `
  cache_backing_memory.v `
  cache_l1_tb.v

vsim -c -lib work cache_l1_tb -do "run -all; quit -f"
```

### Vivado XSim

```powershell
xvlog -f cache_filelist.f
xelab cache_l1_tb -s cache_l1_tb_sim --debug typical --timescale 1ns/1ps
xsim cache_l1_tb_sim -runall
```

### Verilator

```text
verilator --binary --timing --trace -Wall -Wno-fatal \
  l1_icache_fa.v l1_dcache_fa.v cache_backing_memory.v cache_l1_tb.v \
  --top-module cache_l1_tb
```
