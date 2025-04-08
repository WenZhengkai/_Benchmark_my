module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevSensors; // @[dut.scala 14:28]
  wire  _T_2 = prevSensors < io_s; // @[dut.scala 47:26]
  wire  _GEN_4 = 3'h1 == io_s ? 1'h0 : 3'h0 == io_s; // @[dut.scala 35:18 54:16]
  wire  _GEN_5 = 3'h1 == io_s | 3'h0 == io_s; // @[dut.scala 35:18 55:16]
  wire  _GEN_7 = 3'h3 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 35:18 44:16]
  wire  _GEN_8 = 3'h3 == io_s ? 1'h0 : _GEN_5; // @[dut.scala 35:18 45:16]
  wire  _GEN_9 = 3'h3 == io_s | _GEN_5; // @[dut.scala 35:18 46:16]
  wire  _GEN_10 = 3'h3 == io_s ? _T_2 : 3'h1 == io_s & _T_2; // @[dut.scala 35:18]
  wire  _GEN_11 = 3'h7 == io_s ? 1'h0 : _GEN_7; // @[dut.scala 35:18 38:16]
  wire  _GEN_12 = 3'h7 == io_s ? 1'h0 : _GEN_8; // @[dut.scala 35:18 39:16]
  wire  _GEN_13 = 3'h7 == io_s ? 1'h0 : _GEN_9; // @[dut.scala 35:18 40:16]
  wire  _GEN_14 = 3'h7 == io_s ? 1'h0 : _GEN_10; // @[dut.scala 35:18 41:16]
  assign io_fr3 = reset | _GEN_11; // @[dut.scala 24:21 26:12]
  assign io_fr2 = reset | _GEN_12; // @[dut.scala 24:21 27:12]
  assign io_fr1 = reset | _GEN_13; // @[dut.scala 24:21 28:12]
  assign io_dfr = reset | _GEN_14; // @[dut.scala 24:21 29:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:28]
      prevSensors <= 3'h0; // @[dut.scala 14:28]
    end else if (reset) begin // @[dut.scala 24:21]
      prevSensors <= 3'h0; // @[dut.scala 25:17]
    end else begin
      prevSensors <= io_s; // @[dut.scala 32:17]
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
  prevSensors = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
