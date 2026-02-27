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
  reg [1:0] stateReg; // @[dut.scala 23:25]
  wire  _T_3 = ~io_ground; // @[dut.scala 28:12]
  wire [1:0] _GEN_2 = io_bump_right | io_bump_left ? 2'h0 : stateReg; // @[dut.scala 37:49 38:18 23:25]
  wire [1:0] _GEN_4 = io_ground ? 2'h0 : stateReg; // @[dut.scala 42:23 43:18 23:25]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : stateReg; // @[dut.scala 47:23 48:18 23:25]
  wire [1:0] _GEN_6 = 2'h3 == stateReg ? _GEN_5 : stateReg; // @[dut.scala 26:20 23:25]
  assign io_walk_left = stateReg == 2'h0; // @[dut.scala 54:29]
  assign io_walk_right = stateReg == 2'h1; // @[dut.scala 55:30]
  assign io_aaah = stateReg == 2'h2 | stateReg == 2'h3; // @[dut.scala 56:47]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 23:25]
      stateReg <= 2'h0; // @[dut.scala 23:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 26:20]
      if (~io_ground) begin // @[dut.scala 28:24]
        stateReg <= 2'h2; // @[dut.scala 29:18]
      end else if (io_bump_left | io_bump_right) begin // @[dut.scala 30:49]
        stateReg <= 2'h1; // @[dut.scala 31:18]
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 26:20]
      if (_T_3) begin // @[dut.scala 35:24]
        stateReg <= 2'h3; // @[dut.scala 36:18]
      end else begin
        stateReg <= _GEN_2;
      end
    end else if (2'h2 == stateReg) begin // @[dut.scala 26:20]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_6;
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
