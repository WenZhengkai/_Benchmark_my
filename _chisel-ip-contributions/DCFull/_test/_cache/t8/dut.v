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
  reg [1:0] state; // @[dut.scala 23:22]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 26:28]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 27:27]
  wire  _shift_T = state == 2'h1; // @[dut.scala 29:19]
  wire  _shift_T_2 = state == 2'h3; // @[dut.scala 29:51]
  wire  shift = state == 2'h1 & pop_vld | state == 2'h3 & pop_vld; // @[dut.scala 29:41]
  wire  _load_T = state == 2'h0; // @[dut.scala 30:17]
  wire  load = state == 2'h0 & push_vld; // @[dut.scala 30:27]
  wire  _io_deq_valid_T_1 = state == 2'h2; // @[dut.scala 33:44]
  wire  _T_2 = push_vld & pop_vld; // @[dut.scala 43:21]
  wire [1:0] _GEN_1 = pop_vld ? 2'h0 : state; // @[dut.scala 47:27 48:15 23:22]
  wire [1:0] _GEN_2 = push_vld ? 2'h3 : _GEN_1; // @[dut.scala 45:28 46:15]
  wire [1:0] _GEN_4 = push_vld ? 2'h1 : _GEN_1; // @[dut.scala 54:28 55:15]
  wire [1:0] _GEN_5 = _T_2 ? 2'h2 : _GEN_4; // @[dut.scala 52:33 53:15]
  wire [1:0] _GEN_6 = pop_vld ? 2'h1 : state; // @[dut.scala 61:21 62:15 23:22]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_6 : state; // @[dut.scala 36:17 23:22]
  wire  sendSel = _io_deq_valid_T_1 | _shift_T_2; // @[dut.scala 76:32]
  assign io_enq_ready = _load_T | _shift_T; // @[dut.scala 32:35]
  assign io_deq_valid = _shift_T | state == 2'h2 | _shift_T_2; // @[dut.scala 33:54]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 77:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:23]
      hold_0 <= 8'h0; // @[dut.scala 11:23]
    end else if (shift) begin // @[dut.scala 71:15]
      hold_0 <= hold_1; // @[dut.scala 72:12]
    end
    if (reset) begin // @[dut.scala 12:23]
      hold_1 <= 8'h0; // @[dut.scala 12:23]
    end else if (load) begin // @[dut.scala 68:14]
      hold_1 <= io_enq_bits; // @[dut.scala 69:12]
    end
    if (reset) begin // @[dut.scala 23:22]
      state <= 2'h0; // @[dut.scala 23:22]
    end else if (2'h0 == state) begin // @[dut.scala 36:17]
      if (push_vld) begin // @[dut.scala 38:22]
        state <= 2'h1; // @[dut.scala 39:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 36:17]
      if (push_vld & pop_vld) begin // @[dut.scala 43:33]
        state <= 2'h1; // @[dut.scala 44:15]
      end else begin
        state <= _GEN_2;
      end
    end else if (2'h2 == state) begin // @[dut.scala 36:17]
      state <= _GEN_5;
    end else begin
      state <= _GEN_7;
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
