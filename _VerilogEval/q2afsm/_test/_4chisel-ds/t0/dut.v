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
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : state; // @[dut.scala 25:27 26:15 12:22]
  wire [1:0] _GEN_4 = ~io_r[1] ? 2'h0 : state; // @[dut.scala 37:22 38:15 12:22]
  wire [1:0] _GEN_5 = ~io_r[2] ? 2'h0 : state; // @[dut.scala 43:22 44:15 12:22]
  wire [2:0] _GEN_6 = 2'h3 == state ? 3'h4 : 3'h0; // @[dut.scala 18:17 42:12 15:8]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 18:17 12:22]
  wire [2:0] _GEN_8 = 2'h2 == state ? 3'h2 : _GEN_6; // @[dut.scala 18:17 36:12]
  wire [2:0] _GEN_10 = 2'h1 == state ? 3'h1 : _GEN_8; // @[dut.scala 18:17 30:12]
  assign io_g = 2'h0 == state ? 3'h0 : _GEN_10; // @[dut.scala 18:17 15:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 18:17]
      if (io_r[0]) begin // @[dut.scala 21:21]
        state <= 2'h1; // @[dut.scala 22:15]
      end else if (io_r[1]) begin // @[dut.scala 23:27]
        state <= 2'h2; // @[dut.scala 24:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 18:17]
      if (~io_r[0]) begin // @[dut.scala 31:22]
        state <= 2'h0; // @[dut.scala 32:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 18:17]
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
