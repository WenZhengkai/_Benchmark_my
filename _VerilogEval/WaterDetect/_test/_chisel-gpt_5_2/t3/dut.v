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
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _currLevel_T_1 = 3'h7 == io_s ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _currLevel_T_3 = 3'h3 == io_s ? 2'h2 : _currLevel_T_1; // @[Mux.scala 81:58]
  wire [1:0] _currLevel_T_5 = 3'h1 == io_s ? 2'h1 : _currLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] currLevel = 3'h0 == io_s ? 2'h0 : _currLevel_T_5; // @[Mux.scala 81:58]
  reg [2:0] prevS; // @[dut.scala 45:22]
  wire [1:0] _prevLevel_T_1 = 3'h7 == prevS ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _prevLevel_T_3 = 3'h3 == prevS ? 2'h2 : _prevLevel_T_1; // @[Mux.scala 81:58]
  wire [1:0] _prevLevel_T_5 = 3'h1 == prevS ? 2'h1 : _prevLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] prevLevel = 3'h0 == prevS ? 2'h0 : _prevLevel_T_5; // @[Mux.scala 81:58]
  wire  _GEN_3 = 2'h1 == currLevel | 2'h0 == currLevel; // @[dut.scala 61:21 69:15]
  wire  _GEN_4 = 2'h1 == currLevel ? 1'h0 : 2'h0 == currLevel; // @[dut.scala 61:21 69:55]
  wire  _GEN_5 = 2'h2 == currLevel | _GEN_3; // @[dut.scala 61:21 66:15]
  wire  _GEN_6 = 2'h2 == currLevel ? 1'h0 : _GEN_3; // @[dut.scala 61:21 66:35]
  wire  _GEN_7 = 2'h2 == currLevel ? 1'h0 : _GEN_4; // @[dut.scala 61:21 66:55]
  wire  nom_fr1 = 2'h3 == currLevel ? 1'h0 : _GEN_5; // @[dut.scala 61:21 63:15]
  wire  nom_fr2 = 2'h3 == currLevel ? 1'h0 : _GEN_6; // @[dut.scala 61:21 63:35]
  wire  nom_fr3 = 2'h3 == currLevel ? 1'h0 : _GEN_7; // @[dut.scala 61:21 63:55]
  wire  dfrComb = currLevel > prevLevel; // @[dut.scala 79:41]
  reg  fr1_r; // @[dut.scala 83:22]
  reg  fr2_r; // @[dut.scala 84:22]
  reg  fr3_r; // @[dut.scala 85:22]
  reg  dfr_r; // @[dut.scala 86:22]
  wire  _GEN_11 = io_reset | nom_fr1; // @[dut.scala 88:19 90:11 95:11]
  wire  _GEN_12 = io_reset | nom_fr2; // @[dut.scala 88:19 91:11 96:11]
  wire  _GEN_13 = io_reset | nom_fr3; // @[dut.scala 88:19 92:11 97:11]
  wire  _GEN_14 = io_reset | dfrComb; // @[dut.scala 88:19 93:11 98:11]
  assign io_fr3 = fr3_r; // @[dut.scala 103:10]
  assign io_fr2 = fr2_r; // @[dut.scala 102:10]
  assign io_fr1 = fr1_r; // @[dut.scala 101:10]
  assign io_dfr = dfr_r; // @[dut.scala 104:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 45:22]
      prevS <= 3'h0; // @[dut.scala 45:22]
    end else if (io_reset) begin // @[dut.scala 48:19]
      prevS <= 3'h0; // @[dut.scala 49:11]
    end else if (io_s != prevS) begin // @[dut.scala 50:32]
      prevS <= io_s; // @[dut.scala 51:11]
    end
    fr1_r <= reset | _GEN_11; // @[dut.scala 83:{22,22}]
    fr2_r <= reset | _GEN_12; // @[dut.scala 84:{22,22}]
    fr3_r <= reset | _GEN_13; // @[dut.scala 85:{22,22}]
    dfr_r <= reset | _GEN_14; // @[dut.scala 86:{22,22}]
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
  fr1_r = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr3_r = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfr_r = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
