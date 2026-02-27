module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[dut.scala 17:25]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 29:27 30:18 32:18]
  wire [1:0] _GEN_4 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 45:21 46:18 48:18]
  wire [1:0] _GEN_6 = 2'h3 == stateReg ? _GEN_0 : stateReg; // @[dut.scala 23:20 17:25]
  wire [2:0] _io_g_T_3 = stateReg == 2'h3 ? 3'h4 : 3'h0; // @[dut.scala 64:15]
  wire [2:0] _io_g_T_4 = stateReg == 2'h2 ? 3'h2 : _io_g_T_3; // @[dut.scala 63:15]
  assign io_g = stateReg == 2'h1 ? 3'h1 : _io_g_T_4; // @[dut.scala 62:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:25]
      stateReg <= 2'h0; // @[dut.scala 17:25]
    end else if (2'h0 == stateReg) begin // @[dut.scala 23:20]
      if (io_r[0]) begin // @[dut.scala 25:21]
        stateReg <= 2'h1; // @[dut.scala 26:18]
      end else if (io_r[1]) begin // @[dut.scala 27:27]
        stateReg <= 2'h2; // @[dut.scala 28:18]
      end else begin
        stateReg <= _GEN_0;
      end
    end else if (2'h1 == stateReg) begin // @[dut.scala 23:20]
      stateReg <= {{1'd0}, io_r[0]};
    end else if (2'h2 == stateReg) begin // @[dut.scala 23:20]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_6;
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
