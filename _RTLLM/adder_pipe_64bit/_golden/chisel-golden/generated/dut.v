module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire [16:0] _sum_T = io_a + io_b; // @[dut.scala 44:25]
  wire [16:0] _GEN_0 = {{16'd0}, io_cin}; // @[dut.scala 44:33]
  wire [16:0] sum = _sum_T + _GEN_0; // @[dut.scala 44:33]
  assign io_sum = sum[15:0]; // @[dut.scala 45:22]
  assign io_cout = sum[16]; // @[dut.scala 46:23]
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
  wire [15:0] stage1_io_a; // @[dut.scala 53:24]
  wire [15:0] stage1_io_b; // @[dut.scala 53:24]
  wire  stage1_io_cin; // @[dut.scala 53:24]
  wire [15:0] stage1_io_sum; // @[dut.scala 53:24]
  wire  stage1_io_cout; // @[dut.scala 53:24]
  wire [15:0] stage2_io_a; // @[dut.scala 61:24]
  wire [15:0] stage2_io_b; // @[dut.scala 61:24]
  wire  stage2_io_cin; // @[dut.scala 61:24]
  wire [15:0] stage2_io_sum; // @[dut.scala 61:24]
  wire  stage2_io_cout; // @[dut.scala 61:24]
  wire [15:0] stage3_io_a; // @[dut.scala 69:24]
  wire [15:0] stage3_io_b; // @[dut.scala 69:24]
  wire  stage3_io_cin; // @[dut.scala 69:24]
  wire [15:0] stage3_io_sum; // @[dut.scala 69:24]
  wire  stage3_io_cout; // @[dut.scala 69:24]
  wire [15:0] stage4_io_a; // @[dut.scala 77:24]
  wire [15:0] stage4_io_b; // @[dut.scala 77:24]
  wire  stage4_io_cin; // @[dut.scala 77:24]
  wire [15:0] stage4_io_sum; // @[dut.scala 77:24]
  wire  stage4_io_cout; // @[dut.scala 77:24]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 19:30]
  reg  en_pipeline_1; // @[dut.scala 19:30]
  reg  en_pipeline_2; // @[dut.scala 19:30]
  reg  en_pipeline_3; // @[dut.scala 19:30]
  wire  _GEN_2 = io_i_en | en_pipeline_0; // @[dut.scala 21:19 22:24 19:30]
  reg [15:0] stage1_sum; // @[dut.scala 58:29]
  reg  carry1; // @[dut.scala 59:25]
  reg [15:0] stage2_sum; // @[dut.scala 66:29]
  reg  carry2; // @[dut.scala 67:25]
  reg [15:0] stage3_sum; // @[dut.scala 74:29]
  reg  carry3; // @[dut.scala 75:25]
  reg [15:0] stage4_sum; // @[dut.scala 82:29]
  reg  final_carry; // @[dut.scala 83:30]
  reg [64:0] result_reg; // @[dut.scala 89:29]
  wire [64:0] _result_reg_T = {final_carry,stage4_sum,stage3_sum,stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  RCA16 stage1 ( // @[dut.scala 53:24]
    .io_a(stage1_io_a),
    .io_b(stage1_io_b),
    .io_cin(stage1_io_cin),
    .io_sum(stage1_io_sum),
    .io_cout(stage1_io_cout)
  );
  RCA16 stage2 ( // @[dut.scala 61:24]
    .io_a(stage2_io_a),
    .io_b(stage2_io_b),
    .io_cin(stage2_io_cin),
    .io_sum(stage2_io_sum),
    .io_cout(stage2_io_cout)
  );
  RCA16 stage3 ( // @[dut.scala 69:24]
    .io_a(stage3_io_a),
    .io_b(stage3_io_b),
    .io_cin(stage3_io_cin),
    .io_sum(stage3_io_sum),
    .io_cout(stage3_io_cout)
  );
  RCA16 stage4 ( // @[dut.scala 77:24]
    .io_a(stage4_io_a),
    .io_b(stage4_io_b),
    .io_cin(stage4_io_cin),
    .io_sum(stage4_io_sum),
    .io_cout(stage4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 92:15]
  assign io_o_en = en_pipeline_3; // @[dut.scala 98:13]
  assign stage1_io_a = adda_reg[15:0]; // @[dut.scala 54:28]
  assign stage1_io_b = addb_reg[15:0]; // @[dut.scala 55:28]
  assign stage1_io_cin = 1'h0; // @[dut.scala 56:19]
  assign stage2_io_a = adda_reg[31:16]; // @[dut.scala 62:28]
  assign stage2_io_b = addb_reg[31:16]; // @[dut.scala 63:28]
  assign stage2_io_cin = carry1; // @[dut.scala 64:19]
  assign stage3_io_a = adda_reg[47:32]; // @[dut.scala 70:28]
  assign stage3_io_b = addb_reg[47:32]; // @[dut.scala 71:28]
  assign stage3_io_cin = carry2; // @[dut.scala 72:19]
  assign stage4_io_a = adda_reg[63:48]; // @[dut.scala 78:28]
  assign stage4_io_b = addb_reg[63:48]; // @[dut.scala 79:28]
  assign stage4_io_cin = carry3; // @[dut.scala 80:19]
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
    if (reset) begin // @[dut.scala 19:30]
      en_pipeline_0 <= 1'h0; // @[dut.scala 19:30]
    end else begin
      en_pipeline_0 <= _GEN_2;
    end
    if (reset) begin // @[dut.scala 19:30]
      en_pipeline_1 <= 1'h0; // @[dut.scala 19:30]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 27:24]
    end
    if (reset) begin // @[dut.scala 19:30]
      en_pipeline_2 <= 1'h0; // @[dut.scala 19:30]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 27:24]
    end
    if (reset) begin // @[dut.scala 19:30]
      en_pipeline_3 <= 1'h0; // @[dut.scala 19:30]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 27:24]
    end
    stage1_sum <= stage1_io_sum; // @[dut.scala 58:29]
    carry1 <= stage1_io_cout; // @[dut.scala 59:25]
    stage2_sum <= stage2_io_sum; // @[dut.scala 66:29]
    carry2 <= stage2_io_cout; // @[dut.scala 67:25]
    stage3_sum <= stage3_io_sum; // @[dut.scala 74:29]
    carry3 <= stage3_io_cout; // @[dut.scala 75:25]
    stage4_sum <= stage4_io_sum; // @[dut.scala 82:29]
    final_carry <= stage4_io_cout; // @[dut.scala 83:30]
    if (reset) begin // @[dut.scala 89:29]
      result_reg <= 65'h0; // @[dut.scala 89:29]
    end else begin
      result_reg <= _result_reg_T; // @[dut.scala 90:16]
    end
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
  carry1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carry2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3_sum = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry3 = _RAND_11[0:0];
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
