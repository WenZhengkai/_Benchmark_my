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
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg  pipelineEnable_0; // @[dut.scala 18:31]
  reg  pipelineEnable_1; // @[dut.scala 18:31]
  reg  pipelineEnable_2; // @[dut.scala 18:31]
  reg  pipelineEnable_3; // @[dut.scala 18:31]
  wire [15:0] addaSegments_0 = io_adda[15:0]; // @[dut.scala 36:31]
  wire [15:0] addbSegments_0 = io_addb[15:0]; // @[dut.scala 37:31]
  wire [15:0] addaSegments_1 = io_adda[31:16]; // @[dut.scala 36:31]
  wire [15:0] addbSegments_1 = io_addb[31:16]; // @[dut.scala 37:31]
  wire [15:0] addaSegments_2 = io_adda[47:32]; // @[dut.scala 36:31]
  wire [15:0] addbSegments_2 = io_addb[47:32]; // @[dut.scala 37:31]
  wire [15:0] addaSegments_3 = io_adda[63:48]; // @[dut.scala 36:31]
  wire [15:0] addbSegments_3 = io_addb[63:48]; // @[dut.scala 37:31]
  reg [15:0] addaRegs_0; // @[dut.scala 41:21]
  reg [15:0] addaRegs_1; // @[dut.scala 41:21]
  reg [15:0] addaRegs_2; // @[dut.scala 41:21]
  reg [15:0] addaRegs_3; // @[dut.scala 41:21]
  reg [15:0] addbRegs_0; // @[dut.scala 42:21]
  reg [15:0] addbRegs_1; // @[dut.scala 42:21]
  reg [15:0] addbRegs_2; // @[dut.scala 42:21]
  reg [15:0] addbRegs_3; // @[dut.scala 42:21]
  reg  carryRegs_0; // @[dut.scala 51:26]
  reg  carryRegs_1; // @[dut.scala 51:26]
  reg  carryRegs_2; // @[dut.scala 51:26]
  reg  carryRegs_3; // @[dut.scala 51:26]
  reg [15:0] sumRegs_0; // @[dut.scala 54:20]
  reg [15:0] sumRegs_1; // @[dut.scala 54:20]
  reg [15:0] sumRegs_2; // @[dut.scala 54:20]
  reg [15:0] sumRegs_3; // @[dut.scala 54:20]
  wire [16:0] firstStageSum = addaRegs_0 + addbRegs_0; // @[dut.scala 58:32]
  wire [16:0] _stageSum_T = addaRegs_1 + addbRegs_1; // @[dut.scala 75:29]
  wire [16:0] _GEN_16 = {{16'd0}, carryRegs_0}; // @[dut.scala 75:44]
  wire [16:0] stageSum = _stageSum_T + _GEN_16; // @[dut.scala 75:44]
  wire [16:0] _stageSum_T_3 = addaRegs_2 + addbRegs_2; // @[dut.scala 75:29]
  wire [16:0] _GEN_17 = {{16'd0}, carryRegs_1}; // @[dut.scala 75:44]
  wire [16:0] stageSum_1 = _stageSum_T_3 + _GEN_17; // @[dut.scala 75:44]
  wire [16:0] _stageSum_T_6 = addaRegs_3 + addbRegs_3; // @[dut.scala 75:29]
  wire [16:0] _GEN_18 = {{16'd0}, carryRegs_2}; // @[dut.scala 75:44]
  wire [16:0] stageSum_2 = _stageSum_T_6 + _GEN_18; // @[dut.scala 75:44]
  wire [31:0] resultWire_lo = {sumRegs_1,sumRegs_0}; // @[Cat.scala 33:92]
  wire [32:0] resultWire_hi = {carryRegs_3,sumRegs_3,sumRegs_2}; // @[Cat.scala 33:92]
  assign io_result = {resultWire_hi,resultWire_lo}; // @[Cat.scala 33:92]
  assign io_o_en = pipelineEnable_3; // @[dut.scala 29:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:31]
      pipelineEnable_0 <= 1'h0; // @[dut.scala 18:31]
    end else begin
      pipelineEnable_0 <= io_i_en; // @[dut.scala 21:21]
    end
    if (reset) begin // @[dut.scala 18:31]
      pipelineEnable_1 <= 1'h0; // @[dut.scala 18:31]
    end else begin
      pipelineEnable_1 <= pipelineEnable_0; // @[dut.scala 25:23]
    end
    if (reset) begin // @[dut.scala 18:31]
      pipelineEnable_2 <= 1'h0; // @[dut.scala 18:31]
    end else begin
      pipelineEnable_2 <= pipelineEnable_1; // @[dut.scala 25:23]
    end
    if (reset) begin // @[dut.scala 18:31]
      pipelineEnable_3 <= 1'h0; // @[dut.scala 18:31]
    end else begin
      pipelineEnable_3 <= pipelineEnable_2; // @[dut.scala 25:23]
    end
    if (io_i_en) begin // @[dut.scala 45:18]
      addaRegs_0 <= addaSegments_0; // @[dut.scala 46:17]
    end
    if (pipelineEnable_0) begin // @[dut.scala 68:32]
      addaRegs_1 <= addaSegments_1; // @[dut.scala 69:19]
    end
    if (pipelineEnable_1) begin // @[dut.scala 68:32]
      addaRegs_2 <= addaSegments_2; // @[dut.scala 69:19]
    end
    if (pipelineEnable_2) begin // @[dut.scala 68:32]
      addaRegs_3 <= addaSegments_3; // @[dut.scala 69:19]
    end
    if (io_i_en) begin // @[dut.scala 45:18]
      addbRegs_0 <= addbSegments_0; // @[dut.scala 47:17]
    end
    if (pipelineEnable_0) begin // @[dut.scala 68:32]
      addbRegs_1 <= addbSegments_1; // @[dut.scala 70:19]
    end
    if (pipelineEnable_1) begin // @[dut.scala 68:32]
      addbRegs_2 <= addbSegments_2; // @[dut.scala 70:19]
    end
    if (pipelineEnable_2) begin // @[dut.scala 68:32]
      addbRegs_3 <= addbSegments_3; // @[dut.scala 70:19]
    end
    if (reset) begin // @[dut.scala 51:26]
      carryRegs_0 <= 1'h0; // @[dut.scala 51:26]
    end else if (pipelineEnable_0) begin // @[dut.scala 60:28]
      carryRegs_0 <= firstStageSum[16]; // @[dut.scala 62:18]
    end
    if (reset) begin // @[dut.scala 51:26]
      carryRegs_1 <= 1'h0; // @[dut.scala 51:26]
    end else if (pipelineEnable_1) begin // @[dut.scala 78:30]
      carryRegs_1 <= stageSum[16]; // @[dut.scala 81:22]
    end
    if (reset) begin // @[dut.scala 51:26]
      carryRegs_2 <= 1'h0; // @[dut.scala 51:26]
    end else if (pipelineEnable_2) begin // @[dut.scala 78:30]
      carryRegs_2 <= stageSum_1[16]; // @[dut.scala 81:22]
    end
    if (reset) begin // @[dut.scala 51:26]
      carryRegs_3 <= 1'h0; // @[dut.scala 51:26]
    end else if (pipelineEnable_3) begin // @[dut.scala 78:30]
      carryRegs_3 <= stageSum_2[16]; // @[dut.scala 84:22]
    end
    if (pipelineEnable_0) begin // @[dut.scala 60:28]
      sumRegs_0 <= firstStageSum[15:0]; // @[dut.scala 61:16]
    end
    if (pipelineEnable_1) begin // @[dut.scala 78:30]
      sumRegs_1 <= stageSum[15:0]; // @[dut.scala 79:18]
    end
    if (pipelineEnable_2) begin // @[dut.scala 78:30]
      sumRegs_2 <= stageSum_1[15:0]; // @[dut.scala 79:18]
    end
    if (pipelineEnable_3) begin // @[dut.scala 78:30]
      sumRegs_3 <= stageSum_2[15:0]; // @[dut.scala 79:18]
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
  pipelineEnable_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pipelineEnable_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  pipelineEnable_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  pipelineEnable_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  addaRegs_0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  addaRegs_1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  addaRegs_2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  addaRegs_3 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  addbRegs_0 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  addbRegs_1 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  addbRegs_2 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  addbRegs_3 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  carryRegs_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  carryRegs_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  carryRegs_2 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  carryRegs_3 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sumRegs_0 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sumRegs_1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sumRegs_2 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sumRegs_3 = _RAND_19[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
