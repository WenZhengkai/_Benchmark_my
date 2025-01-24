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
  reg [7:0] hold_0; // @[dut.scala 11:27]
  reg [7:0] hold_1; // @[dut.scala 12:27]
  reg [1:0] state; // @[dut.scala 13:27]
  wire  _shift_T = state == 2'h3; // @[dut.scala 29:19]
  wire  _shift_T_2 = state == 2'h1; // @[dut.scala 29:51]
  wire  shift = state == 2'h3 & io_deq_ready | state == 2'h1 & io_deq_ready; // @[dut.scala 29:41]
  wire  _load_T = state == 2'h0; // @[dut.scala 30:19]
  wire  _load_T_3 = _shift_T_2 & io_enq_valid; // @[dut.scala 31:29]
  wire  _load_T_4 = state == 2'h0 & io_enq_valid | _load_T_3; // @[dut.scala 30:42]
  wire  _load_T_5 = state == 2'h2; // @[dut.scala 32:19]
  wire  _load_T_7 = state == 2'h2 & io_enq_valid & io_deq_ready; // @[dut.scala 32:41]
  wire  load = _load_T_4 | _load_T_7; // @[dut.scala 31:42]
  wire  sendSel = _load_T_5 | _shift_T; // @[dut.scala 33:30]
  wire [1:0] _GEN_1 = io_deq_ready ? 2'h0 : state; // @[dut.scala 13:27 43:{34,42}]
  wire [1:0] _GEN_2 = io_enq_valid ? 2'h3 : _GEN_1; // @[dut.scala 42:{34,42}]
  wire [1:0] _GEN_3 = io_enq_valid & io_deq_ready ? 2'h1 : _GEN_2; // @[dut.scala 41:{33,41}]
  wire [1:0] _GEN_5 = io_deq_ready ? 2'h2 : state; // @[dut.scala 51:21 13:27 51:29]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 36:17 13:27]
  wire [7:0] _GEN_10 = _load_T_7 ? hold_1 : hold_0; // @[dut.scala 61:56 62:14 11:27]
  wire [7:0] _GEN_11 = _load_T_7 ? io_enq_bits : hold_1; // @[dut.scala 61:56 63:14 12:27]
  wire [7:0] _GEN_13 = _load_T_3 ? hold_0 : _GEN_10; // @[dut.scala 11:27 59:45]
  assign io_enq_ready = _load_T | _shift_T_2 | _load_T_5; // @[dut.scala 74:54]
  assign io_deq_valid = _shift_T_2 | _load_T_5 | _shift_T; // @[dut.scala 73:54]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 72:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:27]
      hold_0 <= 8'h0; // @[dut.scala 11:27]
    end else if (shift) begin // @[dut.scala 67:15]
      hold_0 <= hold_1; // @[dut.scala 68:12]
    end else if (load) begin // @[dut.scala 56:14]
      if (_load_T) begin // @[dut.scala 57:27]
        hold_0 <= io_enq_bits; // @[dut.scala 58:14]
      end else begin
        hold_0 <= _GEN_13;
      end
    end
    if (reset) begin // @[dut.scala 12:27]
      hold_1 <= 8'h0; // @[dut.scala 12:27]
    end else if (load) begin // @[dut.scala 56:14]
      if (!(_load_T)) begin // @[dut.scala 57:27]
        if (_load_T_3) begin // @[dut.scala 59:45]
          hold_1 <= io_enq_bits; // @[dut.scala 60:14]
        end else begin
          hold_1 <= _GEN_11;
        end
      end
    end
    if (reset) begin // @[dut.scala 13:27]
      state <= 2'h0; // @[dut.scala 13:27]
    end else if (2'h0 == state) begin // @[dut.scala 36:17]
      if (io_enq_valid) begin // @[dut.scala 38:22]
        state <= 2'h1; // @[dut.scala 38:30]
      end
    end else if (2'h1 == state) begin // @[dut.scala 36:17]
      state <= _GEN_3;
    end else if (2'h2 == state) begin // @[dut.scala 36:17]
      state <= _GEN_3;
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
