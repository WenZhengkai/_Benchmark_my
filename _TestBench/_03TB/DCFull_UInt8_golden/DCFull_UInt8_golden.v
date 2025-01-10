module DCFull_UInt8_golden(
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[golden.scala 43:22]
  reg [7:0] hold_1; // @[golden.scala 46:19]
  reg [7:0] hold_0; // @[golden.scala 47:19]
  reg  shift; // @[golden.scala 51:18]
  reg  load; // @[golden.scala 52:17]
  reg  sendSel; // @[golden.scala 53:20]
  reg  enqReady; // @[golden.scala 54:25]
  reg  deqValid; // @[golden.scala 55:25]
  wire  push_vld = io_enq_ready & io_enq_valid; // @[golden.scala 61:31]
  wire [1:0] _GEN_0 = push_vld ? 2'h1 : state; // @[golden.scala 68:22 69:19 44:30]
  wire  _GEN_1 = push_vld | enqReady; // @[golden.scala 68:22 70:18 54:25]
  wire  _GEN_2 = push_vld | deqValid; // @[golden.scala 68:22 71:18 55:25]
  wire  _T_3 = ~io_deq_ready; // @[golden.scala 79:33]
  wire  _T_5 = ~push_vld; // @[golden.scala 81:19]
  wire  _T_6 = ~push_vld & io_deq_ready; // @[golden.scala 81:30]
  wire [1:0] _GEN_4 = _T_5 & _T_3 ? 2'h2 : state; // @[golden.scala 83:50 84:19 44:30]
  wire [1:0] _GEN_5 = ~push_vld & io_deq_ready ? 2'h0 : _GEN_4; // @[golden.scala 81:49 82:19]
  wire [1:0] _GEN_6 = push_vld & ~io_deq_ready ? 2'h3 : _GEN_5; // @[golden.scala 79:49 80:19]
  wire [1:0] _GEN_7 = push_vld & io_deq_ready ? 2'h1 : _GEN_6; // @[golden.scala 77:38 78:19]
  wire [1:0] _GEN_12 = _T_6 ? 2'h1 : state; // @[golden.scala 100:19 44:30 99:43]
  wire [1:0] _GEN_13 = 2'h3 == state ? _GEN_12 : state; // @[golden.scala 66:17 44:30]
  wire [1:0] _GEN_14 = 2'h2 == state ? _GEN_7 : _GEN_13; // @[golden.scala 66:17]
  wire [1:0] _GEN_15 = 2'h1 == state ? _GEN_7 : _GEN_14; // @[golden.scala 66:17]
  wire [1:0] nxt_state = 2'h0 == state ? _GEN_0 : _GEN_15; // @[golden.scala 66:17]
  wire  _GEN_17 = 2'h0 == state ? _GEN_1 : enqReady; // @[golden.scala 66:17 54:25]
  wire  _GEN_18 = 2'h0 == state ? _GEN_2 : deqValid; // @[golden.scala 66:17 55:25]
  wire  _GEN_20 = 2'h3 == nxt_state ? 1'h0 : _GEN_17; // @[golden.scala 105:21 126:16]
  wire  _GEN_21 = 2'h3 == nxt_state | _GEN_18; // @[golden.scala 105:21 127:16]
  wire  _GEN_22 = 2'h3 == nxt_state ? 1'h0 : 1'h1; // @[golden.scala 105:21 128:18]
  wire  _GEN_24 = 2'h1 == nxt_state | _GEN_20; // @[golden.scala 105:21 121:16]
  wire  _GEN_25 = 2'h1 == nxt_state | _GEN_21; // @[golden.scala 105:21 122:16]
  wire  _GEN_26 = 2'h1 == nxt_state | _GEN_22; // @[golden.scala 105:21 123:18]
  wire  _GEN_27 = 2'h2 == nxt_state | 2'h1 == nxt_state; // @[golden.scala 105:21 113:15]
  wire  _GEN_28 = 2'h2 == nxt_state | _GEN_24; // @[golden.scala 105:21 114:16]
  wire  _GEN_29 = 2'h2 == nxt_state | _GEN_25; // @[golden.scala 105:21 115:16]
  wire  _GEN_30 = 2'h2 == nxt_state ? 1'h0 : _GEN_26; // @[golden.scala 105:21 116:18]
  wire  _GEN_34 = 2'h0 == nxt_state | _GEN_28; // @[golden.scala 105:21 109:16]
  assign io_enq_ready = enqReady; // @[golden.scala 57:16]
  assign io_deq_valid = deqValid; // @[golden.scala 58:16]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[golden.scala 142:21]
  always @(posedge clock) begin
    if (reset) begin // @[golden.scala 43:22]
      state <= 2'h0; // @[golden.scala 43:22]
    end else if (2'h0 == state) begin // @[golden.scala 66:17]
      if (push_vld) begin // @[golden.scala 68:22]
        state <= 2'h1; // @[golden.scala 69:19]
      end
    end else if (2'h1 == state) begin // @[golden.scala 66:17]
      state <= _GEN_7;
    end else if (2'h2 == state) begin // @[golden.scala 66:17]
      state <= _GEN_7;
    end else begin
      state <= _GEN_13;
    end
    if (load) begin // @[golden.scala 139:14]
      hold_1 <= io_enq_bits; // @[golden.scala 140:12]
    end
    if (shift) begin // @[golden.scala 136:15]
      hold_0 <= hold_1; // @[golden.scala 137:12]
    end
    if (2'h0 == nxt_state) begin // @[golden.scala 105:21]
      shift <= 1'h0; // @[golden.scala 107:16]
    end else if (2'h2 == nxt_state) begin // @[golden.scala 105:21]
      shift <= 1'h0; // @[golden.scala 48:29]
    end else begin
      shift <= 2'h1 == nxt_state;
    end
    load <= 2'h0 == nxt_state | _GEN_27; // @[golden.scala 105:21 108:15]
    sendSel <= 2'h0 == nxt_state | _GEN_30; // @[golden.scala 105:21]
    enqReady <= reset | _GEN_34; // @[golden.scala 54:{25,25}]
    if (reset) begin // @[golden.scala 55:25]
      deqValid <= 1'h0; // @[golden.scala 55:25]
    end else if (2'h0 == nxt_state) begin // @[golden.scala 105:21]
      deqValid <= 1'h0; // @[golden.scala 110:16]
    end else begin
      deqValid <= _GEN_29;
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
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  hold_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  hold_0 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  shift = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  load = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sendSel = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  enqReady = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  deqValid = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
