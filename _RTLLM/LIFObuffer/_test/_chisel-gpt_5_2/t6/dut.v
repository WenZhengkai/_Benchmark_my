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
  reg [3:0] stack_mem_0; // @[dut.scala 16:26]
  reg [3:0] stack_mem_1; // @[dut.scala 16:26]
  reg [3:0] stack_mem_2; // @[dut.scala 16:26]
  reg [3:0] stack_mem_3; // @[dut.scala 16:26]
  reg [2:0] sp; // @[dut.scala 19:19]
  reg [3:0] dataOutReg; // @[dut.scala 21:27]
  wire [2:0] idx = sp - 3'h1; // @[dut.scala 37:24]
  wire [3:0] _GEN_0 = 2'h0 == idx[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 16:26 38:{26,26}]
  wire [3:0] _GEN_1 = 2'h1 == idx[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 16:26 38:{26,26}]
  wire [3:0] _GEN_2 = 2'h2 == idx[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 16:26 38:{26,26}]
  wire [3:0] _GEN_3 = 2'h3 == idx[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 16:26 38:{26,26}]
  wire [3:0] _GEN_4 = ~io_FULL ? _GEN_0 : stack_mem_0; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_5 = ~io_FULL ? _GEN_1 : stack_mem_1; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_6 = ~io_FULL ? _GEN_2 : stack_mem_2; // @[dut.scala 35:25 16:26]
  wire [3:0] _GEN_7 = ~io_FULL ? _GEN_3 : stack_mem_3; // @[dut.scala 35:25 16:26]
  wire [2:0] _GEN_8 = ~io_FULL ? idx : sp; // @[dut.scala 35:25 39:14 19:19]
  wire [3:0] _GEN_10 = 2'h1 == sp[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 45:{22,22}]
  wire [3:0] _GEN_11 = 2'h2 == sp[1:0] ? stack_mem_2 : _GEN_10; // @[dut.scala 45:{22,22}]
  wire [3:0] _GEN_12 = 2'h3 == sp[1:0] ? stack_mem_3 : _GEN_11; // @[dut.scala 45:{22,22}]
  wire [3:0] _GEN_13 = 2'h0 == sp[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 16:26 46:{26,26}]
  wire [3:0] _GEN_14 = 2'h1 == sp[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 16:26 46:{26,26}]
  wire [3:0] _GEN_15 = 2'h2 == sp[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 16:26 46:{26,26}]
  wire [3:0] _GEN_16 = 2'h3 == sp[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 16:26 46:{26,26}]
  wire [2:0] _sp_T_3 = sp + 3'h1; // @[dut.scala 47:20]
  wire [3:0] _GEN_17 = ~io_EMPTY ? _GEN_12 : dataOutReg; // @[dut.scala 42:26 45:22 21:27]
  wire [3:0] _GEN_18 = ~io_EMPTY ? _GEN_13 : stack_mem_0; // @[dut.scala 16:26 42:26]
  wire [3:0] _GEN_19 = ~io_EMPTY ? _GEN_14 : stack_mem_1; // @[dut.scala 16:26 42:26]
  wire [3:0] _GEN_20 = ~io_EMPTY ? _GEN_15 : stack_mem_2; // @[dut.scala 16:26 42:26]
  wire [3:0] _GEN_21 = ~io_EMPTY ? _GEN_16 : stack_mem_3; // @[dut.scala 16:26 42:26]
  wire [2:0] _GEN_22 = ~io_EMPTY ? _sp_T_3 : sp; // @[dut.scala 42:26 47:14 19:19]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 25:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 26:19]
  assign io_dataOut = dataOutReg; // @[dut.scala 22:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        stack_mem_0 <= 4'h0; // @[dut.scala 32:43]
      end else if (~io_RW) begin // @[dut.scala 34:21]
        stack_mem_0 <= _GEN_4;
      end else begin
        stack_mem_0 <= _GEN_18;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        stack_mem_1 <= 4'h0; // @[dut.scala 32:43]
      end else if (~io_RW) begin // @[dut.scala 34:21]
        stack_mem_1 <= _GEN_5;
      end else begin
        stack_mem_1 <= _GEN_19;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        stack_mem_2 <= 4'h0; // @[dut.scala 32:43]
      end else if (~io_RW) begin // @[dut.scala 34:21]
        stack_mem_2 <= _GEN_6;
      end else begin
        stack_mem_2 <= _GEN_20;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        stack_mem_3 <= 4'h0; // @[dut.scala 32:43]
      end else if (~io_RW) begin // @[dut.scala 34:21]
        stack_mem_3 <= _GEN_7;
      end else begin
        stack_mem_3 <= _GEN_21;
      end
    end
    if (reset) begin // @[dut.scala 19:19]
      sp <= 3'h4; // @[dut.scala 19:19]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        sp <= 3'h4; // @[dut.scala 30:10]
      end else if (~io_RW) begin // @[dut.scala 34:21]
        sp <= _GEN_8;
      end else begin
        sp <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 21:27]
      dataOutReg <= 4'h0; // @[dut.scala 21:27]
    end else if (io_EN) begin // @[dut.scala 28:16]
      if (reset) begin // @[dut.scala 29:25]
        dataOutReg <= 4'h0; // @[dut.scala 31:18]
      end else if (!(~io_RW)) begin // @[dut.scala 34:21]
        dataOutReg <= _GEN_17;
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
  _RAND_5 = {1{`RANDOM}};
  dataOutReg = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
