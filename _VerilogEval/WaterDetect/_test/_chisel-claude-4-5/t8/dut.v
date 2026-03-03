module dut(
  input        clock,
  input        reset,
  input  [3:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  s1 = io_s[1]; // @[dut.scala 14:16]
  wire  s2 = io_s[2]; // @[dut.scala 15:16]
  wire  s3 = io_s[3]; // @[dut.scala 16:16]
  reg [1:0] prevLevel; // @[dut.scala 19:26]
  wire  _currentLevel_T = s1 & s2; // @[dut.scala 29:9]
  wire  _currentLevel_T_1 = s1 & s2 & s3; // @[dut.scala 29:15]
  wire  _currentLevel_T_4 = _currentLevel_T & ~s3; // @[dut.scala 30:15]
  wire  _currentLevel_T_6 = s1 & ~s2; // @[dut.scala 31:9]
  wire [1:0] _currentLevel_T_10 = _currentLevel_T_4 ? 2'h2 : {{1'd0}, _currentLevel_T_6}; // @[Mux.scala 101:16]
  wire [1:0] currentLevel = _currentLevel_T_1 ? 2'h3 : _currentLevel_T_10; // @[Mux.scala 101:16]
  wire  levelRising = currentLevel > prevLevel; // @[dut.scala 36:34]
  wire  _nominalFr1_T = currentLevel == 2'h0; // @[dut.scala 47:19]
  wire  _nominalFr1_T_1 = currentLevel == 2'h1; // @[dut.scala 48:19]
  wire  _nominalFr1_T_2 = currentLevel == 2'h2; // @[dut.scala 49:19]
  assign io_fr3 = currentLevel == 2'h0; // @[dut.scala 57:31]
  assign io_fr2 = _nominalFr1_T | _nominalFr1_T_1; // @[Mux.scala 101:16]
  assign io_fr1 = _nominalFr1_T | (_nominalFr1_T_1 | _nominalFr1_T_2); // @[Mux.scala 101:16]
  assign io_dfr = levelRising & currentLevel != 2'h3; // @[dut.scala 61:38]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:26]
      prevLevel <= 2'h0; // @[dut.scala 19:26]
    end else if (reset) begin // @[dut.scala 71:22]
      prevLevel <= 2'h0; // @[dut.scala 72:15]
    end else if (_currentLevel_T_1) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h3;
    end else if (_currentLevel_T_4) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h2;
    end else begin
      prevLevel <= {{1'd0}, _currentLevel_T_6};
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
