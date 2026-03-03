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
  reg [3:0] stack_mem_0; // @[dut.scala 15:26]
  reg [3:0] stack_mem_1; // @[dut.scala 15:26]
  reg [3:0] stack_mem_2; // @[dut.scala 15:26]
  reg [3:0] stack_mem_3; // @[dut.scala 15:26]
  reg [2:0] SP; // @[dut.scala 17:26]
  reg [3:0] dataOutReg; // @[dut.scala 18:27]
  wire  empty = SP == 3'h4; // @[dut.scala 20:19]
  wire  full = SP == 3'h0; // @[dut.scala 21:19]
  wire [2:0] wrIdx = SP - 3'h1; // @[dut.scala 32:24]
  wire [3:0] _GEN_0 = 2'h0 == wrIdx[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 15:26 33:{26,26}]
  wire [3:0] _GEN_1 = 2'h1 == wrIdx[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 15:26 33:{26,26}]
  wire [3:0] _GEN_2 = 2'h2 == wrIdx[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 15:26 33:{26,26}]
  wire [3:0] _GEN_3 = 2'h3 == wrIdx[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 15:26 33:{26,26}]
  wire [3:0] _GEN_5 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_6 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_5; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_7 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_6; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_8 = 2'h0 == SP[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_9 = 2'h1 == SP[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_10 = 2'h2 == SP[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 37:{23,23} 15:26]
  wire [3:0] _GEN_11 = 2'h3 == SP[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 37:{23,23} 15:26]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 38:18]
  wire [3:0] _GEN_12 = io_RW & ~empty ? _GEN_7 : dataOutReg; // @[dut.scala 35:35 36:20 18:27]
  wire [3:0] _GEN_13 = io_RW & ~empty ? _GEN_8 : stack_mem_0; // @[dut.scala 15:26 35:35]
  wire [3:0] _GEN_14 = io_RW & ~empty ? _GEN_9 : stack_mem_1; // @[dut.scala 15:26 35:35]
  wire [3:0] _GEN_15 = io_RW & ~empty ? _GEN_10 : stack_mem_2; // @[dut.scala 15:26 35:35]
  wire [3:0] _GEN_16 = io_RW & ~empty ? _GEN_11 : stack_mem_3; // @[dut.scala 15:26 35:35]
  wire [2:0] _GEN_17 = io_RW & ~empty ? _SP_T_3 : SP; // @[dut.scala 35:35 38:12 17:26]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 20:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 21:19]
  assign io_dataOut = dataOutReg; // @[dut.scala 45:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 28:22]
      end else if (~io_RW & ~full) begin // @[dut.scala 31:29]
        stack_mem_0 <= _GEN_0;
      end else begin
        stack_mem_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 28:22]
      end else if (~io_RW & ~full) begin // @[dut.scala 31:29]
        stack_mem_1 <= _GEN_1;
      end else begin
        stack_mem_1 <= _GEN_14;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 28:22]
      end else if (~io_RW & ~full) begin // @[dut.scala 31:29]
        stack_mem_2 <= _GEN_2;
      end else begin
        stack_mem_2 <= _GEN_15;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 28:22]
      end else if (~io_RW & ~full) begin // @[dut.scala 31:29]
        stack_mem_3 <= _GEN_3;
      end else begin
        stack_mem_3 <= _GEN_16;
      end
    end
    if (reset) begin // @[dut.scala 17:26]
      SP <= 3'h4; // @[dut.scala 17:26]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        SP <= 3'h4; // @[dut.scala 25:10]
      end else if (~io_RW & ~full) begin // @[dut.scala 31:29]
        SP <= wrIdx; // @[dut.scala 34:12]
      end else begin
        SP <= _GEN_17;
      end
    end
    if (reset) begin // @[dut.scala 18:27]
      dataOutReg <= 4'h0; // @[dut.scala 18:27]
    end else if (io_EN) begin // @[dut.scala 23:15]
      if (reset) begin // @[dut.scala 24:24]
        dataOutReg <= 4'h0; // @[dut.scala 26:18]
      end else if (!(~io_RW & ~full)) begin // @[dut.scala 31:29]
        dataOutReg <= _GEN_12;
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
  dataOutReg = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
