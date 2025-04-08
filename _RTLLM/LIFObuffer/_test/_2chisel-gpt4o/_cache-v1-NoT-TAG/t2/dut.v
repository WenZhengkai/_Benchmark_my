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
  reg [2:0] SP; // @[dut.scala 17:19]
  reg [3:0] dataOutReg; // @[dut.scala 24:27]
  wire [2:0] _GEN_0 = reset ? 3'h4 : SP; // @[dut.scala 17:19 30:24 31:8]
  wire [3:0] _GEN_1 = reset ? 4'h0 : dataOutReg; // @[dut.scala 30:24 32:16 24:27]
  wire [2:0] _SP_T_1 = SP - 3'h1; // @[dut.scala 38:16]
  wire [3:0] _GEN_2 = 2'h0 == _SP_T_1[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 16:26 39:{27,27}]
  wire [3:0] _GEN_3 = 2'h1 == _SP_T_1[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 16:26 39:{27,27}]
  wire [3:0] _GEN_4 = 2'h2 == _SP_T_1[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 16:26 39:{27,27}]
  wire [3:0] _GEN_5 = 2'h3 == _SP_T_1[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 16:26 39:{27,27}]
  wire [2:0] _GEN_6 = ~io_FULL ? _SP_T_1 : _GEN_0; // @[dut.scala 37:20 38:10]
  wire [3:0] _GEN_7 = ~io_FULL ? _GEN_2 : stack_mem_0; // @[dut.scala 37:20 16:26]
  wire [3:0] _GEN_8 = ~io_FULL ? _GEN_3 : stack_mem_1; // @[dut.scala 37:20 16:26]
  wire [3:0] _GEN_9 = ~io_FULL ? _GEN_4 : stack_mem_2; // @[dut.scala 37:20 16:26]
  wire [3:0] _GEN_10 = ~io_FULL ? _GEN_5 : stack_mem_3; // @[dut.scala 37:20 16:26]
  wire [2:0] _GEN_11 = io_EN & ~io_RW ? _GEN_6 : _GEN_0; // @[dut.scala 36:25]
  wire [3:0] _GEN_12 = io_EN & ~io_RW ? _GEN_7 : stack_mem_0; // @[dut.scala 36:25 16:26]
  wire [3:0] _GEN_13 = io_EN & ~io_RW ? _GEN_8 : stack_mem_1; // @[dut.scala 36:25 16:26]
  wire [3:0] _GEN_14 = io_EN & ~io_RW ? _GEN_9 : stack_mem_2; // @[dut.scala 36:25 16:26]
  wire [3:0] _GEN_15 = io_EN & ~io_RW ? _GEN_10 : stack_mem_3; // @[dut.scala 36:25 16:26]
  wire [3:0] _GEN_17 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 46:{18,18}]
  wire [3:0] _GEN_18 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_17; // @[dut.scala 46:{18,18}]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 48:16]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 20:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 21:18]
  assign io_dataOut = dataOutReg; // @[dut.scala 25:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        if (2'h0 == SP[1:0]) begin // @[dut.scala 47:21]
          stack_mem_0 <= 4'h0; // @[dut.scala 47:21]
        end else begin
          stack_mem_0 <= _GEN_12;
        end
      end else begin
        stack_mem_0 <= _GEN_12;
      end
    end else begin
      stack_mem_0 <= _GEN_12;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        if (2'h1 == SP[1:0]) begin // @[dut.scala 47:21]
          stack_mem_1 <= 4'h0; // @[dut.scala 47:21]
        end else begin
          stack_mem_1 <= _GEN_13;
        end
      end else begin
        stack_mem_1 <= _GEN_13;
      end
    end else begin
      stack_mem_1 <= _GEN_13;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        if (2'h2 == SP[1:0]) begin // @[dut.scala 47:21]
          stack_mem_2 <= 4'h0; // @[dut.scala 47:21]
        end else begin
          stack_mem_2 <= _GEN_14;
        end
      end else begin
        stack_mem_2 <= _GEN_14;
      end
    end else begin
      stack_mem_2 <= _GEN_14;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        if (2'h3 == SP[1:0]) begin // @[dut.scala 47:21]
          stack_mem_3 <= 4'h0; // @[dut.scala 47:21]
        end else begin
          stack_mem_3 <= _GEN_15;
        end
      end else begin
        stack_mem_3 <= _GEN_15;
      end
    end else begin
      stack_mem_3 <= _GEN_15;
    end
    if (reset) begin // @[dut.scala 17:19]
      SP <= 3'h4; // @[dut.scala 17:19]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        SP <= _SP_T_3; // @[dut.scala 48:10]
      end else begin
        SP <= _GEN_11;
      end
    end else begin
      SP <= _GEN_11;
    end
    if (reset) begin // @[dut.scala 24:27]
      dataOutReg <= 4'h0; // @[dut.scala 24:27]
    end else if (io_EN & io_RW) begin // @[dut.scala 44:24]
      if (~io_EMPTY) begin // @[dut.scala 45:21]
        if (2'h3 == SP[1:0]) begin // @[dut.scala 46:18]
          dataOutReg <= stack_mem_3; // @[dut.scala 46:18]
        end else begin
          dataOutReg <= _GEN_18;
        end
      end else begin
        dataOutReg <= _GEN_1;
      end
    end else begin
      dataOutReg <= _GEN_1;
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
