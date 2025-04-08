module dut(
  input   clock,
  input   reset,
  input   io_bump_left,
  input   io_bump_right,
  input   io_ground,
  input   io_reset,
  output  io_walk_left,
  output  io_walk_right,
  output  io_aaah
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 21:22]
  reg [1:0] preservedDirection; // @[dut.scala 22:35]
  wire [1:0] _GEN_0 = io_reset ? 2'h0 : state; // @[dut.scala 25:18 26:11 21:22]
  wire [1:0] _GEN_1 = io_reset ? 2'h0 : preservedDirection; // @[dut.scala 25:18 27:24 22:35]
  wire  _T_3 = ~io_ground; // @[dut.scala 33:12]
  wire  _T_4 = io_bump_left & io_bump_right; // @[dut.scala 36:49]
  wire [1:0] _GEN_5 = io_bump_right | _T_4 ? 2'h0 : _GEN_0; // @[dut.scala 45:69 46:15]
  wire [1:0] _GEN_8 = io_ground ? preservedDirection : _GEN_0; // @[dut.scala 52:23 53:15]
  assign io_walk_left = state == 2'h0; // @[dut.scala 59:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 60:27]
  assign io_aaah = state == 2'h2; // @[dut.scala 61:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:22]
      state <= 2'h0; // @[dut.scala 21:22]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (~io_ground) begin // @[dut.scala 33:24]
        state <= 2'h2; // @[dut.scala 34:15]
      end else if (io_bump_left | io_bump_left & io_bump_right) begin // @[dut.scala 36:68]
        state <= 2'h1; // @[dut.scala 37:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      if (_T_3) begin // @[dut.scala 42:24]
        state <= 2'h2; // @[dut.scala 43:15]
      end else begin
        state <= _GEN_5;
      end
    end else if (2'h2 == state) begin // @[dut.scala 31:17]
      state <= _GEN_8;
    end else begin
      state <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 22:35]
      preservedDirection <= 2'h0; // @[dut.scala 22:35]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (~io_ground) begin // @[dut.scala 33:24]
        preservedDirection <= 2'h0; // @[dut.scala 35:28]
      end else begin
        preservedDirection <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      if (_T_3) begin // @[dut.scala 42:24]
        preservedDirection <= 2'h1; // @[dut.scala 44:28]
      end else begin
        preservedDirection <= _GEN_1;
      end
    end else begin
      preservedDirection <= _GEN_1;
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
  _RAND_1 = {1{`RANDOM}};
  preservedDirection = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
