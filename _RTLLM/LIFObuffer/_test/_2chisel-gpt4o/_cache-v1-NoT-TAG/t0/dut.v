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
  reg [2:0] SP; // @[dut.scala 16:19]
  wire [2:0] _GEN_0 = reset ? 3'h4 : SP; // @[dut.scala 16:19 19:24 20:8]
  wire [3:0] _GEN_1 = reset ? 4'h0 : stack_mem_0; // @[dut.scala 19:24 22:20 15:26]
  wire [3:0] _GEN_2 = reset ? 4'h0 : stack_mem_1; // @[dut.scala 19:24 22:20 15:26]
  wire [3:0] _GEN_3 = reset ? 4'h0 : stack_mem_2; // @[dut.scala 19:24 22:20 15:26]
  wire [3:0] _GEN_4 = reset ? 4'h0 : stack_mem_3; // @[dut.scala 19:24 22:20 15:26]
  reg [3:0] dataOutReg; // @[dut.scala 31:27]
  wire [2:0] _SP_T_1 = SP - 3'h1; // @[dut.scala 38:18]
  wire [3:0] _GEN_5 = 2'h0 == _SP_T_1[1:0] ? io_dataIn : _GEN_1; // @[dut.scala 39:{29,29}]
  wire [3:0] _GEN_6 = 2'h1 == _SP_T_1[1:0] ? io_dataIn : _GEN_2; // @[dut.scala 39:{29,29}]
  wire [3:0] _GEN_7 = 2'h2 == _SP_T_1[1:0] ? io_dataIn : _GEN_3; // @[dut.scala 39:{29,29}]
  wire [3:0] _GEN_8 = 2'h3 == _SP_T_1[1:0] ? io_dataIn : _GEN_4; // @[dut.scala 39:{29,29}]
  wire [3:0] _GEN_15 = 2'h1 == SP[1:0] ? stack_mem_1 : stack_mem_0; // @[dut.scala 43:{20,20}]
  wire [3:0] _GEN_16 = 2'h2 == SP[1:0] ? stack_mem_2 : _GEN_15; // @[dut.scala 43:{20,20}]
  wire [3:0] _GEN_17 = 2'h3 == SP[1:0] ? stack_mem_3 : _GEN_16; // @[dut.scala 43:{20,20}]
  wire [3:0] _GEN_18 = 2'h0 == SP[1:0] ? 4'h0 : _GEN_1; // @[dut.scala 44:{23,23}]
  wire [3:0] _GEN_19 = 2'h1 == SP[1:0] ? 4'h0 : _GEN_2; // @[dut.scala 44:{23,23}]
  wire [3:0] _GEN_20 = 2'h2 == SP[1:0] ? 4'h0 : _GEN_3; // @[dut.scala 44:{23,23}]
  wire [3:0] _GEN_21 = 2'h3 == SP[1:0] ? 4'h0 : _GEN_4; // @[dut.scala 44:{23,23}]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 45:18]
  wire [3:0] _GEN_22 = ~io_EMPTY ? _GEN_17 : dataOutReg; // @[dut.scala 42:23 43:20 31:27]
  wire [3:0] _GEN_23 = ~io_EMPTY ? _GEN_18 : _GEN_1; // @[dut.scala 42:23]
  wire [3:0] _GEN_24 = ~io_EMPTY ? _GEN_19 : _GEN_2; // @[dut.scala 42:23]
  wire [3:0] _GEN_25 = ~io_EMPTY ? _GEN_20 : _GEN_3; // @[dut.scala 42:23]
  wire [3:0] _GEN_26 = ~io_EMPTY ? _GEN_21 : _GEN_4; // @[dut.scala 42:23]
  wire [2:0] _GEN_27 = ~io_EMPTY ? _SP_T_3 : _GEN_0; // @[dut.scala 42:23 45:12]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 27:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 28:18]
  assign io_dataOut = dataOutReg; // @[dut.scala 32:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_0 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (~io_RW) begin // @[dut.scala 36:29]
        if (~io_FULL) begin // @[dut.scala 37:22]
          stack_mem_0 <= _GEN_5;
        end else begin
          stack_mem_0 <= _GEN_1;
        end
      end else if (io_RW) begin // @[dut.scala 41:35]
        stack_mem_0 <= _GEN_23;
      end else begin
        stack_mem_0 <= _GEN_1;
      end
    end else begin
      stack_mem_0 <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_1 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (~io_RW) begin // @[dut.scala 36:29]
        if (~io_FULL) begin // @[dut.scala 37:22]
          stack_mem_1 <= _GEN_6;
        end else begin
          stack_mem_1 <= _GEN_2;
        end
      end else if (io_RW) begin // @[dut.scala 41:35]
        stack_mem_1 <= _GEN_24;
      end else begin
        stack_mem_1 <= _GEN_2;
      end
    end else begin
      stack_mem_1 <= _GEN_2;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_2 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (~io_RW) begin // @[dut.scala 36:29]
        if (~io_FULL) begin // @[dut.scala 37:22]
          stack_mem_2 <= _GEN_7;
        end else begin
          stack_mem_2 <= _GEN_3;
        end
      end else if (io_RW) begin // @[dut.scala 41:35]
        stack_mem_2 <= _GEN_25;
      end else begin
        stack_mem_2 <= _GEN_3;
      end
    end else begin
      stack_mem_2 <= _GEN_3;
    end
    if (reset) begin // @[dut.scala 15:26]
      stack_mem_3 <= 4'h0; // @[dut.scala 15:26]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (~io_RW) begin // @[dut.scala 36:29]
        if (~io_FULL) begin // @[dut.scala 37:22]
          stack_mem_3 <= _GEN_8;
        end else begin
          stack_mem_3 <= _GEN_4;
        end
      end else if (io_RW) begin // @[dut.scala 41:35]
        stack_mem_3 <= _GEN_26;
      end else begin
        stack_mem_3 <= _GEN_4;
      end
    end else begin
      stack_mem_3 <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 16:19]
      SP <= 3'h4; // @[dut.scala 16:19]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (~io_RW) begin // @[dut.scala 36:29]
        if (~io_FULL) begin // @[dut.scala 37:22]
          SP <= _SP_T_1; // @[dut.scala 38:12]
        end else begin
          SP <= _GEN_0;
        end
      end else if (io_RW) begin // @[dut.scala 41:35]
        SP <= _GEN_27;
      end else begin
        SP <= _GEN_0;
      end
    end else begin
      SP <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 31:27]
      dataOutReg <= 4'h0; // @[dut.scala 31:27]
    end else if (io_EN) begin // @[dut.scala 35:15]
      if (!(~io_RW)) begin // @[dut.scala 36:29]
        if (io_RW) begin // @[dut.scala 41:35]
          dataOutReg <= _GEN_22;
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
