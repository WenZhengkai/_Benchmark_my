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
  reg [2:0] stackPtr; // @[dut.scala 16:25]
  wire  empty = stackPtr == 3'h4; // @[dut.scala 26:21]
  wire  full = stackPtr == 3'h0; // @[dut.scala 27:20]
  wire [2:0] _T_5 = stackPtr - 3'h1; // @[dut.scala 41:27]
  wire [3:0] _GEN_0 = 2'h0 == _T_5[1:0] ? io_dataIn : stackMem_0; // @[dut.scala 15:25 41:{34,34}]
  wire [3:0] _GEN_1 = 2'h1 == _T_5[1:0] ? io_dataIn : stackMem_1; // @[dut.scala 15:25 41:{34,34}]
  wire [3:0] _GEN_2 = 2'h2 == _T_5[1:0] ? io_dataIn : stackMem_2; // @[dut.scala 15:25 41:{34,34}]
  wire [3:0] _GEN_3 = 2'h3 == _T_5[1:0] ? io_dataIn : stackMem_3; // @[dut.scala 15:25 41:{34,34}]
  wire [3:0] _GEN_5 = 2'h1 == stackPtr[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 45:{20,20}]
  wire [3:0] _GEN_6 = 2'h2 == stackPtr[1:0] ? stackMem_2 : _GEN_5; // @[dut.scala 45:{20,20}]
  wire [3:0] _GEN_7 = 2'h3 == stackPtr[1:0] ? stackMem_3 : _GEN_6; // @[dut.scala 45:{20,20}]
  wire [3:0] _GEN_8 = 2'h0 == stackPtr[1:0] ? 4'h0 : stackMem_0; // @[dut.scala 15:25 46:{28,28}]
  wire [3:0] _GEN_9 = 2'h1 == stackPtr[1:0] ? 4'h0 : stackMem_1; // @[dut.scala 15:25 46:{28,28}]
  wire [3:0] _GEN_10 = 2'h2 == stackPtr[1:0] ? 4'h0 : stackMem_2; // @[dut.scala 15:25 46:{28,28}]
  wire [3:0] _GEN_11 = 2'h3 == stackPtr[1:0] ? 4'h0 : stackMem_3; // @[dut.scala 15:25 46:{28,28}]
  wire [2:0] _stackPtr_T_3 = stackPtr + 3'h1; // @[dut.scala 47:30]
  wire [3:0] _GEN_12 = io_RW & ~empty ? _GEN_7 : 4'h0; // @[dut.scala 23:14 43:35 45:20]
  wire [3:0] _GEN_13 = io_RW & ~empty ? _GEN_8 : stackMem_0; // @[dut.scala 15:25 43:35]
  wire [3:0] _GEN_14 = io_RW & ~empty ? _GEN_9 : stackMem_1; // @[dut.scala 15:25 43:35]
  wire [3:0] _GEN_15 = io_RW & ~empty ? _GEN_10 : stackMem_2; // @[dut.scala 15:25 43:35]
  wire [3:0] _GEN_16 = io_RW & ~empty ? _GEN_11 : stackMem_3; // @[dut.scala 15:25 43:35]
  wire [2:0] _GEN_17 = io_RW & ~empty ? _stackPtr_T_3 : stackPtr; // @[dut.scala 43:35 47:18 16:25]
  wire [3:0] _GEN_23 = ~io_RW & ~full ? 4'h0 : _GEN_12; // @[dut.scala 23:14 39:29]
  wire  _GEN_29 = reset | empty; // @[dut.scala 31:26 35:16 50:16]
  wire  _GEN_30 = reset ? 1'h0 : full; // @[dut.scala 31:26 36:15 51:15]
  wire [3:0] _GEN_31 = reset ? 4'h0 : _GEN_23; // @[dut.scala 23:14 31:26]
  assign io_EMPTY = io_EN & _GEN_29; // @[dut.scala 21:12 30:15]
  assign io_FULL = io_EN & _GEN_30; // @[dut.scala 22:11 30:15]
  assign io_dataOut = io_EN ? _GEN_31 : 4'h0; // @[dut.scala 23:14 30:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:25]
      stackMem_0 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:26]
        stackMem_0 <= 4'h0; // @[dut.scala 33:16]
      end else if (~io_RW & ~full) begin // @[dut.scala 39:29]
        stackMem_0 <= _GEN_0;
      end else begin
        stackMem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_1 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:26]
        stackMem_1 <= 4'h0; // @[dut.scala 33:16]
      end else if (~io_RW & ~full) begin // @[dut.scala 39:29]
        stackMem_1 <= _GEN_1;
      end else begin
        stackMem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_2 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:26]
        stackMem_2 <= 4'h0; // @[dut.scala 33:16]
      end else if (~io_RW & ~full) begin // @[dut.scala 39:29]
        stackMem_2 <= _GEN_2;
      end else begin
        stackMem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_3 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:26]
        stackMem_3 <= 4'h0; // @[dut.scala 33:16]
      end else if (~io_RW & ~full) begin // @[dut.scala 39:29]
        stackMem_3 <= _GEN_3;
      end else begin
        stackMem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackPtr <= 3'h4; // @[dut.scala 16:25]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:26]
        stackPtr <= 3'h4; // @[dut.scala 34:16]
      end else if (~io_RW & ~full) begin // @[dut.scala 39:29]
        stackPtr <= _T_5; // @[dut.scala 42:18]
      end else begin
        stackPtr <= _GEN_17;
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
  stackPtr = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
