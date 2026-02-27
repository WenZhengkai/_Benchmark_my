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
  reg [1:0] state; // @[dut.scala 19:22]
  wire  _T_2 = 2'h0 == state; // @[dut.scala 29:19]
  wire  _T_5 = 2'h1 == state; // @[dut.scala 29:19]
  wire [1:0] _GEN_1 = io_bump_right ? 2'h0 : state; // @[dut.scala 36:29 37:17 19:22]
  wire [1:0] _GEN_2 = 2'h3 == state ? 2'h1 : state; // @[dut.scala 29:19 44:15 19:22]
  wire [1:0] _GEN_3 = 2'h2 == state ? 2'h0 : _GEN_2; // @[dut.scala 29:19 41:15]
  assign io_walk_left = state == 2'h0; // @[dut.scala 22:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 23:27]
  assign io_aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 24:41]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:22]
      state <= 2'h0; // @[dut.scala 19:22]
    end else if (io_ground) begin // @[dut.scala 27:19]
      if (2'h0 == state) begin // @[dut.scala 29:19]
        if (io_bump_left) begin // @[dut.scala 31:28]
          state <= 2'h1; // @[dut.scala 32:17]
        end
      end else if (2'h1 == state) begin // @[dut.scala 29:19]
        state <= _GEN_1;
      end else begin
        state <= _GEN_3;
      end
    end else if (_T_2) begin // @[dut.scala 49:19]
      state <= 2'h2; // @[dut.scala 51:15]
    end else if (_T_5) begin // @[dut.scala 49:19]
      state <= 2'h3; // @[dut.scala 54:15]
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
