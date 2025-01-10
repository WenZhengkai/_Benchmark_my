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
  wire  _sendSel_T = state == 2'h3; // @[dut.scala 69:20]
  wire  sendSel = state == 2'h3 | state == 2'h2; // @[dut.scala 69:30]
  wire [1:0] _GEN_2 = push_vld & pop_vld ? 2'h1 : state; // @[dut.scala 47:39 48:15 12:22]
  wire [7:0] _GEN_3 = push_vld & pop_vld ? io_enq_bits : hold_0; // @[dut.scala 47:39 49:16 15:19]
  wire [1:0] _GEN_4 = ~push_vld & pop_vld ? 2'h0 : _GEN_2; // @[dut.scala 45:40 46:15]
  wire [7:0] _GEN_5 = ~push_vld & pop_vld ? hold_0 : _GEN_3; // @[dut.scala 15:19 45:40]
  wire [1:0] _GEN_9 = pop_vld ? 2'h0 : state; // @[dut.scala 54:21 55:15 12:22]
  wire [1:0] _GEN_10 = pop_vld ? 2'h2 : state; // @[dut.scala 61:21 62:15 12:22]
  wire [7:0] _GEN_11 = pop_vld ? hold_1 : hold_0; // @[dut.scala 61:21 63:16 15:19]
  wire [1:0] _GEN_14 = 2'h3 == state ? _GEN_10 : state; // @[dut.scala 31:17 12:22]
  wire [7:0] _GEN_15 = 2'h3 == state ? _GEN_11 : hold_0; // @[dut.scala 31:17 15:19]
  wire  _GEN_16 = 2'h2 == state | 2'h3 == state; // @[dut.scala 31:17 53:20]
  wire  _GEN_21 = 2'h1 == state | _GEN_16; // @[dut.scala 31:17 41:20]
  wire  load = push_vld & state == 2'h1; // @[dut.scala 72:20]
  wire  shift = pop_vld & _sendSel_T; // @[dut.scala 73:20]
  assign io_enq_ready = 2'h0 == state | 2'h1 == state; // @[dut.scala 31:17 33:20]
  assign io_deq_valid = 2'h0 == state ? 1'h0 : _GEN_21; // @[dut.scala 27:16 31:17]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 28:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (push_vld) begin // @[dut.scala 34:22]
        state <= 2'h1; // @[dut.scala 35:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      if (push_vld & ~pop_vld) begin // @[dut.scala 42:34]
        state <= 2'h3; // @[dut.scala 43:15]
      end else begin
        state <= _GEN_4;
      end
    end else if (2'h2 == state) begin // @[dut.scala 31:17]
      state <= _GEN_9;
    end else begin
      state <= _GEN_14;
    end
    if (shift) begin // @[dut.scala 81:15]
      hold_0 <= hold_1; // @[dut.scala 82:12]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (push_vld) begin // @[dut.scala 34:22]
        hold_0 <= io_enq_bits; // @[dut.scala 36:16]
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      if (!(push_vld & ~pop_vld)) begin // @[dut.scala 42:34]
        hold_0 <= _GEN_5;
      end
    end else if (!(2'h2 == state)) begin // @[dut.scala 31:17]
      hold_0 <= _GEN_15;
    end
    if (load) begin // @[dut.scala 76:14]
      hold_1 <= io_enq_bits; // @[dut.scala 77:12]
    end else if (!(2'h0 == state)) begin // @[dut.scala 31:17]
      if (2'h1 == state) begin // @[dut.scala 31:17]
        if (push_vld & ~pop_vld) begin // @[dut.scala 42:34]
          hold_1 <= io_enq_bits; // @[dut.scala 44:16]
        end
      end
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
