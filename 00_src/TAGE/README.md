# Bộ dự đoán nhánh Compact TAGE

Thư mục này chứa bộ dự đoán hướng rẽ nhánh TAGE thu gọn cho CPU RISC-V
32-bit. Toàn bộ RTL và testbench được viết bằng Verilog-2001, không dùng
SystemVerilog, UVM hoặc `` `include ``. Mỗi file `.v` chứa đúng một module.

Thiết kế dùng một bảng bimodal làm dự đoán nền và ba bảng tagged có độ dài
lịch sử tăng dần. Bảng tagged khớp có lịch sử dài nhất là `provider`; bảng
khớp ngắn hơn kế tiếp hoặc bảng bimodal là `alternate`.

## Cấu trúc thư mục

```text
TAGE/
├── README.md
├── rtl/
│   ├── tage_global_history.v
│   ├── tage_hash.v
│   ├── tage_base_table.v
│   ├── tage_tagged_table.v
│   ├── tage_provider_selector.v
│   └── tage_predictor.v
└── tb/
    ├── tage_global_history_tb.v
    ├── tage_provider_selector_tb.v
    ├── tage_tagged_table_tb.v
    └── tage_predictor_tb.v
```

| File | Module | Chức năng |
| --- | --- | --- |
| `tage_global_history.v` | `tage_global_history` | Global History Register ở chế độ committed hoặc speculative |
| `tage_hash.v` | `tage_hash` | XOR-fold `PC[31:2]` và global history thành index/tag |
| `tage_base_table.v` | `tage_base_table` | Bảng bimodal với counter bão hòa 2-bit |
| `tage_tagged_table.v` | `tage_tagged_table` | Một bảng tagged gồm valid, tag, counter và usefulness |
| `tage_provider_selector.v` | `tage_provider_selector` | Chọn provider, alternate và kết quả cuối |
| `tage_predictor.v` | `tage_predictor` | Top-level Compact TAGE-3 |
| `tage_global_history_tb.v` | `tage_global_history_tb` | Kiểm tra hai chế độ history và recovery |
| `tage_provider_selector_tb.v` | `tage_provider_selector_tb` | Kiểm tra priority và chính sách alternate |
| `tage_tagged_table_tb.v` | `tage_tagged_table_tb` | Kiểm tra counter, tag, usefulness, aging và reset |
| `tage_predictor_tb.v` | `tage_predictor_tb` | Regression tích hợp toàn bộ predictor |

## Cấu hình mặc định

| Thành phần | Cấu hình |
| --- | --- |
| Base table | 64 entry, counter 2-bit |
| Tagged table 1 | 32 entry, history 4, tag 6-bit |
| Tagged table 2 | 32 entry, history 12, tag 7-bit |
| Tagged table 3 | 32 entry, history 32, tag 8-bit |
| Tagged counter | 3-bit saturating |
| Usefulness | 1-bit |
| Global history | 32-bit |
| Allocation | Tối đa một entry trên mỗi misprediction |
| History mode | Committed, `SPECULATIVE_HISTORY = 0` |
| Soft-reset table | Giữ trạng thái, `RESET_ON_SOFT_RESET = 0` |

Tổng dung lượng ba tagged table và base table ở cấu hình mặc định là khoảng
1280 bit, chưa tính GHR và trạng thái round-robin. Cấu hình TAGE-3 được chọn
để giữ priority mux ngắn, giảm LUT và vẫn học được tương quan ngắn, trung bình
và dài.

## Thuật toán dự đoán

1. Base table và ba tagged table được đọc song song.
2. Tagged entry hit khi entry hợp lệ và stored tag bằng tag được hash.
3. Table 3 có priority cao nhất, tiếp theo là table 2 và table 1.
4. Tagged hit ngắn hơn kế tiếp làm alternate; nếu không có thì dùng base.
5. Bit cao nhất của counter là hướng dự đoán của tagged provider.
6. Provider mới, `usefulness = 0` và counter đang weak dùng alternate làm kết
   quả cuối.
7. Nếu không có tagged hit, kết quả cuối đến từ base table.

Hàm hash fold toàn bộ `PC[31:2]` và số bit history tương ứng của từng table.
Các phép `%`, phép chia và phép nhân trong loop chỉ tính trên biến loop và
parameter hằng tại thời điểm elaboration; chúng không tạo bộ chia, bộ nhân hoặc
DSP trong datapath.

## Train, allocation và aging

- Base table được train trên mọi conditional branch hợp lệ đã resolve.
- Counter của tagged provider chỉ được train nếu entry tại update vẫn khớp tag.
- Usefulness chỉ đổi khi raw provider và alternate dự đoán khác nhau.
- Nếu raw provider đúng, usefulness tăng; nếu alternate đúng, usefulness giảm.
- Entry mới chỉ được allocate khi kết quả dự đoán cuối sai.
- Chỉ table có history dài hơn provider mới là candidate.
- Candidate phải có `usefulness = 0` và không được chứa cùng tag của branch.
- Entry mới có counter weak-correct và usefulness bằng 0.
- Round-robin 2-bit phân bố allocation giữa các candidate hợp lệ.
- Nếu không có candidate `u = 0`, pressure aging giảm usefulness để một lần
  misprediction sau có thể thay thế entry.
- Kiểm tra `update_hit_o` ngăn metadata cũ của nhiều branch đang in-flight ghi
  đè entry cùng tag vừa được một branch lớn tuổi hơn tạo ra.

Đây là biến thể TAGE nhỏ dành cho core FPGA. Để giảm metadata và logic ghi,
tagged alternate không có cổng train riêng; base vẫn được train trên mọi
conditional branch. Thiết kế không gồm BTB, RAS, loop predictor, path history
hoặc statistical corrector.

## Giao diện top-level

Module tích hợp là `tage_predictor`.

### Lookup tại IF

- `predict_pc_i`: PC của instruction đang fetch.
- `predict_accept_i`: pulse một chu kỳ khi conditional branch được IF chấp nhận.
- `predict_taken_o`: kết quả dự đoán cuối.
- `predict_provider_table_o`: `0` là base, `1..3` là tagged table.
- `predict_provider_taken_o`: hướng raw provider.
- `predict_alternate_taken_o`: hướng alternate.
- `predict_indices_o`, `predict_tags_o`, `predict_history_o`: context phải
  pipeline cùng instruction.

### Update tại nơi branch resolve

- `update_valid_i`: chỉ bật cho conditional branch hợp lệ.
- `update_pc_i`: PC đã pipeline của branch.
- `update_taken_i`: outcome thực tế.
- `update_prediction_i`: `predict_taken_o` đã pipeline.
- Các input `update_provider_*`, `update_indices_i`, `update_tags_i` và
  `update_history_i` phải lấy từ context của đúng branch đó.

Không dùng index, tag hoặc history đang live tại EX. Không train TAGE bằng
`JAL` hoặc `JALR`. `update_valid_i` cũng không được lấy từ tín hiệu
actual-taken, vì branch not-taken vẫn phải được train.

Layout index với cấu hình mặc định:

```text
predict_indices_o[4:0]   = table 1
predict_indices_o[9:5]   = table 2
predict_indices_o[14:10] = table 3
```

Layout tag với cấu hình mặc định:

```text
predict_tags_o[5:0]   = table 1
predict_tags_o[12:6]  = table 2
predict_tags_o[20:13] = table 3
```

## Global history và flush

Mặc định `SPECULATIVE_HISTORY = 0`. GHR chỉ append actual outcome khi
`update_valid_i = 1`. Chế độ này an toàn khi core chưa pipeline checkpoint cho
mọi loại flush, đổi lại các branch đồng thời trong pipeline nhìn history cũ
hơn.

Khi đặt `SPECULATIVE_HISTORY = 1`:

- Pulse `predict_accept_i` chỉ khi conditional branch thật sự được chấp nhận và
  không bị stall.
- GHR append `predict_taken_o` tại cạnh lên.
- Mỗi branch phải lưu `predict_history_o` làm checkpoint.
- Conditional misprediction tự rollback từ `update_history_i` rồi append
  `update_taken_i`.
- `history_recover_valid_i` thay toàn bộ GHR bằng `history_recover_i` và có
  priority cao nhất.

Core phải điều khiển external recovery cho mọi flush không được top-level tự xử
lý, ví dụ `JAL`, `JALR`, exception, interrupt hoặc redirect khác. Giá trị
`history_recover_i` phải là checkpoint chính xác mà core muốn khôi phục. Nếu
không có cơ chế checkpoint/flush này, giữ cấu hình mặc định committed.

## Reset và tối ưu FPGA

Các bảng dùng:

```verilog
(* ram_style = "distributed" *)
```

Lookup bất đồng bộ và write đồng bộ hướng tới distributed LUTRAM, tránh độ trễ
đọc một chu kỳ của block RAM. Mọi module RTL có `(* use_dsp = "no" *)`; datapath
chỉ dùng bit-select, XOR, mux và counter 2/3-bit. Vì vậy mục tiêu là 0 DSP.
Số LUT và Fmax chính xác vẫn phải lấy từ report synthesis của FPGA đích; dự án
này không chạy Vivado synthesis tự động.

Với `RESET_ON_SOFT_RESET = 0`, table được khởi tạo khi nạp bitstream và giữ lịch
sử qua soft reset. Predictor state không phải architectural state nên việc giữ
lại không làm sai chương trình.

Đặt `RESET_ON_SOFT_RESET = 1` nếu cần table xuất hiện cold sau mọi soft reset.
Chế độ này reset validity plane riêng thay vì reset toàn bộ RAM array, nhưng tốn
thêm flip-flop và mux.

## Trình tự tích hợp vào CPU

1. Lookup bằng fetch PC.
2. Decode đúng conditional branch opcode `7'b1100011`.
3. Chỉ pulse `predict_accept_i` khi fetch branch được chấp nhận.
4. Pipeline toàn bộ prediction context qua các stage.
5. Tạo `conditional_branch_valid` riêng tại stage resolve.
6. So sánh `update_prediction_i` với `update_taken_i` để redirect/flush.
7. Gửi update cho cả branch taken và not-taken.
8. Nếu bật speculative history, pipeline checkpoint và nối external recovery
   cho mọi nguyên nhân flush.

## Mô phỏng

Chạy từ thư mục `00_src/TAGE`:

```powershell
vlib work

vlog -vlog01compat -lint -work work `
  rtl\tage_global_history.v `
  rtl\tage_hash.v `
  rtl\tage_base_table.v `
  rtl\tage_tagged_table.v `
  rtl\tage_provider_selector.v `
  rtl\tage_predictor.v `
  tb\tage_global_history_tb.v `
  tb\tage_provider_selector_tb.v `
  tb\tage_tagged_table_tb.v `
  tb\tage_predictor_tb.v

vsim -c -lib work tage_global_history_tb `
  -do "run -all; quit -f"

vsim -c -lib work tage_provider_selector_tb `
  -do "run -all; quit -f"

vsim -c -lib work tage_tagged_table_tb `
  -do "run -all; quit -f"

vsim -c -lib work tage_predictor_tb `
  -do "run -all; quit -f"
```

Questa trả exit code `0` sau Verilog `$finish` ngay cả khi testbench in `FAIL`.
Khi dùng CI, cần kiểm tra transcript có đúng chuỗi `PASS:` và không có `FAIL:`.

Regression kiểm tra trực tiếp:

- committed và speculative history;
- nhiều branch outstanding, rollback và external recovery priority;
- provider priority và weak-provider alternate;
- allocate, tag mismatch, counter saturation;
- usefulness tăng/giảm, pressure aging và logical soft reset;
- context bus packing/unpacking;
- high PC-bit folding;
- always-taken, always-not-taken và alternating history pattern;
- hai PC cùng base index nhưng khác partial tag.

## Tài liệu thuật toán

- André Seznec và Pierre Michaud, *A case for (partially) TAgged GEometric
  history length branch prediction*, JILP 2006:
  <https://jilp.org/vol8/v8paper1.pdf>
- André Seznec, *A New Case for the TAGE Branch Predictor*, MICRO 2011:
  <https://www.cs.cmu.edu/~18742/papers/Seznec2011.pdf>

