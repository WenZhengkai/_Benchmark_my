module BusyTable_golden(
  input        clock,
  input        reset,
  input        io_wakeups_0_valid,
  input  [7:0] io_wakeups_0_bits_uop_pdst,
  input  [7:0] io_wakeups_0_bits_speculative_mask,
  input        io_wakeups_0_bits_rebusy,
  input        io_wakeups_1_valid,
  input  [7:0] io_wakeups_1_bits_uop_pdst,
  input  [7:0] io_wakeups_1_bits_speculative_mask,
  input        io_wakeups_1_bits_rebusy,
  input  [7:0] io_ren_uops_0_pdst,
  input  [7:0] io_ren_uops_1_pdst,
  input        io_rebusy_reqs_0,
  input        io_rebusy_reqs_1,
  input  [1:0] io_child_rebusys,
  output [1:0] io_busy_table
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  wakeups_wu_valid_REG; // @[BusyTable.scala 28:24]
  reg [7:0] wakeups_wu_valid_REG_1; // @[BusyTable.scala 28:46]
  wire [7:0] _GEN_0 = {{6'd0}, io_child_rebusys}; // @[BusyTable.scala 28:72]
  wire [7:0] _wakeups_wu_valid_T = wakeups_wu_valid_REG_1 & _GEN_0; // @[BusyTable.scala 28:72]
  wire  wakeups_0_valid = wakeups_wu_valid_REG & _wakeups_wu_valid_T == 8'h0; // @[BusyTable.scala 28:34]
  reg [7:0] wakeups_wu_bits_REG_uop_pdst; // @[BusyTable.scala 29:24]
  reg  wakeups_wu_bits_REG_rebusy; // @[BusyTable.scala 29:24]
  reg  wakeups_wu_valid_REG_2; // @[BusyTable.scala 28:24]
  reg [7:0] wakeups_wu_valid_REG_3; // @[BusyTable.scala 28:46]
  wire [7:0] _wakeups_wu_valid_T_3 = wakeups_wu_valid_REG_3 & _GEN_0; // @[BusyTable.scala 28:72]
  wire  wakeups_1_valid = wakeups_wu_valid_REG_2 & _wakeups_wu_valid_T_3 == 8'h0; // @[BusyTable.scala 28:34]
  reg [7:0] wakeups_wu_bits_REG_1_uop_pdst; // @[BusyTable.scala 29:24]
  reg  wakeups_wu_bits_REG_1_rebusy; // @[BusyTable.scala 29:24]
  wire [255:0] _busy_table_wb_T = 256'h1 << wakeups_wu_bits_REG_uop_pdst; // @[OneHot.scala 57:35]
  wire [255:0] _busy_table_wb_T_6 = 256'h1 << wakeups_wu_bits_REG_1_uop_pdst; // @[OneHot.scala 57:35]
  wire [255:0] _busy_table_next_T = 256'h1 << io_ren_uops_0_pdst; // @[OneHot.scala 57:35]
  wire [1:0] _busy_table_next_T_2 = io_rebusy_reqs_0 ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [255:0] _GEN_4 = {{254'd0}, _busy_table_next_T_2}; // @[BusyTable.scala 41:51]
  wire [255:0] _busy_table_next_T_3 = _busy_table_next_T & _GEN_4; // @[BusyTable.scala 41:51]
  wire [255:0] _busy_table_next_T_4 = 256'h1 << io_ren_uops_1_pdst; // @[OneHot.scala 57:35]
  wire [1:0] _busy_table_next_T_6 = io_rebusy_reqs_1 ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [255:0] _GEN_5 = {{254'd0}, _busy_table_next_T_6}; // @[BusyTable.scala 41:51]
  wire [255:0] _busy_table_next_T_7 = _busy_table_next_T_4 & _GEN_5; // @[BusyTable.scala 41:51]
  wire [255:0] _busy_table_next_T_8 = _busy_table_next_T_3 | _busy_table_next_T_7; // @[BusyTable.scala 41:82]
  wire  _busy_table_next_T_11 = wakeups_0_valid & wakeups_wu_bits_REG_rebusy; // @[BusyTable.scala 43:56]
  wire [1:0] _busy_table_next_T_13 = _busy_table_next_T_11 ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [255:0] _GEN_6 = {{254'd0}, _busy_table_next_T_13}; // @[BusyTable.scala 43:31]
  wire [255:0] _busy_table_next_T_14 = _busy_table_wb_T & _GEN_6; // @[BusyTable.scala 43:31]
  wire  _busy_table_next_T_16 = wakeups_1_valid & wakeups_wu_bits_REG_1_rebusy; // @[BusyTable.scala 43:56]
  wire [1:0] _busy_table_next_T_18 = _busy_table_next_T_16 ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [255:0] _GEN_7 = {{254'd0}, _busy_table_next_T_18}; // @[BusyTable.scala 43:31]
  wire [255:0] _busy_table_next_T_19 = _busy_table_wb_T_6 & _GEN_7; // @[BusyTable.scala 43:31]
  wire [255:0] _busy_table_next_T_20 = _busy_table_next_T_14 | _busy_table_next_T_19; // @[BusyTable.scala 44:14]
  wire [255:0] busy_table_next = _busy_table_next_T_8 | _busy_table_next_T_20; // @[BusyTable.scala 42:5]
  assign io_busy_table = busy_table_next[1:0]; // @[BusyTable.scala 47:17]
  always @(posedge clock) begin
    wakeups_wu_valid_REG <= io_wakeups_0_valid; // @[BusyTable.scala 28:24]
    wakeups_wu_valid_REG_1 <= io_wakeups_0_bits_speculative_mask; // @[BusyTable.scala 28:46]
    wakeups_wu_bits_REG_uop_pdst <= io_wakeups_0_bits_uop_pdst; // @[BusyTable.scala 29:24]
    wakeups_wu_bits_REG_rebusy <= io_wakeups_0_bits_rebusy; // @[BusyTable.scala 29:24]
    wakeups_wu_valid_REG_2 <= io_wakeups_1_valid; // @[BusyTable.scala 28:24]
    wakeups_wu_valid_REG_3 <= io_wakeups_1_bits_speculative_mask; // @[BusyTable.scala 28:46]
    wakeups_wu_bits_REG_1_uop_pdst <= io_wakeups_1_bits_uop_pdst; // @[BusyTable.scala 29:24]
    wakeups_wu_bits_REG_1_rebusy <= io_wakeups_1_bits_rebusy; // @[BusyTable.scala 29:24]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wakeups_wu_valid_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wakeups_wu_valid_REG_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  wakeups_wu_bits_REG_uop_pdst = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  wakeups_wu_bits_REG_rebusy = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  wakeups_wu_valid_REG_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  wakeups_wu_valid_REG_3 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  wakeups_wu_bits_REG_1_uop_pdst = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  wakeups_wu_bits_REG_1_rebusy = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
