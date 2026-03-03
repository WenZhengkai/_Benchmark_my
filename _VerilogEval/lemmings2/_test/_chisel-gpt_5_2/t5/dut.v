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
  reg [1:0] state; // @[dut.scala 22:24]
  wire  _T_4 = ~io_ground; // @[dut.scala 27:14]
  wire  _T_5 = io_bump_left | io_bump_right; // @[dut.scala 30:33]
  wire  _GEN_2 = _T_5 ? 1'h0 : 1'h1; // @[dut.scala 41:51 42:17 44:17]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : 2'h3; // @[dut.scala 59:25 60:17 62:17]
  assign io_walk_left = state == 2'h0; // @[dut.scala 68:29]
  assign io_walk_right = state == 2'h1; // @[dut.scala 69:29]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 70:43]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[dut.scala 25:19]
      state <= 2'h0; // @[dut.scala 27:26 29:17]
    end else if (2'h0 == state) begin // @[dut.scala 25:19]
      if (~io_ground) begin // @[dut.scala 39:26]
        state <= 2'h2; // @[dut.scala 40:17]
      end else begin
        state <= {{1'd0}, _T_5};
      end
    end else if (2'h1 == state) begin // @[dut.scala 25:19]
      if (_T_4) begin // @[dut.scala 51:25]
        state <= 2'h3; // @[dut.scala 52:17]
      end else begin
        state <= {{1'd0}, _GEN_2}; // @[dut.scala 54:17]
      end
    end else if (2'h2 == state) begin // @[dut.scala 25:19]
      if (io_ground) begin
        state <= 2'h0;
      end else begin
        state <= 2'h2;
      end
    end else if (2'h3 == state) begin // @[dut.scala 22:24]
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
