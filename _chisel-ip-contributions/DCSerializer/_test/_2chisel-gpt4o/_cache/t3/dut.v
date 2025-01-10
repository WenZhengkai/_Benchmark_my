module dut(
  input        clock,
  input        reset,
  output       io_dataIn_ready,
  input        io_dataIn_valid,
  input  [7:0] io_dataIn_bits,
  input        io_dataOut_ready,
  output       io_dataOut_valid,
  output [4:0] io_dataOut_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  cycleCount; // @[dut.scala 17:27]
  reg [7:0] dataReg; // @[dut.scala 18:20]
  wire  _T = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire [4:0] dataVec_0 = dataReg[4:0]; // @[dut.scala 36:21]
  wire [4:0] dataVec_1 = {{2'd0}, dataReg[7:5]}; // @[dut.scala 33:{24,24}]
  wire  _T_1 = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = cycleCount & io_dataOut_ready; // @[dut.scala 21:54]
  assign io_dataOut_valid = io_dataIn_valid; // @[dut.scala 30:20]
  assign io_dataOut_bits = cycleCount ? dataVec_1 : dataVec_0; // @[dut.scala 40:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:27]
      cycleCount <= 1'h0; // @[dut.scala 17:27]
    end else if (_T_1) begin // @[dut.scala 43:27]
      if (cycleCount) begin // @[dut.scala 44:41]
        cycleCount <= 1'h0; // @[dut.scala 45:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 47:18]
      end
    end else if (_T) begin // @[dut.scala 24:26]
      cycleCount <= 1'h0; // @[dut.scala 26:16]
    end
    if (_T) begin // @[dut.scala 24:26]
      dataReg <= io_dataIn_bits; // @[dut.scala 25:13]
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
  dataReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
