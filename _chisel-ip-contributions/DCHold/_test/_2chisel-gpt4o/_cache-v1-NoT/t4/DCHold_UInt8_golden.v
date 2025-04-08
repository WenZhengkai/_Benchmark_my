module DCHold_UInt8_golden(
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
  reg  pValid; // @[golden.scala 23:23]
  reg [7:0] pData; // @[golden.scala 24:18]
  assign io_enq_ready = ~pValid; // @[golden.scala 34:19]
  assign io_deq_valid = pValid; // @[golden.scala 32:16]
  assign io_deq_bits = pData; // @[golden.scala 33:15]
  always @(posedge clock) begin
    if (reset) begin // @[golden.scala 23:23]
      pValid <= 1'h0; // @[golden.scala 23:23]
    end else if (io_enq_valid & ~pValid) begin // @[golden.scala 26:33]
      pValid <= io_enq_valid; // @[golden.scala 27:12]
    end else if (pValid & io_deq_ready) begin // @[golden.scala 29:47]
      pValid <= 1'h0; // @[golden.scala 30:12]
    end
    if (io_enq_valid & ~pValid) begin // @[golden.scala 26:33]
      pData <= io_enq_bits; // @[golden.scala 28:11]
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
