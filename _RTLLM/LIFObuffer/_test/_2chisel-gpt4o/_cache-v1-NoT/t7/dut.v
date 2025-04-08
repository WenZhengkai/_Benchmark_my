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
  reg [3:0] stack_mem_0; // @[dut.scala 15:26]
  reg [3:0] stack_mem_1; // @[dut.scala 15:26]
  reg [3:0] stack_mem_2; // @[dut.scala 15:26]
  reg [3:0] stack_mem_3; // @[dut.scala 15:26]
  reg [2:0] SP; // @[dut.scala 16:19]
  wire [2:0] _T_5 = SP - 3'h1; // @[dut.scala 25:18]
  wire [3:0] _GEN_0 = 2'h0 == _T_5[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 25:{25,25} 15:26]
  wire [3:0] _GEN_1 = 2'h1 == _T_5[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 25:{25,25} 15:26]
  wire [3:0] _GEN_2 = 2'h2 == _T_5[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 25:{25,25} 15:26]
  wire [3:0] _GEN_3 = 2'h3 == _T_5[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 25:{25,25} 15:26]
  wire [3:0] _GEN_4 = io_EN & ~io_RW & ~io_FULL ? _GEN_0 : stack_mem_0; // @[dut.scala 15:26 24:37]
  wire [3:0] _GEN_5 = io_EN & ~io_RW & ~io_FULL ? _GEN_1 : stack_mem_1; // @[dut.scala 15:26 24:37]
  wire [3:0] _GEN_6 = io_EN & ~io_RW & ~io_FULL ? _GEN_2 : stack_mem_2; // @[dut.scala 15:26 24:37]
  wire [3:0] _GEN_7 = io_EN & ~io_RW & ~io_FULL ? _GEN_3 : stack_mem_3; // @[dut.scala 15:26 24:37]
  wire [3:0] _GEN_10 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 31:{16,16}]
  wire [3:0] _GEN_11 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_10; // @[dut.scala 31:{16,16}]
  wire [3:0] _GEN_12 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_11; // @[dut.scala 31:{16,16}]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 33:14]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 20:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 21:18]
  assign io_dataOut = io_EN & io_RW & ~io_EMPTY ? _GEN_12 : 4'h0; // @[dut.scala 19:14 30:37 31:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN & io_RW & ~io_EMPTY) begin // @[dut.scala 30:37]
      if (2'h0 == SP[1:0]) begin // @[dut.scala 32:19]
        stack_mem_0 <= 4'h0; // @[dut.scala 32:19]
      end else begin
        stack_mem_0 <= _GEN_4;
      end
    end else begin
      stack_mem_0 <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN & io_RW & ~io_EMPTY) begin // @[dut.scala 30:37]
      if (2'h1 == SP[1:0]) begin // @[dut.scala 32:19]
        stack_mem_1 <= 4'h0; // @[dut.scala 32:19]
      end else begin
        stack_mem_1 <= _GEN_5;
      end
    end else begin
      stack_mem_1 <= _GEN_5;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN & io_RW & ~io_EMPTY) begin // @[dut.scala 30:37]
      if (2'h2 == SP[1:0]) begin // @[dut.scala 32:19]
        stack_mem_2 <= 4'h0; // @[dut.scala 32:19]
      end else begin
        stack_mem_2 <= _GEN_6;
      end
    end else begin
      stack_mem_2 <= _GEN_6;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN & io_RW & ~io_EMPTY) begin // @[dut.scala 30:37]
      if (2'h3 == SP[1:0]) begin // @[dut.scala 32:19]
        stack_mem_3 <= 4'h0; // @[dut.scala 32:19]
      end else begin
        stack_mem_3 <= _GEN_7;
      end
    end else begin
      stack_mem_3 <= _GEN_7;
    end
    if (reset) begin // @[dut.scala 16:19]
      SP <= 3'h4; // @[dut.scala 16:19]
    end else if (io_EN & io_RW & ~io_EMPTY) begin // @[dut.scala 30:37]
      SP <= _SP_T_3; // @[dut.scala 33:8]
    end else if (io_EN & ~io_RW & ~io_FULL) begin // @[dut.scala 24:37]
      SP <= _T_5; // @[dut.scala 26:8]
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
