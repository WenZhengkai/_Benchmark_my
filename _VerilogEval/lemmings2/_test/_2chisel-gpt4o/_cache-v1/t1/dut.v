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
  reg [1:0] state; // @[dut.scala 19:22]
  wire  _T_1 = ~io_ground; // @[dut.scala 29:12]
  wire  _GEN_1 = io_bump_left ? 1'h0 : 1'h1; // @[dut.scala 22:16 32:32 35:22]
  wire  _GEN_4 = ~io_ground ? 1'h0 : _GEN_1; // @[dut.scala 22:16 29:24]
  wire [1:0] _GEN_5 = io_bump_right ? 2'h0 : state; // @[dut.scala 43:33 44:15 19:22]
  wire  _GEN_6 = io_bump_right ? 1'h0 : 1'h1; // @[dut.scala 23:17 43:33 46:23]
  wire  _GEN_9 = _T_1 ? 1'h0 : _GEN_6; // @[dut.scala 23:17 40:24]
  wire [1:0] _GEN_10 = io_ground ? 2'h0 : state; // @[dut.scala 51:23 52:15 19:22]
  wire  _GEN_12 = io_ground ? 1'h0 : 1'h1; // @[dut.scala 24:11 51:23 55:17]
  wire [1:0] _GEN_13 = io_ground ? 2'h1 : state; // @[dut.scala 60:23 61:15 19:22]
  wire [1:0] _GEN_14 = 2'h3 == state ? _GEN_13 : state; // @[dut.scala 27:17 19:22]
  wire  _GEN_16 = 2'h3 == state & _GEN_12; // @[dut.scala 24:11 27:17]
  wire  _GEN_19 = 2'h2 == state ? _GEN_12 : _GEN_16; // @[dut.scala 27:17]
  wire  _GEN_20 = 2'h2 == state ? 1'h0 : 2'h3 == state & io_ground; // @[dut.scala 23:17 27:17]
  wire  _GEN_22 = 2'h1 == state ? _T_1 : _GEN_19; // @[dut.scala 27:17]
  wire  _GEN_23 = 2'h1 == state ? _GEN_9 : _GEN_20; // @[dut.scala 27:17]
  wire  _GEN_24 = 2'h1 == state ? 1'h0 : 2'h2 == state & io_ground; // @[dut.scala 22:16 27:17]
  assign io_walk_left = 2'h0 == state ? _GEN_4 : _GEN_24; // @[dut.scala 27:17]
  assign io_walk_right = 2'h0 == state ? 1'h0 : _GEN_23; // @[dut.scala 23:17 27:17]
  assign io_aaah = 2'h0 == state ? _T_1 : _GEN_22; // @[dut.scala 27:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:22]
      state <= 2'h0; // @[dut.scala 19:22]
    end else if (2'h0 == state) begin // @[dut.scala 27:17]
      if (~io_ground) begin // @[dut.scala 29:24]
        state <= 2'h2; // @[dut.scala 30:15]
      end else if (io_bump_left) begin // @[dut.scala 32:32]
        state <= 2'h1; // @[dut.scala 33:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 27:17]
      if (_T_1) begin // @[dut.scala 40:24]
        state <= 2'h3; // @[dut.scala 41:15]
      end else begin
        state <= _GEN_5;
      end
    end else if (2'h2 == state) begin // @[dut.scala 27:17]
      state <= _GEN_10;
    end else begin
      state <= _GEN_14;
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
