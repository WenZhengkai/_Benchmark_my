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
  reg [1:0] state; // @[dut.scala 20:22]
  reg [1:0] prevState; // @[dut.scala 21:26]
  wire [1:0] _GEN_0 = io_reset ? 2'h0 : state; // @[dut.scala 25:18 26:11 20:22]
  wire [1:0] _GEN_2 = state == 2'h2 & io_ground ? prevState : _GEN_0; // @[dut.scala 34:50 36:11]
  wire [1:0] _GEN_4 = ~io_ground ? 2'h2 : _GEN_2; // @[dut.scala 31:20 33:11]
  wire  _T_3 = state == 2'h0; // @[dut.scala 40:27]
  wire  _T_6 = state == 2'h1; // @[dut.scala 42:34]
  wire [1:0] _GEN_5 = _T_6 ? 2'h0 : _GEN_4; // @[dut.scala 48:44 49:13]
  wire [1:0] _GEN_6 = _T_3 ? 2'h1 : _GEN_5; // @[dut.scala 46:36 47:13]
  assign io_walk_left = state == 2'h0; // @[dut.scala 54:26]
  assign io_walk_right = state == 2'h1; // @[dut.scala 55:27]
  assign io_aaah = state == 2'h2; // @[dut.scala 56:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:22]
      state <= 2'h0; // @[dut.scala 20:22]
    end else if (io_ground & state == 2'h0 & io_bump_left) begin // @[dut.scala 40:63]
      state <= 2'h1; // @[dut.scala 41:11]
    end else if (io_ground & state == 2'h1 & io_bump_right) begin // @[dut.scala 42:72]
      state <= 2'h0; // @[dut.scala 43:11]
    end else if (io_ground & io_bump_left & io_bump_right) begin // @[dut.scala 44:59]
      state <= _GEN_6;
    end else begin
      state <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 21:26]
      prevState <= 2'h0; // @[dut.scala 21:26]
    end else if (~io_ground) begin // @[dut.scala 31:20]
      prevState <= state; // @[dut.scala 32:15]
    end else if (io_reset) begin // @[dut.scala 25:18]
      prevState <= 2'h0; // @[dut.scala 27:15]
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
  prevState = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
