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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] cycleCount; // @[dut.scala 17:27]
  wire [9:0] paddedData = {2'h0,io_dataIn_bits}; // @[Cat.scala 33:92]
  wire [4:0] dataSelect_0 = paddedData[4:0]; // @[dut.scala 23:15]
  wire [4:0] dataSelect_1 = paddedData[9:5]; // @[dut.scala 23:15]
  wire  isLastCycle = cycleCount == 2'h1; // @[dut.scala 30:32]
  wire  _T = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _cycleCount_T_1 = cycleCount + 2'h1; // @[dut.scala 40:52]
  assign io_dataIn_ready = isLastCycle & io_dataOut_ready; // @[dut.scala 33:34]
  assign io_dataOut_valid = io_dataIn_valid; // @[dut.scala 36:20]
  assign io_dataOut_bits = cycleCount[0] ? dataSelect_1 : dataSelect_0; // @[dut.scala 27:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:27]
      cycleCount <= 2'h0; // @[dut.scala 17:27]
    end else if (_T) begin // @[dut.scala 39:25]
      if (isLastCycle) begin // @[dut.scala 40:22]
        cycleCount <= 2'h0;
      end else begin
        cycleCount <= _cycleCount_T_1;
      end
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
  cycleCount = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
