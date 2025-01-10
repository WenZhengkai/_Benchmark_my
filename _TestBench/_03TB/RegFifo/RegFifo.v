module RegFifo(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] memReg_0; // @[golden.scala 30:19]
  reg [7:0] memReg_1; // @[golden.scala 30:19]
  reg [7:0] memReg_2; // @[golden.scala 30:19]
  reg [7:0] memReg_3; // @[golden.scala 30:19]
  reg [7:0] memReg_4; // @[golden.scala 30:19]
  reg [7:0] memReg_5; // @[golden.scala 30:19]
  reg [7:0] memReg_6; // @[golden.scala 30:19]
  reg [7:0] memReg_7; // @[golden.scala 30:19]
  reg [7:0] memReg_8; // @[golden.scala 30:19]
  reg [7:0] memReg_9; // @[golden.scala 30:19]
  reg [3:0] readPtr; // @[golden.scala 21:25]
  wire [3:0] _nextVal_T_2 = readPtr + 4'h1; // @[golden.scala 22:61]
  wire [3:0] nextRead = readPtr == 4'h9 ? 4'h0 : _nextVal_T_2; // @[golden.scala 22:22]
  wire [1:0] op = {io_enq_valid,io_deq_ready}; // @[golden.scala 40:25]
  reg  emptyReg; // @[golden.scala 37:25]
  wire  _T_2 = ~emptyReg; // @[golden.scala 46:12]
  wire  _GEN_23 = 2'h2 == op ? 1'h0 : 2'h3 == op & _T_2; // @[golden.scala 43:14 32:29]
  wire  _GEN_26 = 2'h1 == op ? _T_2 : _GEN_23; // @[golden.scala 43:14]
  wire  incrRead = 2'h0 == op ? 1'h0 : _GEN_26; // @[golden.scala 43:14 32:29]
  reg [3:0] writePtr; // @[golden.scala 21:25]
  wire [3:0] _nextVal_T_5 = writePtr + 4'h1; // @[golden.scala 22:61]
  wire [3:0] nextWrite = writePtr == 4'h9 ? 4'h0 : _nextVal_T_5; // @[golden.scala 22:22]
  reg  fullReg; // @[golden.scala 38:24]
  wire  _T_4 = ~fullReg; // @[golden.scala 53:12]
  wire  _GEN_16 = 2'h3 == op & _T_4; // @[golden.scala 43:14 41:28]
  wire  _GEN_20 = 2'h2 == op ? _T_4 : _GEN_16; // @[golden.scala 43:14]
  wire  _GEN_27 = 2'h1 == op ? 1'h0 : _GEN_20; // @[golden.scala 43:14 41:28]
  wire  incrWrite = 2'h0 == op ? 1'h0 : _GEN_27; // @[golden.scala 43:14 41:28]
  wire  _GEN_3 = ~emptyReg ? nextRead == writePtr : emptyReg; // @[golden.scala 46:23 48:18 37:25]
  wire  _GEN_6 = ~fullReg ? 1'h0 : emptyReg; // @[golden.scala 53:22 55:18 37:25]
  wire  _GEN_7 = ~fullReg ? nextWrite == readPtr : fullReg; // @[golden.scala 53:22 56:17 38:24]
  wire  _GEN_8 = emptyReg ? 1'h0 : nextWrite == nextRead; // @[golden.scala 64:24 65:19 67:19]
  wire  _GEN_11 = _T_4 ? _GEN_8 : fullReg; // @[golden.scala 61:22 38:24]
  wire  _GEN_12 = fullReg ? 1'h0 : nextRead == nextWrite; // @[golden.scala 73:23 74:20 76:20]
  wire  _GEN_13 = _T_2 ? 1'h0 : _GEN_11; // @[golden.scala 71:23 72:17]
  wire  _GEN_14 = _T_2 ? _GEN_12 : _GEN_6; // @[golden.scala 71:23]
  wire  _GEN_17 = 2'h3 == op ? _GEN_14 : emptyReg; // @[golden.scala 43:14 37:25]
  wire  _GEN_18 = 2'h3 == op ? _GEN_13 : fullReg; // @[golden.scala 43:14 38:24]
  wire  _GEN_21 = 2'h2 == op ? _GEN_6 : _GEN_17; // @[golden.scala 43:14]
  wire  _GEN_25 = 2'h1 == op ? _GEN_3 : _GEN_21; // @[golden.scala 43:14]
  wire  _GEN_29 = 2'h0 == op ? emptyReg : _GEN_25; // @[golden.scala 43:14 37:25]
  wire [7:0] _GEN_53 = 4'h1 == readPtr ? memReg_1 : memReg_0; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_54 = 4'h2 == readPtr ? memReg_2 : _GEN_53; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_55 = 4'h3 == readPtr ? memReg_3 : _GEN_54; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_56 = 4'h4 == readPtr ? memReg_4 : _GEN_55; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_57 = 4'h5 == readPtr ? memReg_5 : _GEN_56; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_58 = 4'h6 == readPtr ? memReg_6 : _GEN_57; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_59 = 4'h7 == readPtr ? memReg_7 : _GEN_58; // @[golden.scala 87:{15,15}]
  wire [7:0] _GEN_60 = 4'h8 == readPtr ? memReg_8 : _GEN_59; // @[golden.scala 87:{15,15}]
  wire [3:0] fullNr = fullReg ? 4'ha : 4'h0; // @[golden.scala 92:19]
  wire [3:0] _number_T_1 = writePtr - readPtr; // @[golden.scala 93:25]
  wire [3:0] number = _number_T_1 + fullNr; // @[golden.scala 93:35]
  wire  _T_10 = ~reset; // @[golden.scala 94:9]
  wire  _T_21 = readPtr != writePtr; // @[golden.scala 99:16]
  wire  _T_33 = ~(readPtr == writePtr); // @[golden.scala 105:11]
  wire  _GEN_64 = _T_21 & _T_10; // @[golden.scala 100:11]
  assign io_enq_ready = ~fullReg; // @[golden.scala 88:19]
  assign io_deq_valid = ~emptyReg; // @[golden.scala 89:19]
  assign io_deq_bits = 4'h9 == readPtr ? memReg_9 : _GEN_60; // @[golden.scala 87:{15,15}]
  always @(posedge clock) begin
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h0 == writePtr) begin // @[golden.scala 84:22]
        memReg_0 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h1 == writePtr) begin // @[golden.scala 84:22]
        memReg_1 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h2 == writePtr) begin // @[golden.scala 84:22]
        memReg_2 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h3 == writePtr) begin // @[golden.scala 84:22]
        memReg_3 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h4 == writePtr) begin // @[golden.scala 84:22]
        memReg_4 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h5 == writePtr) begin // @[golden.scala 84:22]
        memReg_5 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h6 == writePtr) begin // @[golden.scala 84:22]
        memReg_6 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h7 == writePtr) begin // @[golden.scala 84:22]
        memReg_7 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h8 == writePtr) begin // @[golden.scala 84:22]
        memReg_8 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (incrWrite) begin // @[golden.scala 83:17]
      if (4'h9 == writePtr) begin // @[golden.scala 84:22]
        memReg_9 <= io_enq_bits; // @[golden.scala 84:22]
      end
    end
    if (reset) begin // @[golden.scala 21:25]
      readPtr <= 4'h0; // @[golden.scala 21:25]
    end else if (incrRead) begin // @[golden.scala 23:16]
      if (readPtr == 4'h9) begin // @[golden.scala 22:22]
        readPtr <= 4'h0;
      end else begin
        readPtr <= _nextVal_T_2;
      end
    end
    emptyReg <= reset | _GEN_29; // @[golden.scala 37:{25,25}]
    if (reset) begin // @[golden.scala 21:25]
      writePtr <= 4'h0; // @[golden.scala 21:25]
    end else if (incrWrite) begin // @[golden.scala 23:16]
      if (writePtr == 4'h9) begin // @[golden.scala 22:22]
        writePtr <= 4'h0;
      end else begin
        writePtr <= _nextVal_T_5;
      end
    end
    if (reset) begin // @[golden.scala 38:24]
      fullReg <= 1'h0; // @[golden.scala 38:24]
    end else if (!(2'h0 == op)) begin // @[golden.scala 43:14]
      if (2'h1 == op) begin // @[golden.scala 43:14]
        if (~emptyReg) begin // @[golden.scala 46:23]
          fullReg <= 1'h0; // @[golden.scala 47:17]
        end
      end else if (2'h2 == op) begin // @[golden.scala 43:14]
        fullReg <= _GEN_7;
      end else begin
        fullReg <= _GEN_18;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_10 & ~(number < 4'hb)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:95 assert(number < (depth + 1).U)\n"); // @[golden.scala 95:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & ~(number < 4'hb)) begin
          $fatal; // @[golden.scala 95:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_10 & ~(~(emptyReg & fullReg))) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:97 assert(!(emptyReg && fullReg))\n"); // @[golden.scala 97:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & ~(~(emptyReg & fullReg))) begin
          $fatal; // @[golden.scala 97:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_21 & _T_10 & ~_T_2) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:100 assert(emptyReg === false.B)\n"); // @[golden.scala 100:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_21 & _T_10 & ~_T_2) begin
          $fatal; // @[golden.scala 100:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_64 & ~_T_4) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:101 assert(fullReg === false.B)\n"); // @[golden.scala 101:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_GEN_64 & ~_T_4) begin
          $fatal; // @[golden.scala 101:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (fullReg & _T_10 & ~(readPtr == writePtr)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:105 assert(readPtr === writePtr)\n"); // @[golden.scala 105:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (fullReg & _T_10 & ~(readPtr == writePtr)) begin
          $fatal; // @[golden.scala 105:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (emptyReg & _T_10 & _T_33) begin
          $fwrite(32'h80000002,"Assertion failed\n    at golden.scala:109 assert(readPtr === writePtr)\n"); // @[golden.scala 109:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (emptyReg & _T_10 & _T_33) begin
          $fatal; // @[golden.scala 109:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
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
  memReg_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  memReg_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  memReg_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  memReg_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  memReg_4 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  memReg_5 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  memReg_6 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  memReg_7 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  memReg_8 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  memReg_9 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  readPtr = _RAND_10[3:0];
  _RAND_11 = {1{`RANDOM}};
  emptyReg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  writePtr = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  fullReg = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
