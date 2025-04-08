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
  wire [2:0] _GEN_0 = reset ? 3'h4 : SP; // @[dut.scala 17:19 20:22 21:8]
  wire [3:0] _GEN_1 = reset ? 4'h0 : stack_mem_0; // @[dut.scala 20:22 22:15 16:26]
  wire [3:0] _GEN_2 = reset ? 4'h0 : stack_mem_1; // @[dut.scala 20:22 22:15 16:26]
  wire [3:0] _GEN_3 = reset ? 4'h0 : stack_mem_2; // @[dut.scala 20:22 22:15 16:26]
  wire [3:0] _GEN_4 = reset ? 4'h0 : stack_mem_3; // @[dut.scala 20:22 22:15 16:26]
  reg [3:0] dataOutReg; // @[dut.scala 26:23]
  wire [2:0] _SP_T_1 = SP - 3'h1; // @[dut.scala 31:16]
  wire [3:0] _GEN_5 = 2'h0 == _SP_T_1[1:0] ? io_dataIn : _GEN_1; // @[dut.scala 32:{27,27}]
  wire [3:0] _GEN_6 = 2'h1 == _SP_T_1[1:0] ? io_dataIn : _GEN_2; // @[dut.scala 32:{27,27}]
  wire [3:0] _GEN_7 = 2'h2 == _SP_T_1[1:0] ? io_dataIn : _GEN_3; // @[dut.scala 32:{27,27}]
  wire [3:0] _GEN_8 = 2'h3 == _SP_T_1[1:0] ? io_dataIn : _GEN_4; // @[dut.scala 32:{27,27}]
  wire [2:0] _GEN_9 = SP != 3'h0 ? _SP_T_1 : _GEN_0; // @[dut.scala 30:22 31:10]
  wire [3:0] _GEN_10 = SP != 3'h0 ? _GEN_5 : _GEN_1; // @[dut.scala 30:22]
  wire [3:0] _GEN_11 = SP != 3'h0 ? _GEN_6 : _GEN_2; // @[dut.scala 30:22]
  wire [3:0] _GEN_12 = SP != 3'h0 ? _GEN_7 : _GEN_3; // @[dut.scala 30:22]
  wire [3:0] _GEN_13 = SP != 3'h0 ? _GEN_8 : _GEN_4; // @[dut.scala 30:22]
  wire [2:0] _GEN_14 = io_EN & ~io_RW ? _GEN_9 : _GEN_0; // @[dut.scala 29:25]
  wire [3:0] _GEN_15 = io_EN & ~io_RW ? _GEN_10 : _GEN_1; // @[dut.scala 29:25]
  wire [3:0] _GEN_16 = io_EN & ~io_RW ? _GEN_11 : _GEN_2; // @[dut.scala 29:25]
  wire [3:0] _GEN_17 = io_EN & ~io_RW ? _GEN_12 : _GEN_3; // @[dut.scala 29:25]
  wire [3:0] _GEN_18 = io_EN & ~io_RW ? _GEN_13 : _GEN_4; // @[dut.scala 29:25]
  wire [3:0] _GEN_20 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 39:{18,18}]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 41:16]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 46:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 47:18]
  assign io_dataOut = dataOutReg; // @[dut.scala 50:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        if (2'h0 == SP[1:0]) begin // @[dut.scala 40:21]
          stack_mem_0 <= 4'h0; // @[dut.scala 40:21]
        end else begin
          stack_mem_0 <= _GEN_15;
        end
      end else begin
        stack_mem_0 <= _GEN_15;
      end
    end else begin
      stack_mem_0 <= _GEN_15;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        if (2'h1 == SP[1:0]) begin // @[dut.scala 40:21]
          stack_mem_1 <= 4'h0; // @[dut.scala 40:21]
        end else begin
          stack_mem_1 <= _GEN_16;
        end
      end else begin
        stack_mem_1 <= _GEN_16;
      end
    end else begin
      stack_mem_1 <= _GEN_16;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        if (2'h2 == SP[1:0]) begin // @[dut.scala 40:21]
          stack_mem_2 <= 4'h0; // @[dut.scala 40:21]
        end else begin
          stack_mem_2 <= _GEN_17;
        end
      end else begin
        stack_mem_2 <= _GEN_17;
      end
    end else begin
      stack_mem_2 <= _GEN_17;
    end
    if (reset) begin // @[dut.scala 16:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 16:26]
    end else if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        if (2'h3 == SP[1:0]) begin // @[dut.scala 40:21]
          stack_mem_3 <= 4'h0; // @[dut.scala 40:21]
        end else begin
          stack_mem_3 <= _GEN_18;
        end
      end else begin
        stack_mem_3 <= _GEN_18;
      end
    end else begin
      stack_mem_3 <= _GEN_18;
    end
    if (reset) begin // @[dut.scala 17:19]
      SP <= 3'h4; // @[dut.scala 17:19]
    end else if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        SP <= _SP_T_3; // @[dut.scala 41:10]
      end else begin
        SP <= _GEN_14;
      end
    end else begin
      SP <= _GEN_14;
    end
    if (io_EN & io_RW) begin // @[dut.scala 37:24]
      if (SP != 3'h4) begin // @[dut.scala 38:22]
        if (2'h3 == SP[1:0]) begin // @[dut.scala 39:18]
          dataOutReg <= stack_mem_3; // @[dut.scala 39:18]
        end else if (2'h2 == SP[1:0]) begin // @[dut.scala 39:18]
          dataOutReg <= stack_mem_2; // @[dut.scala 39:18]
        end else begin
          dataOutReg <= _GEN_20;
        end
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
