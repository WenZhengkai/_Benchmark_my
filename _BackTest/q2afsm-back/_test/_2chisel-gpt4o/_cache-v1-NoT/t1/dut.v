module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] currentState; // @[dut.scala 17:29]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 29:27 30:22 32:22]
  wire [1:0] _GEN_4 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 45:21 46:22 48:22]
  wire [2:0] _GEN_6 = 2'h3 == currentState ? 3'h4 : 3'h0; // @[dut.scala 23:24 52:12 20:8]
  wire [1:0] _GEN_7 = 2'h3 == currentState ? _GEN_0 : currentState; // @[dut.scala 23:24 17:29]
  wire [2:0] _GEN_8 = 2'h2 == currentState ? 3'h2 : _GEN_6; // @[dut.scala 23:24 44:12]
  wire [2:0] _GEN_10 = 2'h1 == currentState ? 3'h1 : _GEN_8; // @[dut.scala 23:24 36:12]
  assign io_g = 2'h0 == currentState ? 3'h0 : _GEN_10; // @[dut.scala 23:24 20:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:29]
      currentState <= 2'h0; // @[dut.scala 17:29]
    end else if (2'h0 == currentState) begin // @[dut.scala 23:24]
      if (io_r[0]) begin // @[dut.scala 25:21]
        currentState <= 2'h1; // @[dut.scala 26:22]
      end else if (io_r[1]) begin // @[dut.scala 27:27]
        currentState <= 2'h2; // @[dut.scala 28:22]
      end else begin
        currentState <= _GEN_0;
      end
    end else if (2'h1 == currentState) begin // @[dut.scala 23:24]
      currentState <= {{1'd0}, io_r[0]};
    end else if (2'h2 == currentState) begin // @[dut.scala 23:24]
      currentState <= _GEN_4;
    end else begin
      currentState <= _GEN_7;
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
  currentState = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
