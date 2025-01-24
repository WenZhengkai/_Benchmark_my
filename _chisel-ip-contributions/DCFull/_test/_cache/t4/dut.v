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
  reg [7:0] hold_0; // @[dut.scala 12:19]
  reg [7:0] hold_1; // @[dut.scala 13:19]
  reg [1:0] state; // @[dut.scala 17:22]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 28:28]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 29:27]
  wire  _shift_T = state == 2'h1; // @[dut.scala 32:19]
  wire  _shift_T_2 = state == 2'h3; // @[dut.scala 32:52]
  wire  shift = state == 2'h1 & push_vld | state == 2'h3 & pop_vld; // @[dut.scala 32:42]
  wire  _load_T = state == 2'h0; // @[dut.scala 33:34]
  wire  _load_T_3 = state == 2'h2; // @[dut.scala 33:73]
  wire  _load_T_4 = ~pop_vld; // @[dut.scala 33:86]
  wire  load = io_enq_valid & (state == 2'h0 | _shift_T | state == 2'h2 & ~pop_vld); // @[dut.scala 33:24]
  wire  _T_3 = push_vld & _load_T_4; // @[dut.scala 44:21]
  wire [1:0] _GEN_1 = pop_vld & ~push_vld ? 2'h2 : state; // @[dut.scala 46:40 47:15 17:22]
  wire [1:0] _GEN_3 = pop_vld ? 2'h0 : state; // @[dut.scala 53:27 54:15 17:22]
  wire [1:0] _GEN_4 = _T_3 ? 2'h1 : _GEN_3; // @[dut.scala 51:34 52:15]
  wire [1:0] _GEN_5 = pop_vld ? 2'h1 : state; // @[dut.scala 58:21 59:15 17:22]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 37:17 17:22]
  wire  sendSel = _shift_T_2 | _load_T_3; // @[dut.scala 75:34]
  assign io_enq_ready = _load_T | _load_T_3 | _shift_T; // @[dut.scala 80:55]
  assign io_deq_valid = _shift_T | _load_T_3 | _shift_T_2; // @[dut.scala 81:55]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 76:21]
  always @(posedge clock) begin
    if (shift) begin // @[dut.scala 69:15]
      hold_0 <= hold_1; // @[dut.scala 70:12]
    end
    if (load) begin // @[dut.scala 66:14]
      hold_1 <= io_enq_bits; // @[dut.scala 67:12]
    end
    if (reset) begin // @[dut.scala 17:22]
      state <= 2'h0; // @[dut.scala 17:22]
    end else if (2'h0 == state) begin // @[dut.scala 37:17]
      if (push_vld) begin // @[dut.scala 39:22]
        state <= 2'h1; // @[dut.scala 40:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 37:17]
      if (push_vld & _load_T_4) begin // @[dut.scala 44:34]
        state <= 2'h3; // @[dut.scala 45:15]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h2 == state) begin // @[dut.scala 37:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_6;
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
