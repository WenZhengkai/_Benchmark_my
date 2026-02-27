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
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : state; // @[dut.scala 35:26 36:15 14:22]
  wire [1:0] _GEN_1 = io_r[1] ? 2'h2 : _GEN_0; // @[dut.scala 31:26 32:15]
  wire [1:0] _GEN_5 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 53:21 54:15 56:15]
  wire [1:0] _GEN_6 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 63:21 64:15 66:15]
  wire [2:0] _GEN_7 = 2'h3 == state ? 3'h4 : 3'h0; // @[dut.scala 20:17 61:12 17:8]
  wire [1:0] _GEN_8 = 2'h3 == state ? _GEN_6 : state; // @[dut.scala 20:17 14:22]
  wire [2:0] _GEN_9 = 2'h2 == state ? 3'h2 : _GEN_7; // @[dut.scala 20:17 51:12]
  wire [2:0] _GEN_11 = 2'h1 == state ? 3'h1 : _GEN_9; // @[dut.scala 20:17 41:12]
  assign io_g = 2'h0 == state ? 3'h0 : _GEN_11; // @[dut.scala 20:17 17:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      state <= 2'h0; // @[dut.scala 14:22]
    end else if (2'h0 == state) begin // @[dut.scala 20:17]
      if (io_r == 3'h0) begin // @[dut.scala 23:26]
        state <= 2'h0; // @[dut.scala 24:15]
      end else if (io_r[0]) begin // @[dut.scala 27:26]
        state <= 2'h1; // @[dut.scala 28:15]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[dut.scala 20:17]
      if (io_r[0]) begin // @[dut.scala 43:21]
        state <= 2'h1; // @[dut.scala 44:15]
      end else begin
        state <= 2'h0; // @[dut.scala 46:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 20:17]
      state <= _GEN_5;
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
