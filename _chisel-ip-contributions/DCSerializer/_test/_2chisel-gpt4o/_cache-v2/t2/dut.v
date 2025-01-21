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
  reg  cycleCount; // @[dut.scala 22:27]
  wire  _T = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire [7:0] _dataSelect_0_T_1 = io_dataIn_bits & 8'h1f; // @[dut.scala 34:63]
  wire [7:0] _dataSelect_1_T = {{5'd0}, io_dataIn_bits[7:5]}; // @[dut.scala 34:45]
  wire [7:0] _dataSelect_1_T_1 = _dataSelect_1_T & 8'h1f; // @[dut.scala 34:63]
  wire [4:0] dataSelect_0 = _dataSelect_0_T_1[4:0]; // @[dut.scala 19:24 34:19]
  wire [4:0] dataSelect_1 = _dataSelect_1_T_1[4:0]; // @[dut.scala 19:24 34:19]
  wire  _T_2 = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = cycleCount & io_dataOut_ready; // @[dut.scala 38:54]
  assign io_dataOut_valid = io_dataIn_valid; // @[dut.scala 39:20]
  assign io_dataOut_bits = cycleCount ? dataSelect_1 : dataSelect_0; // @[dut.scala 40:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:27]
      cycleCount <= 1'h0; // @[dut.scala 22:27]
    end else if (_T_2) begin // @[dut.scala 42:26]
      cycleCount <= 1'h0; // @[dut.scala 43:16]
    end else if (_T) begin // @[dut.scala 24:27]
      if (cycleCount) begin // @[dut.scala 27:41]
        cycleCount <= 1'h0; // @[dut.scala 28:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 25:16]
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
  cycleCount = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
