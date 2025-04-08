module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_reset,
  output       io_fr1,
  output       io_fr2,
  output       io_fr3,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevLevel; // @[dut.scala 27:26]
  wire  _io_dfr_T_1 = prevLevel == 3'h0; // @[dut.scala 51:54]
  wire  _T_3 = io_s == 3'h0; // @[dut.scala 58:22]
  wire  _GEN_1 = io_s == 3'h1 | _T_3; // @[dut.scala 52:36 54:14]
  wire  _GEN_2 = io_s == 3'h1 ? 1'h0 : _T_3; // @[dut.scala 52:36 56:14]
  wire  _GEN_3 = io_s == 3'h1 ? _io_dfr_T_1 : _T_3; // @[dut.scala 52:36 57:14]
  wire  _GEN_4 = io_s == 3'h3 | _GEN_1; // @[dut.scala 46:36 48:14]
  wire  _GEN_5 = io_s == 3'h3 ? 1'h0 : _GEN_1; // @[dut.scala 46:36 49:14]
  wire  _GEN_6 = io_s == 3'h3 ? 1'h0 : _GEN_2; // @[dut.scala 46:36 50:14]
  wire  _GEN_7 = io_s == 3'h3 ? prevLevel == 3'h1 | prevLevel == 3'h0 : _GEN_3; // @[dut.scala 46:36 51:14]
  wire  _GEN_8 = io_s == 3'h7 ? 1'h0 : _GEN_4; // @[dut.scala 40:29 42:14]
  wire  _GEN_9 = io_s == 3'h7 ? 1'h0 : _GEN_5; // @[dut.scala 40:29 43:14]
  wire  _GEN_10 = io_s == 3'h7 ? 1'h0 : _GEN_6; // @[dut.scala 40:29 44:14]
  wire  _GEN_11 = io_s == 3'h7 ? 1'h0 : _GEN_7; // @[dut.scala 40:29 45:14]
  assign io_fr1 = io_reset | _GEN_8; // @[dut.scala 28:18 31:12]
  assign io_fr2 = io_reset | _GEN_9; // @[dut.scala 28:18 32:12]
  assign io_fr3 = io_reset | _GEN_10; // @[dut.scala 28:18 33:12]
  assign io_dfr = io_reset | _GEN_11; // @[dut.scala 28:18 34:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 27:26]
      prevLevel <= 3'h0; // @[dut.scala 27:26]
    end else if (io_reset) begin // @[dut.scala 28:18]
      prevLevel <= 3'h0; // @[dut.scala 30:15]
    end else begin
      prevLevel <= io_s; // @[dut.scala 37:15]
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
  prevLevel = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
