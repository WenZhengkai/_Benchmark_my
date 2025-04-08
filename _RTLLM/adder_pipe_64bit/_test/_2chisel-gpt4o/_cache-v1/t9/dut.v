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
  reg [95:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] stage1SumReg; // @[dut.scala 14:29]
  reg [16:0] stage2SumReg; // @[dut.scala 15:29]
  reg [16:0] stage3SumReg; // @[dut.scala 16:29]
  reg [64:0] stage4SumReg; // @[dut.scala 17:29]
  reg  stage1CarryReg; // @[dut.scala 19:31]
  reg  stage2CarryReg; // @[dut.scala 20:31]
  reg  stage3CarryReg; // @[dut.scala 21:31]
  reg  stage1EnReg; // @[dut.scala 23:28]
  reg  stage2EnReg; // @[dut.scala 24:28]
  reg  stage3EnReg; // @[dut.scala 25:28]
  reg  stage4EnReg; // @[dut.scala 26:28]
  wire [16:0] stage1Sum = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 29:34]
  wire [16:0] _stage2Sum_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 35:35]
  wire [16:0] _GEN_0 = {{16'd0}, stage1CarryReg}; // @[dut.scala 35:54]
  wire [16:0] stage2Sum = _stage2Sum_T_2 + _GEN_0; // @[dut.scala 35:54]
  wire [16:0] _stage3Sum_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 41:35]
  wire [16:0] _GEN_1 = {{16'd0}, stage2CarryReg}; // @[dut.scala 41:54]
  wire [16:0] stage3Sum = _stage3Sum_T_2 + _GEN_1; // @[dut.scala 41:54]
  wire [16:0] _stage4Sum_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 47:35]
  wire [16:0] _GEN_2 = {{16'd0}, stage3CarryReg}; // @[dut.scala 47:54]
  wire [16:0] stage4Sum = _stage4Sum_T_2 + _GEN_2; // @[dut.scala 47:54]
  wire [17:0] _stage4SumReg_T = {stage3CarryReg,stage4Sum}; // @[Cat.scala 33:92]
  wire [112:0] _io_result_T_3 = {stage4SumReg,stage1SumReg[15:0],stage2SumReg[15:0],stage3SumReg[15:0]}; // @[Cat.scala 33:92]
  assign io_result = _io_result_T_3[64:0]; // @[dut.scala 52:13]
  assign io_o_en = stage4EnReg; // @[dut.scala 53:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:29]
      stage1SumReg <= 17'h0; // @[dut.scala 14:29]
    end else begin
      stage1SumReg <= stage1Sum; // @[dut.scala 30:16]
    end
    if (reset) begin // @[dut.scala 15:29]
      stage2SumReg <= 17'h0; // @[dut.scala 15:29]
    end else begin
      stage2SumReg <= stage2Sum; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 16:29]
      stage3SumReg <= 17'h0; // @[dut.scala 16:29]
    end else begin
      stage3SumReg <= stage3Sum; // @[dut.scala 42:16]
    end
    if (reset) begin // @[dut.scala 17:29]
      stage4SumReg <= 65'h0; // @[dut.scala 17:29]
    end else begin
      stage4SumReg <= {{47'd0}, _stage4SumReg_T}; // @[dut.scala 48:16]
    end
    if (reset) begin // @[dut.scala 19:31]
      stage1CarryReg <= 1'h0; // @[dut.scala 19:31]
    end else begin
      stage1CarryReg <= stage1Sum[16]; // @[dut.scala 31:18]
    end
    if (reset) begin // @[dut.scala 20:31]
      stage2CarryReg <= 1'h0; // @[dut.scala 20:31]
    end else begin
      stage2CarryReg <= stage2Sum[16]; // @[dut.scala 37:18]
    end
    if (reset) begin // @[dut.scala 21:31]
      stage3CarryReg <= 1'h0; // @[dut.scala 21:31]
    end else begin
      stage3CarryReg <= stage3Sum[16]; // @[dut.scala 43:18]
    end
    if (reset) begin // @[dut.scala 23:28]
      stage1EnReg <= 1'h0; // @[dut.scala 23:28]
    end else begin
      stage1EnReg <= io_i_en; // @[dut.scala 32:15]
    end
    if (reset) begin // @[dut.scala 24:28]
      stage2EnReg <= 1'h0; // @[dut.scala 24:28]
    end else begin
      stage2EnReg <= stage1EnReg; // @[dut.scala 38:15]
    end
    if (reset) begin // @[dut.scala 25:28]
      stage3EnReg <= 1'h0; // @[dut.scala 25:28]
    end else begin
      stage3EnReg <= stage2EnReg; // @[dut.scala 44:15]
    end
    if (reset) begin // @[dut.scala 26:28]
      stage4EnReg <= 1'h0; // @[dut.scala 26:28]
    end else begin
      stage4EnReg <= stage3EnReg; // @[dut.scala 49:15]
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
  stage1SumReg = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  stage2SumReg = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  stage3SumReg = _RAND_2[16:0];
  _RAND_3 = {3{`RANDOM}};
  stage4SumReg = _RAND_3[64:0];
  _RAND_4 = {1{`RANDOM}};
  stage1CarryReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage2CarryReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage3CarryReg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  stage1EnReg = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2EnReg = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  stage3EnReg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage4EnReg = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
