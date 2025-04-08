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
  reg [1:0] state; // @[dut.scala 19:22]
  reg [1:0] preservedWalkingDirection; // @[dut.scala 20:42]
  wire [1:0] _GEN_0 = io_reset ? 2'h0 : state; // @[dut.scala 23:18 24:11 19:22]
  wire [1:0] _GEN_1 = io_reset ? 2'h0 : preservedWalkingDirection; // @[dut.scala 23:18 25:31 20:42]
  wire  _T_3 = ~io_ground; // @[dut.scala 31:12]
  wire  _T_4 = io_bump_left & io_bump_right; // @[dut.scala 34:31]
  wire [1:0] _GEN_2 = io_bump_left ? 2'h1 : _GEN_0; // @[dut.scala 36:32 37:15]
  wire [1:0] _GEN_6 = io_bump_right ? 2'h0 : _GEN_0; // @[dut.scala 46:33 47:15]
  wire [1:0] _GEN_7 = _T_4 ? 2'h0 : _GEN_6; // @[dut.scala 44:49 45:15]
  wire [1:0] _GEN_10 = io_ground ? preservedWalkingDirection : _GEN_0; // @[dut.scala 51:23 52:15]
  assign io_walk_left = state == 2'h0; // @[dut.scala 58:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 59:27]
  assign io_aaah = state == 2'h2; // @[dut.scala 60:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:22]
      state <= 2'h0; // @[dut.scala 19:22]
    end else if (2'h0 == state) begin // @[dut.scala 29:17]
      if (~io_ground) begin // @[dut.scala 31:24]
        state <= 2'h2; // @[dut.scala 32:15]
      end else if (io_bump_left & io_bump_right) begin // @[dut.scala 34:49]
        state <= 2'h1; // @[dut.scala 35:15]
      end else begin
        state <= _GEN_2;
      end
    end else if (2'h1 == state) begin // @[dut.scala 29:17]
      if (_T_3) begin // @[dut.scala 41:24]
        state <= 2'h2; // @[dut.scala 42:15]
      end else begin
        state <= _GEN_7;
      end
    end else if (2'h2 == state) begin // @[dut.scala 29:17]
      state <= _GEN_10;
    end else begin
      state <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 20:42]
      preservedWalkingDirection <= 2'h0; // @[dut.scala 20:42]
    end else if (2'h0 == state) begin // @[dut.scala 29:17]
      if (~io_ground) begin // @[dut.scala 31:24]
        preservedWalkingDirection <= 2'h0; // @[dut.scala 33:35]
      end else begin
        preservedWalkingDirection <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[dut.scala 29:17]
      if (_T_3) begin // @[dut.scala 41:24]
        preservedWalkingDirection <= 2'h1; // @[dut.scala 43:35]
      end else begin
        preservedWalkingDirection <= _GEN_1;
      end
    end else begin
      preservedWalkingDirection <= _GEN_1;
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
  preservedWalkingDirection = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
