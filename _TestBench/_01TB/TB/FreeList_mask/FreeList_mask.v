module FreeList_mask(
  input         clock,
  input         reset,
  input  [15:0] io_initial_allocation,
  input         io_alloc_pregs_0_valid,
  input  [3:0]  io_alloc_pregs_0_bits,
  input         io_alloc_pregs_1_valid,
  input  [3:0]  io_alloc_pregs_1_bits,
  input         io_reqs_0,
  input         io_reqs_1,
  input         io_dealloc_0_valid,
  input  [3:0]  io_dealloc_0_bits,
  input         io_dealloc_1_valid,
  input  [3:0]  io_dealloc_1_bits,
  input  [1:0]  io_brupdate_b2_uop_br_tag,
  input         io_brupdate_b2_mispredict,
  input         io_rollback,
  output [15:0] io_dealloc_mask
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  com_deallocs_REG_0_valid; // @[FreeList_mask.scala 31:29]
  reg [3:0] com_deallocs_REG_0_bits; // @[FreeList_mask.scala 31:29]
  reg  com_deallocs_REG_1_valid; // @[FreeList_mask.scala 31:29]
  reg [3:0] com_deallocs_REG_1_bits; // @[FreeList_mask.scala 31:29]
  wire [15:0] _com_deallocs_T = 16'h1 << com_deallocs_REG_0_bits; // @[OneHot.scala 57:35]
  wire [15:0] _com_deallocs_T_3 = com_deallocs_REG_0_valid ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] _com_deallocs_T_4 = _com_deallocs_T & _com_deallocs_T_3; // @[FreeList_mask.scala 31:82]
  wire [15:0] _com_deallocs_T_5 = 16'h1 << com_deallocs_REG_1_bits; // @[OneHot.scala 57:35]
  wire [15:0] _com_deallocs_T_8 = com_deallocs_REG_1_valid ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] _com_deallocs_T_9 = _com_deallocs_T_5 & _com_deallocs_T_8; // @[FreeList_mask.scala 31:82]
  assign io_dealloc_mask = _com_deallocs_T_4 | _com_deallocs_T_9; // @[FreeList_mask.scala 31:109]
  always @(posedge clock) begin
    com_deallocs_REG_0_valid <= io_dealloc_0_valid; // @[FreeList_mask.scala 31:29]
    com_deallocs_REG_0_bits <= io_dealloc_0_bits; // @[FreeList_mask.scala 31:29]
    com_deallocs_REG_1_valid <= io_dealloc_1_valid; // @[FreeList_mask.scala 31:29]
    com_deallocs_REG_1_bits <= io_dealloc_1_bits; // @[FreeList_mask.scala 31:29]
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
  com_deallocs_REG_0_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  com_deallocs_REG_0_bits = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  com_deallocs_REG_1_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  com_deallocs_REG_1_bits = _RAND_3[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
