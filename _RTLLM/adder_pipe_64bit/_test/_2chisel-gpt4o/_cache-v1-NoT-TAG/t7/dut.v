module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  _fullAdderSum_T_2 = io_a[0] ^ io_b[0]; // @[dut.scala 20:32]
  wire  fullAdderSum = io_a[0] ^ io_b[0] ^ io_cin; // @[dut.scala 20:42]
  wire  fullAdderCarry = io_a[0] & io_b[0] | io_cin & _fullAdderSum_T_2; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_5 = io_a[1] ^ io_b[1]; // @[dut.scala 20:32]
  wire  fullAdderSum_1 = io_a[1] ^ io_b[1] ^ fullAdderCarry; // @[dut.scala 20:42]
  wire  fullAdderCarry_1 = io_a[1] & io_b[1] | fullAdderCarry & _fullAdderSum_T_5; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_8 = io_a[2] ^ io_b[2]; // @[dut.scala 20:32]
  wire  fullAdderSum_2 = io_a[2] ^ io_b[2] ^ fullAdderCarry_1; // @[dut.scala 20:42]
  wire  fullAdderCarry_2 = io_a[2] & io_b[2] | fullAdderCarry_1 & _fullAdderSum_T_8; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_11 = io_a[3] ^ io_b[3]; // @[dut.scala 20:32]
  wire  fullAdderSum_3 = io_a[3] ^ io_b[3] ^ fullAdderCarry_2; // @[dut.scala 20:42]
  wire  fullAdderCarry_3 = io_a[3] & io_b[3] | fullAdderCarry_2 & _fullAdderSum_T_11; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_14 = io_a[4] ^ io_b[4]; // @[dut.scala 20:32]
  wire  fullAdderSum_4 = io_a[4] ^ io_b[4] ^ fullAdderCarry_3; // @[dut.scala 20:42]
  wire  fullAdderCarry_4 = io_a[4] & io_b[4] | fullAdderCarry_3 & _fullAdderSum_T_14; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_17 = io_a[5] ^ io_b[5]; // @[dut.scala 20:32]
  wire  fullAdderSum_5 = io_a[5] ^ io_b[5] ^ fullAdderCarry_4; // @[dut.scala 20:42]
  wire  fullAdderCarry_5 = io_a[5] & io_b[5] | fullAdderCarry_4 & _fullAdderSum_T_17; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_20 = io_a[6] ^ io_b[6]; // @[dut.scala 20:32]
  wire  fullAdderSum_6 = io_a[6] ^ io_b[6] ^ fullAdderCarry_5; // @[dut.scala 20:42]
  wire  fullAdderCarry_6 = io_a[6] & io_b[6] | fullAdderCarry_5 & _fullAdderSum_T_20; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_23 = io_a[7] ^ io_b[7]; // @[dut.scala 20:32]
  wire  fullAdderSum_7 = io_a[7] ^ io_b[7] ^ fullAdderCarry_6; // @[dut.scala 20:42]
  wire  fullAdderCarry_7 = io_a[7] & io_b[7] | fullAdderCarry_6 & _fullAdderSum_T_23; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_26 = io_a[8] ^ io_b[8]; // @[dut.scala 20:32]
  wire  fullAdderSum_8 = io_a[8] ^ io_b[8] ^ fullAdderCarry_7; // @[dut.scala 20:42]
  wire  fullAdderCarry_8 = io_a[8] & io_b[8] | fullAdderCarry_7 & _fullAdderSum_T_26; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_29 = io_a[9] ^ io_b[9]; // @[dut.scala 20:32]
  wire  fullAdderSum_9 = io_a[9] ^ io_b[9] ^ fullAdderCarry_8; // @[dut.scala 20:42]
  wire  fullAdderCarry_9 = io_a[9] & io_b[9] | fullAdderCarry_8 & _fullAdderSum_T_29; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_32 = io_a[10] ^ io_b[10]; // @[dut.scala 20:32]
  wire  fullAdderSum_10 = io_a[10] ^ io_b[10] ^ fullAdderCarry_9; // @[dut.scala 20:42]
  wire  fullAdderCarry_10 = io_a[10] & io_b[10] | fullAdderCarry_9 & _fullAdderSum_T_32; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_35 = io_a[11] ^ io_b[11]; // @[dut.scala 20:32]
  wire  fullAdderSum_11 = io_a[11] ^ io_b[11] ^ fullAdderCarry_10; // @[dut.scala 20:42]
  wire  fullAdderCarry_11 = io_a[11] & io_b[11] | fullAdderCarry_10 & _fullAdderSum_T_35; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_38 = io_a[12] ^ io_b[12]; // @[dut.scala 20:32]
  wire  fullAdderSum_12 = io_a[12] ^ io_b[12] ^ fullAdderCarry_11; // @[dut.scala 20:42]
  wire  fullAdderCarry_12 = io_a[12] & io_b[12] | fullAdderCarry_11 & _fullAdderSum_T_38; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_41 = io_a[13] ^ io_b[13]; // @[dut.scala 20:32]
  wire  fullAdderSum_13 = io_a[13] ^ io_b[13] ^ fullAdderCarry_12; // @[dut.scala 20:42]
  wire  fullAdderCarry_13 = io_a[13] & io_b[13] | fullAdderCarry_12 & _fullAdderSum_T_41; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_44 = io_a[14] ^ io_b[14]; // @[dut.scala 20:32]
  wire  fullAdderSum_14 = io_a[14] ^ io_b[14] ^ fullAdderCarry_13; // @[dut.scala 20:42]
  wire  fullAdderCarry_14 = io_a[14] & io_b[14] | fullAdderCarry_13 & _fullAdderSum_T_44; // @[dut.scala 21:46]
  wire  _fullAdderSum_T_47 = io_a[15] ^ io_b[15]; // @[dut.scala 20:32]
  wire  fullAdderSum_15 = io_a[15] ^ io_b[15] ^ fullAdderCarry_14; // @[dut.scala 20:42]
  wire [7:0] io_sum_lo = {fullAdderSum_7,fullAdderSum_6,fullAdderSum_5,fullAdderSum_4,fullAdderSum_3,fullAdderSum_2,
    fullAdderSum_1,fullAdderSum}; // @[dut.scala 27:26]
  wire [7:0] io_sum_hi = {fullAdderSum_15,fullAdderSum_14,fullAdderSum_13,fullAdderSum_12,fullAdderSum_11,
    fullAdderSum_10,fullAdderSum_9,fullAdderSum_8}; // @[dut.scala 27:26]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 27:26]
  assign io_cout = io_a[15] & io_b[15] | fullAdderCarry_14 & _fullAdderSum_T_47; // @[dut.scala 21:46]
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
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [95:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] rca16_1_io_a; // @[dut.scala 62:23]
  wire [15:0] rca16_1_io_b; // @[dut.scala 62:23]
  wire  rca16_1_io_cin; // @[dut.scala 62:23]
  wire [15:0] rca16_1_io_sum; // @[dut.scala 62:23]
  wire  rca16_1_io_cout; // @[dut.scala 62:23]
  wire [15:0] rca16_2_io_a; // @[dut.scala 63:23]
  wire [15:0] rca16_2_io_b; // @[dut.scala 63:23]
  wire  rca16_2_io_cin; // @[dut.scala 63:23]
  wire [15:0] rca16_2_io_sum; // @[dut.scala 63:23]
  wire  rca16_2_io_cout; // @[dut.scala 63:23]
  wire [15:0] rca16_3_io_a; // @[dut.scala 64:23]
  wire [15:0] rca16_3_io_b; // @[dut.scala 64:23]
  wire  rca16_3_io_cin; // @[dut.scala 64:23]
  wire [15:0] rca16_3_io_sum; // @[dut.scala 64:23]
  wire  rca16_3_io_cout; // @[dut.scala 64:23]
  wire [15:0] rca16_4_io_a; // @[dut.scala 65:23]
  wire [15:0] rca16_4_io_b; // @[dut.scala 65:23]
  wire  rca16_4_io_cin; // @[dut.scala 65:23]
  wire [15:0] rca16_4_io_sum; // @[dut.scala 65:23]
  wire  rca16_4_io_cout; // @[dut.scala 65:23]
  reg [63:0] addaReg; // @[Reg.scala 35:20]
  reg [63:0] addbReg; // @[Reg.scala 35:20]
  reg  enPipeline_0; // @[dut.scala 48:27]
  reg  enPipeline_1; // @[dut.scala 48:27]
  reg  enPipeline_2; // @[dut.scala 48:27]
  reg  enPipeline_3; // @[dut.scala 48:27]
  reg [15:0] sumStage1; // @[dut.scala 75:26]
  reg  carryStage1; // @[dut.scala 76:28]
  reg [15:0] sumStage2; // @[dut.scala 84:26]
  reg  carryStage2; // @[dut.scala 85:28]
  reg [15:0] sumStage3; // @[dut.scala 93:26]
  reg  carryStage3; // @[dut.scala 94:28]
  reg [15:0] sumStage4; // @[dut.scala 102:26]
  reg  carryStage4; // @[dut.scala 103:28]
  wire [31:0] resultReg_lo = {sumStage2,sumStage1}; // @[Cat.scala 33:92]
  wire [32:0] resultReg_hi = {carryStage4,sumStage4,sumStage3}; // @[Cat.scala 33:92]
  reg [64:0] resultReg; // @[dut.scala 109:26]
  RCA16 rca16_1 ( // @[dut.scala 62:23]
    .io_a(rca16_1_io_a),
    .io_b(rca16_1_io_b),
    .io_cin(rca16_1_io_cin),
    .io_sum(rca16_1_io_sum),
    .io_cout(rca16_1_io_cout)
  );
  RCA16 rca16_2 ( // @[dut.scala 63:23]
    .io_a(rca16_2_io_a),
    .io_b(rca16_2_io_b),
    .io_cin(rca16_2_io_cin),
    .io_sum(rca16_2_io_sum),
    .io_cout(rca16_2_io_cout)
  );
  RCA16 rca16_3 ( // @[dut.scala 64:23]
    .io_a(rca16_3_io_a),
    .io_b(rca16_3_io_b),
    .io_cin(rca16_3_io_cin),
    .io_sum(rca16_3_io_sum),
    .io_cout(rca16_3_io_cout)
  );
  RCA16 rca16_4 ( // @[dut.scala 65:23]
    .io_a(rca16_4_io_a),
    .io_b(rca16_4_io_b),
    .io_cin(rca16_4_io_cin),
    .io_sum(rca16_4_io_sum),
    .io_cout(rca16_4_io_cout)
  );
  assign io_result = resultReg; // @[dut.scala 111:13]
  assign io_o_en = enPipeline_3; // @[dut.scala 116:11]
  assign rca16_1_io_a = addaReg[15:0]; // @[dut.scala 71:26]
  assign rca16_1_io_b = addbReg[15:0]; // @[dut.scala 72:26]
  assign rca16_1_io_cin = 1'h0; // @[dut.scala 73:18]
  assign rca16_2_io_a = addaReg[31:16]; // @[dut.scala 80:26]
  assign rca16_2_io_b = addbReg[31:16]; // @[dut.scala 81:26]
  assign rca16_2_io_cin = carryStage1; // @[dut.scala 82:18]
  assign rca16_3_io_a = addaReg[47:32]; // @[dut.scala 89:26]
  assign rca16_3_io_b = addbReg[47:32]; // @[dut.scala 90:26]
  assign rca16_3_io_cin = carryStage2; // @[dut.scala 91:18]
  assign rca16_4_io_a = addaReg[63:48]; // @[dut.scala 98:26]
  assign rca16_4_io_b = addbReg[63:48]; // @[dut.scala 99:26]
  assign rca16_4_io_cin = carryStage3; // @[dut.scala 100:18]
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
    if (reset) begin // @[dut.scala 48:27]
      enPipeline_0 <= 1'h0; // @[dut.scala 48:27]
    end else begin
      enPipeline_0 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 48:27]
      enPipeline_1 <= 1'h0; // @[dut.scala 48:27]
    end else begin
      enPipeline_1 <= enPipeline_0; // @[dut.scala 56:19]
    end
    if (reset) begin // @[dut.scala 48:27]
      enPipeline_2 <= 1'h0; // @[dut.scala 48:27]
    end else begin
      enPipeline_2 <= enPipeline_1; // @[dut.scala 56:19]
    end
    if (reset) begin // @[dut.scala 48:27]
      enPipeline_3 <= 1'h0; // @[dut.scala 48:27]
    end else begin
      enPipeline_3 <= enPipeline_2; // @[dut.scala 56:19]
    end
    sumStage1 <= rca16_1_io_sum; // @[dut.scala 75:26]
    carryStage1 <= rca16_1_io_cout; // @[dut.scala 76:28]
    sumStage2 <= rca16_2_io_sum; // @[dut.scala 84:26]
    carryStage2 <= rca16_2_io_cout; // @[dut.scala 85:28]
    sumStage3 <= rca16_3_io_sum; // @[dut.scala 93:26]
    carryStage3 <= rca16_3_io_cout; // @[dut.scala 94:28]
    sumStage4 <= rca16_4_io_sum; // @[dut.scala 102:26]
    carryStage4 <= rca16_4_io_cout; // @[dut.scala 103:28]
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
  enPipeline_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  enPipeline_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  enPipeline_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  enPipeline_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sumStage1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carryStage1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sumStage2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carryStage2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sumStage3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carryStage3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sumStage4 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carryStage4 = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  resultReg = _RAND_14[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
