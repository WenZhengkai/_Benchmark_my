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
  reg [2:0] SP; // @[dut.scala 21:19]
  wire [2:0] _SP_T_1 = SP + 3'h1; // @[dut.scala 32:18]
  wire [2:0] _GEN_13 = SP != 3'h4 ? _SP_T_1 : SP; // @[dut.scala 29:33 32:12 21:19]
  wire [2:0] _SP_T_3 = SP - 3'h1; // @[dut.scala 38:18]
  wire [2:0] _GEN_18 = SP != 3'h0 ? _SP_T_3 : SP; // @[dut.scala 37:24 38:12 21:19]
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 47:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 48:18]
  assign io_dataOut = 4'h0; // @[dut.scala 51:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:19]
      SP <= 3'h4; // @[dut.scala 21:19]
    end else if (reset) begin // @[dut.scala 24:24]
      SP <= 3'h4; // @[dut.scala 25:8]
    end else if (io_EN) begin // @[dut.scala 27:22]
      if (io_RW) begin // @[dut.scala 28:17]
        SP <= _GEN_13;
      end else begin
        SP <= _GEN_18;
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
