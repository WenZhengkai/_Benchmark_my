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
  reg [1:0] state; // @[dut.scala 16:22]
  reg [7:0] hold_0; // @[dut.scala 19:19]
  reg [7:0] hold_1; // @[dut.scala 20:19]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 27:31]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 28:30]
  wire  _io_enq_ready_T_1 = state == 2'h1; // @[dut.scala 32:50]
  wire  _io_deq_valid_T_1 = state == 2'h2; // @[dut.scala 33:50]
  wire  _io_deq_valid_T_3 = state == 2'h3; // @[dut.scala 33:75]
  wire  sendSel = _io_deq_valid_T_1 | _io_deq_valid_T_3; // @[dut.scala 36:36]
  wire [1:0] _GEN_2 = pop_vld ? 2'h0 : state; // @[dut.scala 55:27 56:15 16:22]
  wire [1:0] _GEN_3 = push_vld ? 2'h3 : _GEN_2; // @[dut.scala 51:28 54:15]
  wire  _GEN_4 = push_vld & pop_vld | push_vld; // @[dut.scala 48:33 49:15]
  wire  _GEN_6 = push_vld & pop_vld ? 1'h0 : push_vld; // @[dut.scala 24:25 48:33]
  wire [1:0] _GEN_7 = push_vld ? 2'h3 : state; // @[dut.scala 62:28 64:15 16:22]
  wire [1:0] _GEN_8 = pop_vld ? 2'h0 : _GEN_7; // @[dut.scala 60:21 61:15]
  wire  _GEN_9 = pop_vld ? 1'h0 : push_vld; // @[dut.scala 60:21 24:25]
  wire [1:0] _GEN_10 = pop_vld ? 2'h1 : state; // @[dut.scala 68:21 69:15 16:22]
  wire [1:0] _GEN_11 = 2'h3 == state ? _GEN_10 : state; // @[dut.scala 40:17 16:22]
  wire  _GEN_13 = 2'h2 == state & _GEN_9; // @[dut.scala 40:17 24:25]
  wire  _GEN_16 = 2'h1 == state ? _GEN_6 : _GEN_13; // @[dut.scala 40:17]
  wire  load = 2'h0 == state ? push_vld : _GEN_16; // @[dut.scala 40:17]
  wire  shift = 2'h0 == state ? 1'h0 : 2'h1 == state & _GEN_4; // @[dut.scala 40:17 23:26]
  assign io_enq_ready = state == 2'h0 | state == 2'h1; // @[dut.scala 32:41]
  assign io_deq_valid = _io_enq_ready_T_1 | state == 2'h2 | state == 2'h3; // @[dut.scala 33:66]
  assign io_deq_bits = sendSel ? hold_0 : hold_1; // @[dut.scala 37:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:22]
      state <= 2'h0; // @[dut.scala 16:22]
    end else if (2'h0 == state) begin // @[dut.scala 40:17]
      if (push_vld) begin // @[dut.scala 42:22]
        state <= 2'h1; // @[dut.scala 44:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 40:17]
      if (push_vld & pop_vld) begin // @[dut.scala 48:33]
        state <= 2'h1; // @[dut.scala 50:15]
      end else begin
        state <= _GEN_3;
      end
    end else if (2'h2 == state) begin // @[dut.scala 40:17]
      state <= _GEN_8;
    end else begin
      state <= _GEN_11;
    end
    if (shift) begin // @[dut.scala 78:15]
      hold_0 <= hold_1; // @[dut.scala 79:12]
    end
    if (load) begin // @[dut.scala 75:14]
      hold_1 <= io_enq_bits; // @[dut.scala 76:12]
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
