module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevSensorState; // @[dut.scala 15:32]
  wire  _GEN_1 = 3'h1 == io_s | 3'h0 == io_s; // @[dut.scala 36:18 44:16]
  wire  _GEN_2 = 3'h1 == io_s ? 1'h0 : 3'h0 == io_s; // @[dut.scala 18:10 36:18]
  wire  _GEN_3 = 3'h3 == io_s | _GEN_1; // @[dut.scala 36:18 41:16]
  wire  _GEN_4 = 3'h3 == io_s ? 1'h0 : _GEN_1; // @[dut.scala 19:10 36:18]
  wire  _GEN_5 = 3'h3 == io_s ? 1'h0 : _GEN_2; // @[dut.scala 18:10 36:18]
  wire  _GEN_6 = 3'h7 == io_s ? 1'h0 : _GEN_3; // @[dut.scala 20:10 36:18]
  wire  _GEN_7 = 3'h7 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 19:10 36:18]
  wire  _GEN_8 = 3'h7 == io_s ? 1'h0 : _GEN_5; // @[dut.scala 18:10 36:18]
  assign io_fr3 = io_reset | _GEN_8; // @[dut.scala 24:18 25:12]
  assign io_fr2 = io_reset | _GEN_7; // @[dut.scala 24:18 26:12]
  assign io_fr1 = io_reset | _GEN_6; // @[dut.scala 24:18 27:12]
  assign io_dfr = io_reset | prevSensorState < io_s; // @[dut.scala 24:18 28:12 55:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:32]
      prevSensorState <= 3'h0; // @[dut.scala 15:32]
    end else if (io_reset) begin // @[dut.scala 24:18]
      prevSensorState <= 3'h0; // @[dut.scala 29:21]
    end else begin
      prevSensorState <= io_s; // @[dut.scala 56:21]
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
  prevSensorState = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
