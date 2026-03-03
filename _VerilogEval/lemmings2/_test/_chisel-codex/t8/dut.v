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
  reg [1:0] state; // @[dut.scala 21:12]
  wire  _T_3 = ~io_ground; // @[dut.scala 28:12]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : state; // @[dut.scala 54:23 55:19 24:30]
  assign io_walk_left = state == 2'h0; // @[dut.scala 63:27]
  assign io_walk_right = state == 2'h1; // @[dut.scala 64:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 65:47]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[dut.scala 26:17]
      state <= 2'h0; // @[dut.scala 28:24 29:19 30:32 32:19 24:30]
    end else if (2'h0 == state) begin // @[dut.scala 26:17]
      if (~io_ground) begin // @[dut.scala 37:24]
        state <= 2'h2; // @[dut.scala 38:19]
      end else if (io_bump_left) begin // @[dut.scala 39:33]
        state <= 2'h1; // @[dut.scala 41:19]
      end
    end else if (2'h1 == state) begin // @[dut.scala 26:17]
      if (_T_3) begin // @[dut.scala 47:23]
        state <= 2'h3; // @[dut.scala 48:19]
      end else if (io_bump_right) begin // @[dut.scala 24:30]
        state <= 2'h0;
      end
    end else if (2'h2 == state) begin // @[dut.scala 26:17]
      if (io_ground) begin
        state <= 2'h0;
      end
    end else if (2'h3 == state) begin // @[dut.scala 24:30]
      state <= _GEN_5;
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
