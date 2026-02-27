module dut(
  input   clock,
  input   reset,
  input   io_bump_left,
  input   io_bump_right,
  input   io_ground,
  output  io_walk_left,
  output  io_walk_right,
  output  io_aaah
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] currentState; // @[dut.scala 19:29]
  wire  _T_3 = ~io_ground; // @[dut.scala 29:12]
  wire  _T_4 = io_bump_left | io_bump_right; // @[dut.scala 31:31]
  wire [1:0] _GEN_0 = io_bump_left | io_bump_right ? 2'h1 : currentState; // @[dut.scala 31:49 32:22 19:29]
  wire [1:0] _GEN_2 = _T_4 ? 2'h0 : currentState; // @[dut.scala 40:49 41:22 19:29]
  wire [1:0] _GEN_3 = _T_3 ? 2'h3 : _GEN_2; // @[dut.scala 38:24 39:22]
  wire [1:0] _GEN_4 = io_ground ? 2'h0 : currentState; // @[dut.scala 47:23 48:22 19:29]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : currentState; // @[dut.scala 54:23 55:22 19:29]
  wire [1:0] _GEN_7 = 2'h3 == currentState ? _GEN_5 : currentState; // @[dut.scala 26:24 19:29]
  wire  _GEN_8 = 2'h2 == currentState | 2'h3 == currentState; // @[dut.scala 26:24 46:15]
  wire [1:0] _GEN_9 = 2'h2 == currentState ? _GEN_4 : _GEN_7; // @[dut.scala 26:24]
  wire  _GEN_12 = 2'h1 == currentState ? 1'h0 : _GEN_8; // @[dut.scala 24:11 26:24]
  assign io_walk_left = 2'h0 == currentState; // @[dut.scala 26:24]
  assign io_walk_right = 2'h0 == currentState ? 1'h0 : 2'h1 == currentState; // @[dut.scala 23:17 26:24]
  assign io_aaah = 2'h0 == currentState ? 1'h0 : _GEN_12; // @[dut.scala 24:11 26:24]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:29]
      currentState <= 2'h0; // @[dut.scala 19:29]
    end else if (reset) begin // @[dut.scala 61:24]
      currentState <= 2'h0; // @[dut.scala 62:18]
    end else if (2'h0 == currentState) begin // @[dut.scala 26:24]
      if (~io_ground) begin // @[dut.scala 29:24]
        currentState <= 2'h2; // @[dut.scala 30:22]
      end else begin
        currentState <= _GEN_0;
      end
    end else if (2'h1 == currentState) begin // @[dut.scala 26:24]
      currentState <= _GEN_3;
    end else begin
      currentState <= _GEN_9;
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
  currentState = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
