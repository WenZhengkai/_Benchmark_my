module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset_sync
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevS; // @[dut.scala 57:22]
  wire  _T = 3'h7 == io_s; // @[dut.scala 64:16]
  wire  _T_1 = 3'h3 == io_s; // @[dut.scala 64:16]
  wire  _T_2 = 3'h1 == io_s; // @[dut.scala 64:16]
  wire  _GEN_1 = 3'h1 == io_s | 3'h0 == io_s; // @[dut.scala 64:16 76:19]
  wire  _GEN_2 = 3'h1 == io_s ? 1'h0 : 3'h0 == io_s; // @[dut.scala 64:16 78:19]
  wire  _GEN_3 = 3'h3 == io_s | _GEN_1; // @[dut.scala 64:16 71:19]
  wire  _GEN_4 = 3'h3 == io_s ? 1'h0 : _GEN_1; // @[dut.scala 64:16 72:19]
  wire  _GEN_5 = 3'h3 == io_s ? 1'h0 : _GEN_2; // @[dut.scala 64:16 73:19]
  wire  sensorsChanged = io_s != prevS; // @[dut.scala 88:29]
  wire [1:0] _prevRank_T_3 = 3'h1 == prevS ? 2'h1 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _prevRank_T_5 = 3'h3 == prevS ? 2'h2 : _prevRank_T_3; // @[Mux.scala 81:58]
  wire [1:0] prevRank = 3'h7 == prevS ? 2'h3 : _prevRank_T_5; // @[Mux.scala 81:58]
  wire [1:0] _currRank_T_3 = _T_2 ? 2'h1 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _currRank_T_5 = _T_1 ? 2'h2 : _currRank_T_3; // @[Mux.scala 81:58]
  wire [1:0] currRank = _T ? 2'h3 : _currRank_T_5; // @[Mux.scala 81:58]
  reg  dfrReg; // @[dut.scala 95:23]
  wire  _GEN_9 = sensorsChanged ? prevRank < currRank : dfrReg; // @[dut.scala 100:26 101:14 95:23]
  wire  _GEN_12 = io_reset_sync | _GEN_9; // @[dut.scala 96:23 98:12]
  assign io_fr3 = 3'h7 == io_s ? 1'h0 : _GEN_5; // @[dut.scala 64:16 68:19]
  assign io_fr2 = 3'h7 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 64:16 67:19]
  assign io_fr1 = 3'h7 == io_s ? 1'h0 : _GEN_3; // @[dut.scala 64:16 66:19]
  assign io_dfr = dfrReg; // @[dut.scala 110:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 57:22]
      prevS <= 3'h0; // @[dut.scala 57:22]
    end else if (io_reset_sync) begin // @[dut.scala 96:23]
      prevS <= 3'h0; // @[dut.scala 97:12]
    end else if (sensorsChanged) begin // @[dut.scala 100:26]
      prevS <= io_s; // @[dut.scala 102:14]
    end
    dfrReg <= reset | _GEN_12; // @[dut.scala 95:{23,23}]
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
  prevS = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  dfrReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
