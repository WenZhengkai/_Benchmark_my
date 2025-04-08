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
  reg [1:0] state; // @[dut.scala 20:22]
  wire  _T_3 = ~io_ground; // @[dut.scala 25:12]
  wire [1:0] _GEN_2 = io_bump_right ? 2'h0 : state; // @[dut.scala 35:33 36:15 20:22]
  wire [1:0] _GEN_4 = io_ground ? 2'h0 : state; // @[dut.scala 41:23 42:15 20:22]
  wire [1:0] _GEN_5 = io_ground ? 2'h1 : state; // @[dut.scala 47:23 48:15 20:22]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 23:17 20:22]
  assign io_walk_left = state == 2'h0; // @[dut.scala 55:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 56:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 57:40]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:22]
      state <= 2'h0; // @[dut.scala 20:22]
    end else if (2'h0 == state) begin // @[dut.scala 23:17]
      if (~io_ground) begin // @[dut.scala 25:24]
        state <= 2'h2; // @[dut.scala 26:15]
      end else if (io_bump_left) begin // @[dut.scala 27:32]
        state <= 2'h1; // @[dut.scala 28:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 23:17]
      if (_T_3) begin // @[dut.scala 33:24]
        state <= 2'h3; // @[dut.scala 34:15]
      end else begin
        state <= _GEN_2;
      end
    end else if (2'h2 == state) begin // @[dut.scala 23:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_6;
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
