module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 12:22]
  wire  _T = 2'h1 == state; // @[dut.scala 18:17]
  wire  _T_1 = 2'h2 == state; // @[dut.scala 18:17]
  wire  _T_2 = 2'h3 == state; // @[dut.scala 18:17]
  wire [2:0] _GEN_0 = 2'h3 == state ? 3'h4 : 3'h0; // @[dut.scala 18:17 21:19 15:8]
  wire [2:0] _GEN_1 = 2'h2 == state ? 3'h2 : _GEN_0; // @[dut.scala 18:17 20:19]
  wire  r0 = io_r[0]; // @[dut.scala 25:16]
  wire  r1 = io_r[1]; // @[dut.scala 26:16]
  wire  r2 = io_r[2]; // @[dut.scala 27:16]
  wire [1:0] _GEN_3 = r2 ? 2'h3 : 2'h0; // @[dut.scala 33:{22,30} 34:30]
  wire [1:0] _GEN_7 = r1 ? 2'h2 : 2'h0; // @[dut.scala 40:{16,24,51}]
  wire [1:0] _GEN_8 = _T_2 ? _GEN_3 : state; // @[dut.scala 29:17 12:22]
  assign io_g = 2'h1 == state ? 3'h1 : _GEN_1; // @[dut.scala 18:17 19:19]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 29:17]
      if (r0) begin // @[dut.scala 31:22]
        state <= 2'h1; // @[dut.scala 31:30]
      end else if (r1) begin // @[dut.scala 32:22]
        state <= 2'h2; // @[dut.scala 32:30]
      end else begin
        state <= _GEN_3;
      end
    end else if (_T) begin // @[dut.scala 29:17]
      if (r0) begin // @[dut.scala 37:16]
        state <= 2'h1; // @[dut.scala 37:24]
      end else begin
        state <= 2'h0; // @[dut.scala 37:51]
      end
    end else if (_T_1) begin // @[dut.scala 29:17]
      state <= _GEN_7;
    end else begin
      state <= _GEN_8;
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
