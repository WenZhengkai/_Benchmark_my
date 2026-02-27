module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[dut.scala 12:25]
  wire  _T_3 = ~io_r[0]; // @[dut.scala 22:18]
  wire [1:0] _GEN_0 = io_r == 3'h4 ? 2'h3 : stateReg; // @[dut.scala 24:37 25:18 12:25]
  wire [1:0] _GEN_4 = ~io_r[1] ? 2'h0 : stateReg; // @[dut.scala 38:22 39:18 12:25]
  wire [1:0] _GEN_5 = ~io_r[2] ? 2'h0 : stateReg; // @[dut.scala 45:22 46:18 12:25]
  wire [2:0] _GEN_6 = 2'h3 == stateReg ? 3'h4 : 3'h0; // @[dut.scala 18:20 44:12 15:8]
  wire [1:0] _GEN_7 = 2'h3 == stateReg ? _GEN_5 : stateReg; // @[dut.scala 18:20 12:25]
  wire [2:0] _GEN_8 = 2'h2 == stateReg ? 3'h2 : _GEN_6; // @[dut.scala 18:20 37:12]
  wire [2:0] _GEN_10 = 2'h1 == stateReg ? 3'h1 : _GEN_8; // @[dut.scala 18:20 30:12]
  assign io_g = 2'h0 == stateReg ? 3'h0 : _GEN_10; // @[dut.scala 18:20 15:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:25]
      stateReg <= 2'h0; // @[dut.scala 12:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 18:20]
      if (io_r[0]) begin // @[dut.scala 20:21]
        stateReg <= 2'h1; // @[dut.scala 21:18]
      end else if (~io_r[0] & io_r[1]) begin // @[dut.scala 22:39]
        stateReg <= 2'h2; // @[dut.scala 23:18]
      end else begin
        stateReg <= _GEN_0;
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 18:20]
      if (_T_3) begin // @[dut.scala 31:22]
        stateReg <= 2'h0; // @[dut.scala 32:18]
      end
    end else if (2'h2 == stateReg) begin // @[dut.scala 18:20]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_7;
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
