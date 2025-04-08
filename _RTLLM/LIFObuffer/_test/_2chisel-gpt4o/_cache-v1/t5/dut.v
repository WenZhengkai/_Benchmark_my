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
  reg [3:0] stack_mem_0; // @[dut.scala 16:26]
  reg [3:0] stack_mem_1; // @[dut.scala 16:26]
  reg [3:0] stack_mem_2; // @[dut.scala 16:26]
  reg [3:0] stack_mem_3; // @[dut.scala 16:26]
  reg [2:0] SP; // @[dut.scala 17:19]
  wire [3:0] _GEN_1 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 36:{22,22}]
  wire [3:0] _GEN_2 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_1; // @[dut.scala 36:{22,22}]
  wire [3:0] _GEN_3 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_2; // @[dut.scala 36:{22,22}]
  wire [3:0] _GEN_4 = 2'h0 == SP[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 37:{25,25} 16:26]
  wire [3:0] _GEN_5 = 2'h1 == SP[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 37:{25,25} 16:26]
  wire [3:0] _GEN_6 = 2'h2 == SP[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 37:{25,25} 16:26]
  wire [3:0] _GEN_7 = 2'h3 == SP[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 37:{25,25} 16:26]
  wire [2:0] _SP_T_1 = SP + 3'h1; // @[dut.scala 38:20]
  wire [3:0] _GEN_8 = ~io_EMPTY ? _GEN_3 : 4'h0; // @[dut.scala 20:14 35:25 36:22]
  wire [3:0] _GEN_9 = ~io_EMPTY ? _GEN_4 : stack_mem_0; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_10 = ~io_EMPTY ? _GEN_5 : stack_mem_1; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_11 = ~io_EMPTY ? _GEN_6 : stack_mem_2; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_12 = ~io_EMPTY ? _GEN_7 : stack_mem_3; // @[dut.scala 35:25 16:26]
  wire [2:0] _GEN_13 = ~io_EMPTY ? _SP_T_1 : SP; // @[dut.scala 35:25 38:14 17:19]
  wire [2:0] _SP_T_3 = SP - 3'h1; // @[dut.scala 43:20]
  wire [3:0] _GEN_14 = 2'h0 == _SP_T_3[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 16:26 44:{31,31}]
  wire [3:0] _GEN_15 = 2'h1 == _SP_T_3[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 16:26 44:{31,31}]
  wire [3:0] _GEN_16 = 2'h2 == _SP_T_3[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 16:26 44:{31,31}]
  wire [3:0] _GEN_17 = 2'h3 == _SP_T_3[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 16:26 44:{31,31}]
  wire [2:0] _GEN_18 = ~io_FULL ? _SP_T_3 : SP; // @[dut.scala 42:24 43:14 17:19]
  wire [3:0] _GEN_19 = ~io_FULL ? _GEN_14 : stack_mem_0; // @[dut.scala 42:24 16:26]
  wire [3:0] _GEN_20 = ~io_FULL ? _GEN_15 : stack_mem_1; // @[dut.scala 42:24 16:26]
  wire [3:0] _GEN_21 = ~io_FULL ? _GEN_16 : stack_mem_2; // @[dut.scala 42:24 16:26]
  wire [3:0] _GEN_22 = ~io_FULL ? _GEN_17 : stack_mem_3; // @[dut.scala 42:24 16:26]
  wire [3:0] _GEN_23 = io_RW ? _GEN_8 : 4'h0; // @[dut.scala 20:14 33:19]
  wire [3:0] _GEN_34 = reset ? 4'h0 : _GEN_23; // @[dut.scala 20:14 29:24]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 23:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 24:18]
  assign io_dataOut = io_EN ? _GEN_34 : 4'h0; // @[dut.scala 20:14 27:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 27:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 31:17]
      end else if (io_RW) begin // @[dut.scala 33:19]
        stack_mem_0 <= _GEN_9;
      end else begin
        stack_mem_0 <= _GEN_19;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 27:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 31:17]
      end else if (io_RW) begin // @[dut.scala 33:19]
        stack_mem_1 <= _GEN_10;
      end else begin
        stack_mem_1 <= _GEN_20;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 27:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 31:17]
      end else if (io_RW) begin // @[dut.scala 33:19]
        stack_mem_2 <= _GEN_11;
      end else begin
        stack_mem_2 <= _GEN_21;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 27:15]
      if (reset) begin // @[dut.scala 29:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 31:17]
      end else if (io_RW) begin // @[dut.scala 33:19]
        stack_mem_3 <= _GEN_12;
      end else begin
        stack_mem_3 <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 17:19]
      SP <= 3'h4; // @[dut.scala 17:19]
    end else if (io_EN) begin // @[dut.scala 27:15]
      if (reset) begin // @[dut.scala 29:24]
        SP <= 3'h4; // @[dut.scala 30:10]
      end else if (io_RW) begin // @[dut.scala 33:19]
        SP <= _GEN_13;
      end else begin
        SP <= _GEN_18;
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
