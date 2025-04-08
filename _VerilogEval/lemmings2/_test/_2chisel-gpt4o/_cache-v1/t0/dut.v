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
  reg [1:0] state; // @[dut.scala 18:22]
  wire  _T_1 = ~io_ground; // @[dut.scala 29:12]
  wire  _T_2 = io_bump_left | io_bump_right; // @[dut.scala 31:31]
  wire [1:0] _GEN_2 = _T_2 ? 2'h0 : state; // @[dut.scala 40:49 41:15 18:22]
  wire [1:0] _GEN_4 = io_ground ? 2'h0 : state; // @[dut.scala 47:23 48:15 18:22]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : state; // @[dut.scala 54:23 55:15 18:22]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 26:17 18:22]
  wire  _GEN_8 = 2'h2 == state | 2'h3 == state; // @[dut.scala 26:17 46:15]
  wire  _GEN_12 = 2'h1 == state ? 1'h0 : _GEN_8; // @[dut.scala 23:17 26:17]
  assign io_walk_left = 2'h0 == state; // @[dut.scala 26:17]
  assign io_walk_right = 2'h0 == state ? 1'h0 : 2'h1 == state; // @[dut.scala 22:17 26:17]
  assign io_aaah = 2'h0 == state ? 1'h0 : _GEN_12; // @[dut.scala 23:17 26:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h0; // @[dut.scala 18:22]
    end else if (2'h0 == state) begin // @[dut.scala 26:17]
      if (~io_ground) begin // @[dut.scala 29:24]
        state <= 2'h2; // @[dut.scala 30:15]
      end else if (io_bump_left | io_bump_right) begin // @[dut.scala 31:49]
        state <= 2'h1; // @[dut.scala 32:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 26:17]
      if (_T_1) begin // @[dut.scala 38:24]
        state <= 2'h3; // @[dut.scala 39:15]
      end else begin
        state <= _GEN_2;
      end
    end else if (2'h2 == state) begin // @[dut.scala 26:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_7;
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
  state = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
