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
  wire  push_vld = io_enq_valid & io_enq_ready; // @[dut.scala 24:31]
  wire  pop_vld = io_deq_valid & io_deq_ready; // @[dut.scala 25:30]
  wire [7:0] _GEN_0 = push_vld ? io_enq_bits : hold_1; // @[dut.scala 35:22 36:16 16:19]
  wire [1:0] _GEN_3 = push_vld ? 2'h3 : state; // @[dut.scala 42:22 45:15 12:22]
  wire [1:0] _GEN_5 = pop_vld ? 2'h0 : state; // @[dut.scala 52:21 53:15 12:22]
  wire [7:0] _GEN_6 = pop_vld ? hold_0 : hold_1; // @[dut.scala 60:21 61:16 16:19]
  wire [1:0] _GEN_7 = pop_vld ? 2'h1 : state; // @[dut.scala 60:21 62:15 12:22]
  wire [1:0] _GEN_11 = 2'h3 == state ? _GEN_7 : state; // @[dut.scala 32:17 12:22]
  wire  _GEN_12 = 2'h2 == state | 2'h3 == state; // @[dut.scala 32:17 50:20]
  wire  _GEN_21 = 2'h1 == state ? 1'h0 : _GEN_12; // @[dut.scala 29:16 32:17]
  wire  _GEN_22 = 2'h1 == state ? 1'h0 : 2'h2 == state; // @[dut.scala 32:17 21:28]
  wire  sendSel = 2'h0 == state ? 1'h0 : _GEN_22; // @[dut.scala 32:17 21:28]
  assign io_enq_ready = 2'h0 == state | 2'h1 == state; // @[dut.scala 32:17 34:20]
  assign io_deq_valid = 2'h0 == state ? 1'h0 : _GEN_21; // @[dut.scala 29:16 32:17]
  assign io_deq_bits = sendSel ? hold_0 : hold_1; // @[dut.scala 68:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 32:17]
      if (push_vld) begin // @[dut.scala 35:22]
        state <= 2'h1; // @[dut.scala 37:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 32:17]
      if (pop_vld) begin // @[dut.scala 47:21]
        state <= 2'h2; // @[dut.scala 47:29]
      end else begin
        state <= _GEN_3;
      end
    end else if (2'h2 == state) begin // @[dut.scala 32:17]
      state <= _GEN_5;
    end else begin
      state <= _GEN_11;
    end
    if (!(2'h0 == state)) begin // @[dut.scala 32:17]
      if (2'h1 == state) begin // @[dut.scala 32:17]
        if (push_vld) begin // @[dut.scala 42:22]
          hold_0 <= hold_1; // @[dut.scala 43:16]
        end
      end
    end
    if (2'h0 == state) begin // @[dut.scala 32:17]
      hold_1 <= _GEN_0;
    end else if (2'h1 == state) begin // @[dut.scala 32:17]
      hold_1 <= _GEN_0;
    end else if (!(2'h2 == state)) begin // @[dut.scala 32:17]
      if (2'h3 == state) begin // @[dut.scala 32:17]
        hold_1 <= _GEN_6;
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
