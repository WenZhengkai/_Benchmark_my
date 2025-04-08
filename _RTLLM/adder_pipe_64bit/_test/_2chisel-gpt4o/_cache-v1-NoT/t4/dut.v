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
  reg  enReg1; // @[dut.scala 14:23]
  reg  enReg2; // @[dut.scala 15:23]
  reg  enReg3; // @[dut.scala 16:23]
  reg  enReg4; // @[dut.scala 17:23]
  reg [16:0] sumReg1; // @[dut.scala 19:20]
  reg [16:0] sumReg2; // @[dut.scala 20:20]
  reg [16:0] sumReg3; // @[dut.scala 21:20]
  reg [16:0] sumReg4; // @[dut.scala 22:20]
  wire [16:0] addResStage1 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 26:39]
  wire [16:0] _addResStage2_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 33:40]
  wire [16:0] _GEN_4 = {{16'd0}, sumReg1[16]}; // @[dut.scala 33:59]
  wire [17:0] addResStage2 = _addResStage2_T_2 + _GEN_4; // @[dut.scala 33:59]
  wire [17:0] _GEN_1 = enReg1 ? addResStage2 : {{1'd0}, sumReg2}; // @[dut.scala 32:16 34:13 20:20]
  wire [16:0] _addResStage3_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 40:40]
  wire [16:0] _GEN_5 = {{16'd0}, sumReg2[16]}; // @[dut.scala 40:59]
  wire [17:0] addResStage3 = _addResStage3_T_2 + _GEN_5; // @[dut.scala 40:59]
  wire [17:0] _GEN_2 = enReg2 ? addResStage3 : {{1'd0}, sumReg3}; // @[dut.scala 39:16 41:13 21:20]
  wire [16:0] _addResStage4_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 47:40]
  wire [16:0] _GEN_6 = {{16'd0}, sumReg3[16]}; // @[dut.scala 47:59]
  wire [17:0] addResStage4 = _addResStage4_T_2 + _GEN_6; // @[dut.scala 47:59]
  wire [17:0] _GEN_3 = enReg3 ? addResStage4 : {{1'd0}, sumReg4}; // @[dut.scala 46:16 48:13 22:20]
  wire [31:0] io_result_lo = {sumReg2[15:0],sumReg1[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sumReg4[16],sumReg4[15:0],sumReg3[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = enReg4; // @[dut.scala 53:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:23]
      enReg1 <= 1'h0; // @[dut.scala 14:23]
    end else begin
      enReg1 <= io_i_en; // @[dut.scala 29:10]
    end
    if (reset) begin // @[dut.scala 15:23]
      enReg2 <= 1'h0; // @[dut.scala 15:23]
    end else begin
      enReg2 <= enReg1; // @[dut.scala 36:10]
    end
    if (reset) begin // @[dut.scala 16:23]
      enReg3 <= 1'h0; // @[dut.scala 16:23]
    end else begin
      enReg3 <= enReg2; // @[dut.scala 43:10]
    end
    if (reset) begin // @[dut.scala 17:23]
      enReg4 <= 1'h0; // @[dut.scala 17:23]
    end else begin
      enReg4 <= enReg3; // @[dut.scala 50:10]
    end
    if (io_i_en) begin // @[dut.scala 25:17]
      sumReg1 <= addResStage1; // @[dut.scala 27:13]
    end
    sumReg2 <= _GEN_1[16:0];
    sumReg3 <= _GEN_2[16:0];
    sumReg4 <= _GEN_3[16:0];
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
  sumReg1 = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  sumReg2 = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  sumReg3 = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  sumReg4 = _RAND_7[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
