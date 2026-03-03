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
  reg [1:0] state; // @[dut.scala 20:12]
  wire  _T_3 = ~io_ground; // @[dut.scala 25:12]
  wire  _T_4 = io_bump_left & io_bump_right; // @[dut.scala 29:27]
  wire [1:0] _GEN_0 = io_bump_right ? 2'h0 : state; // @[dut.scala 20:12 33:35 34:17]
  wire [1:0] _GEN_4 = io_bump_left ? 2'h1 : state; // @[dut.scala 20:12 48:34 49:17]
  wire [1:0] _GEN_5 = io_bump_right ? 2'h0 : _GEN_4; // @[dut.scala 46:35 47:17]
  wire [1:0] _GEN_9 = io_ground ? 2'h1 : state; // @[dut.scala 20:12 62:23 64:15]
  assign io_walk_left = state == 2'h0; // @[dut.scala 70:27]
  assign io_walk_right = state == 2'h1; // @[dut.scala 71:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 72:47]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[dut.scala 23:17]
      state <= 2'h0; // @[dut.scala 25:24 27:15 29:45 30:17 31:34 32:17]
    end else if (2'h0 == state) begin // @[dut.scala 23:17]
      if (~io_ground) begin // @[dut.scala 40:24]
        state <= 2'h2; // @[dut.scala 42:15]
      end else if (io_bump_left & io_bump_right) begin // @[dut.scala 44:45]
        state <= 2'h1; // @[dut.scala 45:17]
      end else if (io_bump_left) begin
        state <= 2'h1;
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 23:17]
      if (_T_3) begin // @[dut.scala 55:23]
        state <= 2'h3; // @[dut.scala 57:15]
      end else if (_T_4) begin // @[dut.scala 20:12]
        state <= 2'h0;
      end else begin
        state <= _GEN_5;
      end
    end else if (2'h2 == state) begin // @[dut.scala 23:17]
      if (io_ground) begin
        state <= 2'h0;
      end
    end else if (2'h3 == state) begin // @[dut.scala 20:12]
      state <= _GEN_9;
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
  if (reset) begin
    state = 2'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
