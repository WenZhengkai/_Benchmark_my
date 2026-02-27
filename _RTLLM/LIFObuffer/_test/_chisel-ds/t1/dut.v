module dut(
  input        clock,
  input        reset,
  input  [3:0] io_dataIn,
  input        io_RW,
  input        io_EN,
  output       io_EMPTY,
  output       io_FULL,
  output [3:0] io_dataOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stackMem_0; // @[dut.scala 15:25]
  reg [3:0] stackMem_1; // @[dut.scala 15:25]
  reg [3:0] stackMem_2; // @[dut.scala 15:25]
  reg [3:0] stackMem_3; // @[dut.scala 15:25]
  reg [2:0] stackPointer; // @[dut.scala 16:29]
  wire [2:0] _T_4 = stackPointer - 3'h1; // @[dut.scala 35:29]
  wire [3:0] _GEN_0 = 2'h0 == _T_4[1:0] ? io_dataIn : stackMem_0; // @[dut.scala 15:25 35:{36,36}]
  wire [3:0] _GEN_1 = 2'h1 == _T_4[1:0] ? io_dataIn : stackMem_1; // @[dut.scala 15:25 35:{36,36}]
  wire [3:0] _GEN_2 = 2'h2 == _T_4[1:0] ? io_dataIn : stackMem_2; // @[dut.scala 15:25 35:{36,36}]
  wire [3:0] _GEN_3 = 2'h3 == _T_4[1:0] ? io_dataIn : stackMem_3; // @[dut.scala 15:25 35:{36,36}]
  wire [3:0] _GEN_5 = 2'h1 == stackPointer[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 39:{18,18}]
  wire [3:0] _GEN_6 = 2'h2 == stackPointer[1:0] ? stackMem_2 : _GEN_5; // @[dut.scala 39:{18,18}]
  wire [3:0] _GEN_7 = 2'h3 == stackPointer[1:0] ? stackMem_3 : _GEN_6; // @[dut.scala 39:{18,18}]
  wire [3:0] _GEN_8 = 2'h0 == stackPointer[1:0] ? 4'h0 : stackMem_0; // @[dut.scala 15:25 40:{30,30}]
  wire [3:0] _GEN_9 = 2'h1 == stackPointer[1:0] ? 4'h0 : stackMem_1; // @[dut.scala 15:25 40:{30,30}]
  wire [3:0] _GEN_10 = 2'h2 == stackPointer[1:0] ? 4'h0 : stackMem_2; // @[dut.scala 15:25 40:{30,30}]
  wire [3:0] _GEN_11 = 2'h3 == stackPointer[1:0] ? 4'h0 : stackMem_3; // @[dut.scala 15:25 40:{30,30}]
  wire [2:0] _stackPointer_T_3 = stackPointer + 3'h1; // @[dut.scala 41:36]
  wire [3:0] _GEN_12 = io_RW & ~io_EMPTY ? _GEN_7 : 4'h0; // @[dut.scala 22:14 37:36 39:18]
  wire [3:0] _GEN_13 = io_RW & ~io_EMPTY ? _GEN_8 : stackMem_0; // @[dut.scala 15:25 37:36]
  wire [3:0] _GEN_14 = io_RW & ~io_EMPTY ? _GEN_9 : stackMem_1; // @[dut.scala 15:25 37:36]
  wire [3:0] _GEN_15 = io_RW & ~io_EMPTY ? _GEN_10 : stackMem_2; // @[dut.scala 15:25 37:36]
  wire [3:0] _GEN_16 = io_RW & ~io_EMPTY ? _GEN_11 : stackMem_3; // @[dut.scala 15:25 37:36]
  wire [2:0] _GEN_17 = io_RW & ~io_EMPTY ? _stackPointer_T_3 : stackPointer; // @[dut.scala 37:36 41:20 16:29]
  wire [3:0] _GEN_23 = ~io_RW & ~io_FULL ? 4'h0 : _GEN_12; // @[dut.scala 22:14 33:30]
  wire [3:0] _GEN_29 = io_EN ? _GEN_23 : 4'h0; // @[dut.scala 22:14 32:21]
  assign io_EMPTY = stackPointer == 3'h4; // @[dut.scala 25:28]
  assign io_FULL = stackPointer == 3'h0; // @[dut.scala 26:27]
  assign io_dataOut = reset ? 4'h0 : _GEN_29; // @[dut.scala 22:14 28:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:25]
      stackMem_0 <= 4'h0; // @[dut.scala 15:25]
    end else if (reset) begin // @[dut.scala 28:21]
      stackMem_0 <= 4'h0; // @[dut.scala 30:24]
    end else if (io_EN) begin // @[dut.scala 32:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 33:30]
        stackMem_0 <= _GEN_0;
      end else begin
        stackMem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_1 <= 4'h0; // @[dut.scala 15:25]
    end else if (reset) begin // @[dut.scala 28:21]
      stackMem_1 <= 4'h0; // @[dut.scala 30:24]
    end else if (io_EN) begin // @[dut.scala 32:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 33:30]
        stackMem_1 <= _GEN_1;
      end else begin
        stackMem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_2 <= 4'h0; // @[dut.scala 15:25]
    end else if (reset) begin // @[dut.scala 28:21]
      stackMem_2 <= 4'h0; // @[dut.scala 30:24]
    end else if (io_EN) begin // @[dut.scala 32:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 33:30]
        stackMem_2 <= _GEN_2;
      end else begin
        stackMem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_3 <= 4'h0; // @[dut.scala 15:25]
    end else if (reset) begin // @[dut.scala 28:21]
      stackMem_3 <= 4'h0; // @[dut.scala 30:24]
    end else if (io_EN) begin // @[dut.scala 32:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 33:30]
        stackMem_3 <= _GEN_3;
      end else begin
        stackMem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 16:29]
      stackPointer <= 3'h4; // @[dut.scala 16:29]
    end else if (reset) begin // @[dut.scala 28:21]
      stackPointer <= 3'h4; // @[dut.scala 31:18]
    end else if (io_EN) begin // @[dut.scala 32:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 33:30]
        stackPointer <= _T_4; // @[dut.scala 36:20]
      end else begin
        stackPointer <= _GEN_17;
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
  stackMem_0 = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  stackMem_1 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  stackMem_2 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  stackMem_3 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  stackPointer = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
