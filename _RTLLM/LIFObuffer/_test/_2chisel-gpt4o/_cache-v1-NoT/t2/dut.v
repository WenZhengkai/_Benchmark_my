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
  reg [2:0] SP; // @[dut.scala 17:19]
  wire [3:0] _GEN_1 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_2 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_1; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_3 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_2; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_4 = 2'h0 == SP[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_5 = 2'h1 == SP[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_6 = 2'h2 == SP[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_7 = 2'h3 == SP[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 37:{23,23} 15:26]
  wire [2:0] _SP_T_1 = SP + 3'h1; // @[dut.scala 38:18]
  wire [3:0] _GEN_8 = ~io_EMPTY ? _GEN_3 : 4'h0; // @[dut.scala 24:14 35:23 36:20]
  wire [3:0] _GEN_9 = ~io_EMPTY ? _GEN_4 : stack_mem_0; // @[dut.scala 35:23 15:26]
  wire [3:0] _GEN_10 = ~io_EMPTY ? _GEN_5 : stack_mem_1; // @[dut.scala 35:23 15:26]
  wire [3:0] _GEN_11 = ~io_EMPTY ? _GEN_6 : stack_mem_2; // @[dut.scala 35:23 15:26]
  wire [3:0] _GEN_12 = ~io_EMPTY ? _GEN_7 : stack_mem_3; // @[dut.scala 35:23 15:26]
  wire [2:0] _GEN_13 = ~io_EMPTY ? _SP_T_1 : SP; // @[dut.scala 35:23 38:12 17:19]
  wire [2:0] _SP_T_3 = SP - 3'h1; // @[dut.scala 43:18]
  wire [3:0] _GEN_14 = 2'h0 == _SP_T_3[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 15:26 44:{29,29}]
  wire [3:0] _GEN_15 = 2'h1 == _SP_T_3[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 15:26 44:{29,29}]
  wire [3:0] _GEN_16 = 2'h2 == _SP_T_3[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 15:26 44:{29,29}]
  wire [3:0] _GEN_17 = 2'h3 == _SP_T_3[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 15:26 44:{29,29}]
  wire [2:0] _GEN_18 = ~io_FULL ? _SP_T_3 : SP; // @[dut.scala 42:22 43:12 17:19]
  wire [3:0] _GEN_19 = ~io_FULL ? _GEN_14 : stack_mem_0; // @[dut.scala 42:22 15:26]
  wire [3:0] _GEN_20 = ~io_FULL ? _GEN_15 : stack_mem_1; // @[dut.scala 42:22 15:26]
  wire [3:0] _GEN_21 = ~io_FULL ? _GEN_16 : stack_mem_2; // @[dut.scala 42:22 15:26]
  wire [3:0] _GEN_22 = ~io_FULL ? _GEN_17 : stack_mem_3; // @[dut.scala 42:22 15:26]
  wire [3:0] _GEN_23 = io_RW ? _GEN_8 : 4'h0; // @[dut.scala 24:14 33:17]
  wire [3:0] _GEN_29 = io_EN ? _GEN_23 : 4'h0; // @[dut.scala 24:14 32:22]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 20:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 21:19]
  assign io_dataOut = reset ? 4'h0 : _GEN_29; // @[dut.scala 24:14 27:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 15:26]
    end else if (reset) begin // @[dut.scala 27:22]
      stack_mem_0 <= 4'h0; // @[dut.scala 30:40]
    end else if (io_EN) begin // @[dut.scala 32:22]
      if (io_RW) begin // @[dut.scala 33:17]
        stack_mem_0 <= _GEN_9;
      end else begin
        stack_mem_0 <= _GEN_19;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 15:26]
    end else if (reset) begin // @[dut.scala 27:22]
      stack_mem_1 <= 4'h0; // @[dut.scala 30:40]
    end else if (io_EN) begin // @[dut.scala 32:22]
      if (io_RW) begin // @[dut.scala 33:17]
        stack_mem_1 <= _GEN_10;
      end else begin
        stack_mem_1 <= _GEN_20;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 15:26]
    end else if (reset) begin // @[dut.scala 27:22]
      stack_mem_2 <= 4'h0; // @[dut.scala 30:40]
    end else if (io_EN) begin // @[dut.scala 32:22]
      if (io_RW) begin // @[dut.scala 33:17]
        stack_mem_2 <= _GEN_11;
      end else begin
        stack_mem_2 <= _GEN_21;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 15:26]
    end else if (reset) begin // @[dut.scala 27:22]
      stack_mem_3 <= 4'h0; // @[dut.scala 30:40]
    end else if (io_EN) begin // @[dut.scala 32:22]
      if (io_RW) begin // @[dut.scala 33:17]
        stack_mem_3 <= _GEN_12;
      end else begin
        stack_mem_3 <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 17:19]
      SP <= 3'h4; // @[dut.scala 17:19]
    end else if (reset) begin // @[dut.scala 27:22]
      SP <= 3'h4; // @[dut.scala 31:8]
    end else if (io_EN) begin // @[dut.scala 32:22]
      if (io_RW) begin // @[dut.scala 33:17]
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
