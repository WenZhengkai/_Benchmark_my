module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] prevLevel; // @[dut.scala 15:26]
  wire [1:0] _GEN_1 = io_s[1] & io_s[0] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 35:36 36:20]
  wire [1:0] currentLevel = io_s[2] & io_s[1] & io_s[0] ? 2'h3 : _GEN_1; // @[dut.scala 33:41 34:20]
  wire  _T_11 = prevLevel < currentLevel; // @[dut.scala 53:24]
  wire  _GEN_6 = 2'h1 == currentLevel | 2'h0 == currentLevel; // @[dut.scala 44:26 58:16]
  wire  _GEN_7 = 2'h1 == currentLevel ? _T_11 : 2'h0 == currentLevel; // @[dut.scala 44:26]
  wire  _GEN_8 = 2'h1 == currentLevel ? 1'h0 : 2'h0 == currentLevel; // @[dut.scala 26:12 44:26]
  wire  _GEN_9 = 2'h2 == currentLevel | _GEN_6; // @[dut.scala 44:26 52:16]
  wire  _GEN_10 = 2'h2 == currentLevel ? _T_11 : _GEN_7; // @[dut.scala 44:26]
  wire  _GEN_11 = 2'h2 == currentLevel ? 1'h0 : _GEN_6; // @[dut.scala 27:12 44:26]
  wire  _GEN_12 = 2'h2 == currentLevel ? 1'h0 : _GEN_8; // @[dut.scala 26:12 44:26]
  wire  _GEN_13 = 2'h3 == currentLevel ? 1'h0 : _GEN_12; // @[dut.scala 44:26 46:16]
  wire  _GEN_14 = 2'h3 == currentLevel ? 1'h0 : _GEN_11; // @[dut.scala 44:26 47:16]
  wire  _GEN_15 = 2'h3 == currentLevel ? 1'h0 : _GEN_9; // @[dut.scala 44:26 48:16]
  wire  _GEN_16 = 2'h3 == currentLevel ? 1'h0 : _GEN_10; // @[dut.scala 44:26 49:16]
  assign io_fr3 = io_reset | _GEN_13; // @[dut.scala 18:18 19:12]
  assign io_fr2 = io_reset | _GEN_14; // @[dut.scala 18:18 20:12]
  assign io_fr1 = io_reset | _GEN_15; // @[dut.scala 18:18 21:12]
  assign io_dfr = io_reset | _GEN_16; // @[dut.scala 18:18 22:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      prevLevel <= 2'h0; // @[dut.scala 15:26]
    end else if (io_reset) begin // @[dut.scala 18:18]
      prevLevel <= 2'h0; // @[dut.scala 23:15]
    end else if (io_s[2] & io_s[1] & io_s[0]) begin // @[dut.scala 33:41]
      prevLevel <= 2'h3; // @[dut.scala 34:20]
    end else if (io_s[1] & io_s[0]) begin // @[dut.scala 35:36]
      prevLevel <= 2'h2; // @[dut.scala 36:20]
    end else begin
      prevLevel <= {{1'd0}, io_s[0]};
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
  prevLevel = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
