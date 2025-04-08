module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  sums_0 = io_a[0] ^ io_b[0] ^ io_cin; // @[dut.scala 18:41]
  wire  carries_0 = io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin; // @[dut.scala 19:65]
  wire  sums_1 = io_a[1] ^ io_b[1] ^ carries_0; // @[dut.scala 21:41]
  wire  carries_1 = io_a[1] & io_b[1] | io_a[1] & carries_0 | io_b[1] & carries_0; // @[dut.scala 22:67]
  wire  sums_2 = io_a[2] ^ io_b[2] ^ carries_1; // @[dut.scala 21:41]
  wire  carries_2 = io_a[2] & io_b[2] | io_a[2] & carries_1 | io_b[2] & carries_1; // @[dut.scala 22:67]
  wire  sums_3 = io_a[3] ^ io_b[3] ^ carries_2; // @[dut.scala 21:41]
  wire  carries_3 = io_a[3] & io_b[3] | io_a[3] & carries_2 | io_b[3] & carries_2; // @[dut.scala 22:67]
  wire  sums_4 = io_a[4] ^ io_b[4] ^ carries_3; // @[dut.scala 21:41]
  wire  carries_4 = io_a[4] & io_b[4] | io_a[4] & carries_3 | io_b[4] & carries_3; // @[dut.scala 22:67]
  wire  sums_5 = io_a[5] ^ io_b[5] ^ carries_4; // @[dut.scala 21:41]
  wire  carries_5 = io_a[5] & io_b[5] | io_a[5] & carries_4 | io_b[5] & carries_4; // @[dut.scala 22:67]
  wire  sums_6 = io_a[6] ^ io_b[6] ^ carries_5; // @[dut.scala 21:41]
  wire  carries_6 = io_a[6] & io_b[6] | io_a[6] & carries_5 | io_b[6] & carries_5; // @[dut.scala 22:67]
  wire  sums_7 = io_a[7] ^ io_b[7] ^ carries_6; // @[dut.scala 21:41]
  wire  carries_7 = io_a[7] & io_b[7] | io_a[7] & carries_6 | io_b[7] & carries_6; // @[dut.scala 22:67]
  wire  sums_8 = io_a[8] ^ io_b[8] ^ carries_7; // @[dut.scala 21:41]
  wire  carries_8 = io_a[8] & io_b[8] | io_a[8] & carries_7 | io_b[8] & carries_7; // @[dut.scala 22:67]
  wire  sums_9 = io_a[9] ^ io_b[9] ^ carries_8; // @[dut.scala 21:41]
  wire  carries_9 = io_a[9] & io_b[9] | io_a[9] & carries_8 | io_b[9] & carries_8; // @[dut.scala 22:67]
  wire  sums_10 = io_a[10] ^ io_b[10] ^ carries_9; // @[dut.scala 21:41]
  wire  carries_10 = io_a[10] & io_b[10] | io_a[10] & carries_9 | io_b[10] & carries_9; // @[dut.scala 22:67]
  wire  sums_11 = io_a[11] ^ io_b[11] ^ carries_10; // @[dut.scala 21:41]
  wire  carries_11 = io_a[11] & io_b[11] | io_a[11] & carries_10 | io_b[11] & carries_10; // @[dut.scala 22:67]
  wire  sums_12 = io_a[12] ^ io_b[12] ^ carries_11; // @[dut.scala 21:41]
  wire  carries_12 = io_a[12] & io_b[12] | io_a[12] & carries_11 | io_b[12] & carries_11; // @[dut.scala 22:67]
  wire  sums_13 = io_a[13] ^ io_b[13] ^ carries_12; // @[dut.scala 21:41]
  wire  carries_13 = io_a[13] & io_b[13] | io_a[13] & carries_12 | io_b[13] & carries_12; // @[dut.scala 22:67]
  wire  sums_14 = io_a[14] ^ io_b[14] ^ carries_13; // @[dut.scala 21:41]
  wire  carries_14 = io_a[14] & io_b[14] | io_a[14] & carries_13 | io_b[14] & carries_13; // @[dut.scala 22:67]
  wire  sums_15 = io_a[15] ^ io_b[15] ^ carries_14; // @[dut.scala 21:41]
  wire [7:0] io_sum_lo = {sums_7,sums_6,sums_5,sums_4,sums_3,sums_2,sums_1,sums_0}; // @[dut.scala 29:24]
  wire [7:0] io_sum_hi = {sums_15,sums_14,sums_13,sums_12,sums_11,sums_10,sums_9,sums_8}; // @[dut.scala 29:24]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 29:24]
  assign io_cout = io_a[15] & io_b[15] | io_a[15] & carries_14 | io_b[15] & carries_14; // @[dut.scala 22:67]
endmodule
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
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [95:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] rca1_io_a; // @[dut.scala 51:20]
  wire [15:0] rca1_io_b; // @[dut.scala 51:20]
  wire  rca1_io_cin; // @[dut.scala 51:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 51:20]
  wire  rca1_io_cout; // @[dut.scala 51:20]
  wire [15:0] rca2_io_a; // @[dut.scala 60:20]
  wire [15:0] rca2_io_b; // @[dut.scala 60:20]
  wire  rca2_io_cin; // @[dut.scala 60:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 60:20]
  wire  rca2_io_cout; // @[dut.scala 60:20]
  wire [15:0] rca3_io_a; // @[dut.scala 69:20]
  wire [15:0] rca3_io_b; // @[dut.scala 69:20]
  wire  rca3_io_cin; // @[dut.scala 69:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 69:20]
  wire  rca3_io_cout; // @[dut.scala 69:20]
  wire [15:0] rca4_io_a; // @[dut.scala 78:20]
  wire [15:0] rca4_io_b; // @[dut.scala 78:20]
  wire  rca4_io_cin; // @[dut.scala 78:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 78:20]
  wire  rca4_io_cout; // @[dut.scala 78:20]
  reg [63:0] addaReg; // @[Reg.scala 35:20]
  reg [63:0] addbReg; // @[Reg.scala 35:20]
  reg [3:0] enPipeline; // @[dut.scala 46:27]
  wire [3:0] _enPipeline_T_1 = {enPipeline[2:0],io_i_en}; // @[dut.scala 47:34]
  reg [15:0] stage1Sum; // @[dut.scala 56:26]
  reg  stage1Cout; // @[dut.scala 57:27]
  reg [15:0] stage2Sum; // @[dut.scala 65:26]
  reg  stage2Cout; // @[dut.scala 66:27]
  reg [15:0] stage3Sum; // @[dut.scala 74:26]
  reg  stage3Cout; // @[dut.scala 75:27]
  reg [15:0] stage4Sum; // @[dut.scala 83:26]
  reg  finalCarry; // @[dut.scala 84:27]
  wire [31:0] resultReg_lo = {stage2Sum,stage1Sum}; // @[Cat.scala 33:92]
  wire [32:0] resultReg_hi = {finalCarry,stage4Sum,stage3Sum}; // @[Cat.scala 33:92]
  reg [64:0] resultReg; // @[dut.scala 87:26]
  RCA16 rca1 ( // @[dut.scala 51:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 60:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 69:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 78:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = resultReg; // @[dut.scala 88:13]
  assign io_o_en = enPipeline[3]; // @[dut.scala 91:24]
  assign rca1_io_a = addaReg[15:0]; // @[dut.scala 52:23]
  assign rca1_io_b = addbReg[15:0]; // @[dut.scala 53:23]
  assign rca1_io_cin = 1'h0; // @[dut.scala 54:15]
  assign rca2_io_a = addaReg[31:16]; // @[dut.scala 61:23]
  assign rca2_io_b = addbReg[31:16]; // @[dut.scala 62:23]
  assign rca2_io_cin = stage1Cout; // @[dut.scala 63:15]
  assign rca3_io_a = addaReg[47:32]; // @[dut.scala 70:23]
  assign rca3_io_b = addbReg[47:32]; // @[dut.scala 71:23]
  assign rca3_io_cin = stage2Cout; // @[dut.scala 72:15]
  assign rca4_io_a = addaReg[63:48]; // @[dut.scala 79:23]
  assign rca4_io_b = addbReg[63:48]; // @[dut.scala 80:23]
  assign rca4_io_cin = stage3Cout; // @[dut.scala 81:15]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 35:20]
      addaReg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addaReg <= io_adda; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      addbReg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addbReg <= io_addb; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 46:27]
      enPipeline <= 4'h0; // @[dut.scala 46:27]
    end else begin
      enPipeline <= _enPipeline_T_1; // @[dut.scala 47:14]
    end
    stage1Sum <= rca1_io_sum; // @[dut.scala 56:26]
    stage1Cout <= rca1_io_cout; // @[dut.scala 57:27]
    stage2Sum <= rca2_io_sum; // @[dut.scala 65:26]
    stage2Cout <= rca2_io_cout; // @[dut.scala 66:27]
    stage3Sum <= rca3_io_sum; // @[dut.scala 74:26]
    stage3Cout <= rca3_io_cout; // @[dut.scala 75:27]
    stage4Sum <= rca4_io_sum; // @[dut.scala 83:26]
    finalCarry <= rca4_io_cout; // @[dut.scala 84:27]
    resultReg <= {resultReg_hi,resultReg_lo}; // @[Cat.scala 33:92]
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
  _RAND_0 = {2{`RANDOM}};
  addaReg = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addbReg = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  enPipeline = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  stage1Sum = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  stage1Cout = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage2Sum = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  stage2Cout = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  stage3Sum = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage3Cout = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  stage4Sum = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  finalCarry = _RAND_10[0:0];
  _RAND_11 = {3{`RANDOM}};
  resultReg = _RAND_11[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
