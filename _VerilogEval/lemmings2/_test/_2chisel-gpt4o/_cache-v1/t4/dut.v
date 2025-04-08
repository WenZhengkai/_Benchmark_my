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
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 18:22]
  reg [1:0] savedWalkingDirection; // @[dut.scala 19:38]
  wire  _T_1 = ~io_ground; // @[dut.scala 29:12]
  wire  _T_2 = io_bump_left | io_bump_right; // @[dut.scala 32:31]
  wire [1:0] _GEN_3 = _T_2 ? 2'h0 : state; // @[dut.scala 42:49 43:15 18:22]
  wire [1:0] _GEN_6 = io_ground ? savedWalkingDirection : state; // @[dut.scala 49:23 50:15 18:22]
  wire  _GEN_12 = 2'h1 == state ? 1'h0 : 2'h2 == state; // @[dut.scala 24:11 26:17]
  assign io_walk_left = 2'h0 == state; // @[dut.scala 26:17]
  assign io_walk_right = 2'h0 == state ? 1'h0 : 2'h1 == state; // @[dut.scala 23:17 26:17]
  assign io_aaah = 2'h0 == state ? 1'h0 : _GEN_12; // @[dut.scala 24:11 26:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h0; // @[dut.scala 18:22]
    end else if (2'h0 == state) begin // @[dut.scala 26:17]
      if (~io_ground) begin // @[dut.scala 29:24]
        state <= 2'h2; // @[dut.scala 30:15]
      end else if (io_bump_left | io_bump_right) begin // @[dut.scala 32:49]
        state <= 2'h1; // @[dut.scala 33:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 26:17]
      if (_T_1) begin // @[dut.scala 39:24]
        state <= 2'h2; // @[dut.scala 40:15]
      end else begin
        state <= _GEN_3;
      end
    end else if (2'h2 == state) begin // @[dut.scala 26:17]
      state <= _GEN_6;
    end
    if (reset) begin // @[dut.scala 19:38]
      savedWalkingDirection <= 2'h0; // @[dut.scala 19:38]
    end else if (2'h0 == state) begin // @[dut.scala 26:17]
      if (~io_ground) begin // @[dut.scala 29:24]
        savedWalkingDirection <= 2'h0; // @[dut.scala 31:31]
      end
    end else if (2'h1 == state) begin // @[dut.scala 26:17]
      if (_T_1) begin // @[dut.scala 39:24]
        savedWalkingDirection <= 2'h1; // @[dut.scala 41:31]
      end
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
  savedWalkingDirection = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
