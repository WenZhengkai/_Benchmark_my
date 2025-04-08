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
  reg [1:0] preservedDirection; // @[dut.scala 20:35]
  wire  _T_2 = 2'h0 == state; // @[dut.scala 33:19]
  wire  _T_3 = ~io_ground; // @[dut.scala 35:14]
  wire [1:0] _GEN_0 = io_bump_right ? 2'h1 : state; // @[dut.scala 38:36 39:17 19:22]
  wire  _T_6 = 2'h1 == state; // @[dut.scala 33:19]
  wire [1:0] _GEN_3 = io_bump_left ? 2'h0 : state; // @[dut.scala 46:35 47:17 19:22]
  wire [1:0] _GEN_4 = _T_3 ? 2'h2 : _GEN_3; // @[dut.scala 43:26 44:17]
  wire [1:0] _GEN_5 = _T_3 ? 2'h1 : preservedDirection; // @[dut.scala 43:26 45:30 20:35]
  wire  _T_10 = 2'h2 == state; // @[dut.scala 33:19]
  wire [1:0] _GEN_6 = io_ground ? preservedDirection : state; // @[dut.scala 51:25 52:17 19:22]
  wire [1:0] _GEN_7 = 2'h2 == state ? _GEN_6 : state; // @[dut.scala 33:19 19:22]
  wire  _GEN_16 = _T_6 ? 1'h0 : _T_10; // @[dut.scala 25:11 59:17]
  assign io_walk_left = 2'h0 == state; // @[dut.scala 59:17]
  assign io_walk_right = _T_2 ? 1'h0 : _T_6; // @[dut.scala 24:17 59:17]
  assign io_aaah = _T_2 ? 1'h0 : _GEN_16; // @[dut.scala 25:11 59:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:22]
      state <= 2'h0; // @[dut.scala 19:22]
    end else if (io_reset) begin // @[dut.scala 28:18]
      state <= 2'h0; // @[dut.scala 29:11]
    end else if (2'h0 == state) begin // @[dut.scala 33:19]
      if (~io_ground) begin // @[dut.scala 35:26]
        state <= 2'h2; // @[dut.scala 36:17]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 33:19]
      state <= _GEN_4;
    end else begin
      state <= _GEN_7;
    end
    if (reset) begin // @[dut.scala 20:35]
      preservedDirection <= 2'h0; // @[dut.scala 20:35]
    end else if (io_reset) begin // @[dut.scala 28:18]
      preservedDirection <= 2'h0; // @[dut.scala 30:24]
    end else if (2'h0 == state) begin // @[dut.scala 33:19]
      if (~io_ground) begin // @[dut.scala 35:26]
        preservedDirection <= 2'h0; // @[dut.scala 37:30]
      end
    end else if (2'h1 == state) begin // @[dut.scala 33:19]
      preservedDirection <= _GEN_5;
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
