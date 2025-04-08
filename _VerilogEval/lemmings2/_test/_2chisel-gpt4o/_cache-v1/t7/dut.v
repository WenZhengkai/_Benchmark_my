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
  reg [1:0] state; // @[dut.scala 20:22]
  wire  _T_3 = ~io_ground; // @[dut.scala 30:12]
  wire  _GEN_1 = io_bump_left ? 1'h0 : 1'h1; // @[dut.scala 23:16 33:33 38:22]
  wire  _GEN_3 = ~io_ground ? 1'h0 : _GEN_1; // @[dut.scala 23:16 30:24]
  wire [1:0] _GEN_4 = io_bump_right ? 2'h0 : state; // @[dut.scala 45:34 47:15 20:22]
  wire  _GEN_5 = io_bump_right ? 1'h0 : 1'h1; // @[dut.scala 24:17 45:34 50:23]
  wire  _GEN_7 = _T_3 ? 1'h0 : _GEN_5; // @[dut.scala 24:17 42:24]
  wire [1:0] _GEN_8 = io_ground ? 2'h0 : state; // @[dut.scala 56:23 58:15 20:22]
  wire [1:0] _GEN_9 = io_ground ? 2'h1 : state; // @[dut.scala 64:23 66:15 20:22]
  wire [1:0] _GEN_11 = 2'h3 == state ? _GEN_9 : state; // @[dut.scala 28:17 20:22]
  wire  _GEN_12 = 2'h2 == state | 2'h3 == state; // @[dut.scala 28:17 55:15]
  wire  _GEN_16 = 2'h1 == state ? 1'h0 : _GEN_12; // @[dut.scala 25:11 28:17]
  assign io_walk_left = 2'h0 == state & _GEN_3; // @[dut.scala 23:16 28:17]
  assign io_walk_right = 2'h0 == state ? 1'h0 : 2'h1 == state & _GEN_7; // @[dut.scala 24:17 28:17]
  assign io_aaah = 2'h0 == state ? 1'h0 : _GEN_16; // @[dut.scala 25:11 28:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:22]
      state <= 2'h0; // @[dut.scala 20:22]
    end else if (2'h0 == state) begin // @[dut.scala 28:17]
      if (~io_ground) begin // @[dut.scala 30:24]
        state <= 2'h2; // @[dut.scala 32:15]
      end else if (io_bump_left) begin // @[dut.scala 33:33]
        state <= 2'h1; // @[dut.scala 35:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 28:17]
      if (_T_3) begin // @[dut.scala 42:24]
        state <= 2'h3; // @[dut.scala 44:15]
      end else begin
        state <= _GEN_4;
      end
    end else if (2'h2 == state) begin // @[dut.scala 28:17]
      state <= _GEN_8;
    end else begin
      state <= _GEN_11;
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
