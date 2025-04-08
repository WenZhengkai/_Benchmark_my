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
  reg [1:0] cycleCount; // @[dut.scala 16:27]
  wire  _T = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _cycleCount_T_1 = cycleCount + 2'h1; // @[dut.scala 19:30]
  wire  _T_1 = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire [9:0] paddedData = {2'h0,io_dataIn_bits}; // @[Cat.scala 33:92]
  wire [4:0] dataSelect_0 = paddedData[4:0]; // @[dut.scala 27:60]
  wire [4:0] dataSelect_1 = paddedData[9:5]; // @[dut.scala 27:60]
  assign io_dataIn_ready = cycleCount == 2'h1 & io_dataOut_ready; // @[dut.scala 32:54]
  assign io_dataOut_valid = io_dataIn_valid; // @[dut.scala 35:20]
  assign io_dataOut_bits = cycleCount[0] ? dataSelect_1 : dataSelect_0; // @[dut.scala 38:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:27]
      cycleCount <= 2'h0; // @[dut.scala 16:27]
    end else if (_T) begin // @[dut.scala 18:25]
      cycleCount <= _cycleCount_T_1; // @[dut.scala 19:16]
    end else if (_T_1) begin // @[dut.scala 20:30]
      cycleCount <= 2'h0; // @[dut.scala 21:16]
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
