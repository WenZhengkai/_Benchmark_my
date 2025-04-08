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
`endif // RANDOMIZE_REG_INIT
  reg [16:0] stage1_sum; // @[dut.scala 14:23]
  reg  stage1_carry; // @[dut.scala 15:25]
  reg [16:0] stage2_sum; // @[dut.scala 18:23]
  reg  stage2_carry; // @[dut.scala 19:25]
  reg [16:0] stage3_sum; // @[dut.scala 22:23]
  reg  stage3_carry; // @[dut.scala 23:25]
  reg [16:0] stage4_sum; // @[dut.scala 26:23]
  reg  o_en_reg; // @[dut.scala 27:25]
  wire [16:0] stage1_result = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 32:40]
  wire [16:0] _stage2_result_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 40:41]
  wire [16:0] _GEN_11 = {{16'd0}, stage1_carry}; // @[dut.scala 40:60]
  wire [16:0] stage2_result = _stage2_result_T_2 + _GEN_11; // @[dut.scala 40:60]
  wire [16:0] _stage3_result_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 48:41]
  wire [16:0] _GEN_12 = {{16'd0}, stage2_carry}; // @[dut.scala 48:60]
  wire [16:0] stage3_result = _stage3_result_T_2 + _GEN_12; // @[dut.scala 48:60]
  wire [16:0] _stage4_result_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 56:41]
  wire [16:0] _GEN_13 = {{16'd0}, stage3_carry}; // @[dut.scala 56:60]
  wire [31:0] io_result_lo = {stage2_sum[15:0],stage1_sum[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4_sum,stage3_sum[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = o_en_reg; // @[dut.scala 63:11]
  always @(posedge clock) begin
    if (io_i_en) begin // @[dut.scala 30:18]
      stage1_sum <= stage1_result; // @[dut.scala 33:16]
    end
    if (io_i_en) begin // @[dut.scala 30:18]
      stage1_carry <= stage1_result[16]; // @[dut.scala 34:18]
    end
    stage2_sum <= _stage2_result_T_2 + _GEN_11; // @[dut.scala 40:60]
    stage2_carry <= stage2_result[16]; // @[dut.scala 42:34]
    stage3_sum <= _stage3_result_T_2 + _GEN_12; // @[dut.scala 48:60]
    stage3_carry <= stage3_result[16]; // @[dut.scala 50:34]
    stage4_sum <= _stage4_result_T_2 + _GEN_13; // @[dut.scala 56:60]
    if (reset) begin // @[dut.scala 27:25]
      o_en_reg <= 1'h0; // @[dut.scala 27:25]
    end else begin
      o_en_reg <= 1'h1;
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
  _RAND_0 = {1{`RANDOM}};
  stage1_sum = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  stage1_carry = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  stage2_sum = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  stage2_carry = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stage3_sum = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  stage3_carry = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage4_sum = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  o_en_reg = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
