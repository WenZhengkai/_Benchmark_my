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
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [95:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] stage1_sum; // @[dut.scala 14:23]
  reg  stage1_carry; // @[dut.scala 15:25]
  reg [32:0] stage2_sum; // @[dut.scala 16:23]
  reg  stage2_carry; // @[dut.scala 17:25]
  reg [48:0] stage3_sum; // @[dut.scala 18:23]
  reg  stage3_carry; // @[dut.scala 19:25]
  reg [64:0] stage4_sum; // @[dut.scala 20:23]
  reg  stage1_en; // @[dut.scala 23:26]
  reg  stage2_en; // @[dut.scala 24:26]
  reg  stage3_en; // @[dut.scala 25:26]
  reg  stage4_en; // @[dut.scala 26:26]
  wire [16:0] sum = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 30:30]
  wire [16:0] _sum_T_4 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 37:31]
  wire [16:0] _GEN_7 = {{16'd0}, stage1_carry}; // @[dut.scala 37:50]
  wire [16:0] sum_1 = _sum_T_4 + _GEN_7; // @[dut.scala 37:50]
  wire [32:0] _stage2_sum_T_1 = {sum_1[15:0],stage1_sum}; // @[Cat.scala 33:92]
  wire [16:0] _sum_T_8 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 44:31]
  wire [16:0] _GEN_8 = {{16'd0}, stage2_carry}; // @[dut.scala 44:50]
  wire [16:0] sum_2 = _sum_T_8 + _GEN_8; // @[dut.scala 44:50]
  wire [48:0] _stage3_sum_T_1 = {sum_2[15:0],stage2_sum}; // @[Cat.scala 33:92]
  wire [16:0] _sum_T_12 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 51:31]
  wire [16:0] _GEN_9 = {{16'd0}, stage3_carry}; // @[dut.scala 51:50]
  wire [16:0] sum_3 = _sum_T_12 + _GEN_9; // @[dut.scala 51:50]
  wire [65:0] _stage4_sum_T_1 = {sum_3,stage3_sum}; // @[Cat.scala 33:92]
  wire [65:0] _GEN_6 = stage3_en ? _stage4_sum_T_1 : {{1'd0}, stage4_sum}; // @[dut.scala 50:19 52:16 20:23]
  assign io_result = stage4_sum; // @[dut.scala 56:13]
  assign io_o_en = stage4_en; // @[dut.scala 57:11]
  always @(posedge clock) begin
    if (io_i_en) begin // @[dut.scala 29:17]
      stage1_sum <= {{1'd0}, sum[15:0]}; // @[dut.scala 31:16]
    end
    if (io_i_en) begin // @[dut.scala 29:17]
      stage1_carry <= sum[16]; // @[dut.scala 32:18]
    end
    if (stage1_en) begin // @[dut.scala 36:19]
      stage2_sum <= _stage2_sum_T_1; // @[dut.scala 38:16]
    end
    if (stage1_en) begin // @[dut.scala 36:19]
      stage2_carry <= sum_1[16]; // @[dut.scala 39:18]
    end
    if (stage2_en) begin // @[dut.scala 43:19]
      stage3_sum <= _stage3_sum_T_1; // @[dut.scala 45:16]
    end
    if (stage2_en) begin // @[dut.scala 43:19]
      stage3_carry <= sum_2[16]; // @[dut.scala 46:18]
    end
    stage4_sum <= _GEN_6[64:0];
    if (reset) begin // @[dut.scala 23:26]
      stage1_en <= 1'h0; // @[dut.scala 23:26]
    end else begin
      stage1_en <= io_i_en; // @[dut.scala 23:26]
    end
    if (reset) begin // @[dut.scala 24:26]
      stage2_en <= 1'h0; // @[dut.scala 24:26]
    end else begin
      stage2_en <= stage1_en; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      stage3_en <= 1'h0; // @[dut.scala 25:26]
    end else begin
      stage3_en <= stage2_en; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      stage4_en <= 1'h0; // @[dut.scala 26:26]
    end else begin
      stage4_en <= stage3_en; // @[dut.scala 26:26]
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
  _RAND_2 = {2{`RANDOM}};
  stage2_sum = _RAND_2[32:0];
  _RAND_3 = {1{`RANDOM}};
  stage2_carry = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  stage3_sum = _RAND_4[48:0];
  _RAND_5 = {1{`RANDOM}};
  stage3_carry = _RAND_5[0:0];
  _RAND_6 = {3{`RANDOM}};
  stage4_sum = _RAND_6[64:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_en = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2_en = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  stage3_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage4_en = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
