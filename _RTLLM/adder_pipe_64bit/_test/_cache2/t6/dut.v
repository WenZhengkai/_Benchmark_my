module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  ai = io_a[0]; // @[dut.scala 17:18]
  wire  bi = io_b[0]; // @[dut.scala 18:18]
  wire  s_0 = ai ^ bi ^ io_cin; // @[dut.scala 20:21]
  wire  c_0 = ai & bi | ai & io_cin | bi & io_cin; // @[dut.scala 21:37]
  wire  ai_1 = io_a[1]; // @[dut.scala 17:18]
  wire  bi_1 = io_b[1]; // @[dut.scala 18:18]
  wire  s_1 = ai_1 ^ bi_1 ^ c_0; // @[dut.scala 20:21]
  wire  c_1 = ai_1 & bi_1 | ai_1 & c_0 | bi_1 & c_0; // @[dut.scala 21:37]
  wire  ai_2 = io_a[2]; // @[dut.scala 17:18]
  wire  bi_2 = io_b[2]; // @[dut.scala 18:18]
  wire  s_2 = ai_2 ^ bi_2 ^ c_1; // @[dut.scala 20:21]
  wire  c_2 = ai_2 & bi_2 | ai_2 & c_1 | bi_2 & c_1; // @[dut.scala 21:37]
  wire  ai_3 = io_a[3]; // @[dut.scala 17:18]
  wire  bi_3 = io_b[3]; // @[dut.scala 18:18]
  wire  s_3 = ai_3 ^ bi_3 ^ c_2; // @[dut.scala 20:21]
  wire  c_3 = ai_3 & bi_3 | ai_3 & c_2 | bi_3 & c_2; // @[dut.scala 21:37]
  wire  ai_4 = io_a[4]; // @[dut.scala 17:18]
  wire  bi_4 = io_b[4]; // @[dut.scala 18:18]
  wire  s_4 = ai_4 ^ bi_4 ^ c_3; // @[dut.scala 20:21]
  wire  c_4 = ai_4 & bi_4 | ai_4 & c_3 | bi_4 & c_3; // @[dut.scala 21:37]
  wire  ai_5 = io_a[5]; // @[dut.scala 17:18]
  wire  bi_5 = io_b[5]; // @[dut.scala 18:18]
  wire  s_5 = ai_5 ^ bi_5 ^ c_4; // @[dut.scala 20:21]
  wire  c_5 = ai_5 & bi_5 | ai_5 & c_4 | bi_5 & c_4; // @[dut.scala 21:37]
  wire  ai_6 = io_a[6]; // @[dut.scala 17:18]
  wire  bi_6 = io_b[6]; // @[dut.scala 18:18]
  wire  s_6 = ai_6 ^ bi_6 ^ c_5; // @[dut.scala 20:21]
  wire  c_6 = ai_6 & bi_6 | ai_6 & c_5 | bi_6 & c_5; // @[dut.scala 21:37]
  wire  ai_7 = io_a[7]; // @[dut.scala 17:18]
  wire  bi_7 = io_b[7]; // @[dut.scala 18:18]
  wire  s_7 = ai_7 ^ bi_7 ^ c_6; // @[dut.scala 20:21]
  wire  c_7 = ai_7 & bi_7 | ai_7 & c_6 | bi_7 & c_6; // @[dut.scala 21:37]
  wire  ai_8 = io_a[8]; // @[dut.scala 17:18]
  wire  bi_8 = io_b[8]; // @[dut.scala 18:18]
  wire  s_8 = ai_8 ^ bi_8 ^ c_7; // @[dut.scala 20:21]
  wire  c_8 = ai_8 & bi_8 | ai_8 & c_7 | bi_8 & c_7; // @[dut.scala 21:37]
  wire  ai_9 = io_a[9]; // @[dut.scala 17:18]
  wire  bi_9 = io_b[9]; // @[dut.scala 18:18]
  wire  s_9 = ai_9 ^ bi_9 ^ c_8; // @[dut.scala 20:21]
  wire  c_9 = ai_9 & bi_9 | ai_9 & c_8 | bi_9 & c_8; // @[dut.scala 21:37]
  wire  ai_10 = io_a[10]; // @[dut.scala 17:18]
  wire  bi_10 = io_b[10]; // @[dut.scala 18:18]
  wire  s_10 = ai_10 ^ bi_10 ^ c_9; // @[dut.scala 20:21]
  wire  c_10 = ai_10 & bi_10 | ai_10 & c_9 | bi_10 & c_9; // @[dut.scala 21:37]
  wire  ai_11 = io_a[11]; // @[dut.scala 17:18]
  wire  bi_11 = io_b[11]; // @[dut.scala 18:18]
  wire  s_11 = ai_11 ^ bi_11 ^ c_10; // @[dut.scala 20:21]
  wire  c_11 = ai_11 & bi_11 | ai_11 & c_10 | bi_11 & c_10; // @[dut.scala 21:37]
  wire  ai_12 = io_a[12]; // @[dut.scala 17:18]
  wire  bi_12 = io_b[12]; // @[dut.scala 18:18]
  wire  s_12 = ai_12 ^ bi_12 ^ c_11; // @[dut.scala 20:21]
  wire  c_12 = ai_12 & bi_12 | ai_12 & c_11 | bi_12 & c_11; // @[dut.scala 21:37]
  wire  ai_13 = io_a[13]; // @[dut.scala 17:18]
  wire  bi_13 = io_b[13]; // @[dut.scala 18:18]
  wire  s_13 = ai_13 ^ bi_13 ^ c_12; // @[dut.scala 20:21]
  wire  c_13 = ai_13 & bi_13 | ai_13 & c_12 | bi_13 & c_12; // @[dut.scala 21:37]
  wire  ai_14 = io_a[14]; // @[dut.scala 17:18]
  wire  bi_14 = io_b[14]; // @[dut.scala 18:18]
  wire  s_14 = ai_14 ^ bi_14 ^ c_13; // @[dut.scala 20:21]
  wire  c_14 = ai_14 & bi_14 | ai_14 & c_13 | bi_14 & c_13; // @[dut.scala 21:37]
  wire  ai_15 = io_a[15]; // @[dut.scala 17:18]
  wire  bi_15 = io_b[15]; // @[dut.scala 18:18]
  wire  s_15 = ai_15 ^ bi_15 ^ c_14; // @[dut.scala 20:21]
  wire [7:0] io_sum_lo = {s_7,s_6,s_5,s_4,s_3,s_2,s_1,s_0}; // @[dut.scala 24:15]
  wire [7:0] io_sum_hi = {s_15,s_14,s_13,s_12,s_11,s_10,s_9,s_8}; // @[dut.scala 24:15]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 24:15]
  assign io_cout = ai_15 & bi_15 | ai_15 & c_14 | bi_15 & c_14; // @[dut.scala 21:37]
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
  wire [15:0] rca_stage1_io_a; // @[dut.scala 47:26]
  wire [15:0] rca_stage1_io_b; // @[dut.scala 47:26]
  wire  rca_stage1_io_cin; // @[dut.scala 47:26]
  wire [15:0] rca_stage1_io_sum; // @[dut.scala 47:26]
  wire  rca_stage1_io_cout; // @[dut.scala 47:26]
  wire [15:0] rca_stage2_io_a; // @[dut.scala 48:26]
  wire [15:0] rca_stage2_io_b; // @[dut.scala 48:26]
  wire  rca_stage2_io_cin; // @[dut.scala 48:26]
  wire [15:0] rca_stage2_io_sum; // @[dut.scala 48:26]
  wire  rca_stage2_io_cout; // @[dut.scala 48:26]
  wire [15:0] rca_stage3_io_a; // @[dut.scala 49:26]
  wire [15:0] rca_stage3_io_b; // @[dut.scala 49:26]
  wire  rca_stage3_io_cin; // @[dut.scala 49:26]
  wire [15:0] rca_stage3_io_sum; // @[dut.scala 49:26]
  wire  rca_stage3_io_cout; // @[dut.scala 49:26]
  wire [15:0] rca_stage4_io_a; // @[dut.scala 50:26]
  wire [15:0] rca_stage4_io_b; // @[dut.scala 50:26]
  wire  rca_stage4_io_cin; // @[dut.scala 50:26]
  wire [15:0] rca_stage4_io_sum; // @[dut.scala 50:26]
  wire  rca_stage4_io_cout; // @[dut.scala 50:26]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 40:28]
  reg  en_pipeline_1; // @[dut.scala 40:28]
  reg  en_pipeline_2; // @[dut.scala 40:28]
  reg  en_pipeline_3; // @[dut.scala 40:28]
  reg [15:0] stage1_sum_reg; // @[dut.scala 56:31]
  reg  stage1_cout_reg; // @[dut.scala 57:32]
  reg [15:0] stage2_sum_reg; // @[dut.scala 63:31]
  reg  stage2_cout_reg; // @[dut.scala 64:32]
  reg [15:0] stage3_sum_reg; // @[dut.scala 70:31]
  reg  stage3_cout_reg; // @[dut.scala 71:32]
  reg [15:0] stage4_sum_reg; // @[dut.scala 77:31]
  reg  final_carry; // @[dut.scala 78:28]
  wire [31:0] result_reg_lo = {stage2_sum_reg,stage1_sum_reg}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {final_carry,stage4_sum_reg,stage3_sum_reg}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[dut.scala 81:27]
  RCA16 rca_stage1 ( // @[dut.scala 47:26]
    .io_a(rca_stage1_io_a),
    .io_b(rca_stage1_io_b),
    .io_cin(rca_stage1_io_cin),
    .io_sum(rca_stage1_io_sum),
    .io_cout(rca_stage1_io_cout)
  );
  RCA16 rca_stage2 ( // @[dut.scala 48:26]
    .io_a(rca_stage2_io_a),
    .io_b(rca_stage2_io_b),
    .io_cin(rca_stage2_io_cin),
    .io_sum(rca_stage2_io_sum),
    .io_cout(rca_stage2_io_cout)
  );
  RCA16 rca_stage3 ( // @[dut.scala 49:26]
    .io_a(rca_stage3_io_a),
    .io_b(rca_stage3_io_b),
    .io_cin(rca_stage3_io_cin),
    .io_sum(rca_stage3_io_sum),
    .io_cout(rca_stage3_io_cout)
  );
  RCA16 rca_stage4 ( // @[dut.scala 50:26]
    .io_a(rca_stage4_io_a),
    .io_b(rca_stage4_io_b),
    .io_cin(rca_stage4_io_cin),
    .io_sum(rca_stage4_io_sum),
    .io_cout(rca_stage4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 82:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 85:11]
  assign rca_stage1_io_a = adda_reg[15:0]; // @[dut.scala 52:30]
  assign rca_stage1_io_b = addb_reg[15:0]; // @[dut.scala 53:30]
  assign rca_stage1_io_cin = 1'h0; // @[dut.scala 54:21]
  assign rca_stage2_io_a = adda_reg[31:16]; // @[dut.scala 59:30]
  assign rca_stage2_io_b = addb_reg[31:16]; // @[dut.scala 60:30]
  assign rca_stage2_io_cin = stage1_cout_reg; // @[dut.scala 61:21]
  assign rca_stage3_io_a = adda_reg[47:32]; // @[dut.scala 66:30]
  assign rca_stage3_io_b = addb_reg[47:32]; // @[dut.scala 67:30]
  assign rca_stage3_io_cin = stage2_cout_reg; // @[dut.scala 68:21]
  assign rca_stage4_io_a = adda_reg[63:48]; // @[dut.scala 73:30]
  assign rca_stage4_io_b = addb_reg[63:48]; // @[dut.scala 74:30]
  assign rca_stage4_io_cin = stage3_cout_reg; // @[dut.scala 75:21]
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
    if (reset) begin // @[dut.scala 40:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 40:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 41:18]
    end
    if (reset) begin // @[dut.scala 40:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 40:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 43:20]
    end
    if (reset) begin // @[dut.scala 40:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 40:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 43:20]
    end
    if (reset) begin // @[dut.scala 40:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 40:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 43:20]
    end
    stage1_sum_reg <= rca_stage1_io_sum; // @[dut.scala 56:31]
    stage1_cout_reg <= rca_stage1_io_cout; // @[dut.scala 57:32]
    stage2_sum_reg <= rca_stage2_io_sum; // @[dut.scala 63:31]
    stage2_cout_reg <= rca_stage2_io_cout; // @[dut.scala 64:32]
    stage3_sum_reg <= rca_stage3_io_sum; // @[dut.scala 70:31]
    stage3_cout_reg <= rca_stage3_io_cout; // @[dut.scala 71:32]
    stage4_sum_reg <= rca_stage4_io_sum; // @[dut.scala 77:31]
    final_carry <= rca_stage4_io_cout; // @[dut.scala 78:28]
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
  stage1_sum_reg = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_cout_reg = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2_sum_reg = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage2_cout_reg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3_sum_reg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage3_cout_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage4_sum_reg = _RAND_12[15:0];
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
