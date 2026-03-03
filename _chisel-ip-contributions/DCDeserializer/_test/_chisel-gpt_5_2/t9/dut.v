module dut(
  input        clock,
  input        reset,
  output       io_dataIn_ready,
  input        io_dataIn_valid,
  input  [4:0] io_dataIn_bits,
  input        io_dataOut_ready,
  output       io_dataOut_valid,
  output [7:0] io_dataOut_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  cycleCount; // @[dut.scala 22:27]
  reg [4:0] dataSelect_0; // @[dut.scala 23:27]
  reg [4:0] dataSelect_1; // @[dut.scala 23:27]
  reg  dataValid; // @[dut.scala 24:27]
  wire [9:0] assembled = {dataSelect_1,dataSelect_0}; // @[dut.scala 34:30]
  wire  _T = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_3 = cycleCount | dataValid; // @[dut.scala 41:41 43:18 24:27]
  wire  _T_2 = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = ~dataValid; // @[dut.scala 29:22]
  assign io_dataOut_valid = dataValid; // @[dut.scala 36:20]
  assign io_dataOut_bits = assembled[7:0]; // @[dut.scala 35:{41,41}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:27]
      cycleCount <= 1'h0; // @[dut.scala 22:27]
    end else if (_T) begin // @[dut.scala 38:24]
      if (cycleCount) begin // @[dut.scala 41:41]
        cycleCount <= 1'h0; // @[dut.scala 42:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 45:18]
      end
    end
    if (reset) begin // @[dut.scala 23:27]
      dataSelect_0 <= 5'h0; // @[dut.scala 23:27]
    end else if (_T) begin // @[dut.scala 38:24]
      if (~cycleCount) begin // @[dut.scala 39:28]
        dataSelect_0 <= io_dataIn_bits; // @[dut.scala 39:28]
      end
    end
    if (reset) begin // @[dut.scala 23:27]
      dataSelect_1 <= 5'h0; // @[dut.scala 23:27]
    end else if (_T) begin // @[dut.scala 38:24]
      if (cycleCount) begin // @[dut.scala 39:28]
        dataSelect_1 <= io_dataIn_bits; // @[dut.scala 39:28]
      end
    end
    if (reset) begin // @[dut.scala 24:27]
      dataValid <= 1'h0; // @[dut.scala 24:27]
    end else if (_T_2) begin // @[dut.scala 49:25]
      dataValid <= 1'h0; // @[dut.scala 50:15]
    end else if (_T) begin // @[dut.scala 38:24]
      dataValid <= _GEN_3;
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
  cycleCount = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataSelect_0 = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  dataSelect_1 = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  dataValid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
