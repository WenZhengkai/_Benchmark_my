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
`endif // RANDOMIZE_REG_INIT
  reg  pValid; // @[dut.scala 21:23]
  reg [7:0] pData; // @[dut.scala 22:18]
  wire  _GEN_0 = io_deq_valid & io_deq_ready ? 1'h0 : pValid; // @[dut.scala 33:44 34:12 21:23]
  wire  _GEN_1 = io_enq_valid & io_enq_ready | _GEN_0; // @[dut.scala 30:38 31:12]
  assign io_enq_ready = ~pValid; // @[dut.scala 25:19]
  assign io_deq_valid = pValid; // @[dut.scala 26:16]
  assign io_deq_bits = pData; // @[dut.scala 27:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:23]
      pValid <= 1'h0; // @[dut.scala 21:23]
    end else begin
      pValid <= _GEN_1;
    end
    if (io_enq_valid & io_enq_ready) begin // @[dut.scala 30:38]
      pData <= io_enq_bits; // @[dut.scala 32:11]
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
  pValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pData = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
