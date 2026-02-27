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
  reg [1:0] prevLevel; // @[dut.scala 16:26]
  wire  _currentLevel_T = io_s == 3'h0; // @[dut.scala 32:15]
  wire  _currentLevel_T_1 = io_s == 3'h1; // @[dut.scala 33:15]
  wire  _currentLevel_T_2 = io_s == 3'h3; // @[dut.scala 34:15]
  wire [1:0] _currentLevel_T_3 = _currentLevel_T_2 ? 2'h2 : 2'h3; // @[Mux.scala 101:16]
  wire [1:0] _currentLevel_T_4 = _currentLevel_T_1 ? 2'h1 : _currentLevel_T_3; // @[Mux.scala 101:16]
  wire [1:0] currentLevel = _currentLevel_T ? 2'h0 : _currentLevel_T_4; // @[Mux.scala 101:16]
  assign io_fr3 = io_reset | currentLevel == 2'h0; // @[dut.scala 19:18 21:12 39:12]
  assign io_fr2 = io_reset | currentLevel <= 2'h1; // @[dut.scala 19:18 22:12 40:12]
  assign io_fr1 = io_reset | currentLevel <= 2'h2; // @[dut.scala 19:18 23:12 41:12]
  assign io_dfr = io_reset | prevLevel < currentLevel; // @[dut.scala 19:18 24:12 44:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      prevLevel <= 2'h0; // @[dut.scala 16:26]
    end else if (io_reset) begin // @[dut.scala 19:18]
      prevLevel <= 2'h0; // @[dut.scala 25:15]
    end else if (_currentLevel_T) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h0;
    end else if (_currentLevel_T_1) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h1;
    end else begin
      prevLevel <= _currentLevel_T_3;
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
