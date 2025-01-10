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
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  cycleCount; // @[dut.scala 18:27]
  reg  active; // @[dut.scala 19:23]
  reg [7:0] inputData; // @[dut.scala 23:22]
  wire [4:0] dataVec_0 = inputData[4:0]; // @[dut.scala 29:37]
  wire [4:0] dataVec_1 = {{2'd0}, inputData[7:5]}; // @[dut.scala 22:21 29:16]
  wire  _T = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire  _T_1 = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_2 = cycleCount ? 1'h0 : active; // @[dut.scala 44:41 45:14 19:23]
  wire  _GEN_4 = _T_1 & active ? _GEN_2 : active; // @[dut.scala 19:23 42:41]
  wire  _GEN_8 = _T | _GEN_4; // @[dut.scala 37:24 41:12]
  assign io_dataIn_ready = ~active & io_dataOut_ready; // @[dut.scala 33:30]
  assign io_dataOut_valid = active; // @[dut.scala 34:20]
  assign io_dataOut_bits = cycleCount ? dataVec_1 : dataVec_0; // @[dut.scala 35:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:27]
      cycleCount <= 1'h0; // @[dut.scala 18:27]
    end else if (_T) begin // @[dut.scala 37:24]
      cycleCount <= 1'h0; // @[dut.scala 40:16]
    end else if (_T_1 & active) begin // @[dut.scala 42:41]
      if (!(cycleCount)) begin // @[dut.scala 44:41]
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 47:18]
      end
    end
    if (reset) begin // @[dut.scala 19:23]
      active <= 1'h0; // @[dut.scala 19:23]
    end else begin
      active <= _GEN_8;
    end
    if (_T) begin // @[dut.scala 37:24]
      inputData <= io_dataIn_bits; // @[dut.scala 39:15]
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
  active = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  inputData = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
