module dut(
  input        clock,
  input        reset,
  input  [3:0] io_dataIn,
  input        io_RW,
  input        io_EN,
  output       io_EMPTY,
  output       io_FULL,
  output [3:0] io_dataOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] SP; // @[dut.scala 19:19]
  wire [2:0] _SP_T_1 = SP + 3'h1; // @[dut.scala 32:20]
  wire [2:0] _GEN_12 = SP != 3'h4 ? _SP_T_1 : SP; // @[dut.scala 29:26 32:14 19:19]
  wire [2:0] _SP_T_3 = SP - 3'h1; // @[dut.scala 37:20]
  wire [2:0] _GEN_17 = SP != 3'h0 ? _SP_T_3 : SP; // @[dut.scala 36:26 37:14 19:19]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 45:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 46:18]
  assign io_dataOut = 4'h0; // @[dut.scala 49:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:19]
      SP <= 3'h4; // @[dut.scala 19:19]
    end else if (io_EN) begin // @[dut.scala 21:15]
      if (reset) begin // @[dut.scala 22:24]
        SP <= 3'h4; // @[dut.scala 24:10]
      end else if (io_RW) begin // @[dut.scala 27:19]
        SP <= _GEN_12;
      end else begin
        SP <= _GEN_17;
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
  SP = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
