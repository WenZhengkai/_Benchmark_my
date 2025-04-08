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
  reg [3:0] stack_mem_0; // @[dut.scala 19:26]
  reg [3:0] stack_mem_1; // @[dut.scala 19:26]
  reg [3:0] stack_mem_2; // @[dut.scala 19:26]
  reg [3:0] stack_mem_3; // @[dut.scala 19:26]
  reg [2:0] sp; // @[dut.scala 20:19]
  wire [3:0] _GEN_1 = 2'h1 == sp[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 38:{20,20}]
  wire [3:0] _GEN_2 = 2'h2 == sp[1:0] ? stack_mem_2 : _GEN_1; // @[dut.scala 38:{20,20}]
  wire [3:0] _GEN_3 = 2'h3 == sp[1:0] ? stack_mem_3 : _GEN_2; // @[dut.scala 38:{20,20}]
  wire [3:0] _GEN_4 = 2'h0 == sp[1:0] ? 4'h0 : stack_mem_0; // @[dut.scala 39:{23,23} 19:26]
  wire [3:0] _GEN_5 = 2'h1 == sp[1:0] ? 4'h0 : stack_mem_1; // @[dut.scala 39:{23,23} 19:26]
  wire [3:0] _GEN_6 = 2'h2 == sp[1:0] ? 4'h0 : stack_mem_2; // @[dut.scala 39:{23,23} 19:26]
  wire [3:0] _GEN_7 = 2'h3 == sp[1:0] ? 4'h0 : stack_mem_3; // @[dut.scala 39:{23,23} 19:26]
  wire [2:0] _sp_T_1 = sp + 3'h1; // @[dut.scala 40:18]
  wire [3:0] _GEN_8 = ~io_EMPTY ? _GEN_3 : 4'h0; // @[dut.scala 25:14 37:23 38:20]
  wire [3:0] _GEN_9 = ~io_EMPTY ? _GEN_4 : stack_mem_0; // @[dut.scala 37:23 19:26]
  wire [3:0] _GEN_10 = ~io_EMPTY ? _GEN_5 : stack_mem_1; // @[dut.scala 37:23 19:26]
  wire [3:0] _GEN_11 = ~io_EMPTY ? _GEN_6 : stack_mem_2; // @[dut.scala 37:23 19:26]
  wire [3:0] _GEN_12 = ~io_EMPTY ? _GEN_7 : stack_mem_3; // @[dut.scala 37:23 19:26]
  wire [2:0] _GEN_13 = ~io_EMPTY ? _sp_T_1 : sp; // @[dut.scala 37:23 40:12 20:19]
  wire [2:0] _sp_T_3 = sp - 3'h1; // @[dut.scala 45:18]
  wire [3:0] _GEN_14 = 2'h0 == sp[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 46:{23,23} 19:26]
  wire [3:0] _GEN_15 = 2'h1 == sp[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 46:{23,23} 19:26]
  wire [3:0] _GEN_16 = 2'h2 == sp[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 46:{23,23} 19:26]
  wire [3:0] _GEN_17 = 2'h3 == sp[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 46:{23,23} 19:26]
  wire [2:0] _GEN_18 = ~io_FULL ? _sp_T_3 : sp; // @[dut.scala 44:22 45:12 20:19]
  wire [3:0] _GEN_19 = ~io_FULL ? _GEN_14 : stack_mem_0; // @[dut.scala 44:22 19:26]
  wire [3:0] _GEN_20 = ~io_FULL ? _GEN_15 : stack_mem_1; // @[dut.scala 44:22 19:26]
  wire [3:0] _GEN_21 = ~io_FULL ? _GEN_16 : stack_mem_2; // @[dut.scala 44:22 19:26]
  wire [3:0] _GEN_22 = ~io_FULL ? _GEN_17 : stack_mem_3; // @[dut.scala 44:22 19:26]
  wire [3:0] _GEN_23 = io_RW ? _GEN_8 : 4'h0; // @[dut.scala 25:14 35:23]
  wire [3:0] _GEN_34 = reset ? 4'h0 : _GEN_23; // @[dut.scala 25:14 29:26]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 23:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 24:18]
  assign io_dataOut = io_EN ? _GEN_34 : 4'h0; // @[dut.scala 25:14 28:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:26]
        stack_mem_0 <= 4'h0; // @[dut.scala 33:22]
      end else if (io_RW) begin // @[dut.scala 35:23]
        stack_mem_0 <= _GEN_9;
      end else begin
        stack_mem_0 <= _GEN_19;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:26]
        stack_mem_1 <= 4'h0; // @[dut.scala 33:22]
      end else if (io_RW) begin // @[dut.scala 35:23]
        stack_mem_1 <= _GEN_10;
      end else begin
        stack_mem_1 <= _GEN_20;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:26]
        stack_mem_2 <= 4'h0; // @[dut.scala 33:22]
      end else if (io_RW) begin // @[dut.scala 35:23]
        stack_mem_2 <= _GEN_11;
      end else begin
        stack_mem_2 <= _GEN_21;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 19:26]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:26]
        stack_mem_3 <= 4'h0; // @[dut.scala 33:22]
      end else if (io_RW) begin // @[dut.scala 35:23]
        stack_mem_3 <= _GEN_12;
      end else begin
        stack_mem_3 <= _GEN_22;
      end
    end
    if (reset) begin // @[dut.scala 20:19]
      sp <= 3'h4; // @[dut.scala 20:19]
    end else if (io_EN) begin // @[dut.scala 28:15]
      if (reset) begin // @[dut.scala 29:26]
        sp <= 3'h4; // @[dut.scala 31:10]
      end else if (io_RW) begin // @[dut.scala 35:23]
        sp <= _GEN_13;
      end else begin
        sp <= _GEN_18;
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
