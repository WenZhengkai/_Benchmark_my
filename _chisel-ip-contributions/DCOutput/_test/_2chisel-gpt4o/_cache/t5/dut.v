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
  reg  rValid; // @[dut.scala 11:23]
  wire  _rData_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg [7:0] rData; // @[Reg.scala 19:16]
  wire  _GEN_1 = io_deq_ready ? 1'h0 : rValid; // @[dut.scala 20:28 21:12 11:23]
  wire  _GEN_2 = _rData_T | _GEN_1; // @[dut.scala 18:21 19:12]
  assign io_enq_ready = io_deq_ready | ~rValid; // @[dut.scala 15:32]
  assign io_deq_valid = rValid; // @[dut.scala 26:16]
  assign io_deq_bits = rData; // @[dut.scala 25:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:23]
      rValid <= 1'h0; // @[dut.scala 11:23]
    end else begin
      rValid <= _GEN_2;
    end
    if (_rData_T) begin // @[Reg.scala 20:18]
      rData <= io_enq_bits; // @[Reg.scala 20:22]
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
  rValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rData = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
