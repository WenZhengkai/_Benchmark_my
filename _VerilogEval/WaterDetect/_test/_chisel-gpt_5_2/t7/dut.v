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
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _currLevel_T_1 = 3'h7 == io_s ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _currLevel_T_3 = 3'h3 == io_s ? 2'h2 : _currLevel_T_1; // @[Mux.scala 81:58]
  wire [1:0] _currLevel_T_5 = 3'h1 == io_s ? 2'h1 : _currLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] currLevel = 3'h0 == io_s ? 2'h0 : _currLevel_T_5; // @[Mux.scala 81:58]
  reg [1:0] prevLevel; // @[dut.scala 45:26]
  reg  dfrReg; // @[dut.scala 49:23]
  wire  _T_2 = currLevel > prevLevel; // @[dut.scala 57:23]
  wire  _GEN_1 = currLevel != prevLevel ? _T_2 : dfrReg; // @[dut.scala 49:23 56:36]
  wire  _GEN_4 = reset | _GEN_1; // @[dut.scala 52:23 54:15]
  wire  _GEN_6 = 2'h1 == currLevel | 2'h0 == currLevel; // @[dut.scala 73:21 81:14]
  wire  _GEN_7 = 2'h1 == currLevel ? 1'h0 : 2'h0 == currLevel; // @[dut.scala 73:21 81:52]
  wire  _GEN_8 = 2'h2 == currLevel | _GEN_6; // @[dut.scala 73:21 78:14]
  wire  _GEN_9 = 2'h2 == currLevel ? 1'h0 : _GEN_6; // @[dut.scala 73:21 78:33]
  wire  _GEN_10 = 2'h2 == currLevel ? 1'h0 : _GEN_7; // @[dut.scala 73:21 78:52]
  assign io_fr3 = 2'h3 == currLevel ? 1'h0 : _GEN_10; // @[dut.scala 73:21 75:52]
  assign io_fr2 = 2'h3 == currLevel ? 1'h0 : _GEN_9; // @[dut.scala 73:21 75:33]
  assign io_fr1 = 2'h3 == currLevel ? 1'h0 : _GEN_8; // @[dut.scala 73:21 75:14]
  assign io_dfr = dfrReg; // @[dut.scala 91:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 45:26]
      prevLevel <= 2'h0; // @[dut.scala 45:26]
    end else if (reset) begin // @[dut.scala 52:23]
      prevLevel <= 2'h0; // @[dut.scala 53:15]
    end else if (currLevel != prevLevel) begin // @[dut.scala 56:36]
      if (3'h0 == io_s) begin // @[Mux.scala 81:58]
        prevLevel <= 2'h0;
      end else begin
        prevLevel <= _currLevel_T_5;
      end
    end
    dfrReg <= reset | _GEN_4; // @[dut.scala 49:{23,23}]
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
