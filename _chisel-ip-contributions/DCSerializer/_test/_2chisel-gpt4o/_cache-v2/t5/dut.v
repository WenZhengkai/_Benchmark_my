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
  reg  cycleCount; // @[dut.scala 15:27]
  wire [4:0] dataVec_0 = io_dataIn_bits[4:0]; // @[dut.scala 24:42]
  wire [4:0] dataVec_1 = {{2'd0}, io_dataIn_bits[7:5]}; // @[dut.scala 18:21 24:16]
  wire  _T = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire  _T_1 = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = cycleCount & io_dataOut_ready; // @[dut.scala 31:54]
  assign io_dataOut_valid = io_dataIn_valid; // @[dut.scala 32:20]
  assign io_dataOut_bits = cycleCount ? dataVec_1 : dataVec_0; // @[dut.scala 28:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:27]
      cycleCount <= 1'h0; // @[dut.scala 15:27]
    end else if (_T_1) begin // @[dut.scala 38:24]
      cycleCount <= 1'h0; // @[dut.scala 39:16]
    end else if (_T) begin // @[dut.scala 34:25]
      cycleCount <= cycleCount + 1'h1; // @[dut.scala 35:16]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
