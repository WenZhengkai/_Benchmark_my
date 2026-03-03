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
  wire [1:0] _GEN_1 = 3'h1 == io_s ? 2'h2 : 2'h3; // @[dut.scala 38:16 41:29]
  wire [1:0] _GEN_2 = 3'h3 == io_s ? 2'h1 : _GEN_1; // @[dut.scala 38:16 40:29]
  wire [1:0] curLevel = 3'h7 == io_s ? 2'h0 : _GEN_2; // @[dut.scala 38:16 39:29]
  reg [1:0] prevLevel; // @[dut.scala 46:26]
  wire  dfrNext = curLevel < prevLevel; // @[dut.scala 49:25]
  wire  _GEN_5 = 2'h2 == curLevel | 2'h3 == curLevel; // @[dut.scala 56:20 64:14]
  wire  _GEN_6 = 2'h2 == curLevel ? 1'h0 : 2'h3 == curLevel; // @[dut.scala 56:20 64:52]
  wire  _GEN_7 = 2'h1 == curLevel | _GEN_5; // @[dut.scala 56:20 61:14]
  wire  _GEN_8 = 2'h1 == curLevel ? 1'h0 : _GEN_5; // @[dut.scala 56:20 61:33]
  wire  _GEN_9 = 2'h1 == curLevel ? 1'h0 : _GEN_6; // @[dut.scala 56:20 61:52]
  wire  fr1Nom = 2'h0 == curLevel ? 1'h0 : _GEN_7; // @[dut.scala 56:20 58:14]
  wire  fr2Nom = 2'h0 == curLevel ? 1'h0 : _GEN_8; // @[dut.scala 56:20 58:33]
  wire  fr3Nom = 2'h0 == curLevel ? 1'h0 : _GEN_9; // @[dut.scala 56:20 58:52]
  assign io_fr3 = reset | fr3Nom; // @[dut.scala 77:22 81:12 89:12]
  assign io_fr2 = reset | fr2Nom; // @[dut.scala 77:22 80:12 88:12]
  assign io_fr1 = reset | fr1Nom; // @[dut.scala 77:22 79:12 87:12]
  assign io_dfr = reset | dfrNext; // @[dut.scala 77:22 82:12 90:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 46:26]
      prevLevel <= 2'h3; // @[dut.scala 46:26]
    end else if (reset) begin // @[dut.scala 77:22]
      prevLevel <= 2'h3; // @[dut.scala 78:15]
    end else if (3'h7 == io_s) begin // @[dut.scala 38:16]
      prevLevel <= 2'h0; // @[dut.scala 39:29]
    end else if (3'h3 == io_s) begin // @[dut.scala 38:16]
      prevLevel <= 2'h1; // @[dut.scala 40:29]
    end else begin
      prevLevel <= _GEN_1;
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
  prevLevel = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
