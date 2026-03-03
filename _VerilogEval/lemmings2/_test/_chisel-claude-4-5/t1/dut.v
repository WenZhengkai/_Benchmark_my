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
  wire  _T_1 = ~io_ground; // @[dut.scala 23:12]
  wire [1:0] _GEN_0 = io_bump_right ? 2'h0 : state; // @[dut.scala 27:33 28:15 18:22]
  wire [1:0] _GEN_3 = io_bump_left ? 2'h1 : state; // @[dut.scala 37:32 38:15 18:22]
  wire [1:0] _GEN_4 = io_bump_right ? 2'h0 : _GEN_3; // @[dut.scala 35:33 36:15]
  wire [1:0] _GEN_6 = io_ground ? 2'h0 : state; // @[dut.scala 43:23 44:15 18:22]
  wire [1:0] _GEN_7 = io_ground ? 2'h1 : state; // @[dut.scala 49:23 50:15 18:22]
  wire [1:0] _GEN_8 = 2'h3 == state ? _GEN_7 : state; // @[dut.scala 21:17 18:22]
  assign io_walk_left = state == 2'h0; // @[dut.scala 56:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 57:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 58:36]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h0; // @[dut.scala 18:22]
    end else if (2'h0 == state) begin // @[dut.scala 21:17]
      if (~io_ground) begin // @[dut.scala 23:24]
        state <= 2'h2; // @[dut.scala 24:15]
      end else if (io_bump_left) begin // @[dut.scala 25:32]
        state <= 2'h1; // @[dut.scala 26:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 21:17]
      if (_T_1) begin // @[dut.scala 33:24]
        state <= 2'h3; // @[dut.scala 34:15]
      end else begin
        state <= _GEN_4;
      end
    end else if (2'h2 == state) begin // @[dut.scala 21:17]
      state <= _GEN_6;
    end else begin
      state <= _GEN_8;
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
