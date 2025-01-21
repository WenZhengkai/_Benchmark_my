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
  reg  cycleCount; // @[dut.scala 20:27]
  reg [7:0] activeData; // @[dut.scala 21:23]
  reg  activeTransaction; // @[dut.scala 22:34]
  wire [4:0] dataVec_0 = activeData[4:0]; // @[dut.scala 29:38]
  wire [4:0] dataVec_1 = {{2'd0}, activeData[7:5]}; // @[dut.scala 25:21 29:16]
  wire  _T = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  wire  _T_2 = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_5 = _T_2 | activeTransaction; // @[dut.scala 48:26 50:25 22:34]
  assign io_dataIn_ready = ~activeTransaction & io_dataOut_ready; // @[dut.scala 37:41]
  assign io_dataOut_valid = activeTransaction; // @[dut.scala 34:20]
  assign io_dataOut_bits = cycleCount ? dataVec_1 : dataVec_0; // @[dut.scala 33:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:27]
      cycleCount <= 1'h0; // @[dut.scala 20:27]
    end else if (_T) begin // @[dut.scala 40:25]
      if (cycleCount) begin // @[dut.scala 41:41]
        cycleCount <= 1'h0; // @[dut.scala 42:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[dut.scala 45:18]
      end
    end else if (_T_2) begin // @[dut.scala 48:26]
      cycleCount <= 1'h0; // @[dut.scala 51:18]
    end
    if (!(_T)) begin // @[dut.scala 40:25]
      if (_T_2) begin // @[dut.scala 48:26]
        activeData <= io_dataIn_bits; // @[dut.scala 49:18]
      end
    end
    if (reset) begin // @[dut.scala 22:34]
      activeTransaction <= 1'h0; // @[dut.scala 22:34]
    end else if (_T) begin // @[dut.scala 40:25]
      if (cycleCount) begin // @[dut.scala 41:41]
        activeTransaction <= 1'h0; // @[dut.scala 43:25]
      end
    end else begin
      activeTransaction <= _GEN_5;
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
  activeData = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  activeTransaction = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
