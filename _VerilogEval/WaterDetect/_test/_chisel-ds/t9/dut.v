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
  reg [1:0] prevLevel; // @[dut.scala 15:26]
  wire  _currentLevel_T = io_s == 3'h7; // @[dut.scala 34:13]
  wire  _currentLevel_T_1 = io_s == 3'h3; // @[dut.scala 35:13]
  wire  _currentLevel_T_2 = io_s == 3'h1; // @[dut.scala 36:13]
  wire  _currentLevel_T_3 = io_s == 3'h0; // @[dut.scala 37:13]
  wire [1:0] _currentLevel_T_4 = _currentLevel_T_3 ? 2'h0 : 2'h3; // @[Mux.scala 101:16]
  wire [1:0] _currentLevel_T_5 = _currentLevel_T_2 ? 2'h1 : _currentLevel_T_4; // @[Mux.scala 101:16]
  wire [1:0] _currentLevel_T_6 = _currentLevel_T_1 ? 2'h2 : _currentLevel_T_5; // @[Mux.scala 101:16]
  wire [1:0] currentLevel = _currentLevel_T ? 2'h3 : _currentLevel_T_6; // @[Mux.scala 101:16]
  wire  _GEN_1 = 2'h1 == currentLevel ? 1'h0 : 2'h0 == currentLevel; // @[dut.scala 41:26 53:16]
  wire  _GEN_2 = 2'h1 == currentLevel | 2'h0 == currentLevel; // @[dut.scala 41:26 54:16]
  wire  _GEN_3 = 2'h2 == currentLevel ? 1'h0 : _GEN_1; // @[dut.scala 41:26 48:16]
  wire  _GEN_4 = 2'h2 == currentLevel ? 1'h0 : _GEN_2; // @[dut.scala 41:26 49:16]
  wire  _GEN_5 = 2'h2 == currentLevel | _GEN_2; // @[dut.scala 41:26 50:16]
  wire  _GEN_6 = 2'h3 == currentLevel ? 1'h0 : _GEN_3; // @[dut.scala 41:26 43:16]
  wire  _GEN_7 = 2'h3 == currentLevel ? 1'h0 : _GEN_4; // @[dut.scala 41:26 44:16]
  wire  _GEN_8 = 2'h3 == currentLevel ? 1'h0 : _GEN_5; // @[dut.scala 41:26 45:16]
  wire  _T_4 = currentLevel > prevLevel; // @[dut.scala 65:23]
  assign io_fr3 = io_reset | _GEN_6; // @[dut.scala 24:18 26:12]
  assign io_fr2 = io_reset | _GEN_7; // @[dut.scala 24:18 27:12]
  assign io_fr1 = io_reset | _GEN_8; // @[dut.scala 24:18 28:12]
  assign io_dfr = io_reset | _T_4; // @[dut.scala 24:18 29:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      prevLevel <= 2'h0; // @[dut.scala 15:26]
    end else if (io_reset) begin // @[dut.scala 24:18]
      prevLevel <= 2'h0; // @[dut.scala 25:15]
    end else if (_currentLevel_T) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h3;
    end else if (_currentLevel_T_1) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h2;
    end else begin
      prevLevel <= _currentLevel_T_5;
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
