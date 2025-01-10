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
  reg [1:0] state; // @[dut.scala 14:22]
  reg [7:0] hold_0; // @[dut.scala 17:19]
  reg [7:0] hold_1; // @[dut.scala 18:19]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 26:31]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 27:31]
  wire  _T_2 = push_vld & pop_vld; // @[dut.scala 43:21]
  wire [1:0] _GEN_2 = pop_vld ? 2'h2 : state; // @[dut.scala 50:27 51:15 14:22]
  wire [1:0] _GEN_4 = push_vld ? 2'h3 : _GEN_2; // @[dut.scala 47:28 48:15]
  wire  _GEN_5 = push_vld ? 1'h0 : pop_vld; // @[dut.scala 47:28 30:9]
  wire  _GEN_7 = push_vld & pop_vld | push_vld; // @[dut.scala 43:33 45:14]
  wire  _GEN_8 = push_vld & pop_vld | _GEN_5; // @[dut.scala 43:33 46:15]
  wire [1:0] _GEN_9 = pop_vld ? 2'h0 : state; // @[dut.scala 63:27 64:15 14:22]
  wire [1:0] _GEN_10 = push_vld ? 2'h3 : _GEN_9; // @[dut.scala 60:28 61:15]
  wire [1:0] _GEN_11 = _T_2 ? 2'h1 : _GEN_10; // @[dut.scala 56:33 57:15]
  wire [1:0] _GEN_14 = pop_vld ? 2'h1 : state; // @[dut.scala 68:21 69:15 14:22]
  wire [1:0] _GEN_15 = 2'h3 == state ? _GEN_14 : state; // @[dut.scala 35:17 14:22]
  wire  _GEN_16 = 2'h3 == state & pop_vld; // @[dut.scala 35:17 30:9]
  wire  _GEN_18 = 2'h2 == state & _GEN_7; // @[dut.scala 35:17 31:8]
  wire  _GEN_19 = 2'h2 == state ? _T_2 : _GEN_16; // @[dut.scala 35:17]
  wire  _GEN_21 = 2'h1 == state ? _GEN_7 : _GEN_18; // @[dut.scala 35:17]
  wire  _GEN_22 = 2'h1 == state ? _GEN_8 : _GEN_19; // @[dut.scala 35:17]
  wire  load = 2'h0 == state ? push_vld : _GEN_21; // @[dut.scala 35:17]
  wire  shift = 2'h0 == state ? 1'h0 : _GEN_22; // @[dut.scala 35:17 30:9]
  wire  sendSel = state == 2'h2 | state == 2'h3; // @[dut.scala 87:31]
  assign io_enq_ready = state != 2'h3; // @[dut.scala 90:25]
  assign io_deq_valid = state != 2'h0; // @[dut.scala 91:25]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 84:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      state <= 2'h0; // @[dut.scala 14:22]
    end else if (2'h0 == state) begin // @[dut.scala 35:17]
      if (push_vld) begin // @[dut.scala 37:22]
        state <= 2'h1; // @[dut.scala 38:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 35:17]
      if (push_vld & pop_vld) begin // @[dut.scala 43:33]
        state <= 2'h1; // @[dut.scala 44:15]
      end else begin
        state <= _GEN_4;
      end
    end else if (2'h2 == state) begin // @[dut.scala 35:17]
      state <= _GEN_11;
    end else begin
      state <= _GEN_15;
    end
    if (load) begin // @[dut.scala 76:14]
      hold_0 <= io_enq_bits; // @[dut.scala 77:12]
    end
    if (shift) begin // @[dut.scala 79:15]
      hold_1 <= hold_0; // @[dut.scala 80:12]
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
