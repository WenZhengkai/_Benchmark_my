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
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stack_mem_0; // @[dut.scala 18:26]
  reg [3:0] stack_mem_1; // @[dut.scala 18:26]
  reg [3:0] stack_mem_2; // @[dut.scala 18:26]
  reg [3:0] stack_mem_3; // @[dut.scala 18:26]
  reg [2:0] SP; // @[dut.scala 19:19]
  reg  emptyReg; // @[dut.scala 22:25]
  reg  fullReg; // @[dut.scala 23:24]
  reg [3:0] dataOutReg; // @[dut.scala 24:27]
  wire [2:0] _T_5 = SP - 3'h1; // @[dut.scala 44:22]
  wire [3:0] _GEN_0 = 2'h0 == _T_5[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 18:26 44:{29,29}]
  wire [3:0] _GEN_1 = 2'h1 == _T_5[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 18:26 44:{29,29}]
  wire [3:0] _GEN_2 = 2'h2 == _T_5[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 18:26 44:{29,29}]
  wire [3:0] _GEN_3 = 2'h3 == _T_5[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 18:26 44:{29,29}]
  wire [3:0] _GEN_4 = ~io_RW & ~fullReg ? _GEN_0 : stack_mem_0; // @[dut.scala 18:26 43:32]
  wire [3:0] _GEN_5 = ~io_RW & ~fullReg ? _GEN_1 : stack_mem_1; // @[dut.scala 18:26 43:32]
  wire [3:0] _GEN_6 = ~io_RW & ~fullReg ? _GEN_2 : stack_mem_2; // @[dut.scala 18:26 43:32]
  wire [3:0] _GEN_7 = ~io_RW & ~fullReg ? _GEN_3 : stack_mem_3; // @[dut.scala 18:26 43:32]
  wire [2:0] _GEN_8 = ~io_RW & ~fullReg ? _T_5 : SP; // @[dut.scala 43:32 45:12 19:19]
  wire  _GEN_9 = ~io_RW & ~fullReg ? 1'h0 : emptyReg; // @[dut.scala 43:32 46:18 22:25]
  wire  _GEN_10 = ~io_RW & ~fullReg ? _T_5 == 3'h0 : fullReg; // @[dut.scala 43:32 47:17 23:24]
  wire [3:0] _GEN_12 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 52:{20,20}]
  wire [3:0] _GEN_13 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_12; // @[dut.scala 52:{20,20}]
  wire [3:0] _GEN_14 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_13; // @[dut.scala 52:{20,20}]
  wire [3:0] _GEN_15 = 2'h0 == SP[1:0] ? 4'h0 : _GEN_4; // @[dut.scala 53:{23,23}]
  wire [3:0] _GEN_16 = 2'h1 == SP[1:0] ? 4'h0 : _GEN_5; // @[dut.scala 53:{23,23}]
  wire [3:0] _GEN_17 = 2'h2 == SP[1:0] ? 4'h0 : _GEN_6; // @[dut.scala 53:{23,23}]
  wire [3:0] _GEN_18 = 2'h3 == SP[1:0] ? 4'h0 : _GEN_7; // @[dut.scala 53:{23,23}]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 54:18]
  wire  _GEN_26 = io_RW & ~emptyReg ? _SP_T_3 == 3'h4 : _GEN_9; // @[dut.scala 51:32 56:18]
  wire  _GEN_32 = reset | _GEN_26; // @[dut.scala 32:24 38:16]
  wire  _GEN_40 = io_EN ? _GEN_32 : emptyReg; // @[dut.scala 31:15 22:25]
  assign io_EMPTY = emptyReg; // @[dut.scala 27:12]
  assign io_FULL = fullReg; // @[dut.scala 28:11]
  assign io_dataOut = dataOutReg; // @[dut.scala 29:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 18:26]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 36:22]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        stack_mem_0 <= _GEN_15;
      end else begin
        stack_mem_0 <= _GEN_4;
      end
    end
    if (reset) begin // @[dut.scala 18:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 18:26]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 36:22]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        stack_mem_1 <= _GEN_16;
      end else begin
        stack_mem_1 <= _GEN_5;
      end
    end
    if (reset) begin // @[dut.scala 18:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 18:26]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 36:22]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        stack_mem_2 <= _GEN_17;
      end else begin
        stack_mem_2 <= _GEN_6;
      end
    end
    if (reset) begin // @[dut.scala 18:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 18:26]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 36:22]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        stack_mem_3 <= _GEN_18;
      end else begin
        stack_mem_3 <= _GEN_7;
      end
    end
    if (reset) begin // @[dut.scala 19:19]
      SP <= 3'h4; // @[dut.scala 19:19]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        SP <= 3'h4; // @[dut.scala 34:10]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        SP <= _SP_T_3; // @[dut.scala 54:12]
      end else begin
        SP <= _GEN_8;
      end
    end
    emptyReg <= reset | _GEN_40; // @[dut.scala 22:{25,25}]
    if (reset) begin // @[dut.scala 23:24]
      fullReg <= 1'h0; // @[dut.scala 23:24]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        fullReg <= 1'h0; // @[dut.scala 39:15]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        fullReg <= 1'h0; // @[dut.scala 55:17]
      end else begin
        fullReg <= _GEN_10;
      end
    end
    if (reset) begin // @[dut.scala 24:27]
      dataOutReg <= 4'h0; // @[dut.scala 24:27]
    end else if (io_EN) begin // @[dut.scala 31:15]
      if (reset) begin // @[dut.scala 32:24]
        dataOutReg <= 4'h0; // @[dut.scala 40:18]
      end else if (io_RW & ~emptyReg) begin // @[dut.scala 51:32]
        dataOutReg <= _GEN_14; // @[dut.scala 52:20]
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
  SP = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  emptyReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  fullReg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  dataOutReg = _RAND_7[3:0];
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
  wire  lifo_clock; // @[dut.scala 74:20]
  wire  lifo_reset; // @[dut.scala 74:20]
  wire [3:0] lifo_io_dataIn; // @[dut.scala 74:20]
  wire  lifo_io_RW; // @[dut.scala 74:20]
  wire  lifo_io_EN; // @[dut.scala 74:20]
  wire  lifo_io_EMPTY; // @[dut.scala 74:20]
  wire  lifo_io_FULL; // @[dut.scala 74:20]
  wire [3:0] lifo_io_dataOut; // @[dut.scala 74:20]
  LIFO lifo ( // @[dut.scala 74:20]
    .clock(lifo_clock),
    .reset(lifo_reset),
    .io_dataIn(lifo_io_dataIn),
    .io_RW(lifo_io_RW),
    .io_EN(lifo_io_EN),
    .io_EMPTY(lifo_io_EMPTY),
    .io_FULL(lifo_io_FULL),
    .io_dataOut(lifo_io_dataOut)
  );
  assign io_EMPTY = lifo_io_EMPTY; // @[dut.scala 81:12]
  assign io_FULL = lifo_io_FULL; // @[dut.scala 82:11]
  assign io_dataOut = lifo_io_dataOut; // @[dut.scala 83:14]
  assign lifo_clock = clock;
  assign lifo_reset = reset;
  assign lifo_io_dataIn = io_dataIn; // @[dut.scala 77:18]
  assign lifo_io_RW = io_RW; // @[dut.scala 78:14]
  assign lifo_io_EN = io_EN; // @[dut.scala 79:14]
endmodule
