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
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] stage1Reg; // @[dut.scala 14:26]
  reg  stage1Carry; // @[dut.scala 15:28]
  reg [15:0] stage2Reg; // @[dut.scala 16:26]
  reg  stage2Carry; // @[dut.scala 17:28]
  reg [15:0] stage3Reg; // @[dut.scala 18:26]
  reg  stage3Carry; // @[dut.scala 19:28]
  reg [15:0] stage4Reg; // @[dut.scala 20:26]
  reg  stage4Carry; // @[dut.scala 21:28]
  reg  pipelineEnable; // @[dut.scala 23:31]
  wire [16:0] stage1Sum = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 27:36]
  wire [16:0] _stage2Sum_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 34:37]
  wire [16:0] _GEN_8 = {{16'd0}, stage1Carry}; // @[dut.scala 34:56]
  wire [16:0] stage2Sum = _stage2Sum_T_2 + _GEN_8; // @[dut.scala 34:56]
  wire [16:0] _stage3Sum_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 41:37]
  wire [16:0] _GEN_9 = {{16'd0}, stage2Carry}; // @[dut.scala 41:56]
  wire [16:0] stage3Sum = _stage3Sum_T_2 + _GEN_9; // @[dut.scala 41:56]
  wire [16:0] _stage4Sum_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 48:37]
  wire [16:0] _GEN_10 = {{16'd0}, stage3Carry}; // @[dut.scala 48:56]
  wire [16:0] stage4Sum = _stage4Sum_T_2 + _GEN_10; // @[dut.scala 48:56]
  wire [31:0] finalSum_lo = {stage2Reg,stage1Reg}; // @[Cat.scala 33:92]
  wire [32:0] finalSum_hi = {stage4Carry,stage4Reg,stage3Reg}; // @[Cat.scala 33:92]
  assign io_result = {finalSum_hi,finalSum_lo}; // @[Cat.scala 33:92]
  assign io_o_en = pipelineEnable; // @[dut.scala 55:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      stage1Reg <= 16'h0; // @[dut.scala 14:26]
    end else if (io_i_en) begin // @[dut.scala 26:17]
      stage1Reg <= stage1Sum[15:0]; // @[dut.scala 28:15]
    end
    if (reset) begin // @[dut.scala 15:28]
      stage1Carry <= 1'h0; // @[dut.scala 15:28]
    end else if (io_i_en) begin // @[dut.scala 26:17]
      stage1Carry <= stage1Sum[16]; // @[dut.scala 29:17]
    end
    if (reset) begin // @[dut.scala 16:26]
      stage2Reg <= 16'h0; // @[dut.scala 16:26]
    end else if (io_i_en) begin // @[dut.scala 33:17]
      stage2Reg <= stage2Sum[15:0]; // @[dut.scala 35:15]
    end
    if (reset) begin // @[dut.scala 17:28]
      stage2Carry <= 1'h0; // @[dut.scala 17:28]
    end else if (io_i_en) begin // @[dut.scala 33:17]
      stage2Carry <= stage2Sum[16]; // @[dut.scala 36:17]
    end
    if (reset) begin // @[dut.scala 18:26]
      stage3Reg <= 16'h0; // @[dut.scala 18:26]
    end else if (io_i_en) begin // @[dut.scala 40:17]
      stage3Reg <= stage3Sum[15:0]; // @[dut.scala 42:15]
    end
    if (reset) begin // @[dut.scala 19:28]
      stage3Carry <= 1'h0; // @[dut.scala 19:28]
    end else if (io_i_en) begin // @[dut.scala 40:17]
      stage3Carry <= stage3Sum[16]; // @[dut.scala 43:17]
    end
    if (reset) begin // @[dut.scala 20:26]
      stage4Reg <= 16'h0; // @[dut.scala 20:26]
    end else if (io_i_en) begin // @[dut.scala 47:17]
      stage4Reg <= stage4Sum[15:0]; // @[dut.scala 49:15]
    end
    if (reset) begin // @[dut.scala 21:28]
      stage4Carry <= 1'h0; // @[dut.scala 21:28]
    end else if (io_i_en) begin // @[dut.scala 47:17]
      stage4Carry <= stage4Sum[16]; // @[dut.scala 50:17]
    end
    if (reset) begin // @[dut.scala 23:31]
      pipelineEnable <= 1'h0; // @[dut.scala 23:31]
    end else begin
      pipelineEnable <= io_i_en; // @[dut.scala 54:18]
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
  stage1Reg = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  stage1Carry = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  stage2Reg = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  stage2Carry = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stage3Reg = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  stage3Carry = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage4Reg = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage4Carry = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  pipelineEnable = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
