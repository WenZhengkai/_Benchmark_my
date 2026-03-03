module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 15:22]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 24:27 25:15 27:15]
  wire  _T_8 = 2'h1 == state; // @[dut.scala 18:17]
  wire  _T_12 = 2'h2 == state; // @[dut.scala 18:17]
  wire [1:0] _GEN_4 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 35:{21,29} 36:28]
  wire  _T_16 = 2'h3 == state; // @[dut.scala 18:17]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_0 : state; // @[dut.scala 18:17 15:22]
  wire [2:0] _GEN_10 = _T_16 ? 3'h4 : 3'h0; // @[dut.scala 46:17 49:18 45:8]
  wire [2:0] _GEN_11 = _T_12 ? 3'h2 : _GEN_10; // @[dut.scala 46:17 48:18]
  assign io_g = _T_8 ? 3'h1 : _GEN_11; // @[dut.scala 46:17 47:18]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      state <= 2'h0; // @[dut.scala 15:22]
    end else if (2'h0 == state) begin // @[dut.scala 18:17]
      if (io_r[0]) begin // @[dut.scala 20:21]
        state <= 2'h1; // @[dut.scala 21:15]
      end else if (io_r[1]) begin // @[dut.scala 22:27]
        state <= 2'h2; // @[dut.scala 23:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 18:17]
      state <= {{1'd0}, io_r[0]};
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
