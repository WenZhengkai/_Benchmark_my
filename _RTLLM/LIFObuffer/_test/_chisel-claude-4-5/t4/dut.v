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
  reg [2:0] SP; // @[dut.scala 18:19]
  reg [3:0] dataOut_reg; // @[dut.scala 21:28]
  wire [2:0] newSP = SP - 3'h1; // @[dut.scala 45:24]
  wire [3:0] _GEN_0 = 2'h0 == newSP[1:0] ? io_dataIn : stack_mem_0; // @[dut.scala 15:26 46:{26,26}]
  wire [3:0] _GEN_1 = 2'h1 == newSP[1:0] ? io_dataIn : stack_mem_1; // @[dut.scala 15:26 46:{26,26}]
  wire [3:0] _GEN_2 = 2'h2 == newSP[1:0] ? io_dataIn : stack_mem_2; // @[dut.scala 15:26 46:{26,26}]
  wire [3:0] _GEN_3 = 2'h3 == newSP[1:0] ? io_dataIn : stack_mem_3; // @[dut.scala 15:26 46:{26,26}]
  wire [3:0] _GEN_4 = ~io_RW & ~io_FULL ? _GEN_0 : stack_mem_0; // @[dut.scala 15:26 43:32]
  wire [3:0] _GEN_5 = ~io_RW & ~io_FULL ? _GEN_1 : stack_mem_1; // @[dut.scala 15:26 43:32]
  wire [3:0] _GEN_6 = ~io_RW & ~io_FULL ? _GEN_2 : stack_mem_2; // @[dut.scala 15:26 43:32]
  wire [3:0] _GEN_7 = ~io_RW & ~io_FULL ? _GEN_3 : stack_mem_3; // @[dut.scala 15:26 43:32]
  wire [2:0] _GEN_8 = ~io_RW & ~io_FULL ? newSP : SP; // @[dut.scala 43:32 47:12 18:19]
  wire [3:0] _GEN_10 = 2'h1 == newSP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 53:{21,21}]
  wire [3:0] _GEN_11 = 2'h2 == newSP[1:0] ? stack_mem_2 : _GEN_10; // @[dut.scala 53:{21,21}]
  wire [3:0] _GEN_12 = 2'h3 == newSP[1:0] ? stack_mem_3 : _GEN_11; // @[dut.scala 53:{21,21}]
  wire [3:0] _GEN_13 = 2'h0 == newSP[1:0] ? 4'h0 : _GEN_4; // @[dut.scala 54:{29,29}]
  wire [3:0] _GEN_14 = 2'h1 == newSP[1:0] ? 4'h0 : _GEN_5; // @[dut.scala 54:{29,29}]
  wire [3:0] _GEN_15 = 2'h2 == newSP[1:0] ? 4'h0 : _GEN_6; // @[dut.scala 54:{29,29}]
  wire [3:0] _GEN_16 = 2'h3 == newSP[1:0] ? 4'h0 : _GEN_7; // @[dut.scala 54:{29,29}]
  wire [2:0] _SP_T_1 = SP + 3'h1; // @[dut.scala 55:18]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 27:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 30:18]
  assign io_dataOut = dataOut_reg; // @[dut.scala 24:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        stack_mem_0 <= 4'h0; // @[dut.scala 39:22]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        stack_mem_0 <= _GEN_13;
      end else begin
        stack_mem_0 <= _GEN_4;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        stack_mem_1 <= 4'h0; // @[dut.scala 39:22]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        stack_mem_1 <= _GEN_14;
      end else begin
        stack_mem_1 <= _GEN_5;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        stack_mem_2 <= 4'h0; // @[dut.scala 39:22]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        stack_mem_2 <= _GEN_15;
      end else begin
        stack_mem_2 <= _GEN_6;
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        stack_mem_3 <= 4'h0; // @[dut.scala 39:22]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        stack_mem_3 <= _GEN_16;
      end else begin
        stack_mem_3 <= _GEN_7;
      end
    end
    if (reset) begin // @[dut.scala 18:19]
      SP <= 3'h4; // @[dut.scala 18:19]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        SP <= 3'h4; // @[dut.scala 36:10]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        SP <= _SP_T_1; // @[dut.scala 55:12]
      end else begin
        SP <= _GEN_8;
      end
    end
    if (reset) begin // @[dut.scala 21:28]
      dataOut_reg <= 4'h0; // @[dut.scala 21:28]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (reset) begin // @[dut.scala 34:24]
        dataOut_reg <= 4'h0; // @[dut.scala 37:19]
      end else if (io_RW & ~io_EMPTY) begin // @[dut.scala 51:32]
        dataOut_reg <= _GEN_12; // @[dut.scala 53:21]
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
  dataOut_reg = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
