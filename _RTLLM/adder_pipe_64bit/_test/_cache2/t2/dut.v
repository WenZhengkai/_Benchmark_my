module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  aBit = io_a[0]; // @[dut.scala 21:20]
  wire  bBit = io_b[0]; // @[dut.scala 22:20]
  wire  sum_0 = aBit ^ bBit ^ io_cin; // @[dut.scala 23:27]
  wire  carry_1 = aBit & bBit | aBit & io_cin | bBit & io_cin; // @[dut.scala 24:55]
  wire  aBit_1 = io_a[1]; // @[dut.scala 21:20]
  wire  bBit_1 = io_b[1]; // @[dut.scala 22:20]
  wire  sum_1 = aBit_1 ^ bBit_1 ^ carry_1; // @[dut.scala 23:27]
  wire  carry_2 = aBit_1 & bBit_1 | aBit_1 & carry_1 | bBit_1 & carry_1; // @[dut.scala 24:55]
  wire  aBit_2 = io_a[2]; // @[dut.scala 21:20]
  wire  bBit_2 = io_b[2]; // @[dut.scala 22:20]
  wire  sum_2 = aBit_2 ^ bBit_2 ^ carry_2; // @[dut.scala 23:27]
  wire  carry_3 = aBit_2 & bBit_2 | aBit_2 & carry_2 | bBit_2 & carry_2; // @[dut.scala 24:55]
  wire  aBit_3 = io_a[3]; // @[dut.scala 21:20]
  wire  bBit_3 = io_b[3]; // @[dut.scala 22:20]
  wire  sum_3 = aBit_3 ^ bBit_3 ^ carry_3; // @[dut.scala 23:27]
  wire  carry_4 = aBit_3 & bBit_3 | aBit_3 & carry_3 | bBit_3 & carry_3; // @[dut.scala 24:55]
  wire  aBit_4 = io_a[4]; // @[dut.scala 21:20]
  wire  bBit_4 = io_b[4]; // @[dut.scala 22:20]
  wire  sum_4 = aBit_4 ^ bBit_4 ^ carry_4; // @[dut.scala 23:27]
  wire  carry_5 = aBit_4 & bBit_4 | aBit_4 & carry_4 | bBit_4 & carry_4; // @[dut.scala 24:55]
  wire  aBit_5 = io_a[5]; // @[dut.scala 21:20]
  wire  bBit_5 = io_b[5]; // @[dut.scala 22:20]
  wire  sum_5 = aBit_5 ^ bBit_5 ^ carry_5; // @[dut.scala 23:27]
  wire  carry_6 = aBit_5 & bBit_5 | aBit_5 & carry_5 | bBit_5 & carry_5; // @[dut.scala 24:55]
  wire  aBit_6 = io_a[6]; // @[dut.scala 21:20]
  wire  bBit_6 = io_b[6]; // @[dut.scala 22:20]
  wire  sum_6 = aBit_6 ^ bBit_6 ^ carry_6; // @[dut.scala 23:27]
  wire  carry_7 = aBit_6 & bBit_6 | aBit_6 & carry_6 | bBit_6 & carry_6; // @[dut.scala 24:55]
  wire  aBit_7 = io_a[7]; // @[dut.scala 21:20]
  wire  bBit_7 = io_b[7]; // @[dut.scala 22:20]
  wire  sum_7 = aBit_7 ^ bBit_7 ^ carry_7; // @[dut.scala 23:27]
  wire  carry_8 = aBit_7 & bBit_7 | aBit_7 & carry_7 | bBit_7 & carry_7; // @[dut.scala 24:55]
  wire  aBit_8 = io_a[8]; // @[dut.scala 21:20]
  wire  bBit_8 = io_b[8]; // @[dut.scala 22:20]
  wire  sum_8 = aBit_8 ^ bBit_8 ^ carry_8; // @[dut.scala 23:27]
  wire  carry_9 = aBit_8 & bBit_8 | aBit_8 & carry_8 | bBit_8 & carry_8; // @[dut.scala 24:55]
  wire  aBit_9 = io_a[9]; // @[dut.scala 21:20]
  wire  bBit_9 = io_b[9]; // @[dut.scala 22:20]
  wire  sum_9 = aBit_9 ^ bBit_9 ^ carry_9; // @[dut.scala 23:27]
  wire  carry_10 = aBit_9 & bBit_9 | aBit_9 & carry_9 | bBit_9 & carry_9; // @[dut.scala 24:55]
  wire  aBit_10 = io_a[10]; // @[dut.scala 21:20]
  wire  bBit_10 = io_b[10]; // @[dut.scala 22:20]
  wire  sum_10 = aBit_10 ^ bBit_10 ^ carry_10; // @[dut.scala 23:27]
  wire  carry_11 = aBit_10 & bBit_10 | aBit_10 & carry_10 | bBit_10 & carry_10; // @[dut.scala 24:55]
  wire  aBit_11 = io_a[11]; // @[dut.scala 21:20]
  wire  bBit_11 = io_b[11]; // @[dut.scala 22:20]
  wire  sum_11 = aBit_11 ^ bBit_11 ^ carry_11; // @[dut.scala 23:27]
  wire  carry_12 = aBit_11 & bBit_11 | aBit_11 & carry_11 | bBit_11 & carry_11; // @[dut.scala 24:55]
  wire  aBit_12 = io_a[12]; // @[dut.scala 21:20]
  wire  bBit_12 = io_b[12]; // @[dut.scala 22:20]
  wire  sum_12 = aBit_12 ^ bBit_12 ^ carry_12; // @[dut.scala 23:27]
  wire  carry_13 = aBit_12 & bBit_12 | aBit_12 & carry_12 | bBit_12 & carry_12; // @[dut.scala 24:55]
  wire  aBit_13 = io_a[13]; // @[dut.scala 21:20]
  wire  bBit_13 = io_b[13]; // @[dut.scala 22:20]
  wire  sum_13 = aBit_13 ^ bBit_13 ^ carry_13; // @[dut.scala 23:27]
  wire  carry_14 = aBit_13 & bBit_13 | aBit_13 & carry_13 | bBit_13 & carry_13; // @[dut.scala 24:55]
  wire  aBit_14 = io_a[14]; // @[dut.scala 21:20]
  wire  bBit_14 = io_b[14]; // @[dut.scala 22:20]
  wire  sum_14 = aBit_14 ^ bBit_14 ^ carry_14; // @[dut.scala 23:27]
  wire  carry_15 = aBit_14 & bBit_14 | aBit_14 & carry_14 | bBit_14 & carry_14; // @[dut.scala 24:55]
  wire  aBit_15 = io_a[15]; // @[dut.scala 21:20]
  wire  bBit_15 = io_b[15]; // @[dut.scala 22:20]
  wire  sum_15 = aBit_15 ^ bBit_15 ^ carry_15; // @[dut.scala 23:27]
  wire [7:0] io_sum_lo = {sum_7,sum_6,sum_5,sum_4,sum_3,sum_2,sum_1,sum_0}; // @[dut.scala 28:17]
  wire [7:0] io_sum_hi = {sum_15,sum_14,sum_13,sum_12,sum_11,sum_10,sum_9,sum_8}; // @[dut.scala 28:17]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 28:17]
  assign io_cout = aBit_15 & bBit_15 | aBit_15 & carry_15 | bBit_15 & carry_15; // @[dut.scala 24:55]
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
  wire [15:0] rca1_io_a; // @[dut.scala 63:20]
  wire [15:0] rca1_io_b; // @[dut.scala 63:20]
  wire  rca1_io_cin; // @[dut.scala 63:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 63:20]
  wire  rca1_io_cout; // @[dut.scala 63:20]
  wire [15:0] rca2_io_a; // @[dut.scala 70:20]
  wire [15:0] rca2_io_b; // @[dut.scala 70:20]
  wire  rca2_io_cin; // @[dut.scala 70:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 70:20]
  wire  rca2_io_cout; // @[dut.scala 70:20]
  wire [15:0] rca3_io_a; // @[dut.scala 77:20]
  wire [15:0] rca3_io_b; // @[dut.scala 77:20]
  wire  rca3_io_cin; // @[dut.scala 77:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 77:20]
  wire  rca3_io_cout; // @[dut.scala 77:20]
  wire [15:0] rca4_io_a; // @[dut.scala 84:20]
  wire [15:0] rca4_io_b; // @[dut.scala 84:20]
  wire  rca4_io_cin; // @[dut.scala 84:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 84:20]
  wire  rca4_io_cout; // @[dut.scala 84:20]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 45:28]
  reg  en_pipeline_1; // @[dut.scala 45:28]
  reg  en_pipeline_2; // @[dut.scala 45:28]
  reg  en_pipeline_3; // @[dut.scala 45:28]
  reg [15:0] stage1_sum; // @[dut.scala 52:23]
  reg [15:0] stage2_sum; // @[dut.scala 53:23]
  reg [15:0] stage3_sum; // @[dut.scala 54:23]
  reg [15:0] stage4_sum; // @[dut.scala 55:23]
  reg  stage1_cout; // @[dut.scala 57:24]
  reg  stage2_cout; // @[dut.scala 58:24]
  reg  stage3_cout; // @[dut.scala 59:24]
  reg  final_carry; // @[dut.scala 60:24]
  reg [64:0] result_reg; // @[dut.scala 92:23]
  wire [31:0] result_reg_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {final_carry,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  RCA16 rca1 ( // @[dut.scala 63:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 70:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 77:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 84:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 94:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 97:11]
  assign rca1_io_a = adda_reg[15:0]; // @[dut.scala 64:24]
  assign rca1_io_b = addb_reg[15:0]; // @[dut.scala 65:24]
  assign rca1_io_cin = 1'h0; // @[dut.scala 66:15]
  assign rca2_io_a = adda_reg[31:16]; // @[dut.scala 71:24]
  assign rca2_io_b = addb_reg[31:16]; // @[dut.scala 72:24]
  assign rca2_io_cin = stage1_cout; // @[dut.scala 73:15]
  assign rca3_io_a = adda_reg[47:32]; // @[dut.scala 78:24]
  assign rca3_io_b = addb_reg[47:32]; // @[dut.scala 79:24]
  assign rca3_io_cin = stage2_cout; // @[dut.scala 80:15]
  assign rca4_io_a = adda_reg[63:48]; // @[dut.scala 85:24]
  assign rca4_io_b = addb_reg[63:48]; // @[dut.scala 86:24]
  assign rca4_io_cin = stage3_cout; // @[dut.scala 87:15]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 35:20]
      adda_reg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      adda_reg <= io_adda; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      addb_reg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addb_reg <= io_addb; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 46:18]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 48:20]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 48:20]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 48:20]
    end
    stage1_sum <= rca1_io_sum; // @[dut.scala 67:14]
    stage2_sum <= rca2_io_sum; // @[dut.scala 74:14]
    stage3_sum <= rca3_io_sum; // @[dut.scala 81:14]
    stage4_sum <= rca4_io_sum; // @[dut.scala 88:14]
    stage1_cout <= rca1_io_cout; // @[dut.scala 68:15]
    stage2_cout <= rca2_io_cout; // @[dut.scala 75:15]
    stage3_cout <= rca3_io_cout; // @[dut.scala 82:15]
    final_carry <= rca4_io_cout; // @[dut.scala 89:15]
    result_reg <= {result_reg_hi,result_reg_lo}; // @[Cat.scala 33:92]
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
  adda_reg = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addb_reg = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  en_pipeline_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_pipeline_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  en_pipeline_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  en_pipeline_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage1_sum = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage2_sum = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage3_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage4_sum = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  stage1_cout = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  stage2_cout = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage3_cout = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  final_carry = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  result_reg = _RAND_14[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
