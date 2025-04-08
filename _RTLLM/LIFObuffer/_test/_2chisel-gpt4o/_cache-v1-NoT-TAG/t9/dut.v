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
  reg [3:0] stackMem_0; // @[dut.scala 15:25]
  reg [3:0] stackMem_1; // @[dut.scala 15:25]
  reg [3:0] stackMem_2; // @[dut.scala 15:25]
  reg [3:0] stackMem_3; // @[dut.scala 15:25]
  reg [2:0] sp; // @[dut.scala 16:19]
  wire [2:0] _GEN_0 = reset ? 3'h4 : sp; // @[dut.scala 16:19 19:22 20:8]
  wire [3:0] _GEN_1 = reset ? 4'h0 : stackMem_0; // @[dut.scala 19:22 21:14 15:25]
  wire [3:0] _GEN_2 = reset ? 4'h0 : stackMem_1; // @[dut.scala 19:22 21:14 15:25]
  wire [3:0] _GEN_3 = reset ? 4'h0 : stackMem_2; // @[dut.scala 19:22 21:14 15:25]
  wire [3:0] _GEN_4 = reset ? 4'h0 : stackMem_3; // @[dut.scala 19:22 21:14 15:25]
  reg [3:0] dataOutReg; // @[dut.scala 29:27]
  wire [3:0] _GEN_6 = 2'h1 == sp[1:0] ? stackMem_1 : stackMem_0; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_7 = 2'h2 == sp[1:0] ? stackMem_2 : _GEN_6; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_8 = 2'h3 == sp[1:0] ? stackMem_3 : _GEN_7; // @[dut.scala 36:{20,20}]
  wire [3:0] _GEN_9 = 2'h0 == sp[1:0] ? 4'h0 : _GEN_1; // @[dut.scala 37:{22,22}]
  wire [3:0] _GEN_10 = 2'h1 == sp[1:0] ? 4'h0 : _GEN_2; // @[dut.scala 37:{22,22}]
  wire [3:0] _GEN_11 = 2'h2 == sp[1:0] ? 4'h0 : _GEN_3; // @[dut.scala 37:{22,22}]
  wire [3:0] _GEN_12 = 2'h3 == sp[1:0] ? 4'h0 : _GEN_4; // @[dut.scala 37:{22,22}]
  wire [2:0] _sp_T_1 = sp + 3'h1; // @[dut.scala 38:18]
  wire [2:0] _sp_T_3 = sp - 3'h1; // @[dut.scala 42:18]
  wire [3:0] _GEN_19 = 2'h0 == _sp_T_3[1:0] ? io_dataIn : _GEN_1; // @[dut.scala 43:{28,28}]
  wire [3:0] _GEN_20 = 2'h1 == _sp_T_3[1:0] ? io_dataIn : _GEN_2; // @[dut.scala 43:{28,28}]
  wire [3:0] _GEN_21 = 2'h2 == _sp_T_3[1:0] ? io_dataIn : _GEN_3; // @[dut.scala 43:{28,28}]
  wire [3:0] _GEN_22 = 2'h3 == _sp_T_3[1:0] ? io_dataIn : _GEN_4; // @[dut.scala 43:{28,28}]
  assign io_EMPTY = sp == 3'h4; // @[dut.scala 25:19]
  assign io_FULL = sp == 3'h0; // @[dut.scala 26:18]
  assign io_dataOut = dataOutReg; // @[dut.scala 30:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:25]
      stackMem_0 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          stackMem_0 <= _GEN_9;
        end else begin
          stackMem_0 <= _GEN_1;
        end
      end else if (~io_FULL) begin // @[dut.scala 41:22]
        stackMem_0 <= _GEN_19;
      end else begin
        stackMem_0 <= _GEN_1;
      end
    end else begin
      stackMem_0 <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_1 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          stackMem_1 <= _GEN_10;
        end else begin
          stackMem_1 <= _GEN_2;
        end
      end else if (~io_FULL) begin // @[dut.scala 41:22]
        stackMem_1 <= _GEN_20;
      end else begin
        stackMem_1 <= _GEN_2;
      end
    end else begin
      stackMem_1 <= _GEN_2;
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_2 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          stackMem_2 <= _GEN_11;
        end else begin
          stackMem_2 <= _GEN_3;
        end
      end else if (~io_FULL) begin // @[dut.scala 41:22]
        stackMem_2 <= _GEN_21;
      end else begin
        stackMem_2 <= _GEN_3;
      end
    end else begin
      stackMem_2 <= _GEN_3;
    end
    if (reset) begin // @[dut.scala 15:25]
      stackMem_3 <= 4'h0; // @[dut.scala 15:25]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          stackMem_3 <= _GEN_12;
        end else begin
          stackMem_3 <= _GEN_4;
        end
      end else if (~io_FULL) begin // @[dut.scala 41:22]
        stackMem_3 <= _GEN_22;
      end else begin
        stackMem_3 <= _GEN_4;
      end
    end else begin
      stackMem_3 <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 16:19]
      sp <= 3'h4; // @[dut.scala 16:19]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          sp <= _sp_T_1; // @[dut.scala 38:12]
        end else begin
          sp <= _GEN_0;
        end
      end else if (~io_FULL) begin // @[dut.scala 41:22]
        sp <= _sp_T_3; // @[dut.scala 42:12]
      end else begin
        sp <= _GEN_0;
      end
    end else begin
      sp <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 29:27]
      dataOutReg <= 4'h0; // @[dut.scala 29:27]
    end else if (io_EN) begin // @[dut.scala 33:15]
      if (io_RW) begin // @[dut.scala 34:17]
        if (~io_EMPTY) begin // @[dut.scala 35:23]
          dataOutReg <= _GEN_8; // @[dut.scala 36:20]
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
  stackMem_0 = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  stackMem_1 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  stackMem_2 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  stackMem_3 = _RAND_3[3:0];
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
