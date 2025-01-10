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
  reg [3:0] stackMem_0; // @[dut.scala 16:25]
  reg [3:0] stackMem_1; // @[dut.scala 16:25]
  reg [3:0] stackMem_2; // @[dut.scala 16:25]
  reg [3:0] stackMem_3; // @[dut.scala 16:25]
  reg [2:0] sp; // @[dut.scala 17:19]
  wire [2:0] _sp_T_1 = sp - 3'h1; // @[dut.scala 29:20]
  wire [3:0] _GEN_0 = 2'h0 == _sp_T_1[1:0] ? io_dataIn : stackMem_0; // @[dut.scala 16:25 30:{30,30}]
  wire [3:0] _GEN_1 = 2'h1 == _sp_T_1[1:0] ? io_dataIn : stackMem_1; // @[dut.scala 16:25 30:{30,30}]
  wire [3:0] _GEN_2 = 2'h2 == _sp_T_1[1:0] ? io_dataIn : stackMem_2; // @[dut.scala 16:25 30:{30,30}]
  wire [3:0] _GEN_3 = 2'h3 == _sp_T_1[1:0] ? io_dataIn : stackMem_3; // @[dut.scala 16:25 30:{30,30}]
  wire [2:0] _GEN_4 = sp > 3'h0 ? _sp_T_1 : sp; // @[dut.scala 28:24 29:14 17:19]
  wire [3:0] _GEN_5 = sp > 3'h0 ? _GEN_0 : stackMem_0; // @[dut.scala 28:24 16:25]
  wire [3:0] _GEN_6 = sp > 3'h0 ? _GEN_1 : stackMem_1; // @[dut.scala 28:24 16:25]
  wire [3:0] _GEN_7 = sp > 3'h0 ? _GEN_2 : stackMem_2; // @[dut.scala 28:24 16:25]
  wire [3:0] _GEN_8 = sp > 3'h0 ? _GEN_3 : stackMem_3; // @[dut.scala 28:24 16:25]
  wire  _T_9 = ~io_EMPTY; // @[dut.scala 32:39]
  wire [3:0] _GEN_10 = 2'h1 == sp[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 33:{20,20}]
  wire [3:0] _GEN_11 = 2'h2 == sp[1:0] ? stackMem_2 : _GEN_10; // @[dut.scala 33:{20,20}]
  wire [3:0] _GEN_12 = 2'h3 == sp[1:0] ? stackMem_3 : _GEN_11; // @[dut.scala 33:{20,20}]
  wire [3:0] _GEN_13 = 2'h0 == sp[1:0] ? 4'h0 : stackMem_0; // @[dut.scala 35:{24,24} 16:25]
  wire [3:0] _GEN_14 = 2'h1 == sp[1:0] ? 4'h0 : stackMem_1; // @[dut.scala 35:{24,24} 16:25]
  wire [3:0] _GEN_15 = 2'h2 == sp[1:0] ? 4'h0 : stackMem_2; // @[dut.scala 35:{24,24} 16:25]
  wire [3:0] _GEN_16 = 2'h3 == sp[1:0] ? 4'h0 : stackMem_3; // @[dut.scala 35:{24,24} 16:25]
  wire [2:0] _sp_T_3 = sp + 3'h1; // @[dut.scala 36:20]
  wire [3:0] _GEN_17 = sp < 3'h4 ? _GEN_13 : stackMem_0; // @[dut.scala 34:24 16:25]
  wire [3:0] _GEN_18 = sp < 3'h4 ? _GEN_14 : stackMem_1; // @[dut.scala 34:24 16:25]
  wire [3:0] _GEN_19 = sp < 3'h4 ? _GEN_15 : stackMem_2; // @[dut.scala 34:24 16:25]
  wire [3:0] _GEN_20 = sp < 3'h4 ? _GEN_16 : stackMem_3; // @[dut.scala 34:24 16:25]
  wire [2:0] _GEN_21 = sp < 3'h4 ? _sp_T_3 : sp; // @[dut.scala 34:24 36:14 17:19]
  wire [3:0] _GEN_22 = io_RW & ~io_EMPTY ? _GEN_17 : stackMem_0; // @[dut.scala 16:25 32:50]
  wire [3:0] _GEN_23 = io_RW & ~io_EMPTY ? _GEN_18 : stackMem_1; // @[dut.scala 16:25 32:50]
  wire [3:0] _GEN_24 = io_RW & ~io_EMPTY ? _GEN_19 : stackMem_2; // @[dut.scala 16:25 32:50]
  wire [3:0] _GEN_25 = io_RW & ~io_EMPTY ? _GEN_20 : stackMem_3; // @[dut.scala 16:25 32:50]
  wire [2:0] _GEN_26 = io_RW & ~io_EMPTY ? _GEN_21 : sp; // @[dut.scala 17:19 32:50]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 43:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 44:18]
  assign io_dataOut = io_RW & io_EN & _T_9 ? _GEN_12 : 4'h0; // @[dut.scala 45:14 48:48 49:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:25]
      stackMem_0 <= 4'h0; // @[dut.scala 16:25]
    end else if (reset) begin // @[dut.scala 20:23]
      stackMem_0 <= 4'h0; // @[dut.scala 23:19]
    end else if (io_EN) begin // @[dut.scala 26:17]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 27:43]
        stackMem_0 <= _GEN_5;
      end else begin
        stackMem_0 <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_1 <= 4'h0; // @[dut.scala 16:25]
    end else if (reset) begin // @[dut.scala 20:23]
      stackMem_1 <= 4'h0; // @[dut.scala 23:19]
    end else if (io_EN) begin // @[dut.scala 26:17]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 27:43]
        stackMem_1 <= _GEN_6;
      end else begin
        stackMem_1 <= _GEN_23;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_2 <= 4'h0; // @[dut.scala 16:25]
    end else if (reset) begin // @[dut.scala 20:23]
      stackMem_2 <= 4'h0; // @[dut.scala 23:19]
    end else if (io_EN) begin // @[dut.scala 26:17]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 27:43]
        stackMem_2 <= _GEN_7;
      end else begin
        stackMem_2 <= _GEN_24;
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      stackMem_3 <= 4'h0; // @[dut.scala 16:25]
    end else if (reset) begin // @[dut.scala 20:23]
      stackMem_3 <= 4'h0; // @[dut.scala 23:19]
    end else if (io_EN) begin // @[dut.scala 26:17]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 27:43]
        stackMem_3 <= _GEN_8;
      end else begin
        stackMem_3 <= _GEN_25;
      end
    end
    if (reset) begin // @[dut.scala 17:19]
      sp <= 3'h4; // @[dut.scala 17:19]
    end else if (reset) begin // @[dut.scala 20:23]
      sp <= 3'h4; // @[dut.scala 21:8]
    end else if (io_EN) begin // @[dut.scala 26:17]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 27:43]
        sp <= _GEN_4;
      end else begin
        sp <= _GEN_26;
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
