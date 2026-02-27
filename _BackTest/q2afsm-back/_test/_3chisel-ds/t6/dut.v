module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[dut.scala 14:25]
  wire  _T = 2'h1 == stateReg; // @[dut.scala 18:20]
  wire  _T_1 = 2'h2 == stateReg; // @[dut.scala 18:20]
  wire  _T_2 = 2'h3 == stateReg; // @[dut.scala 18:20]
  wire [2:0] _GEN_0 = 2'h3 == stateReg ? 3'h4 : 3'h0; // @[dut.scala 18:20 21:19 17:8]
  wire [2:0] _GEN_1 = 2'h2 == stateReg ? 3'h2 : _GEN_0; // @[dut.scala 18:20 20:19]
  wire [1:0] _GEN_3 = io_r[2] ? 2'h3 : stateReg; // @[dut.scala 31:27 32:18 14:25]
  wire [1:0] _GEN_7 = ~io_r[1] ? 2'h0 : stateReg; // @[dut.scala 41:22 42:18 14:25]
  wire [1:0] _GEN_8 = ~io_r[2] ? 2'h0 : stateReg; // @[dut.scala 46:22 47:18 14:25]
  wire [1:0] _GEN_9 = _T_2 ? _GEN_8 : stateReg; // @[dut.scala 25:20 14:25]
  assign io_g = 2'h1 == stateReg ? 3'h1 : _GEN_1; // @[dut.scala 18:20 19:19]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:25]
      stateReg <= 2'h0; // @[dut.scala 14:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 25:20]
      if (io_r[0]) begin // @[dut.scala 27:21]
        stateReg <= 2'h1; // @[dut.scala 28:18]
      end else if (io_r[1]) begin // @[dut.scala 29:27]
        stateReg <= 2'h2; // @[dut.scala 30:18]
      end else begin
        stateReg <= _GEN_3;
      end
    end else if (_T) begin // @[dut.scala 25:20]
      if (~io_r[0]) begin // @[dut.scala 36:22]
        stateReg <= 2'h0; // @[dut.scala 37:18]
      end
    end else if (_T_1) begin // @[dut.scala 25:20]
      stateReg <= _GEN_7;
    end else begin
      stateReg <= _GEN_9;
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
  stateReg = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
