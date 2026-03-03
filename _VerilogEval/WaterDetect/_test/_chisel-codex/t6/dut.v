module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_srst,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _sensedLevel_T_1 = 3'h7 == io_s ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _sensedLevel_T_3 = 3'h6 == io_s ? 2'h2 : _sensedLevel_T_1; // @[Mux.scala 81:58]
  wire [1:0] _sensedLevel_T_5 = 3'h4 == io_s ? 2'h1 : _sensedLevel_T_3; // @[Mux.scala 81:58]
  wire [1:0] sensedLevel = 3'h0 == io_s ? 2'h0 : _sensedLevel_T_5; // @[Mux.scala 81:58]
  reg [1:0] currentLevel; // @[dut.scala 28:29]
  reg [1:0] prevLevel; // @[dut.scala 29:29]
  wire  _io_fr3_T = currentLevel == 2'h0; // @[dut.scala 43:26]
  wire  _io_dfr_T_5 = (currentLevel == 2'h1 | currentLevel == 2'h2) & prevLevel < currentLevel; // @[dut.scala 49:65]
  assign io_fr3 = currentLevel == 2'h0; // @[dut.scala 43:26]
  assign io_fr2 = currentLevel <= 2'h1; // @[dut.scala 42:26]
  assign io_fr1 = currentLevel != 2'h3; // @[dut.scala 41:26]
  assign io_dfr = _io_fr3_T | _io_dfr_T_5; // @[dut.scala 48:36]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 28:29]
      currentLevel <= 2'h0; // @[dut.scala 28:29]
    end else if (io_srst) begin // @[dut.scala 31:17]
      currentLevel <= 2'h0; // @[dut.scala 33:18]
    end else if (sensedLevel != currentLevel) begin // @[dut.scala 35:44]
      if (3'h0 == io_s) begin // @[Mux.scala 81:58]
        currentLevel <= 2'h0;
      end else begin
        currentLevel <= _sensedLevel_T_5;
      end
    end
    if (reset) begin // @[dut.scala 29:29]
      prevLevel <= 2'h0; // @[dut.scala 29:29]
    end else if (io_srst) begin // @[dut.scala 31:17]
      prevLevel <= 2'h0; // @[dut.scala 34:18]
    end else if (sensedLevel != currentLevel) begin // @[dut.scala 35:44]
      prevLevel <= currentLevel; // @[dut.scala 36:18]
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
  currentLevel = _RAND_0[1:0];
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
