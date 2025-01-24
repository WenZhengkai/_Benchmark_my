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
  reg [1:0] stateReg; // @[dut.scala 13:25]
  reg [7:0] hold_0; // @[dut.scala 16:23]
  reg [7:0] hold_1; // @[dut.scala 17:23]
  wire  _push_vld_T = stateReg == 2'h0; // @[dut.scala 27:41]
  wire  _push_vld_T_1 = stateReg == 2'h1; // @[dut.scala 27:63]
  wire  _pop_vld_T_2 = stateReg == 2'h2 | stateReg == 2'h3; // @[dut.scala 28:50]
  wire  shift = _push_vld_T_1 & io_enq_valid & io_deq_ready; // @[dut.scala 30:49]
  wire  load = _push_vld_T & io_enq_valid; // @[dut.scala 31:32]
  wire [1:0] _GEN_1 = io_deq_ready ? 2'h0 : stateReg; // @[dut.scala 48:32 49:18 13:25]
  wire [1:0] _GEN_2 = io_enq_valid ? 2'h2 : _GEN_1; // @[dut.scala 46:32 47:18]
  wire [1:0] _GEN_4 = io_deq_ready ? 2'h1 : stateReg; // @[dut.scala 58:26 59:18 13:25]
  wire [1:0] _GEN_5 = 2'h3 == stateReg ? _GEN_4 : stateReg; // @[dut.scala 37:20 13:25]
  assign io_enq_ready = io_enq_valid & (stateReg == 2'h0 | stateReg == 2'h1); // @[dut.scala 27:28]
  assign io_deq_valid = io_deq_ready & (stateReg == 2'h2 | stateReg == 2'h3); // @[dut.scala 28:27]
  assign io_deq_bits = _pop_vld_T_2 ? hold_1 : hold_0; // @[dut.scala 76:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:25]
      stateReg <= 2'h0; // @[dut.scala 13:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 37:20]
      if (io_enq_valid) begin // @[dut.scala 39:26]
        stateReg <= 2'h1; // @[dut.scala 40:18]
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 37:20]
      if (io_enq_valid & io_deq_ready) begin // @[dut.scala 44:42]
        stateReg <= 2'h3; // @[dut.scala 45:18]
      end else begin
        stateReg <= _GEN_2;
      end
    end else if (2'h2 == stateReg) begin // @[dut.scala 37:20]
      stateReg <= _GEN_1;
    end else begin
      stateReg <= _GEN_5;
    end
    if (reset) begin // @[dut.scala 16:23]
      hold_0 <= 8'h0; // @[dut.scala 16:23]
    end else if (shift) begin // @[dut.scala 68:15]
      hold_0 <= hold_1; // @[dut.scala 69:12]
    end else if (load) begin // @[dut.scala 65:14]
      hold_0 <= io_enq_bits; // @[dut.scala 66:12]
    end
    if (reset) begin // @[dut.scala 17:23]
      hold_1 <= 8'h0; // @[dut.scala 17:23]
    end else if (shift) begin // @[dut.scala 68:15]
      hold_1 <= io_enq_bits; // @[dut.scala 70:12]
    end else if (load) begin // @[dut.scala 71:50]
      hold_1 <= io_enq_bits; // @[dut.scala 72:12]
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
