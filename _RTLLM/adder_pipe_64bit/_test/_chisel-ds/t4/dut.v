module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] addaReg_0; // @[dut.scala 14:20]
  reg [15:0] addaReg_1; // @[dut.scala 14:20]
  reg [15:0] addaReg_2; // @[dut.scala 14:20]
  reg [15:0] addaReg_3; // @[dut.scala 14:20]
  reg [15:0] addbReg_0; // @[dut.scala 15:20]
  reg [15:0] addbReg_1; // @[dut.scala 15:20]
  reg [15:0] addbReg_2; // @[dut.scala 15:20]
  reg [15:0] addbReg_3; // @[dut.scala 15:20]
  reg  carryReg_1; // @[dut.scala 18:21]
  reg  carryReg_2; // @[dut.scala 18:21]
  reg  carryReg_3; // @[dut.scala 18:21]
  reg [16:0] sumReg_0; // @[dut.scala 22:19]
  reg [16:0] sumReg_1; // @[dut.scala 22:19]
  reg [16:0] sumReg_2; // @[dut.scala 22:19]
  reg [16:0] sumReg_3; // @[dut.scala 22:19]
  reg  enReg_0; // @[dut.scala 25:18]
  reg  enReg_1; // @[dut.scala 25:18]
  reg  enReg_2; // @[dut.scala 25:18]
  reg  enReg_3; // @[dut.scala 25:18]
  wire [16:0] _sumReg_0_T = addaReg_0 + addbReg_0; // @[dut.scala 30:27]
  wire [17:0] _sumReg_0_T_1 = {{1'd0}, _sumReg_0_T}; // @[dut.scala 30:41]
  wire [16:0] _sumReg_1_T = addaReg_1 + addbReg_1; // @[dut.scala 37:27]
  wire [16:0] _GEN_0 = {{16'd0}, carryReg_1}; // @[dut.scala 37:41]
  wire [16:0] _sumReg_2_T = addaReg_2 + addbReg_2; // @[dut.scala 44:27]
  wire [16:0] _GEN_1 = {{16'd0}, carryReg_2}; // @[dut.scala 44:41]
  wire [16:0] _sumReg_3_T = addaReg_3 + addbReg_3; // @[dut.scala 51:27]
  wire [16:0] _GEN_2 = {{16'd0}, carryReg_3}; // @[dut.scala 51:41]
  wire [63:0] _io_result_T_4 = {sumReg_3[15:0],sumReg_2[15:0],sumReg_1[15:0],sumReg_0[15:0]}; // @[Cat.scala 33:92]
  wire [64:0] _io_result_T_6 = {sumReg_3[16], 64'h0}; // @[dut.scala 55:110]
  wire [64:0] _GEN_3 = {{1'd0}, _io_result_T_4}; // @[dut.scala 55:92]
  wire [65:0] _io_result_T_7 = _GEN_3 + _io_result_T_6; // @[dut.scala 55:92]
  assign io_result = _io_result_T_7[64:0]; // @[dut.scala 55:13]
  assign io_o_en = enReg_3; // @[dut.scala 56:11]
  always @(posedge clock) begin
    addaReg_0 <= io_adda[15:0]; // @[dut.scala 28:24]
    addaReg_1 <= io_adda[31:16]; // @[dut.scala 35:24]
    addaReg_2 <= io_adda[47:32]; // @[dut.scala 42:24]
    addaReg_3 <= io_adda[63:48]; // @[dut.scala 49:24]
    addbReg_0 <= io_addb[15:0]; // @[dut.scala 29:24]
    addbReg_1 <= io_addb[31:16]; // @[dut.scala 36:24]
    addbReg_2 <= io_addb[47:32]; // @[dut.scala 43:24]
    addbReg_3 <= io_addb[63:48]; // @[dut.scala 50:24]
    carryReg_1 <= sumReg_0[16]; // @[dut.scala 31:27]
    carryReg_2 <= sumReg_1[16]; // @[dut.scala 38:27]
    carryReg_3 <= sumReg_2[16]; // @[dut.scala 45:27]
    sumReg_0 <= _sumReg_0_T_1[16:0]; // @[dut.scala 30:41]
    sumReg_1 <= _sumReg_1_T + _GEN_0; // @[dut.scala 37:41]
    sumReg_2 <= _sumReg_2_T + _GEN_1; // @[dut.scala 44:41]
    sumReg_3 <= _sumReg_3_T + _GEN_2; // @[dut.scala 51:41]
    enReg_0 <= io_i_en; // @[dut.scala 32:12]
    enReg_1 <= enReg_0; // @[dut.scala 39:12]
    enReg_2 <= enReg_1; // @[dut.scala 46:12]
    enReg_3 <= enReg_2; // @[dut.scala 52:12]
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
  addaReg_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  addaReg_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  addaReg_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  addaReg_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  addbReg_0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  addbReg_1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  addbReg_2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  addbReg_3 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  carryReg_1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  carryReg_2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  carryReg_3 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sumReg_0 = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  sumReg_1 = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  sumReg_2 = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  sumReg_3 = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  enReg_0 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  enReg_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  enReg_2 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  enReg_3 = _RAND_18[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
