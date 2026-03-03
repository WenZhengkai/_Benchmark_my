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
  reg [1:0] state; // @[dut.scala 18:54]
  wire  _T_1 = ~io_ground; // @[dut.scala 22:12]
  wire  _T_2 = io_bump_left | io_bump_right; // @[dut.scala 24:31]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : 2'h3; // @[dut.scala 50:23 51:15 53:15]
  assign io_walk_left = state == 2'h0; // @[dut.scala 59:27]
  assign io_walk_right = state == 2'h1; // @[dut.scala 60:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 61:39]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[dut.scala 20:17]
      state <= 2'h0; // @[dut.scala 22:24 23:15 24:49 25:15 27:15]
    end else if (2'h0 == state) begin // @[dut.scala 20:17]
      if (~io_ground) begin // @[dut.scala 32:24]
        state <= 2'h2; // @[dut.scala 33:15]
      end else if (io_bump_left | io_bump_right) begin // @[dut.scala 34:49]
        state <= 2'h1; // @[dut.scala 35:15]
      end else begin
        state <= 2'h0; // @[dut.scala 37:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 20:17]
      if (_T_1) begin // @[dut.scala 42:23]
        state <= 2'h3; // @[dut.scala 43:15]
      end else if (_T_2) begin // @[dut.scala 45:15]
        state <= 2'h0;
      end else begin
        state <= 2'h1;
      end
    end else if (2'h2 == state) begin // @[dut.scala 20:17]
      if (io_ground) begin
        state <= 2'h0;
      end else begin
        state <= 2'h2;
      end
    end else if (2'h3 == state) begin // @[dut.scala 18:54]
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
