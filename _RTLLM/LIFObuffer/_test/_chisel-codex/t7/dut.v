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
  reg [2:0] SP; // @[dut.scala 20:19]
  reg [3:0] dataOutReg; // @[dut.scala 22:27]
  wire [2:0] _T_4 = SP - 3'h1; // @[dut.scala 41:24]
  wire [3:0] _GEN_0 = 2'h0 == _T_4[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 16:26 41:{31,31}]
  wire [3:0] _GEN_1 = 2'h1 == _T_4[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 16:26 41:{31,31}]
  wire [3:0] _GEN_2 = 2'h2 == _T_4[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 16:26 41:{31,31}]
  wire [3:0] _GEN_3 = 2'h3 == _T_4[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 16:26 41:{31,31}]
  wire [3:0] _GEN_4 = SP != 3'h0 ? _GEN_0 : stack_mem_0; // @[dut.scala 16:26 40:26]
  wire [3:0] _GEN_5 = SP != 3'h0 ? _GEN_1 : stack_mem_1; // @[dut.scala 16:26 40:26]
  wire [3:0] _GEN_6 = SP != 3'h0 ? _GEN_2 : stack_mem_2; // @[dut.scala 16:26 40:26]
  wire [3:0] _GEN_7 = SP != 3'h0 ? _GEN_3 : stack_mem_3; // @[dut.scala 16:26 40:26]
  wire [2:0] _GEN_8 = SP != 3'h0 ? _T_4 : SP; // @[dut.scala 40:26 42:14 20:19]
  wire [3:0] _GEN_10 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 47:{22,22}]
  wire [3:0] _GEN_11 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_10; // @[dut.scala 47:{22,22}]
  wire [3:0] _GEN_12 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_11; // @[dut.scala 47:{22,22}]
  wire [3:0] _GEN_13 = 2'h0 == SP[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 48:{25,25} 16:26]
  wire [3:0] _GEN_14 = 2'h1 == SP[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 48:{25,25} 16:26]
  wire [3:0] _GEN_15 = 2'h2 == SP[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 48:{25,25} 16:26]
  wire [3:0] _GEN_16 = 2'h3 == SP[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 48:{25,25} 16:26]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 49:20]
  wire [3:0] _GEN_17 = SP != 3'h4 ? _GEN_12 : dataOutReg; // @[dut.scala 46:26 47:22 22:27]
  wire [3:0] _GEN_18 = SP != 3'h4 ? _GEN_13 : stack_mem_0; // @[dut.scala 16:26 46:26]
  wire [3:0] _GEN_19 = SP != 3'h4 ? _GEN_14 : stack_mem_1; // @[dut.scala 16:26 46:26]
  wire [3:0] _GEN_20 = SP != 3'h4 ? _GEN_15 : stack_mem_2; // @[dut.scala 16:26 46:26]
  wire [3:0] _GEN_21 = SP != 3'h4 ? _GEN_16 : stack_mem_3; // @[dut.scala 16:26 46:26]
  wire [2:0] _GEN_22 = SP != 3'h4 ? _SP_T_3 : SP; // @[dut.scala 46:26 49:14 20:19]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 26:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 27:19]
  assign io_dataOut = dataOutReg; // @[dut.scala 23:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 35:22]
      end else if (~io_RW) begin // @[dut.scala 38:20]
        stack_mem_0 <= _GEN_4;
      end else begin
        stack_mem_0 <= _GEN_18;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 35:22]
      end else if (~io_RW) begin // @[dut.scala 38:20]
        stack_mem_1 <= _GEN_5;
      end else begin
        stack_mem_1 <= _GEN_19;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 35:22]
      end else if (~io_RW) begin // @[dut.scala 38:20]
        stack_mem_2 <= _GEN_6;
      end else begin
        stack_mem_2 <= _GEN_20;
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 35:22]
      end else if (~io_RW) begin // @[dut.scala 38:20]
        stack_mem_3 <= _GEN_7;
      end else begin
        stack_mem_3 <= _GEN_21;
      end
    end
    if (reset) begin // @[dut.scala 20:19]
      SP <= 3'h4; // @[dut.scala 20:19]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        SP <= 3'h4; // @[dut.scala 32:10]
      end else if (~io_RW) begin // @[dut.scala 38:20]
        SP <= _GEN_8;
      end else begin
        SP <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 22:27]
      dataOutReg <= 4'h0; // @[dut.scala 22:27]
    end else if (io_EN) begin // @[dut.scala 30:15]
      if (reset) begin // @[dut.scala 31:24]
        dataOutReg <= 4'h0; // @[dut.scala 33:18]
      end else if (!(~io_RW)) begin // @[dut.scala 38:20]
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
