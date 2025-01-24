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
  reg [7:0] hold_0; // @[dut.scala 11:19]
  reg [7:0] hold_1; // @[dut.scala 12:19]
  reg [1:0] state; // @[dut.scala 16:22]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 26:28]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 27:27]
  wire [1:0] _GEN_1 = pop_vld ? 2'h2 : state; // @[dut.scala 39:27 40:15 16:22]
  wire [1:0] _GEN_3 = pop_vld ? 2'h0 : state; // @[dut.scala 44:21 45:15 16:22]
  wire [1:0] _GEN_4 = pop_vld ? 2'h1 : state; // @[dut.scala 49:21 50:15 16:22]
  wire [1:0] _GEN_5 = 2'h3 == state ? _GEN_4 : state; // @[dut.scala 30:17 16:22]
  wire  load = state == 2'h0 & push_vld; // @[dut.scala 56:28]
  wire  _shift_T = state == 2'h1; // @[dut.scala 57:19]
  wire  shift = state == 2'h1 & pop_vld; // @[dut.scala 57:29]
  wire  sendSel = state == 2'h3; // @[dut.scala 70:21]
  assign io_enq_ready = state != 2'h3; // @[dut.scala 76:26]
  assign io_deq_valid = _shift_T | state == 2'h2 | sendSel; // @[dut.scala 73:55]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 72:21]
  always @(posedge clock) begin
    if (load) begin // @[dut.scala 59:14]
      hold_0 <= io_enq_bits; // @[dut.scala 60:12]
    end else if (shift) begin // @[dut.scala 61:21]
      hold_0 <= hold_1; // @[dut.scala 62:12]
    end
    if (_shift_T & push_vld) begin // @[dut.scala 65:37]
      hold_1 <= io_enq_bits; // @[dut.scala 66:12]
    end
    if (reset) begin // @[dut.scala 16:22]
      state <= 2'h0; // @[dut.scala 16:22]
    end else if (2'h0 == state) begin // @[dut.scala 30:17]
      if (push_vld) begin // @[dut.scala 32:22]
        state <= 2'h1; // @[dut.scala 33:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 30:17]
      if (push_vld) begin // @[dut.scala 37:22]
        state <= 2'h3; // @[dut.scala 38:15]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h2 == state) begin // @[dut.scala 30:17]
      state <= _GEN_3;
    end else begin
      state <= _GEN_5;
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
