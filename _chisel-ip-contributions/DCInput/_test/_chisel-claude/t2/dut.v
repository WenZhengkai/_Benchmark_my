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
  reg  ready_r; // @[dut.scala 11:24]
  reg  occupied; // @[dut.scala 12:25]
  reg [7:0] hold; // @[dut.scala 13:17]
  wire  drain = occupied & io_deq_ready; // @[dut.scala 19:21]
  wire  load = io_enq_valid & ready_r & (~io_deq_ready | drain); // @[dut.scala 20:35]
  wire  _GEN_0 = drain ? 1'h0 : occupied; // @[dut.scala 30:21 31:14 12:25]
  wire  _GEN_1 = load | _GEN_0; // @[dut.scala 27:14 28:14]
  assign io_enq_ready = ready_r; // @[dut.scala 36:16]
  assign io_deq_valid = io_enq_valid | occupied; // @[dut.scala 24:32]
  assign io_deq_bits = occupied ? hold : io_enq_bits; // @[dut.scala 23:21]
  always @(posedge clock) begin
    ready_r <= reset | (~occupied | drain); // @[dut.scala 11:{24,24} 35:11]
    if (reset) begin // @[dut.scala 12:25]
      occupied <= 1'h0; // @[dut.scala 12:25]
    end else begin
      occupied <= _GEN_1;
    end
    if (load) begin // @[dut.scala 27:14]
      hold <= io_enq_bits; // @[dut.scala 29:10]
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
  ready_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  occupied = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  hold = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
