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
  reg [3:0] stack_mem_0; // @[dut.scala 20:26]
  reg [3:0] stack_mem_1; // @[dut.scala 20:26]
  reg [3:0] stack_mem_2; // @[dut.scala 20:26]
  reg [3:0] stack_mem_3; // @[dut.scala 20:26]
  reg [2:0] SP; // @[dut.scala 21:19]
  wire [2:0] _T_5 = SP - 3'h1; // @[dut.scala 39:20]
  wire [3:0] _GEN_0 = 2'h0 == _T_5[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 20:26 39:{27,27}]
  wire [3:0] _GEN_1 = 2'h1 == _T_5[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 20:26 39:{27,27}]
  wire [3:0] _GEN_2 = 2'h2 == _T_5[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 20:26 39:{27,27}]
  wire [3:0] _GEN_3 = 2'h3 == _T_5[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 20:26 39:{27,27}]
  wire [3:0] _GEN_5 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 42:{18,18}]
  wire [3:0] _GEN_6 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_5; // @[dut.scala 42:{18,18}]
  wire [3:0] _GEN_7 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_6; // @[dut.scala 42:{18,18}]
  wire [3:0] _GEN_8 = 2'h0 == SP[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 43:{21,21} 20:26]
  wire [3:0] _GEN_9 = 2'h1 == SP[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 43:{21,21} 20:26]
  wire [3:0] _GEN_10 = 2'h2 == SP[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 43:{21,21} 20:26]
  wire [3:0] _GEN_11 = 2'h3 == SP[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 43:{21,21} 20:26]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 44:16]
  wire [3:0] _GEN_12 = io_RW & ~io_EMPTY ? _GEN_7 : 4'h0; // @[dut.scala 28:14 41:36 42:18]
  wire [3:0] _GEN_13 = io_RW & ~io_EMPTY ? _GEN_8 : stack_mem_0; // @[dut.scala 20:26 41:36]
  wire [3:0] _GEN_14 = io_RW & ~io_EMPTY ? _GEN_9 : stack_mem_1; // @[dut.scala 20:26 41:36]
  wire [3:0] _GEN_15 = io_RW & ~io_EMPTY ? _GEN_10 : stack_mem_2; // @[dut.scala 20:26 41:36]
  wire [3:0] _GEN_16 = io_RW & ~io_EMPTY ? _GEN_11 : stack_mem_3; // @[dut.scala 20:26 41:36]
  wire [2:0] _GEN_17 = io_RW & ~io_EMPTY ? _SP_T_3 : SP; // @[dut.scala 41:36 44:10 21:19]
  wire [3:0] _GEN_23 = ~io_RW & ~io_FULL ? 4'h0 : _GEN_12; // @[dut.scala 28:14 38:30]
  wire [3:0] _GEN_29 = io_EN ? _GEN_23 : 4'h0; // @[dut.scala 28:14 37:21]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 24:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 25:18]
  assign io_dataOut = reset ? 4'h0 : _GEN_29; // @[dut.scala 28:14 31:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 20:26]
    end else if (reset) begin // @[dut.scala 31:22]
      stack_mem_0 <= 4'h0; // @[dut.scala 34:20]
    end else if (io_EN) begin // @[dut.scala 37:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 38:30]
        stack_mem_0 <= _GEN_0;
      end else begin
        stack_mem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 20:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 20:26]
    end else if (reset) begin // @[dut.scala 31:22]
      stack_mem_1 <= 4'h0; // @[dut.scala 34:20]
    end else if (io_EN) begin // @[dut.scala 37:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 38:30]
        stack_mem_1 <= _GEN_1;
      end else begin
        stack_mem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 20:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 20:26]
    end else if (reset) begin // @[dut.scala 31:22]
      stack_mem_2 <= 4'h0; // @[dut.scala 34:20]
    end else if (io_EN) begin // @[dut.scala 37:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 38:30]
        stack_mem_2 <= _GEN_2;
      end else begin
        stack_mem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 20:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 20:26]
    end else if (reset) begin // @[dut.scala 31:22]
      stack_mem_3 <= 4'h0; // @[dut.scala 34:20]
    end else if (io_EN) begin // @[dut.scala 37:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 38:30]
        stack_mem_3 <= _GEN_3;
      end else begin
        stack_mem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 21:19]
      SP <= 3'h4; // @[dut.scala 21:19]
    end else if (reset) begin // @[dut.scala 31:22]
      SP <= 3'h4; // @[dut.scala 36:8]
    end else if (io_EN) begin // @[dut.scala 37:21]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 38:30]
        SP <= _T_5; // @[dut.scala 40:10]
      end else begin
        SP <= _GEN_17;
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
