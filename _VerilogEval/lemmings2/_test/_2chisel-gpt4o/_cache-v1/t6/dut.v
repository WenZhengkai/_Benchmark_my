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
  reg [1:0] stateReg; // @[dut.scala 19:25]
  wire  _T_3 = ~io_ground; // @[dut.scala 30:12]
  wire [1:0] _GEN_2 = io_bump_right ? 2'h0 : stateReg; // @[dut.scala 41:33 42:18 19:25]
  wire [1:0] _GEN_4 = io_ground ? 2'h0 : stateReg; // @[dut.scala 48:23 49:18 19:25]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : stateReg; // @[dut.scala 55:23 56:18 19:25]
  wire [1:0] _GEN_7 = 2'h3 == stateReg ? _GEN_5 : stateReg; // @[dut.scala 27:20 19:25]
  wire  _GEN_8 = 2'h2 == stateReg | 2'h3 == stateReg; // @[dut.scala 27:20 47:15]
  wire  _GEN_12 = 2'h1 == stateReg ? 1'h0 : _GEN_8; // @[dut.scala 24:11 27:20]
  assign io_walk_left = 2'h0 == stateReg; // @[dut.scala 27:20]
  assign io_walk_right = 2'h0 == stateReg ? 1'h0 : 2'h1 == stateReg; // @[dut.scala 23:17 27:20]
  assign io_aaah = 2'h0 == stateReg ? 1'h0 : _GEN_12; // @[dut.scala 24:11 27:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:25]
      stateReg <= 2'h0; // @[dut.scala 19:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 27:20]
      if (~io_ground) begin // @[dut.scala 30:24]
        stateReg <= 2'h2; // @[dut.scala 31:18]
      end else if (io_bump_left) begin // @[dut.scala 32:32]
        stateReg <= 2'h1; // @[dut.scala 33:18]
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 27:20]
      if (_T_3) begin // @[dut.scala 39:24]
        stateReg <= 2'h3; // @[dut.scala 40:18]
      end else begin
        stateReg <= _GEN_2;
      end
    end else if (2'h2 == stateReg) begin // @[dut.scala 27:20]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_7;
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
  stateReg = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
