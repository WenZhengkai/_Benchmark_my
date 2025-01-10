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
  wire  _GEN_17 = 2'h2 == state | 2'h3 == state; // @[dut.scala 38:17 59:20]
  wire  _GEN_23 = 2'h1 == state ? 1'h0 : _GEN_17; // @[dut.scala 38:17 49:15]
  wire  sendSel = 2'h0 == state ? 1'h0 : _GEN_23; // @[dut.scala 33:11 38:17]
  wire [7:0] _GEN_0 = push_vld ? io_enq_bits : hold_1; // @[dut.scala 41:22 42:16 16:19]
  wire [1:0] _GEN_2 = push_vld ? 2'h3 : state; // @[dut.scala 52:28 54:15 12:22]
  wire [1:0] _GEN_3 = pop_vld ? 2'h0 : _GEN_2; // @[dut.scala 50:21 51:15]
  wire [7:0] _GEN_5 = push_vld ? io_enq_bits : hold_0; // @[dut.scala 63:28 64:16 15:19]
  wire [1:0] _GEN_7 = push_vld ? state : 2'h1; // @[dut.scala 12:22 75:24 78:17]
  wire [7:0] _GEN_8 = pop_vld ? hold_1 : hold_0; // @[dut.scala 72:21 73:16 15:19]
  wire [7:0] _GEN_10 = pop_vld ? _GEN_0 : hold_1; // @[dut.scala 16:19 72:21]
  wire [1:0] _GEN_11 = pop_vld ? _GEN_7 : state; // @[dut.scala 72:21 12:22]
  wire [1:0] _GEN_16 = 2'h3 == state ? _GEN_11 : state; // @[dut.scala 38:17 12:22]
  wire  _GEN_20 = 2'h2 == state ? 1'h0 : 2'h3 == state & pop_vld; // @[dut.scala 36:16 38:17]
  wire  _GEN_22 = 2'h1 == state | _GEN_17; // @[dut.scala 38:17 48:20]
  wire  _GEN_27 = 2'h1 == state ? 1'h0 : _GEN_20; // @[dut.scala 36:16 38:17]
  assign io_enq_ready = 2'h0 == state | _GEN_27; // @[dut.scala 38:17 40:20]
  assign io_deq_valid = 2'h0 == state ? 1'h0 : _GEN_22; // @[dut.scala 35:16 38:17]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 28:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 38:17]
      if (push_vld) begin // @[dut.scala 41:22]
        state <= 2'h2; // @[dut.scala 43:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 38:17]
      state <= _GEN_3;
    end else if (2'h2 == state) begin // @[dut.scala 38:17]
      state <= _GEN_3;
    end else begin
      state <= _GEN_16;
    end
    if (!(2'h0 == state)) begin // @[dut.scala 38:17]
      if (!(2'h1 == state)) begin // @[dut.scala 38:17]
        if (2'h2 == state) begin // @[dut.scala 38:17]
          if (!(pop_vld)) begin // @[dut.scala 61:21]
            hold_0 <= _GEN_5;
          end
        end else if (2'h3 == state) begin // @[dut.scala 38:17]
          hold_0 <= _GEN_8;
        end
      end
    end
    if (2'h0 == state) begin // @[dut.scala 38:17]
      hold_1 <= _GEN_0;
    end else if (2'h1 == state) begin // @[dut.scala 38:17]
      if (!(pop_vld)) begin // @[dut.scala 50:21]
        hold_1 <= _GEN_0;
      end
    end else if (!(2'h2 == state)) begin // @[dut.scala 38:17]
      if (2'h3 == state) begin // @[dut.scala 38:17]
        hold_1 <= _GEN_10;
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
