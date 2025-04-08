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
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [95:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  reg  enaReg1; // @[dut.scala 14:24]
  reg  enaReg2; // @[dut.scala 15:24]
  reg  enaReg3; // @[dut.scala 16:24]
  reg  enaReg4; // @[dut.scala 17:24]
  reg [63:0] addaReg1; // @[dut.scala 19:21]
  reg [63:0] addaReg2; // @[dut.scala 20:21]
  reg [63:0] addaReg3; // @[dut.scala 21:21]
  reg [63:0] addbReg1; // @[dut.scala 24:21]
  reg [63:0] addbReg2; // @[dut.scala 25:21]
  reg [63:0] addbReg3; // @[dut.scala 26:21]
  reg  carryOut1; // @[dut.scala 29:26]
  reg  carryOut2; // @[dut.scala 30:26]
  reg  carryOut3; // @[dut.scala 31:26]
  reg [16:0] sumReg1; // @[dut.scala 33:20]
  reg [16:0] sumReg2; // @[dut.scala 34:20]
  reg [16:0] sumReg3; // @[dut.scala 35:20]
  reg [64:0] finalSum; // @[dut.scala 36:21]
  wire [16:0] lowerAdd = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 40:35]
  wire [16:0] _middleAdd_T_2 = addaReg1[31:16] + addbReg1[31:16]; // @[dut.scala 50:38]
  wire [16:0] _GEN_17 = {{16'd0}, carryOut1}; // @[dut.scala 50:58]
  wire [16:0] middleAdd = _middleAdd_T_2 + _GEN_17; // @[dut.scala 50:58]
  wire [16:0] _upperAdd_T_2 = addaReg2[47:32] + addbReg2[47:32]; // @[dut.scala 60:37]
  wire [16:0] _GEN_18 = {{16'd0}, carryOut2}; // @[dut.scala 60:57]
  wire [16:0] upperAdd = _upperAdd_T_2 + _GEN_18; // @[dut.scala 60:57]
  wire [16:0] _topAdd_T_2 = addaReg3[63:48] + addbReg3[63:48]; // @[dut.scala 70:35]
  wire [16:0] _GEN_19 = {{16'd0}, carryOut3}; // @[dut.scala 70:55]
  wire [16:0] topAdd = _topAdd_T_2 + _GEN_19; // @[dut.scala 70:55]
  wire [64:0] _finalSum_T_3 = {topAdd,sumReg3[15:0],sumReg2[15:0],sumReg1[15:0]}; // @[Cat.scala 33:92]
  assign io_result = finalSum; // @[dut.scala 76:13]
  assign io_o_en = enaReg4; // @[dut.scala 77:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:24]
      enaReg1 <= 1'h0; // @[dut.scala 14:24]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      enaReg1 <= io_i_en; // @[dut.scala 43:13]
    end
    if (reset) begin // @[dut.scala 15:24]
      enaReg2 <= 1'h0; // @[dut.scala 15:24]
    end else if (enaReg1) begin // @[dut.scala 49:17]
      enaReg2 <= enaReg1; // @[dut.scala 53:13]
    end
    if (reset) begin // @[dut.scala 16:24]
      enaReg3 <= 1'h0; // @[dut.scala 16:24]
    end else if (enaReg2) begin // @[dut.scala 59:17]
      enaReg3 <= enaReg2; // @[dut.scala 63:13]
    end
    if (reset) begin // @[dut.scala 17:24]
      enaReg4 <= 1'h0; // @[dut.scala 17:24]
    end else if (enaReg3) begin // @[dut.scala 69:17]
      enaReg4 <= enaReg3; // @[dut.scala 72:13]
    end
    if (io_i_en) begin // @[dut.scala 39:17]
      addaReg1 <= io_adda; // @[dut.scala 44:14]
    end
    if (enaReg1) begin // @[dut.scala 49:17]
      addaReg2 <= addaReg1; // @[dut.scala 54:14]
    end
    if (enaReg2) begin // @[dut.scala 59:17]
      addaReg3 <= addaReg2; // @[dut.scala 64:14]
    end
    if (io_i_en) begin // @[dut.scala 39:17]
      addbReg1 <= io_addb; // @[dut.scala 45:14]
    end
    if (enaReg1) begin // @[dut.scala 49:17]
      addbReg2 <= addbReg1; // @[dut.scala 55:14]
    end
    if (enaReg2) begin // @[dut.scala 59:17]
      addbReg3 <= addbReg2; // @[dut.scala 65:14]
    end
    if (reset) begin // @[dut.scala 29:26]
      carryOut1 <= 1'h0; // @[dut.scala 29:26]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      carryOut1 <= lowerAdd[16]; // @[dut.scala 42:15]
    end
    if (reset) begin // @[dut.scala 30:26]
      carryOut2 <= 1'h0; // @[dut.scala 30:26]
    end else if (enaReg1) begin // @[dut.scala 49:17]
      carryOut2 <= middleAdd[16]; // @[dut.scala 52:15]
    end
    if (reset) begin // @[dut.scala 31:26]
      carryOut3 <= 1'h0; // @[dut.scala 31:26]
    end else if (enaReg2) begin // @[dut.scala 59:17]
      carryOut3 <= upperAdd[16]; // @[dut.scala 62:15]
    end
    if (io_i_en) begin // @[dut.scala 39:17]
      sumReg1 <= lowerAdd; // @[dut.scala 41:13]
    end
    if (enaReg1) begin // @[dut.scala 49:17]
      sumReg2 <= middleAdd; // @[dut.scala 51:13]
    end
    if (enaReg2) begin // @[dut.scala 59:17]
      sumReg3 <= upperAdd; // @[dut.scala 61:13]
    end
    if (enaReg3) begin // @[dut.scala 69:17]
      finalSum <= _finalSum_T_3; // @[dut.scala 71:14]
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
  enaReg1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  enaReg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  enaReg3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  enaReg4 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  addaReg1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addaReg2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  addaReg3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  addbReg1 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  addbReg2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  addbReg3 = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  carryOut1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  carryOut2 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  carryOut3 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sumReg1 = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  sumReg2 = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  sumReg3 = _RAND_15[16:0];
  _RAND_16 = {3{`RANDOM}};
  finalSum = _RAND_16[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
