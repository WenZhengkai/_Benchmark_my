module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_reset,
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] currentState; // @[dut.scala 18:29]
  reg [1:0] previousState; // @[dut.scala 21:30]
  reg [1:0] REG; // @[dut.scala 24:32]
  reg [1:0] previousState_REG; // @[dut.scala 25:29]
  wire  _T_10 = ~io_s[2]; // @[dut.scala 32:36]
  wire [1:0] _GEN_1 = io_s[0] & ~io_s[1] & _T_10 ? 2'h2 : 2'h3; // @[dut.scala 34:47 35:14 37:14]
  wire  wasRising = previousState < currentState; // @[dut.scala 50:31]
  wire  _GEN_7 = 2'h3 == currentState & wasRising; // @[dut.scala 57:10 66:26 83:16]
  wire  _GEN_8 = 2'h2 == currentState | 2'h3 == currentState; // @[dut.scala 66:26 75:16]
  wire  _GEN_9 = 2'h2 == currentState ? wasRising : _GEN_7; // @[dut.scala 66:26 77:16]
  wire  _GEN_10 = 2'h2 == currentState ? 1'h0 : 2'h3 == currentState; // @[dut.scala 56:10 66:26]
  wire  _GEN_11 = 2'h1 == currentState | _GEN_8; // @[dut.scala 66:26 71:16]
  wire  _GEN_12 = 2'h1 == currentState ? wasRising : _GEN_9; // @[dut.scala 66:26 72:16]
  wire  _GEN_13 = 2'h1 == currentState ? 1'h0 : _GEN_8; // @[dut.scala 55:10 66:26]
  wire  _GEN_14 = 2'h1 == currentState ? 1'h0 : _GEN_10; // @[dut.scala 56:10 66:26]
  wire  _GEN_15 = 2'h0 == currentState ? 1'h0 : _GEN_11; // @[dut.scala 54:10 66:26]
  wire  _GEN_16 = 2'h0 == currentState ? 1'h0 : _GEN_12; // @[dut.scala 57:10 66:26]
  wire  _GEN_17 = 2'h0 == currentState ? 1'h0 : _GEN_13; // @[dut.scala 55:10 66:26]
  wire  _GEN_18 = 2'h0 == currentState ? 1'h0 : _GEN_14; // @[dut.scala 56:10 66:26]
  assign io_fr3 = io_reset | _GEN_18; // @[dut.scala 59:18 63:12]
  assign io_fr2 = io_reset | _GEN_17; // @[dut.scala 59:18 62:12]
  assign io_fr1 = io_reset | _GEN_15; // @[dut.scala 59:18 61:12]
  assign io_dfr = io_reset | _GEN_16; // @[dut.scala 59:18 64:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:29]
      currentState <= 2'h3; // @[dut.scala 18:29]
    end else if (io_reset) begin // @[dut.scala 41:18]
      currentState <= 2'h3; // @[dut.scala 42:18]
    end else if (io_s[2] & io_s[1] & io_s[0]) begin // @[dut.scala 30:39]
      currentState <= 2'h0; // @[dut.scala 31:14]
    end else if (io_s[1] & io_s[0] & ~io_s[2]) begin // @[dut.scala 32:46]
      currentState <= 2'h1; // @[dut.scala 33:14]
    end else begin
      currentState <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 21:30]
      previousState <= 2'h3; // @[dut.scala 21:30]
    end else if (io_reset) begin // @[dut.scala 41:18]
      previousState <= 2'h3; // @[dut.scala 43:19]
    end else if (currentState != REG) begin // @[dut.scala 24:48]
      previousState <= previousState_REG; // @[dut.scala 25:19]
    end
    REG <= currentState; // @[dut.scala 24:32]
    previousState_REG <= currentState; // @[dut.scala 25:29]
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
  currentState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  previousState = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  REG = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  previousState_REG = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
