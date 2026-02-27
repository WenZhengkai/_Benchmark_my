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
  reg [1:0] stateReg; // @[dut.scala 18:25]
  reg  fr3Reg; // @[dut.scala 21:23]
  reg  fr2Reg; // @[dut.scala 22:23]
  reg  fr1Reg; // @[dut.scala 23:23]
  reg  dfrReg; // @[dut.scala 24:23]
  wire  _T = 2'h0 == stateReg; // @[dut.scala 41:22]
  wire  _T_1 = io_s == 3'h7; // @[dut.scala 43:19]
  wire  _T_2 = io_s == 3'h6; // @[dut.scala 45:25]
  wire [1:0] _GEN_0 = io_s == 3'h6 ? 2'h1 : 2'h2; // @[dut.scala 45:39 46:20 48:20]
  wire  _T_3 = 2'h1 == stateReg; // @[dut.scala 41:22]
  wire  _T_6 = io_s == 3'h4; // @[dut.scala 56:25]
  wire [1:0] _GEN_2 = io_s == 3'h4 ? 2'h2 : 2'h3; // @[dut.scala 56:39 57:20 59:20]
  wire [1:0] _GEN_3 = _T_2 ? 2'h1 : _GEN_2; // @[dut.scala 54:39 55:20]
  wire [1:0] _GEN_4 = _T_1 ? 2'h0 : _GEN_3; // @[dut.scala 52:33 53:20]
  wire  _T_7 = 2'h2 == stateReg; // @[dut.scala 41:22]
  wire  _T_11 = 2'h3 == stateReg; // @[dut.scala 41:22]
  wire [1:0] _GEN_11 = 2'h3 == stateReg ? _GEN_4 : stateReg; // @[dut.scala 41:22 18:25]
  wire [1:0] _GEN_12 = 2'h2 == stateReg ? _GEN_4 : _GEN_11; // @[dut.scala 41:22]
  wire  _GEN_15 = _T_11 | fr3Reg; // @[dut.scala 107:16 87:22 21:23]
  wire  _GEN_16 = _T_11 | fr2Reg; // @[dut.scala 108:16 87:22 22:23]
  wire  _GEN_17 = _T_11 | fr1Reg; // @[dut.scala 109:16 87:22 23:23]
  wire  _GEN_19 = _T_7 ? 1'h0 : _GEN_15; // @[dut.scala 101:16 87:22]
  wire  _GEN_20 = _T_7 | _GEN_16; // @[dut.scala 102:16 87:22]
  wire  _GEN_21 = _T_7 | _GEN_17; // @[dut.scala 103:16 87:22]
  wire  _GEN_23 = _T_3 ? 1'h0 : _GEN_19; // @[dut.scala 87:22 95:16]
  wire  _GEN_24 = _T_3 ? 1'h0 : _GEN_20; // @[dut.scala 87:22 96:16]
  wire  _GEN_25 = _T_3 | _GEN_21; // @[dut.scala 87:22 97:16]
  wire  _GEN_27 = _T ? 1'h0 : _GEN_23; // @[dut.scala 87:22 89:16]
  wire  _GEN_28 = _T ? 1'h0 : _GEN_24; // @[dut.scala 87:22 90:16]
  wire  _GEN_29 = _T ? 1'h0 : _GEN_25; // @[dut.scala 87:22 91:16]
  wire  _T_26 = _T_1 | _T_2 | _T_6; // @[dut.scala 116:51]
  wire  _GEN_32 = (stateReg == 2'h1 | stateReg == 2'h2) & _T_26; // @[dut.scala 115:64 122:14]
  wire  _GEN_34 = io_reset | _GEN_27; // @[dut.scala 33:18 35:12]
  wire  _GEN_35 = io_reset | _GEN_28; // @[dut.scala 33:18 36:12]
  wire  _GEN_36 = io_reset | _GEN_29; // @[dut.scala 33:18 37:12]
  wire  _GEN_37 = io_reset | _GEN_32; // @[dut.scala 33:18 38:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 27:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 28:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 29:10]
  assign io_dfr = dfrReg; // @[dut.scala 30:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:25]
      stateReg <= 2'h3; // @[dut.scala 18:25]
    end else if (io_reset) begin // @[dut.scala 33:18]
      stateReg <= 2'h3; // @[dut.scala 34:14]
    end else if (2'h0 == stateReg) begin // @[dut.scala 41:22]
      if (io_s == 3'h7) begin // @[dut.scala 43:33]
        stateReg <= 2'h0; // @[dut.scala 44:20]
      end else begin
        stateReg <= _GEN_0;
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 41:22]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_12;
    end
    fr3Reg <= reset | _GEN_34; // @[dut.scala 21:{23,23}]
    fr2Reg <= reset | _GEN_35; // @[dut.scala 22:{23,23}]
    fr1Reg <= reset | _GEN_36; // @[dut.scala 23:{23,23}]
    dfrReg <= reset | _GEN_37; // @[dut.scala 24:{23,23}]
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
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  fr3Reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr1Reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfrReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
