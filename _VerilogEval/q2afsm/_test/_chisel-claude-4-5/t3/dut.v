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
  wire [1:0] _GEN_0 = r2 ? 2'h3 : 2'h0; // @[dut.scala 35:22 36:15 38:15]
  wire [1:0] _GEN_4 = r1 ? 2'h2 : 2'h0; // @[dut.scala 57:16 58:15 60:15]
  wire [2:0] _GEN_5 = 2'h3 == state ? 3'h4 : 3'h0; // @[dut.scala 25:17 66:12 22:8]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_0 : state; // @[dut.scala 25:17 14:22]
  wire [2:0] _GEN_7 = 2'h2 == state ? 3'h2 : _GEN_5; // @[dut.scala 25:17 55:12]
  wire [2:0] _GEN_9 = 2'h1 == state ? 3'h1 : _GEN_7; // @[dut.scala 25:17 44:12]
  assign io_g = 2'h0 == state ? 3'h0 : _GEN_9; // @[dut.scala 25:17 28:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      state <= 2'h0; // @[dut.scala 14:22]
    end else if (2'h0 == state) begin // @[dut.scala 25:17]
      if (r0) begin // @[dut.scala 31:16]
        state <= 2'h1; // @[dut.scala 32:15]
      end else if (r1) begin // @[dut.scala 33:22]
        state <= 2'h2; // @[dut.scala 34:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 25:17]
      if (r0) begin // @[dut.scala 46:16]
        state <= 2'h1; // @[dut.scala 47:15]
      end else begin
        state <= 2'h0; // @[dut.scala 49:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 25:17]
      state <= _GEN_4;
    end else begin
      state <= _GEN_6;
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
