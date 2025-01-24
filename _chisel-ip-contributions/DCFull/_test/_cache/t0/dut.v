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
  reg [7:0] hold_0; // @[dut.scala 11:23]
  reg [7:0] hold_1; // @[dut.scala 12:23]
  reg [1:0] state; // @[dut.scala 16:22]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 26:28]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 27:27]
  wire  _T_2 = pop_vld & io_enq_valid; // @[dut.scala 39:20]
  wire [1:0] _GEN_3 = push_vld ? 2'h3 : state; // @[dut.scala 45:28 46:15 16:22]
  wire [1:0] _GEN_4 = pop_vld ? 2'h0 : _GEN_3; // @[dut.scala 43:27 44:15]
  wire  _GEN_5 = pop_vld ? 1'h0 : push_vld; // @[dut.scala 20:25 43:27]
  wire  _GEN_8 = pop_vld & io_enq_valid | _GEN_5; // @[dut.scala 39:37 42:14]
  wire [1:0] _GEN_9 = pop_vld ? 2'h0 : state; // @[dut.scala 51:21 52:15 16:22]
  wire [1:0] _GEN_10 = pop_vld ? 2'h2 : state; // @[dut.scala 56:21 57:15 16:22]
  wire [1:0] _GEN_12 = 2'h3 == state ? _GEN_10 : state; // @[dut.scala 30:17 16:22]
  wire  _GEN_15 = 2'h2 == state ? 1'h0 : 2'h3 == state & pop_vld; // @[dut.scala 30:17 19:26]
  wire  _GEN_17 = 2'h1 == state ? _T_2 : _GEN_15; // @[dut.scala 30:17]
  wire  _GEN_18 = 2'h1 == state & _GEN_8; // @[dut.scala 30:17 20:25]
  wire  load = 2'h0 == state ? push_vld : _GEN_18; // @[dut.scala 30:17]
  wire  shift = 2'h0 == state ? 1'h0 : _GEN_17; // @[dut.scala 30:17 19:26]
  wire  _sendSel_T = state == 2'h1; // @[dut.scala 80:21]
  wire  sendSel = state == 2'h1 | state == 2'h2; // @[dut.scala 80:31]
  assign io_enq_ready = state == 2'h0 | _sendSel_T; // @[dut.scala 76:36]
  assign io_deq_valid = sendSel | state == 2'h3; // @[dut.scala 77:55]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 73:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:23]
      hold_0 <= 8'h0; // @[dut.scala 11:23]
    end else if (shift) begin // @[dut.scala 68:15]
      hold_0 <= hold_1; // @[dut.scala 69:12]
    end
    if (reset) begin // @[dut.scala 12:23]
      hold_1 <= 8'h0; // @[dut.scala 12:23]
    end else if (load) begin // @[dut.scala 64:14]
      hold_1 <= io_enq_bits; // @[dut.scala 65:12]
    end
    if (reset) begin // @[dut.scala 16:22]
      state <= 2'h0; // @[dut.scala 16:22]
    end else if (2'h0 == state) begin // @[dut.scala 30:17]
      if (push_vld) begin // @[dut.scala 32:22]
        state <= 2'h1; // @[dut.scala 33:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 30:17]
      if (pop_vld & io_enq_valid) begin // @[dut.scala 39:37]
        state <= 2'h1; // @[dut.scala 40:15]
      end else begin
        state <= _GEN_4;
      end
    end else if (2'h2 == state) begin // @[dut.scala 30:17]
      state <= _GEN_9;
    end else begin
      state <= _GEN_12;
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
  hold_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  hold_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
