# Bộ dự đoán nhánh 2-bit

Thư mục này chứa bộ dự đoán hướng rẽ kiểu bimodal cho core RV32I. Module dùng một bảng counter được đánh chỉ mục trực tiếp bằng PC; mỗi entry là một counter bão hòa 2-bit. Đường đọc là tổ hợp để kết quả có thể được dùng ngay trong tầng IF, còn việc huấn luyện diễn ra tại cạnh lên của clock khi conditional branch đã được xử lý.

Module hiện là khối độc lập và chưa được nối vào `RISCV.v`. Nó chỉ dự đoán hướng taken/not-taken; target của B-type vẫn phải được tính bên ngoài bằng `PC + immediate`. JAL có thể xử lý như always-taken, còn JALR cần giá trị `rs1` hoặc một Branch Target Buffer (BTB) nên không thuộc module cơ bản này.

## Cấu trúc

```text
branch_prediction/
├── README.md
└── rtl/
    └── branch_predictor_2bit.v
```

## Giải thuật

Mỗi entry có bốn trạng thái:

| Mã | Trạng thái | Dự đoán | Khi actual taken | Khi actual not-taken |
| --- | --- | --- | --- | --- |
| `2'b00` | Strongly not-taken | Not-taken | `2'b01` | `2'b00` |
| `2'b01` | Weakly not-taken | Not-taken | `2'b10` | `2'b00` |
| `2'b10` | Weakly taken | Taken | `2'b11` | `2'b01` |
| `2'b11` | Strongly taken | Taken | `2'b11` | `2'b10` |

Bit cao của counter là kết quả `predict_taken_o`. Counter bão hòa ở `2'b00` và `2'b11`, vì vậy không bị wrap-around. Reset khởi tạo mọi entry về `2'b01` để lần gặp đầu tiên dự đoán not-taken nhưng chỉ cần một kết quả taken để đổi hướng dự đoán.

## Parameter

| Parameter | Mặc định | Mô tả |
| --- | --- | --- |
| `ENTRY_COUNT` | `64` | Số entry của bảng; phải là lũy thừa của hai và tối thiểu là `2` |

Với cấu hình mặc định, bảng chứa `64 x 2 = 128` bit trạng thái. Index từ PC 32-bit có giới hạn toán học là 30 bit, nhưng kích thước khả thi nhỏ hơn rất nhiều và phụ thuộc tài nguyên cũng như công cụ của công nghệ đích. Các cấu hình nhỏ như 16, 32, 64 hoặc 128 entry phù hợp hơn với cách triển khai bằng flip-flop hiện tại.

## Port

| Port | Hướng | Độ rộng | Mô tả |
| --- | --- | --- | --- |
| `clk_i` | Input | 1 bit | Clock cạnh lên |
| `rstn_i` | Input | 1 bit | Reset bất đồng bộ active-low |
| `predict_pc_i` | Input | 32 bit | PC cần tra cứu ở đường fetch |
| `predict_taken_o` | Output | 1 bit | `1` nếu entry dự đoán taken, ngược lại là not-taken |
| `update_valid_i` | Input | 1 bit | Cho phép huấn luyện một conditional branch ở cạnh lên |
| `update_pc_i` | Input | 32 bit | PC của conditional branch đã được xử lý |
| `update_taken_i` | Input | 1 bit | Kết quả thực tế của branch: `1` là taken |

## Đánh chỉ mục

Hai bit thấp `PC[1:0]` bị bỏ qua vì instruction RV32I trong core này aligned theo 4 byte:

```text
INDEX_WIDTH = log2(ENTRY_COUNT)
index       = PC[INDEX_WIDTH+1:2]
```

Module không lưu tag. Hai PC có cùng các bit index sẽ dùng chung counter; đây là aliasing có chủ đích của predictor bimodal 2-bit cơ bản.

## Giao thức thời gian

- Lookup bằng `predict_pc_i` là bất đồng bộ và không thay đổi trạng thái.
- Khi `update_valid_i = 1`, đúng một counter được cập nhật tại cạnh lên theo `update_pc_i` và `update_taken_i`.
- Khi `update_valid_i = 0`, toàn bộ bảng giữ nguyên.
- Nếu lookup và update cùng một entry trong một chu kỳ, output biểu diễn trạng thái cũ trước cạnh clock và trạng thái mới sau khi cập nhật nonblocking hoàn tất.
- Không cần `flush_i` vì predictor chỉ thay đổi trạng thái khi branch thật đã resolve; lookup speculative không ghi bảng counter.

`update_valid_i` phải được bật cho mọi conditional branch hợp lệ đã resolve, kể cả khi dự đoán đúng. Không dùng tín hiệu actual-taken làm valid và không huấn luyện bảng bằng JAL/JALR.

## Ví dụ tích hợp

```verilog
wire predicted_taken_w;

branch_predictor_2bit #(
    .ENTRY_COUNT (64)
) branch_predictor_inst (
    .clk_i           (clk_i),
    .rstn_i          (rstn_i),
    .predict_pc_i    (fetch_pc_w),
    .predict_taken_o (predicted_taken_w),
    .update_valid_i  (branch_resolve_valid_w),
    .update_pc_i     (branch_pc_EX_w),
    .update_taken_i  (branch_taken_EX_w)
);
```

Phần tích hợp pipeline cần thực hiện thêm các việc sau:

1. Lookup bằng live fetch PC và decode live IMEM instruction bên trong `IF_stage` (`addr_current_w` và `instruction_w`), không dùng `addr_IF_w`/`instr_IF_w` đã được chốt trong IF/ID.
2. Chỉ coi instruction là conditional branch khi opcode là `7'b1100011` và `funct3` thuộc `000`, `001`, `100`, `101`, `110` hoặc `111`.
3. Khi dự đoán taken, tính target từ live PC và B-immediate. Prediction chỉ chọn đường next-PC bình thường giữa `PC + 4` và predicted target khi fetch được phép tiến.
4. Không nối `predicted_taken_w` trực tiếp vào `IF_stage.branch_i` hoặc `flush_i`. Trong thiết kế hiện tại, `branch_i` override stall và đồng thời đường redirect được dùng để flush; prediction đúng không được tạo flush hoặc bỏ qua load-use stall.
5. Pipeline bit dự đoán và PC của branch qua IF/ID rồi ID/EX. IF/ID phải giữ metadata khi PC stall; ID/EX phải xóa metadata khi chèn bubble hoặc flush.
6. Tại EX, phát hiện sai dự đoán bằng:

   ```text
   conditional_mispredict = branch_resolve_valid &&
                            (predicted_taken_EX != branch_taken_EX)
   ```

7. Khi conditional branch sai dự đoán, recovery PC là branch target nếu actual taken, hoặc `branch_pc_EX + 4` nếu actual not-taken. Recovery redirect/flush phải ưu tiên stall và prediction mới ở IF.
8. JAL/JALR không dùng bảng predictor này; chúng vẫn cần đường redirect riêng tới target thật khi resolve.

Trong core hiện tại, `redirect_EXE_w` là actual-taken khi được qualify bởi conditional branch, nhưng cũng được dùng làm redirect cho JAL/JALR. Giá trị `redirect_EXE_w = 0` có thể có nghĩa là branch not-taken hoặc instruction không phải branch. Vì vậy:

- Không nối trực tiếp `redirect_EXE_w` vào `update_valid_i`; cần một branch-valid riêng được pipeline tới EX.
- Phải thay đường redirect/flush conditional đang điều khiển trực tiếp bằng `redirect_EXE_w` thành `conditional_mispredict`. Nếu giữ đường cũ, predicted-taken đúng vẫn bị flush và predicted-taken sai về not-taken không thể recovery đúng.
- Correctly predicted conditional branch không tạo redirect/flush ở EX. JAL/JALR vẫn tạo redirect vì chưa được dự đoán bởi module này.

## Lint

Chạy độc lập từ thư mục `00_src/branch_prediction`:

```text
verilator --lint-only -Wall -Wno-UNUSEDSIGNAL \
  rtl/branch_predictor_2bit.v \
  --top-module branch_predictor_2bit
```

`UNUSEDSIGNAL` được tắt vì predictor cố ý bỏ `PC[1:0]` và các bit PC cao hơn index. Việc reset toàn bộ array phù hợp với bảng nhỏ triển khai bằng flip-flop; nếu cần suy diễn block RAM cho bảng lớn, phải thay đổi chiến lược khởi tạo/reset theo công nghệ đích.
