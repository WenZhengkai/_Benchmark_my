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
  reg [3:0] stackMem_0; // @[dut.scala 17:25]
  reg [3:0] stackMem_1; // @[dut.scala 17:25]
  reg [3:0] stackMem_2; // @[dut.scala 17:25]
  reg [3:0] stackMem_3; // @[dut.scala 17:25]
  reg [2:0] sp; // @[dut.scala 20:19]
  wire [2:0] _T_5 = sp - 3'h1; // @[dut.scala 37:19]
  wire [3:0] _GEN_0 = 2'h0 == _T_5[1:0] ? io_dataIn : stackMem_0; // @[dut.scala 17:25 37:{26,26}]
  wire [3:0] _GEN_1 = 2'h1 == _T_5[1:0] ? io_dataIn : stackMem_1; // @[dut.scala 17:25 37:{26,26}]
  wire [3:0] _GEN_2 = 2'h2 == _T_5[1:0] ? io_dataIn : stackMem_2; // @[dut.scala 17:25 37:{26,26}]
  wire [3:0] _GEN_3 = 2'h3 == _T_5[1:0] ? io_dataIn : stackMem_3; // @[dut.scala 17:25 37:{26,26}]
  wire  _T_8 = io_RW & ~io_EMPTY; // @[dut.scala 39:22]
  wire [3:0] _GEN_5 = 2'h1 == sp[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 41:{18,18}]
  wire [3:0] _GEN_6 = 2'h2 == sp[1:0] ? stackMem_2 : _GEN_5; // @[dut.scala 41:{18,18}]
  wire [3:0] _GEN_7 = 2'h3 == sp[1:0] ? stackMem_3 : _GEN_6; // @[dut.scala 41:{18,18}]
  wire [3:0] _GEN_8 = 2'h0 == sp[1:0] ? 4'h0 : stackMem_0; // @[dut.scala 42:{20,20} 17:25]
  wire [3:0] _GEN_9 = 2'h1 == sp[1:0] ? 4'h0 : stackMem_1; // @[dut.scala 42:{20,20} 17:25]
  wire [3:0] _GEN_10 = 2'h2 == sp[1:0] ? 4'h0 : stackMem_2; // @[dut.scala 42:{20,20} 17:25]
  wire [3:0] _GEN_11 = 2'h3 == sp[1:0] ? 4'h0 : stackMem_3; // @[dut.scala 42:{20,20} 17:25]
  wire [2:0] _sp_T_3 = sp + 3'h1; // @[dut.scala 43:16]
  wire [3:0] _GEN_12 = io_RW & ~io_EMPTY ? _GEN_7 : 4'h0; // @[dut.scala 25:14 39:36 41:18]
  wire [3:0] _GEN_13 = io_RW & ~io_EMPTY ? _GEN_8 : stackMem_0; // @[dut.scala 17:25 39:36]
  wire [3:0] _GEN_14 = io_RW & ~io_EMPTY ? _GEN_9 : stackMem_1; // @[dut.scala 17:25 39:36]
  wire [3:0] _GEN_15 = io_RW & ~io_EMPTY ? _GEN_10 : stackMem_2; // @[dut.scala 17:25 39:36]
  wire [3:0] _GEN_16 = io_RW & ~io_EMPTY ? _GEN_11 : stackMem_3; // @[dut.scala 17:25 39:36]
  wire [2:0] _GEN_17 = io_RW & ~io_EMPTY ? _sp_T_3 : sp; // @[dut.scala 39:36 43:10 20:19]
  wire [3:0] _GEN_23 = ~io_RW & ~io_FULL ? 4'h0 : _GEN_12; // @[dut.scala 25:14 35:36]
  wire [3:0] _GEN_29 = reset ? 4'h0 : _GEN_23; // @[dut.scala 25:14 29:24]
  wire [3:0] _GEN_35 = io_EN ? _GEN_29 : 4'h0; // @[dut.scala 25:14 28:15]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 23:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 24:18]
  assign io_dataOut = _T_8 ? _GEN_7 : _GEN_35; // @[dut.scala 49:28 50:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:25]
      stackMem_0 <= 4'h0; // @[dut.scala 17:25]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stackMem_0 <= 4'h0; // @[dut.scala 33:21]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 35:36]
        stackMem_0 <= _GEN_0;
      end else begin
        stackMem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 17:25]
      stackMem_1 <= 4'h0; // @[dut.scala 17:25]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stackMem_1 <= 4'h0; // @[dut.scala 33:21]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 35:36]
        stackMem_1 <= _GEN_1;
      end else begin
        stackMem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 17:25]
      stackMem_2 <= 4'h0; // @[dut.scala 17:25]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stackMem_2 <= 4'h0; // @[dut.scala 33:21]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 35:36]
        stackMem_2 <= _GEN_2;
      end else begin
        stackMem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 17:25]
      stackMem_3 <= 4'h0; // @[dut.scala 17:25]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stackMem_3 <= 4'h0; // @[dut.scala 33:21]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 35:36]
        stackMem_3 <= _GEN_3;
      end else begin
        stackMem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 20:19]
      sp <= 3'h4; // @[dut.scala 20:19]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        sp <= 3'h4; // @[dut.scala 31:10]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 35:36]
        sp <= _T_5; // @[dut.scala 38:10]
      end else begin
        sp <= _GEN_17;
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
  sp = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
