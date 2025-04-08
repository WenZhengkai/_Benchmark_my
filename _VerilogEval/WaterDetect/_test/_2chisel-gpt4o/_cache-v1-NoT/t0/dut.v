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
  reg [2:0] prevState; // @[dut.scala 17:26]
  reg  fr3Reg; // @[dut.scala 18:23]
  reg  fr2Reg; // @[dut.scala 19:23]
  reg  fr1Reg; // @[dut.scala 20:23]
  reg  dfrReg; // @[dut.scala 21:23]
  wire  _GEN_0 = io_s == 3'h1 ? 1'h0 : 1'h1; // @[dut.scala 47:35 48:14 52:14]
  wire  _GEN_2 = io_s == 3'h3 ? 1'h0 : _GEN_0; // @[dut.scala 43:35 44:14]
  wire  _GEN_3 = io_s == 3'h3 ? 1'h0 : 1'h1; // @[dut.scala 43:35 45:14]
  wire  _GEN_5 = io_s == 3'h7 ? 1'h0 : _GEN_2; // @[dut.scala 39:29 40:14]
  wire  _GEN_6 = io_s == 3'h7 ? 1'h0 : _GEN_3; // @[dut.scala 39:29 41:14]
  wire  _GEN_7 = io_s == 3'h7 ? 1'h0 : 1'h1; // @[dut.scala 39:29 42:14]
  wire  _GEN_9 = reset | _GEN_5; // @[dut.scala 30:19 33:12]
  wire  _GEN_10 = reset | _GEN_6; // @[dut.scala 30:19 34:12]
  wire  _GEN_11 = reset | _GEN_7; // @[dut.scala 30:19 35:12]
  wire  _GEN_12 = reset | io_s > prevState; // @[dut.scala 30:19 36:12 59:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 24:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 25:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 26:10]
  assign io_dfr = dfrReg; // @[dut.scala 27:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:26]
      prevState <= 3'h0; // @[dut.scala 17:26]
    end else if (reset) begin // @[dut.scala 30:19]
      prevState <= 3'h0; // @[dut.scala 32:15]
    end else begin
      prevState <= io_s; // @[dut.scala 62:15]
    end
    fr3Reg <= reset | _GEN_9; // @[dut.scala 18:{23,23}]
    fr2Reg <= reset | _GEN_10; // @[dut.scala 19:{23,23}]
    fr1Reg <= reset | _GEN_11; // @[dut.scala 20:{23,23}]
    dfrReg <= reset | _GEN_12; // @[dut.scala 21:{23,23}]
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
  prevState = _RAND_0[2:0];
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
