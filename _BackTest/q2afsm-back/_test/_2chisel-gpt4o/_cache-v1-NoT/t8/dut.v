module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 18:22]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 31:27 32:15 34:15]
  wire [1:0] _GEN_1 = io_r[1] ? 2'h2 : _GEN_0; // @[dut.scala 29:27 30:15]
  wire [1:0] _GEN_4 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 53:21 54:15 56:15]
  wire [1:0] _GEN_7 = 2'h3 == state ? _GEN_0 : state; // @[dut.scala 24:17 18:22]
  wire [1:0] _GEN_8 = 2'h2 == state ? 2'h2 : {{1'd0}, 2'h3 == state}; // @[dut.scala 24:17 51:12]
  wire [1:0] _GEN_9 = 2'h2 == state ? _GEN_4 : _GEN_7; // @[dut.scala 24:17]
  wire [1:0] _GEN_10 = 2'h1 == state ? 2'h1 : _GEN_8; // @[dut.scala 24:17 40:12]
  wire [1:0] _GEN_13 = 2'h0 == state ? 2'h0 : _GEN_10; // @[dut.scala 24:17 21:8]
  assign io_g = {{1'd0}, _GEN_13};
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h0; // @[dut.scala 18:22]
    end else if (reset) begin // @[dut.scala 73:22]
      state <= 2'h0; // @[dut.scala 74:11]
    end else if (2'h0 == state) begin // @[dut.scala 24:17]
      if (io_r[0]) begin // @[dut.scala 27:21]
        state <= 2'h1; // @[dut.scala 28:15]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[dut.scala 24:17]
      state <= {{1'd0}, io_r[0]};
    end else begin
      state <= _GEN_9;
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
