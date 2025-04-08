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
  reg  preservedDirection; // @[dut.scala 22:35]
  wire  _T_3 = ~io_ground; // @[dut.scala 35:14]
  wire  _T_4 = io_bump_left & io_bump_right; // @[dut.scala 38:33]
  wire [1:0] _GEN_0 = io_bump_left ? 2'h1 : state; // @[dut.scala 40:34 41:17 21:22]
  wire [1:0] _GEN_1 = io_bump_left & io_bump_right ? 2'h1 : _GEN_0; // @[dut.scala 38:51 39:17]
  wire [1:0] _GEN_4 = io_bump_right ? 2'h0 : state; // @[dut.scala 50:35 51:17 21:22]
  wire [1:0] _GEN_5 = _T_4 ? 2'h0 : _GEN_4; // @[dut.scala 48:51 49:17]
  wire [1:0] _GEN_6 = _T_3 ? 2'h2 : _GEN_5; // @[dut.scala 45:26 46:17]
  wire  _GEN_7 = _T_3 | preservedDirection; // @[dut.scala 45:26 47:30 22:35]
  wire [1:0] _GEN_8 = io_ground ? {{1'd0}, preservedDirection} : state; // @[dut.scala 55:25 56:17 21:22]
  wire [1:0] _GEN_9 = 2'h2 == state ? _GEN_8 : state; // @[dut.scala 33:19 21:22]
  assign io_walk_left = state == 2'h0; // @[dut.scala 63:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 64:27]
  assign io_aaah = state == 2'h2; // @[dut.scala 65:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:22]
      state <= 2'h0; // @[dut.scala 21:22]
    end else if (io_reset) begin // @[dut.scala 28:18]
      state <= 2'h0; // @[dut.scala 29:11]
    end else if (2'h0 == state) begin // @[dut.scala 33:19]
      if (~io_ground) begin // @[dut.scala 35:26]
        state <= 2'h2; // @[dut.scala 36:17]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[dut.scala 33:19]
      state <= _GEN_6;
    end else begin
      state <= _GEN_9;
    end
    if (reset) begin // @[dut.scala 22:35]
      preservedDirection <= 1'h0; // @[dut.scala 22:35]
    end else if (io_reset) begin // @[dut.scala 28:18]
      preservedDirection <= 1'h0; // @[dut.scala 30:24]
    end else if (2'h0 == state) begin // @[dut.scala 33:19]
      if (~io_ground) begin // @[dut.scala 35:26]
        preservedDirection <= 1'h0; // @[dut.scala 37:30]
      end
    end else if (2'h1 == state) begin // @[dut.scala 33:19]
      preservedDirection <= _GEN_7;
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
  preservedDirection = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
