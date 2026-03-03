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
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stackMem_0; // @[dut.scala 16:25]
  reg [3:0] stackMem_1; // @[dut.scala 16:25]
  reg [3:0] stackMem_2; // @[dut.scala 16:25]
  reg [3:0] stackMem_3; // @[dut.scala 16:25]
  reg [2:0] sp; // @[dut.scala 18:25]
  reg [3:0] dataOutR; // @[dut.scala 19:25]
  wire  empty = sp == 3'h4; // @[dut.scala 21:19]
  wire  full = sp == 3'h0; // @[dut.scala 22:19]
  wire [2:0] nextSp = sp - 3'h1; // @[dut.scala 34:25]
  wire [3:0] _GEN_0 = 2'h0 == nextSp[1:0] ? io_dataIn : stackMem_0; // @[dut.scala 16:25 35:{26,26}]
  wire [3:0] _GEN_1 = 2'h1 == nextSp[1:0] ? io_dataIn : stackMem_1; // @[dut.scala 16:25 35:{26,26}]
  wire [3:0] _GEN_2 = 2'h2 == nextSp[1:0] ? io_dataIn : stackMem_2; // @[dut.scala 16:25 35:{26,26}]
  wire [3:0] _GEN_3 = 2'h3 == nextSp[1:0] ? io_dataIn : stackMem_3; // @[dut.scala 16:25 35:{26,26}]
  wire [3:0] _GEN_5 = 2'h1 == sp[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 40:{18,18}]
  wire [3:0] _GEN_6 = 2'h2 == sp[1:0] ? stackMem_2 : _GEN_5; // @[dut.scala 40:{18,18}]
  wire [3:0] _GEN_7 = 2'h3 == sp[1:0] ? stackMem_3 : _GEN_6; // @[dut.scala 40:{18,18}]
  wire [3:0] _GEN_8 = 2'h0 == sp[1:0] ? 4'h0 : stackMem_0; // @[dut.scala 41:{22,22} 16:25]
  wire [3:0] _GEN_9 = 2'h1 == sp[1:0] ? 4'h0 : stackMem_1; // @[dut.scala 41:{22,22} 16:25]
  wire [3:0] _GEN_10 = 2'h2 == sp[1:0] ? 4'h0 : stackMem_2; // @[dut.scala 41:{22,22} 16:25]
  wire [3:0] _GEN_11 = 2'h3 == sp[1:0] ? 4'h0 : stackMem_3; // @[dut.scala 41:{22,22} 16:25]
  wire [2:0] _sp_T_1 = sp + 3'h1; // @[dut.scala 42:18]
  wire [3:0] _GEN_12 = io_RW & ~empty ? _GEN_7 : dataOutR; // @[dut.scala 39:34 40:18 19:25]
  wire [3:0] _GEN_13 = io_RW & ~empty ? _GEN_8 : stackMem_0; // @[dut.scala 16:25 39:34]
  wire [3:0] _GEN_14 = io_RW & ~empty ? _GEN_9 : stackMem_1; // @[dut.scala 16:25 39:34]
  wire [3:0] _GEN_15 = io_RW & ~empty ? _GEN_10 : stackMem_2; // @[dut.scala 16:25 39:34]
  wire [3:0] _GEN_16 = io_RW & ~empty ? _GEN_11 : stackMem_3; // @[dut.scala 16:25 39:34]
  wire [2:0] _GEN_17 = io_RW & ~empty ? _sp_T_1 : sp; // @[dut.scala 39:34 42:12 18:25]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 21:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 22:19]
  assign io_dataOut = dataOutR; // @[dut.scala 49:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:25]
      stackMem_0 <= 4'h0; // @[dut.scala 16:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        stackMem_0 <= 4'h0; // @[dut.scala 29:21]
      end else if (~io_RW & ~full) begin // @[dut.scala 33:29]
        stackMem_0 <= _GEN_0;
      end else begin
        stackMem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_1 <= 4'h0; // @[dut.scala 16:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        stackMem_1 <= 4'h0; // @[dut.scala 29:21]
      end else if (~io_RW & ~full) begin // @[dut.scala 33:29]
        stackMem_1 <= _GEN_1;
      end else begin
        stackMem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_2 <= 4'h0; // @[dut.scala 16:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        stackMem_2 <= 4'h0; // @[dut.scala 29:21]
      end else if (~io_RW & ~full) begin // @[dut.scala 33:29]
        stackMem_2 <= _GEN_2;
      end else begin
        stackMem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_3 <= 4'h0; // @[dut.scala 16:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        stackMem_3 <= 4'h0; // @[dut.scala 29:21]
      end else if (~io_RW & ~full) begin // @[dut.scala 33:29]
        stackMem_3 <= _GEN_3;
      end else begin
        stackMem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 18:25]
      sp <= 3'h4; // @[dut.scala 18:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        sp <= 3'h4; // @[dut.scala 26:10]
      end else if (~io_RW & ~full) begin // @[dut.scala 33:29]
        sp <= nextSp; // @[dut.scala 36:12]
      end else begin
        sp <= _GEN_17;
      end
    end
    if (reset) begin // @[dut.scala 19:25]
      dataOutR <= 4'h0; // @[dut.scala 19:25]
    end else if (io_EN) begin // @[dut.scala 24:15]
      if (reset) begin // @[dut.scala 25:24]
        dataOutR <= 4'h0; // @[dut.scala 27:16]
      end else if (!(~io_RW & ~full)) begin // @[dut.scala 33:29]
        dataOutR <= _GEN_12;
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
  _RAND_5 = {1{`RANDOM}};
  dataOutR = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
