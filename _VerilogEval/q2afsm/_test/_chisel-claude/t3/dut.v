module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 14:22]
  wire  r0 = io_r[0]; // @[dut.scala 17:16]
  wire  r1 = io_r[1]; // @[dut.scala 18:16]
  wire  r2 = io_r[2]; // @[dut.scala 19:16]
  wire  _T_2 = ~r0; // @[dut.scala 29:21]
  wire  _T_6 = ~r1; // @[dut.scala 31:35]
  wire [1:0] _GEN_0 = _T_2 & ~r1 & r2 ? 2'h3 : 2'h0; // @[dut.scala 31:58 32:15 34:15]
  wire [1:0] _GEN_4 = _T_6 ? 2'h0 : 2'h2; // @[dut.scala 49:24 50:15 52:15]
  wire [1:0] _GEN_5 = ~r2 ? 2'h0 : 2'h3; // @[dut.scala 58:24 59:15 61:15]
  wire [2:0] _GEN_6 = 2'h3 == state ? 3'h4 : 3'h0; // @[dut.scala 25:17 57:12 22:8]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 25:17 14:22]
  wire [2:0] _GEN_8 = 2'h2 == state ? 3'h2 : _GEN_6; // @[dut.scala 25:17 48:12]
  wire [2:0] _GEN_10 = 2'h1 == state ? 3'h1 : _GEN_8; // @[dut.scala 25:17 39:12]
  assign io_g = 2'h0 == state ? 3'h0 : _GEN_10; // @[dut.scala 25:17 22:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      state <= 2'h0; // @[dut.scala 14:22]
    end else if (2'h0 == state) begin // @[dut.scala 25:17]
      if (r0) begin // @[dut.scala 27:24]
        state <= 2'h1; // @[dut.scala 28:15]
      end else if (~r0 & r1) begin // @[dut.scala 29:44]
        state <= 2'h2; // @[dut.scala 30:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 25:17]
      if (_T_2) begin // @[dut.scala 40:24]
        state <= 2'h0; // @[dut.scala 41:15]
      end else begin
        state <= 2'h1; // @[dut.scala 43:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 25:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_7;
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
  state = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
