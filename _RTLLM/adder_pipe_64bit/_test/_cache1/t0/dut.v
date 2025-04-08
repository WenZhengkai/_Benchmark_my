module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire [15:0] _sum_T_1 = io_a + io_b; // @[dut.scala 14:15]
  wire [15:0] _GEN_0 = {{15'd0}, io_cin}; // @[dut.scala 14:22]
  wire [15:0] _sum_T_3 = _sum_T_1 + _GEN_0; // @[dut.scala 14:22]
  wire [16:0] sum = {{1'd0}, _sum_T_3}; // @[dut.scala 13:17 14:7]
  assign io_sum = sum[15:0]; // @[dut.scala 15:16]
  assign io_cout = sum[16]; // @[dut.scala 16:17]
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
  wire [15:0] rca0_io_a; // @[dut.scala 46:20]
  wire [15:0] rca0_io_b; // @[dut.scala 46:20]
  wire  rca0_io_cin; // @[dut.scala 46:20]
  wire [15:0] rca0_io_sum; // @[dut.scala 46:20]
  wire  rca0_io_cout; // @[dut.scala 46:20]
  wire [15:0] rca1_io_a; // @[dut.scala 54:20]
  wire [15:0] rca1_io_b; // @[dut.scala 54:20]
  wire  rca1_io_cin; // @[dut.scala 54:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 54:20]
  wire  rca1_io_cout; // @[dut.scala 54:20]
  wire [15:0] rca2_io_a; // @[dut.scala 62:20]
  wire [15:0] rca2_io_b; // @[dut.scala 62:20]
  wire  rca2_io_cin; // @[dut.scala 62:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 62:20]
  wire  rca2_io_cout; // @[dut.scala 62:20]
  wire [15:0] rca3_io_a; // @[dut.scala 70:20]
  wire [15:0] rca3_io_b; // @[dut.scala 70:20]
  wire  rca3_io_cin; // @[dut.scala 70:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 70:20]
  wire  rca3_io_cout; // @[dut.scala 70:20]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 33:28]
  reg  en_pipeline_1; // @[dut.scala 33:28]
  reg  en_pipeline_2; // @[dut.scala 33:28]
  reg  en_pipeline_3; // @[dut.scala 33:28]
  reg [15:0] stage1_sum; // @[dut.scala 51:27]
  reg  stage1_cout; // @[dut.scala 52:28]
  reg [15:0] stage2_sum; // @[dut.scala 59:27]
  reg  stage2_cout; // @[dut.scala 60:28]
  reg [15:0] stage3_sum; // @[dut.scala 67:27]
  reg  stage3_cout; // @[dut.scala 68:28]
  reg [15:0] stage4_sum; // @[dut.scala 75:27]
  reg  final_carry; // @[dut.scala 76:28]
  wire [31:0] result_reg_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {final_carry,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[dut.scala 79:27]
  RCA16 rca0 ( // @[dut.scala 46:20]
    .io_a(rca0_io_a),
    .io_b(rca0_io_b),
    .io_cin(rca0_io_cin),
    .io_sum(rca0_io_sum),
    .io_cout(rca0_io_cout)
  );
  RCA16 rca1 ( // @[dut.scala 54:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 62:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 70:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 82:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 83:11]
  assign rca0_io_a = adda_reg[15:0]; // @[dut.scala 47:24]
  assign rca0_io_b = addb_reg[15:0]; // @[dut.scala 48:24]
  assign rca0_io_cin = 1'h0; // @[dut.scala 49:15]
  assign rca1_io_a = adda_reg[31:16]; // @[dut.scala 55:24]
  assign rca1_io_b = addb_reg[31:16]; // @[dut.scala 56:24]
  assign rca1_io_cin = stage1_cout; // @[dut.scala 57:15]
  assign rca2_io_a = adda_reg[47:32]; // @[dut.scala 63:24]
  assign rca2_io_b = addb_reg[47:32]; // @[dut.scala 64:24]
  assign rca2_io_cin = stage2_cout; // @[dut.scala 65:15]
  assign rca3_io_a = adda_reg[63:48]; // @[dut.scala 71:24]
  assign rca3_io_b = addb_reg[63:48]; // @[dut.scala 72:24]
  assign rca3_io_cin = stage3_cout; // @[dut.scala 73:15]
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
    if (reset) begin // @[dut.scala 33:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 33:28]
    end else begin
      en_pipeline_0 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 33:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 33:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 42:20]
    end
    if (reset) begin // @[dut.scala 33:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 33:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 42:20]
    end
    if (reset) begin // @[dut.scala 33:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 33:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 42:20]
    end
    stage1_sum <= rca0_io_sum; // @[dut.scala 51:27]
    stage1_cout <= rca0_io_cout; // @[dut.scala 52:28]
    stage2_sum <= rca1_io_sum; // @[dut.scala 59:27]
    stage2_cout <= rca1_io_cout; // @[dut.scala 60:28]
    stage3_sum <= rca2_io_sum; // @[dut.scala 67:27]
    stage3_cout <= rca2_io_cout; // @[dut.scala 68:28]
    stage4_sum <= rca3_io_sum; // @[dut.scala 75:27]
    final_carry <= rca3_io_cout; // @[dut.scala 76:28]
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
  stage1_cout = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage2_cout = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3_sum = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage3_cout = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage4_sum = _RAND_12[15:0];
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
