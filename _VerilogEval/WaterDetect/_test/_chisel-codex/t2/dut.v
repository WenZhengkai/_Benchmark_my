module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_rst,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _GEN_1 = io_s[1] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 21:23 22:11]
  wire [1:0] level = io_s[2] ? 2'h3 : _GEN_1; // @[dut.scala 19:17 20:11]
  reg [1:0] lastLevel; // @[dut.scala 30:32]
  reg  lastChangeWasUp; // @[dut.scala 31:32]
  wire  _GEN_8 = 2'h1 == level | 2'h0 == level; // @[dut.scala 55:19 69:16]
  wire  _GEN_9 = 2'h1 == level ? 1'h0 : 2'h0 == level; // @[dut.scala 55:19 71:16]
  wire  _GEN_10 = 2'h1 == level ? lastChangeWasUp : 2'h0 == level; // @[dut.scala 55:19 72:16]
  wire  _GEN_11 = 2'h2 == level | _GEN_8; // @[dut.scala 55:19 63:16]
  wire  _GEN_12 = 2'h2 == level ? 1'h0 : _GEN_8; // @[dut.scala 55:19 64:16]
  wire  _GEN_13 = 2'h2 == level ? 1'h0 : _GEN_9; // @[dut.scala 55:19 65:16]
  wire  _GEN_14 = 2'h2 == level ? lastChangeWasUp : _GEN_10; // @[dut.scala 55:19 66:16]
  wire  _GEN_15 = 2'h3 == level ? 1'h0 : _GEN_11; // @[dut.scala 55:19 57:16]
  wire  _GEN_16 = 2'h3 == level ? 1'h0 : _GEN_12; // @[dut.scala 55:19 58:16]
  wire  _GEN_17 = 2'h3 == level ? 1'h0 : _GEN_13; // @[dut.scala 55:19 59:16]
  wire  _GEN_18 = 2'h3 == level ? 1'h0 : _GEN_14; // @[dut.scala 55:19 60:16]
  assign io_fr3 = io_rst | _GEN_17; // @[dut.scala 49:16 52:12]
  assign io_fr2 = io_rst | _GEN_16; // @[dut.scala 49:16 51:12]
  assign io_fr1 = io_rst | _GEN_15; // @[dut.scala 49:16 50:12]
  assign io_dfr = io_rst | _GEN_18; // @[dut.scala 49:16 53:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 30:32]
      lastLevel <= 2'h0; // @[dut.scala 30:32]
    end else if (io_rst) begin // @[dut.scala 34:16]
      lastLevel <= 2'h0; // @[dut.scala 35:21]
    end else if (level != lastLevel) begin // @[dut.scala 37:35]
      if (io_s[2]) begin // @[dut.scala 19:17]
        lastLevel <= 2'h3; // @[dut.scala 20:11]
      end else begin
        lastLevel <= _GEN_1;
      end
    end
    if (reset) begin // @[dut.scala 31:32]
      lastChangeWasUp <= 1'h0; // @[dut.scala 31:32]
    end else if (io_rst) begin // @[dut.scala 34:16]
      lastChangeWasUp <= 1'h0; // @[dut.scala 36:21]
    end else if (level != lastLevel) begin // @[dut.scala 37:35]
      lastChangeWasUp <= level > lastLevel; // @[dut.scala 38:21]
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
  lastLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  lastChangeWasUp = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
