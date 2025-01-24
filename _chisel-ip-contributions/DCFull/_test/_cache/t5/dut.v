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
  reg [7:0] hold_0; // @[dut.scala 12:23]
  reg [7:0] hold_1; // @[dut.scala 13:23]
  reg [1:0] state; // @[dut.scala 17:22]
  wire  _push_vld_T_1 = state == 2'h1; // @[dut.scala 27:57]
  wire  _push_vld_T_2 = state == 2'h0 | state == 2'h1; // @[dut.scala 27:48]
  wire  push_vld = io_enq_valid & (state == 2'h0 | state == 2'h1); // @[dut.scala 27:28]
  wire  _pop_vld_T_1 = state == 2'h2; // @[dut.scala 28:56]
  wire  _pop_vld_T_2 = _push_vld_T_1 | state == 2'h2; // @[dut.scala 28:47]
  wire  _pop_vld_T_3 = state == 2'h3; // @[dut.scala 28:75]
  wire  pop_vld = io_deq_ready & (_push_vld_T_1 | state == 2'h2 | state == 2'h3); // @[dut.scala 28:27]
  wire  shift = push_vld & _pop_vld_T_2; // @[dut.scala 29:21]
  wire  load = push_vld & _push_vld_T_2; // @[dut.scala 30:20]
  wire  sendSel = _pop_vld_T_1 | _pop_vld_T_3; // @[dut.scala 31:30]
  wire [1:0] _GEN_2 = pop_vld ? 2'h0 : state; // @[dut.scala 47:27 48:15 17:22]
  wire [1:0] _GEN_3 = push_vld ? 2'h2 : _GEN_2; // @[dut.scala 45:28 46:15]
  wire [1:0] _GEN_5 = push_vld ? 2'h3 : _GEN_2; // @[dut.scala 52:22 53:15]
  wire [1:0] _GEN_6 = pop_vld ? 2'h1 : state; // @[dut.scala 59:21 60:15 17:22]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_6 : state; // @[dut.scala 34:17 17:22]
  assign io_enq_ready = push_vld & state != 2'h3; // @[dut.scala 77:28]
  assign io_deq_valid = pop_vld & state != 2'h0; // @[dut.scala 78:27]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 74:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:23]
      hold_0 <= 8'h0; // @[dut.scala 12:23]
    end else if (shift) begin // @[dut.scala 69:15]
      hold_0 <= hold_1; // @[dut.scala 70:12]
    end
    if (reset) begin // @[dut.scala 13:23]
      hold_1 <= 8'h0; // @[dut.scala 13:23]
    end else if (load) begin // @[dut.scala 66:14]
      hold_1 <= io_enq_bits; // @[dut.scala 67:12]
    end
    if (reset) begin // @[dut.scala 17:22]
      state <= 2'h0; // @[dut.scala 17:22]
    end else if (2'h0 == state) begin // @[dut.scala 34:17]
      if (push_vld & io_deq_ready) begin // @[dut.scala 36:38]
        state <= 2'h1; // @[dut.scala 37:15]
      end else if (push_vld) begin // @[dut.scala 38:28]
        state <= 2'h2; // @[dut.scala 39:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 34:17]
      if (push_vld & pop_vld) begin // @[dut.scala 43:33]
        state <= 2'h3; // @[dut.scala 44:15]
      end else begin
        state <= _GEN_3;
      end
    end else if (2'h2 == state) begin // @[dut.scala 34:17]
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
