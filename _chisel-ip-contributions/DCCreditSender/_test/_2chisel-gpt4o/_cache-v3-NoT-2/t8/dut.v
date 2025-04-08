module dut(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  output       io_deq_valid,
  input        io_deq_credit,
  output [7:0] io_deq_bits,
  output [2:0] io_curCredit
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg [7:0] dataOut; // @[Reg.scala 35:20]
  reg  validOut; // @[dut.scala 50:25]
  assign io_enq_ready = 1'h1; // @[dut.scala 45:32]
  assign io_deq_valid = validOut; // @[dut.scala 53:16]
  assign io_deq_bits = dataOut; // @[dut.scala 54:15]
  assign io_curCredit = 3'h5; // @[dut.scala 41:16]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 35:20]
      dataOut <= 8'h0; // @[Reg.scala 35:20]
    end else if (_T) begin // @[Reg.scala 36:18]
      dataOut <= io_enq_bits; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 50:25]
      validOut <= 1'h0; // @[dut.scala 50:25]
    end else begin
      validOut <= _T; // @[dut.scala 50:25]
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
  dataOut = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  validOut = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
