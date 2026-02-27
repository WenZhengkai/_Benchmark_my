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
  reg [1:0] state; // @[dut.scala 22:22]
  wire  _T_1 = ~io_ground; // @[dut.scala 32:12]
  wire  _T_2 = io_bump_left | io_bump_right; // @[dut.scala 34:31]
  wire [1:0] _GEN_2 = _T_2 ? 2'h0 : state; // @[dut.scala 42:49 43:15 22:22]
  reg [1:0] state_REG; // @[dut.scala 50:25]
  wire [1:0] _GEN_4 = io_ground ? state_REG : state; // @[dut.scala 48:23 50:15 22:22]
  assign io_walk_left = state == 2'h0; // @[dut.scala 25:25]
  assign io_walk_right = state == 2'h1; // @[dut.scala 26:26]
  assign io_aaah = state == 2'h2; // @[dut.scala 27:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:22]
      state <= 2'h0; // @[dut.scala 22:22]
    end else if (2'h0 == state) begin // @[dut.scala 30:17]
      if (~io_ground) begin // @[dut.scala 32:24]
        state <= 2'h2; // @[dut.scala 33:15]
      end else if (io_bump_left | io_bump_right) begin // @[dut.scala 34:49]
        state <= 2'h1; // @[dut.scala 35:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 30:17]
      if (_T_1) begin // @[dut.scala 40:24]
        state <= 2'h2; // @[dut.scala 41:15]
      end else begin
        state <= _GEN_2;
      end
    end else if (2'h2 == state) begin // @[dut.scala 30:17]
      state <= _GEN_4;
    end
    state_REG <= state; // @[dut.scala 50:25]
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
  state_REG = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
