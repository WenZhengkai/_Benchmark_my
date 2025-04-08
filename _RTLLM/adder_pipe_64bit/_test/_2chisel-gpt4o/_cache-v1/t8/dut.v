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
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [95:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  stage1_en; // @[dut.scala 14:26]
  reg [63:0] stage1_adda; // @[dut.scala 15:28]
  reg [63:0] stage1_addb; // @[dut.scala 16:28]
  reg  stage2_en; // @[dut.scala 18:26]
  reg [16:0] stage2_sum; // @[dut.scala 19:27]
  reg  stage3_en; // @[dut.scala 21:26]
  reg [32:0] stage3_sum; // @[dut.scala 22:27]
  reg  stage4_en; // @[dut.scala 24:26]
  reg [48:0] stage4_sum; // @[dut.scala 25:27]
  reg [64:0] finalResult; // @[dut.scala 27:28]
  reg  finalEn; // @[dut.scala 28:24]
  wire [16:0] stage1_sum = stage1_adda[15:0] + stage1_addb[15:0]; // @[dut.scala 31:39]
  wire [16:0] _stage2_sum_temp_T_2 = stage1_adda[31:16] + stage1_addb[31:16]; // @[dut.scala 34:45]
  wire [16:0] _GEN_4 = {{16'd0}, stage1_sum[16]}; // @[dut.scala 34:68]
  wire [16:0] stage2_sum_temp = _stage2_sum_temp_T_2 + _GEN_4; // @[dut.scala 34:68]
  wire [16:0] _stage2_sum_T_2 = {stage2_sum_temp[16],stage1_sum[15:0]}; // @[Cat.scala 33:92]
  wire [16:0] _stage3_sum_temp_T_2 = stage1_adda[47:32] + stage1_addb[47:32]; // @[dut.scala 40:45]
  wire [16:0] _GEN_5 = {{16'd0}, stage2_sum[16]}; // @[dut.scala 40:68]
  wire [16:0] stage3_sum_temp = _stage3_sum_temp_T_2 + _GEN_5; // @[dut.scala 40:68]
  wire [16:0] _stage3_sum_T_2 = {stage3_sum_temp[16],stage2_sum[15:0]}; // @[Cat.scala 33:92]
  wire [16:0] _stage4_sum_temp_T_2 = stage1_adda[63:48] + stage1_addb[63:48]; // @[dut.scala 46:45]
  wire [16:0] _GEN_6 = {{16'd0}, stage3_sum[16]}; // @[dut.scala 46:68]
  wire [16:0] stage4_sum_temp = _stage4_sum_temp_T_2 + _GEN_6; // @[dut.scala 46:68]
  wire [16:0] _stage4_sum_T_2 = {stage4_sum_temp[16],stage3_sum[15:0]}; // @[Cat.scala 33:92]
  wire [16:0] _finalResult_T_2 = {stage4_sum[16],stage4_sum[15:0]}; // @[Cat.scala 33:92]
  assign io_result = finalResult; // @[dut.scala 57:13]
  assign io_o_en = finalEn; // @[dut.scala 58:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      stage1_en <= 1'h0; // @[dut.scala 14:26]
    end else begin
      stage1_en <= io_i_en; // @[dut.scala 14:26]
    end
    if (reset) begin // @[dut.scala 15:28]
      stage1_adda <= 64'h0; // @[dut.scala 15:28]
    end else begin
      stage1_adda <= io_adda; // @[dut.scala 15:28]
    end
    if (reset) begin // @[dut.scala 16:28]
      stage1_addb <= 64'h0; // @[dut.scala 16:28]
    end else begin
      stage1_addb <= io_addb; // @[dut.scala 16:28]
    end
    if (reset) begin // @[dut.scala 18:26]
      stage2_en <= 1'h0; // @[dut.scala 18:26]
    end else begin
      stage2_en <= stage1_en; // @[dut.scala 18:26]
    end
    if (reset) begin // @[dut.scala 19:27]
      stage2_sum <= 17'h0; // @[dut.scala 19:27]
    end else if (stage2_en) begin // @[dut.scala 35:19]
      stage2_sum <= _stage2_sum_T_2; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 21:26]
      stage3_en <= 1'h0; // @[dut.scala 21:26]
    end else begin
      stage3_en <= stage2_en; // @[dut.scala 21:26]
    end
    if (reset) begin // @[dut.scala 22:27]
      stage3_sum <= 33'h0; // @[dut.scala 22:27]
    end else if (stage3_en) begin // @[dut.scala 41:19]
      stage3_sum <= {{16'd0}, _stage3_sum_T_2}; // @[dut.scala 42:16]
    end
    if (reset) begin // @[dut.scala 24:26]
      stage4_en <= 1'h0; // @[dut.scala 24:26]
    end else begin
      stage4_en <= stage3_en; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:27]
      stage4_sum <= 49'h0; // @[dut.scala 25:27]
    end else if (stage4_en) begin // @[dut.scala 47:19]
      stage4_sum <= {{32'd0}, _stage4_sum_T_2}; // @[dut.scala 48:16]
    end
    if (reset) begin // @[dut.scala 27:28]
      finalResult <= 65'h0; // @[dut.scala 27:28]
    end else if (finalEn) begin // @[dut.scala 52:17]
      finalResult <= {{48'd0}, _finalResult_T_2}; // @[dut.scala 53:17]
    end
    if (reset) begin // @[dut.scala 28:24]
      finalEn <= 1'h0; // @[dut.scala 28:24]
    end else begin
      finalEn <= stage4_en; // @[dut.scala 28:24]
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
  stage1_en = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  stage1_adda = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  stage1_addb = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  stage2_en = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stage2_sum = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  stage3_en = _RAND_5[0:0];
  _RAND_6 = {2{`RANDOM}};
  stage3_sum = _RAND_6[32:0];
  _RAND_7 = {1{`RANDOM}};
  stage4_en = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  stage4_sum = _RAND_8[48:0];
  _RAND_9 = {3{`RANDOM}};
  finalResult = _RAND_9[64:0];
  _RAND_10 = {1{`RANDOM}};
  finalEn = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
