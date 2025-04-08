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
  reg  enReg1; // @[dut.scala 15:23]
  reg  enReg2; // @[dut.scala 16:23]
  reg  enReg3; // @[dut.scala 17:23]
  reg  enReg4; // @[dut.scala 18:23]
  reg [16:0] sumStage1; // @[dut.scala 21:26]
  reg [16:0] sumStage2; // @[dut.scala 22:26]
  reg [16:0] sumStage3; // @[dut.scala 23:26]
  reg [16:0] sumStage4; // @[dut.scala 24:26]
  wire [16:0] addLsb = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 28:33]
  wire [16:0] _addNext_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 37:35]
  wire [16:0] _GEN_8 = {{16'd0}, sumStage1[16]}; // @[dut.scala 37:54]
  wire [16:0] addNext = _addNext_T_2 + _GEN_8; // @[dut.scala 37:54]
  wire [16:0] _addNext_T_7 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 46:35]
  wire [16:0] _GEN_9 = {{16'd0}, sumStage2[16]}; // @[dut.scala 46:54]
  wire [16:0] addNext_1 = _addNext_T_7 + _GEN_9; // @[dut.scala 46:54]
  wire [16:0] _addMsb_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 55:34]
  wire [16:0] _GEN_10 = {{16'd0}, sumStage3[16]}; // @[dut.scala 55:53]
  wire [16:0] addMsb = _addMsb_T_2 + _GEN_10; // @[dut.scala 55:53]
  wire [31:0] io_result_lo = {sumStage2[15:0],sumStage1[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sumStage4[16],sumStage4[15:0],sumStage3[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = enReg4; // @[dut.scala 64:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:23]
      enReg1 <= 1'h0; // @[dut.scala 15:23]
    end else begin
      enReg1 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 16:23]
      enReg2 <= 1'h0; // @[dut.scala 16:23]
    end else begin
      enReg2 <= enReg1;
    end
    if (reset) begin // @[dut.scala 17:23]
      enReg3 <= 1'h0; // @[dut.scala 17:23]
    end else begin
      enReg3 <= enReg2;
    end
    if (reset) begin // @[dut.scala 18:23]
      enReg4 <= 1'h0; // @[dut.scala 18:23]
    end else begin
      enReg4 <= enReg3;
    end
    if (reset) begin // @[dut.scala 21:26]
      sumStage1 <= 17'h0; // @[dut.scala 21:26]
    end else if (io_i_en) begin // @[dut.scala 27:18]
      sumStage1 <= addLsb; // @[dut.scala 29:15]
    end
    if (reset) begin // @[dut.scala 22:26]
      sumStage2 <= 17'h0; // @[dut.scala 22:26]
    end else if (enReg1) begin // @[dut.scala 36:17]
      sumStage2 <= addNext; // @[dut.scala 38:15]
    end
    if (reset) begin // @[dut.scala 23:26]
      sumStage3 <= 17'h0; // @[dut.scala 23:26]
    end else if (enReg2) begin // @[dut.scala 45:17]
      sumStage3 <= addNext_1; // @[dut.scala 47:15]
    end
    if (reset) begin // @[dut.scala 24:26]
      sumStage4 <= 17'h0; // @[dut.scala 24:26]
    end else if (enReg3) begin // @[dut.scala 54:17]
      sumStage4 <= addMsb; // @[dut.scala 56:15]
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
  enReg1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  enReg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  enReg3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  enReg4 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sumStage1 = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  sumStage2 = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  sumStage3 = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  sumStage4 = _RAND_7[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
