module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevS; // @[dut.scala 14:22]
  reg  fr3Reg; // @[dut.scala 15:23]
  reg  fr2Reg; // @[dut.scala 16:23]
  reg  fr1Reg; // @[dut.scala 17:23]
  reg  dfrReg; // @[dut.scala 18:23]
  wire  _GEN_0 = 3'h0 == io_s | fr3Reg; // @[dut.scala 36:18 53:16 15:23]
  wire  _GEN_1 = 3'h0 == io_s | fr2Reg; // @[dut.scala 36:18 54:16 16:23]
  wire  _GEN_2 = 3'h0 == io_s | fr1Reg; // @[dut.scala 36:18 55:16 17:23]
  wire  _GEN_3 = 3'h4 == io_s ? 1'h0 : _GEN_0; // @[dut.scala 36:18 48:16]
  wire  _GEN_4 = 3'h4 == io_s | _GEN_1; // @[dut.scala 36:18 49:16]
  wire  _GEN_5 = 3'h4 == io_s | _GEN_2; // @[dut.scala 36:18 50:16]
  wire  _GEN_6 = 3'h6 == io_s ? 1'h0 : _GEN_3; // @[dut.scala 36:18 43:16]
  wire  _GEN_7 = 3'h6 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 36:18 44:16]
  wire  _GEN_8 = 3'h6 == io_s | _GEN_5; // @[dut.scala 36:18 45:16]
  wire  _GEN_9 = 3'h7 == io_s ? 1'h0 : _GEN_6; // @[dut.scala 36:18 38:16]
  wire  _GEN_10 = 3'h7 == io_s ? 1'h0 : _GEN_7; // @[dut.scala 36:18 39:16]
  wire  _GEN_11 = 3'h7 == io_s ? 1'h0 : _GEN_8; // @[dut.scala 36:18 40:16]
  wire  _T_5 = io_s > prevS; // @[dut.scala 60:15]
  wire  _GEN_13 = reset | _GEN_9; // @[dut.scala 27:24 29:12]
  wire  _GEN_14 = reset | _GEN_10; // @[dut.scala 27:24 30:12]
  wire  _GEN_15 = reset | _GEN_11; // @[dut.scala 27:24 31:12]
  wire  _GEN_16 = reset | _T_5; // @[dut.scala 27:24 32:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 21:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 22:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 23:10]
  assign io_dfr = dfrReg; // @[dut.scala 24:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      prevS <= 3'h0; // @[dut.scala 14:22]
    end else if (reset) begin // @[dut.scala 27:24]
      prevS <= 3'h0; // @[dut.scala 33:11]
    end else begin
      prevS <= io_s; // @[dut.scala 67:11]
    end
    fr3Reg <= reset | _GEN_13; // @[dut.scala 15:{23,23}]
    fr2Reg <= reset | _GEN_14; // @[dut.scala 16:{23,23}]
    fr1Reg <= reset | _GEN_15; // @[dut.scala 17:{23,23}]
    dfrReg <= reset | _GEN_16; // @[dut.scala 18:{23,23}]
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
  prevS = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  fr3Reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr1Reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfrReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
