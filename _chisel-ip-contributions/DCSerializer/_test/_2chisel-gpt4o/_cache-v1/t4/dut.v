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
  reg [7:0] dataReg; // @[dut.scala 21:24]
  reg  active; // @[dut.scala 22:23]
  wire [4:0] dataSelect_0 = dataReg[4:0]; // @[dut.scala 28:12]
  wire [4:0] dataSelect_1 = {{2'd0}, dataReg[7:5]}; // @[dut.scala 25:{45,45}]
  wire  _T = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_4 = _T | active; // @[dut.scala 36:24 40:12 22:23]
  wire  _T_1 = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = ~active & io_dataOut_ready; // @[dut.scala 32:30]
  assign io_dataOut_valid = active; // @[dut.scala 34:20]
  assign io_dataOut_bits = cycleCount ? dataSelect_1 : dataSelect_0; // @[dut.scala 33:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:27]
      cycleCount <= 1'h0; // @[dut.scala 18:27]
    end else if (_T_1) begin // @[dut.scala 43:25]
      if (cycleCount) begin // @[dut.scala 48:41]
        cycleCount <= 1'h0; // @[dut.scala 51:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 45:16]
      end
    end else if (_T) begin // @[dut.scala 36:24]
      cycleCount <= 1'h0; // @[dut.scala 39:16]
    end
    if (reset) begin // @[dut.scala 21:24]
      dataReg <= 8'h0; // @[dut.scala 21:24]
    end else if (_T) begin // @[dut.scala 36:24]
      dataReg <= io_dataIn_bits; // @[dut.scala 38:13]
    end
    if (reset) begin // @[dut.scala 22:23]
      active <= 1'h0; // @[dut.scala 22:23]
    end else if (_T_1) begin // @[dut.scala 43:25]
      if (cycleCount) begin // @[dut.scala 48:41]
        active <= 1'h0; // @[dut.scala 49:14]
      end else begin
        active <= _GEN_4;
      end
    end else begin
      active <= _GEN_4;
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
  _RAND_2 = {1{`RANDOM}};
  active = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
