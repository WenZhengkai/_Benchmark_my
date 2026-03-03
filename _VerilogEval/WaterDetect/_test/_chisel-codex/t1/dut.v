module dut(
  input        clock,
  input        reset,
  input        io_rst,
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
  wire [1:0] _sensorLevel_T_3 = 3'h4 == io_s ? 2'h1 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _sensorLevel_T_5 = 3'h6 == io_s ? 2'h2 : _sensorLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] sensorLevel = 3'h7 == io_s ? 2'h3 : _sensorLevel_T_5; // @[Mux.scala 81:58]
  reg [1:0] currLevel; // @[dut.scala 36:26]
  reg [1:0] prevLevel; // @[dut.scala 37:26]
  wire  _io_fr3_T = currLevel == 2'h0; // @[dut.scala 54:24]
  wire  roseSinceLastChange = prevLevel < currLevel; // @[dut.scala 60:39]
  wire  _io_dfr_T_2 = currLevel == 2'h3 ? 1'h0 : roseSinceLastChange; // @[dut.scala 62:16]
  assign io_fr3 = currLevel == 2'h0; // @[dut.scala 54:24]
  assign io_fr2 = currLevel <= 2'h1; // @[dut.scala 53:24]
  assign io_fr1 = currLevel <= 2'h2; // @[dut.scala 52:24]
  assign io_dfr = _io_fr3_T | _io_dfr_T_2; // @[dut.scala 61:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 36:26]
      currLevel <= 2'h0; // @[dut.scala 36:26]
    end else if (io_rst) begin // @[dut.scala 39:16]
      currLevel <= 2'h0; // @[dut.scala 42:15]
    end else if (sensorLevel != currLevel) begin // @[dut.scala 45:37]
      if (3'h7 == io_s) begin // @[Mux.scala 81:58]
        currLevel <= 2'h3;
      end else begin
        currLevel <= _sensorLevel_T_5;
      end
    end
    if (reset) begin // @[dut.scala 37:26]
      prevLevel <= 2'h0; // @[dut.scala 37:26]
    end else if (io_rst) begin // @[dut.scala 39:16]
      prevLevel <= 2'h0; // @[dut.scala 43:15]
    end else if (sensorLevel != currLevel) begin // @[dut.scala 45:37]
      prevLevel <= currLevel; // @[dut.scala 46:17]
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
  currLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  prevLevel = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
