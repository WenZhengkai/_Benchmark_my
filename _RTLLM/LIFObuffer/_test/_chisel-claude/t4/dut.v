module LIFO(
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
  reg [3:0] stack_mem_0; // @[dut.scala 19:26]
  reg [3:0] stack_mem_1; // @[dut.scala 19:26]
  reg [3:0] stack_mem_2; // @[dut.scala 19:26]
  reg [3:0] stack_mem_3; // @[dut.scala 19:26]
  reg [2:0] sp; // @[dut.scala 20:19]
  wire [2:0] _sp_T_1 = sp - 3'h1; // @[dut.scala 38:18]
  wire [3:0] _GEN_0 = 2'h0 == _sp_T_1[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 19:26 39:{29,29}]
  wire [3:0] _GEN_1 = 2'h1 == _sp_T_1[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 19:26 39:{29,29}]
  wire [3:0] _GEN_2 = 2'h2 == _sp_T_1[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 19:26 39:{29,29}]
  wire [3:0] _GEN_3 = 2'h3 == _sp_T_1[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 19:26 39:{29,29}]
  wire [3:0] _GEN_5 = 2'h1 == sp[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 42:{20,20}]
  wire [3:0] _GEN_6 = 2'h2 == sp[1:0] ? stack_mem_2 : _GEN_5; // @[dut.scala 42:{20,20}]
  wire [3:0] _GEN_7 = 2'h3 == sp[1:0] ? stack_mem_3 : _GEN_6; // @[dut.scala 42:{20,20}]
  wire [3:0] _GEN_8 = 2'h0 == sp[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 43:{23,23} 19:26]
  wire [3:0] _GEN_9 = 2'h1 == sp[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 43:{23,23} 19:26]
  wire [3:0] _GEN_10 = 2'h2 == sp[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 43:{23,23} 19:26]
  wire [3:0] _GEN_11 = 2'h3 == sp[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 43:{23,23} 19:26]
  wire [2:0] _sp_T_3 = sp + 3'h1; // @[dut.scala 44:18]
  wire [3:0] _GEN_12 = io_RW & ~io_EMPTY ? _GEN_7 : 4'h0; // @[dut.scala 23:14 40:38 42:20]
  wire [3:0] _GEN_13 = io_RW & ~io_EMPTY ? _GEN_8 : stack_mem_0; // @[dut.scala 19:26 40:38]
  wire [3:0] _GEN_14 = io_RW & ~io_EMPTY ? _GEN_9 : stack_mem_1; // @[dut.scala 19:26 40:38]
  wire [3:0] _GEN_15 = io_RW & ~io_EMPTY ? _GEN_10 : stack_mem_2; // @[dut.scala 19:26 40:38]
  wire [3:0] _GEN_16 = io_RW & ~io_EMPTY ? _GEN_11 : stack_mem_3; // @[dut.scala 19:26 40:38]
  wire [2:0] _GEN_17 = io_RW & ~io_EMPTY ? _sp_T_3 : sp; // @[dut.scala 40:38 44:12 20:19]
  wire [3:0] _GEN_23 = ~io_RW & ~io_FULL ? 4'h0 : _GEN_12; // @[dut.scala 23:14 36:32]
  wire [3:0] _GEN_29 = reset ? 4'h0 : _GEN_23; // @[dut.scala 23:14 29:24]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 24:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 25:18]
  assign io_dataOut = io_EN ? _GEN_29 : 4'h0; // @[dut.scala 23:14 28:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 33:22]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 36:32]
        stack_mem_0 <= _GEN_0;
      end else begin
        stack_mem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 33:22]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 36:32]
        stack_mem_1 <= _GEN_1;
      end else begin
        stack_mem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 33:22]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 36:32]
        stack_mem_2 <= _GEN_2;
      end else begin
        stack_mem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 33:22]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 36:32]
        stack_mem_3 <= _GEN_3;
      end else begin
        stack_mem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 20:19]
      sp <= 3'h4; // @[dut.scala 20:19]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:24]
        sp <= 3'h4; // @[dut.scala 31:10]
      end else if (~io_RW & ~io_FULL) begin // @[dut.scala 36:32]
        sp <= _sp_T_1; // @[dut.scala 38:12]
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
  stack_mem_0 = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  stack_mem_1 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  stack_mem_2 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  stack_mem_3 = _RAND_3[3:0];
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
  wire  lifo_clock; // @[dut.scala 62:20]
  wire  lifo_reset; // @[dut.scala 62:20]
  wire [3:0] lifo_io_dataIn; // @[dut.scala 62:20]
  wire  lifo_io_RW; // @[dut.scala 62:20]
  wire  lifo_io_EN; // @[dut.scala 62:20]
  wire  lifo_io_EMPTY; // @[dut.scala 62:20]
  wire  lifo_io_FULL; // @[dut.scala 62:20]
  wire [3:0] lifo_io_dataOut; // @[dut.scala 62:20]
  LIFO lifo ( // @[dut.scala 62:20]
    .clock(lifo_clock),
    .reset(lifo_reset),
    .io_dataIn(lifo_io_dataIn),
    .io_RW(lifo_io_RW),
    .io_EN(lifo_io_EN),
    .io_EMPTY(lifo_io_EMPTY),
    .io_FULL(lifo_io_FULL),
    .io_dataOut(lifo_io_dataOut)
  );
  assign io_EMPTY = lifo_io_EMPTY; // @[dut.scala 69:12]
  assign io_FULL = lifo_io_FULL; // @[dut.scala 70:11]
  assign io_dataOut = lifo_io_dataOut; // @[dut.scala 71:14]
  assign lifo_clock = clock;
  assign lifo_reset = reset;
  assign lifo_io_dataIn = io_dataIn; // @[dut.scala 65:18]
  assign lifo_io_RW = io_RW; // @[dut.scala 66:14]
  assign lifo_io_EN = io_EN; // @[dut.scala 67:14]
endmodule
