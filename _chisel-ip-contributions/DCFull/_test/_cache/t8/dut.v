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
  reg [1:0] stateReg; // @[dut.scala 12:25]
  reg [7:0] hold_0; // @[dut.scala 15:19]
  reg [7:0] hold_1; // @[dut.scala 16:19]
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 24:31]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 25:30]
  wire [1:0] _GEN_3 = pop_vld ? 2'h0 : stateReg; // @[dut.scala 42:27 44:18 12:25]
  wire [1:0] _GEN_4 = push_vld ? 2'h3 : _GEN_3; // @[dut.scala 39:28 41:18]
  wire  _GEN_5 = push_vld ? 1'h0 : pop_vld; // @[dut.scala 19:26 39:28]
  wire  _GEN_6 = push_vld & pop_vld | _GEN_5; // @[dut.scala 36:33 37:15]
  wire  _GEN_7 = push_vld & pop_vld | push_vld; // @[dut.scala 36:33 38:14]
  wire [1:0] _GEN_8 = push_vld & pop_vld ? stateReg : _GEN_4; // @[dut.scala 12:25 36:33]
  wire [1:0] _GEN_11 = pop_vld ? 2'h1 : stateReg; // @[dut.scala 58:21 60:18 12:25]
  wire [1:0] _GEN_13 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[dut.scala 28:20 12:25]
  wire  _GEN_14 = 2'h2 == stateReg & _GEN_7; // @[dut.scala 28:20 20:25]
  wire  _GEN_16 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & pop_vld; // @[dut.scala 28:20 19:26]
  wire  _GEN_17 = 2'h1 == stateReg ? _GEN_6 : _GEN_16; // @[dut.scala 28:20]
  wire  _GEN_18 = 2'h1 == stateReg ? _GEN_7 : _GEN_14; // @[dut.scala 28:20]
  wire  load = 2'h0 == stateReg ? push_vld : _GEN_18; // @[dut.scala 28:20]
  wire  shift = 2'h0 == stateReg ? 1'h0 : _GEN_17; // @[dut.scala 28:20 19:26]
  wire  _sendSel_T = stateReg == 2'h1; // @[dut.scala 74:24]
  wire  _sendSel_T_1 = stateReg == 2'h3; // @[dut.scala 74:48]
  wire  sendSel = stateReg == 2'h1 | stateReg == 2'h3; // @[dut.scala 74:35]
  wire  _io_deq_valid_T_1 = stateReg == 2'h2; // @[dut.scala 78:53]
  assign io_enq_ready = stateReg == 2'h0 | _io_deq_valid_T_1; // @[dut.scala 80:40]
  assign io_deq_valid = _sendSel_T | stateReg == 2'h2 | _sendSel_T_1; // @[dut.scala 78:64]
  assign io_deq_bits = sendSel ? hold_0 : hold_1; // @[dut.scala 75:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:25]
      stateReg <= 2'h0; // @[dut.scala 12:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 28:20]
      if (push_vld) begin // @[dut.scala 30:22]
        stateReg <= 2'h1; // @[dut.scala 32:18]
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 28:20]
      stateReg <= _GEN_8;
    end else if (2'h2 == stateReg) begin // @[dut.scala 28:20]
      stateReg <= _GEN_8;
    end else begin
      stateReg <= _GEN_13;
    end
    if (shift) begin // @[dut.scala 66:15]
      hold_0 <= hold_1; // @[dut.scala 67:12]
    end
    if (load) begin // @[dut.scala 69:14]
      hold_1 <= io_enq_bits; // @[dut.scala 70:12]
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
  stateReg = _RAND_0[1:0];
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
