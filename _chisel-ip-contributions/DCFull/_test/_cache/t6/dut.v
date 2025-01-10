module dut(
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 12:22]
  reg [7:0] hold_0; // @[dut.scala 15:19]
  reg [7:0] hold_1; // @[dut.scala 16:19]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 19:31]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 20:30]
  wire  _T_2 = push_vld & pop_vld; // @[dut.scala 39:21]
  wire [1:0] _GEN_2 = pop_vld ? 2'h0 : state; // @[dut.scala 46:28 47:15 12:22]
  wire [1:0] _GEN_3 = push_vld ? 2'h3 : _GEN_2; // @[dut.scala 43:29 44:15]
  wire [1:0] _GEN_4 = push_vld & pop_vld ? 2'h1 : _GEN_3; // @[dut.scala 39:33 40:15]
  wire  _GEN_6 = push_vld & pop_vld | push_vld; // @[dut.scala 39:33 42:14]
  wire  _GEN_8 = push_vld | pop_vld; // @[dut.scala 55:29 57:15]
  wire  _GEN_10 = _T_2 | _GEN_8; // @[dut.scala 51:33 53:15]
  wire [1:0] _GEN_12 = pop_vld ? 2'h1 : state; // @[dut.scala 65:21 66:15 12:22]
  wire [1:0] _GEN_13 = 2'h3 == state ? _GEN_12 : state; // @[dut.scala 31:17 12:22]
  wire  _GEN_14 = 2'h3 == state & pop_vld; // @[dut.scala 31:17 26:9]
  wire  _GEN_16 = 2'h2 == state ? _GEN_10 : _GEN_14; // @[dut.scala 31:17]
  wire  _GEN_17 = 2'h2 == state & _GEN_6; // @[dut.scala 31:17 27:8]
  wire  _GEN_19 = 2'h1 == state ? _T_2 : _GEN_16; // @[dut.scala 31:17]
  wire  _GEN_20 = 2'h1 == state ? _GEN_6 : _GEN_17; // @[dut.scala 31:17]
  wire  load = 2'h0 == state ? push_vld : _GEN_20; // @[dut.scala 31:17]
  wire  shift = 2'h0 == state ? 1'h0 : _GEN_19; // @[dut.scala 31:17 26:9]
  wire  _sendSel_T = state == 2'h2; // @[dut.scala 81:21]
  wire  _sendSel_T_1 = state == 2'h3; // @[dut.scala 81:40]
  wire  sendSel = state == 2'h2 | state == 2'h3; // @[dut.scala 81:31]
  assign io_enq_ready = state != 2'h3; // @[dut.scala 84:26]
  assign io_deq_valid = state == 2'h1 | _sendSel_T | _sendSel_T_1; // @[dut.scala 85:55]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 86:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (push_vld) begin // @[dut.scala 33:22]
        state <= 2'h1; // @[dut.scala 34:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      state <= _GEN_4;
    end else if (2'h2 == state) begin // @[dut.scala 31:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_13;
    end
    if (shift) begin // @[dut.scala 73:15]
      hold_0 <= hold_1; // @[dut.scala 74:12]
    end
    if (load) begin // @[dut.scala 76:14]
      hold_1 <= io_enq_bits; // @[dut.scala 77:12]
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
  hold_0 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  hold_1 = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
