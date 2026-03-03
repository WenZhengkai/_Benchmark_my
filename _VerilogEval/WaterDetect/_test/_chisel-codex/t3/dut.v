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
  wire [1:0] _currLevel_T_3 = 3'h1 == io_s ? 2'h1 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _currLevel_T_5 = 3'h3 == io_s ? 2'h2 : _currLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] currLevel = 3'h7 == io_s ? 2'h3 : _currLevel_T_5; // @[Mux.scala 81:58]
  reg [1:0] lastLevel; // @[dut.scala 32:30]
  reg  cameFromLower; // @[dut.scala 33:30]
  wire  _GEN_0 = currLevel != lastLevel ? lastLevel < currLevel : cameFromLower; // @[dut.scala 35:33 36:19 33:30]
  wire  _T_1 = 2'h0 == currLevel; // @[dut.scala 47:21]
  wire  _GEN_3 = 2'h2 == currLevel & cameFromLower; // @[dut.scala 44:10 47:21 61:14]
  wire  _GEN_4 = 2'h1 == currLevel | 2'h2 == currLevel; // @[dut.scala 47:21 55:14]
  wire  _GEN_6 = 2'h1 == currLevel ? cameFromLower : _GEN_3; // @[dut.scala 47:21 57:14]
  wire  _GEN_7 = 2'h0 == currLevel | _GEN_4; // @[dut.scala 47:21 49:14]
  wire  _GEN_8 = 2'h0 == currLevel | 2'h1 == currLevel; // @[dut.scala 47:21 50:14]
  wire  _GEN_10 = 2'h0 == currLevel | _GEN_6; // @[dut.scala 47:21 52:14]
  assign io_fr3 = reset | _T_1; // @[dut.scala 70:22 73:12]
  assign io_fr2 = reset | _GEN_8; // @[dut.scala 70:22 72:12]
  assign io_fr1 = reset | _GEN_7; // @[dut.scala 70:22 71:12]
  assign io_dfr = reset | _GEN_10; // @[dut.scala 70:22 74:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 32:30]
      lastLevel <= 2'h0; // @[dut.scala 32:30]
    end else if (currLevel != lastLevel) begin // @[dut.scala 35:33]
      if (3'h7 == io_s) begin // @[Mux.scala 81:58]
        lastLevel <= 2'h3;
      end else if (3'h3 == io_s) begin // @[Mux.scala 81:58]
        lastLevel <= 2'h2;
      end else begin
        lastLevel <= _currLevel_T_3;
      end
    end
    cameFromLower <= reset | _GEN_0; // @[dut.scala 33:{30,30}]
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
  lastLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cameFromLower = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
