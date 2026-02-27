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
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : state; // @[dut.scala 24:28 25:15 12:22]
  wire  _T_4 = 2'h1 == state; // @[dut.scala 18:17]
  wire  _T_7 = 2'h2 == state; // @[dut.scala 18:17]
  wire [1:0] _GEN_4 = ~io_r[1] ? 2'h0 : state; // @[dut.scala 34:22 35:15 12:22]
  wire  _T_10 = 2'h3 == state; // @[dut.scala 18:17]
  wire [1:0] _GEN_5 = ~io_r[2] ? 2'h0 : state; // @[dut.scala 39:22 40:15 12:22]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_5 : state; // @[dut.scala 18:17 12:22]
  wire [2:0] _GEN_10 = _T_10 ? 3'h4 : 3'h0; // @[dut.scala 46:17 54:12 15:8]
  wire [2:0] _GEN_11 = _T_7 ? 3'h2 : _GEN_10; // @[dut.scala 46:17 51:12]
  assign io_g = _T_4 ? 3'h1 : _GEN_11; // @[dut.scala 46:17 48:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 18:17]
      if (io_r[0]) begin // @[dut.scala 20:21]
        state <= 2'h1; // @[dut.scala 21:15]
      end else if (io_r[1]) begin // @[dut.scala 22:28]
        state <= 2'h2; // @[dut.scala 23:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 18:17]
      if (~io_r[0]) begin // @[dut.scala 29:22]
        state <= 2'h0; // @[dut.scala 30:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 18:17]
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
