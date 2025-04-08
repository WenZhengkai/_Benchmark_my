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
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [95:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg  stage0_en; // @[dut.scala 15:26]
  reg  stage1_en; // @[dut.scala 16:26]
  reg  stage2_en; // @[dut.scala 17:26]
  reg  stage3_en; // @[dut.scala 18:26]
  reg [63:0] regA; // @[dut.scala 20:17]
  reg [63:0] regB; // @[dut.scala 21:17]
  reg [15:0] stage0_sum; // @[dut.scala 23:23]
  reg  stage0_carry; // @[dut.scala 24:25]
  reg [15:0] stage1_sum; // @[dut.scala 26:23]
  reg  stage1_carry; // @[dut.scala 27:25]
  reg [15:0] stage2_sum; // @[dut.scala 29:23]
  reg  stage2_carry; // @[dut.scala 30:25]
  reg [15:0] stage3_sum; // @[dut.scala 32:23]
  reg  stage3_carry; // @[dut.scala 33:25]
  reg [64:0] resultReg; // @[dut.scala 36:22]
  reg  resultValid; // @[dut.scala 37:28]
  wire [16:0] partialSum = regA[15:0] + regB[15:0]; // @[dut.scala 50:34]
  wire [16:0] _partialSum_T_4 = regA[31:16] + regB[31:16]; // @[dut.scala 60:35]
  wire [16:0] _GEN_16 = {{16'd0}, stage0_carry}; // @[dut.scala 60:51]
  wire [16:0] partialSum_1 = _partialSum_T_4 + _GEN_16; // @[dut.scala 60:51]
  wire [16:0] _partialSum_T_8 = regA[47:32] + regB[47:32]; // @[dut.scala 70:35]
  wire [16:0] _GEN_17 = {{16'd0}, stage1_carry}; // @[dut.scala 70:51]
  wire [16:0] partialSum_2 = _partialSum_T_8 + _GEN_17; // @[dut.scala 70:51]
  wire [16:0] _partialSum_T_12 = regA[63:48] + regB[63:48]; // @[dut.scala 80:35]
  wire [16:0] _GEN_18 = {{16'd0}, stage2_carry}; // @[dut.scala 80:51]
  wire [16:0] partialSum_3 = _partialSum_T_12 + _GEN_18; // @[dut.scala 80:51]
  wire [64:0] _resultReg_T = {stage3_carry,stage3_sum,stage2_sum,stage1_sum,stage0_sum}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 94:13]
  assign io_o_en = resultValid; // @[dut.scala 95:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stage0_en <= 1'h0; // @[dut.scala 15:26]
    end else begin
      stage0_en <= io_i_en;
    end
    if (reset) begin // @[dut.scala 16:26]
      stage1_en <= 1'h0; // @[dut.scala 16:26]
    end else begin
      stage1_en <= stage0_en;
    end
    if (reset) begin // @[dut.scala 17:26]
      stage2_en <= 1'h0; // @[dut.scala 17:26]
    end else begin
      stage2_en <= stage1_en;
    end
    if (reset) begin // @[dut.scala 18:26]
      stage3_en <= 1'h0; // @[dut.scala 18:26]
    end else begin
      stage3_en <= stage2_en;
    end
    if (io_i_en) begin // @[dut.scala 40:17]
      regA <= io_adda; // @[dut.scala 41:10]
    end
    if (io_i_en) begin // @[dut.scala 40:17]
      regB <= io_addb; // @[dut.scala 42:10]
    end
    if (stage0_en) begin // @[dut.scala 49:19]
      stage0_sum <= partialSum[15:0]; // @[dut.scala 51:16]
    end
    if (stage0_en) begin // @[dut.scala 49:19]
      stage0_carry <= partialSum[16]; // @[dut.scala 52:18]
    end
    if (stage1_en) begin // @[dut.scala 59:19]
      stage1_sum <= partialSum_1[15:0]; // @[dut.scala 61:16]
    end
    if (stage1_en) begin // @[dut.scala 59:19]
      stage1_carry <= partialSum_1[16]; // @[dut.scala 62:18]
    end
    if (stage2_en) begin // @[dut.scala 69:19]
      stage2_sum <= partialSum_2[15:0]; // @[dut.scala 71:16]
    end
    if (stage2_en) begin // @[dut.scala 69:19]
      stage2_carry <= partialSum_2[16]; // @[dut.scala 72:18]
    end
    if (stage3_en) begin // @[dut.scala 79:19]
      stage3_sum <= partialSum_3[15:0]; // @[dut.scala 81:16]
    end
    if (stage3_en) begin // @[dut.scala 79:19]
      stage3_carry <= partialSum_3[16]; // @[dut.scala 82:18]
    end
    if (resultValid) begin // @[dut.scala 89:21]
      resultReg <= _resultReg_T; // @[dut.scala 90:15]
    end
    if (reset) begin // @[dut.scala 37:28]
      resultValid <= 1'h0; // @[dut.scala 37:28]
    end else begin
      resultValid <= stage3_en;
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
  stage0_en = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  stage1_en = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  stage2_en = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  stage3_en = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  regA = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  regB = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  stage0_sum = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage0_carry = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage1_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage1_carry = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage2_sum = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage2_carry = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage3_sum = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  stage3_carry = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  resultReg = _RAND_14[64:0];
  _RAND_15 = {1{`RANDOM}};
  resultValid = _RAND_15[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
