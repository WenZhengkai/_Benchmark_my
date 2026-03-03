module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 11:22]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 20:27 21:15 23:15]
  wire  _T_4 = 2'h1 == state; // @[dut.scala 14:17]
  wire  _T_6 = 2'h2 == state; // @[dut.scala 14:17]
  wire [1:0] _GEN_4 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 31:{21,29} 32:28]
  wire  _T_8 = 2'h3 == state; // @[dut.scala 14:17]
  wire [1:0] _GEN_6 = 2'h3 == state ? _GEN_0 : state; // @[dut.scala 14:17 11:22]
  wire [1:0] _io_g_T_3 = _T_6 ? 2'h2 : {{1'd0}, _T_4}; // @[Mux.scala 81:58]
  assign io_g = _T_8 ? 3'h4 : {{1'd0}, _io_g_T_3}; // @[Mux.scala 81:58]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:22]
      state <= 2'h0; // @[dut.scala 11:22]
    end else if (2'h0 == state) begin // @[dut.scala 14:17]
      if (io_r[0]) begin // @[dut.scala 16:21]
        state <= 2'h1; // @[dut.scala 17:15]
      end else if (io_r[1]) begin // @[dut.scala 18:27]
        state <= 2'h2; // @[dut.scala 19:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 14:17]
      if (io_r[0]) begin // @[dut.scala 27:21]
        state <= 2'h1; // @[dut.scala 27:29]
      end else begin
        state <= 2'h0; // @[dut.scala 28:28]
      end
    end else if (2'h2 == state) begin // @[dut.scala 14:17]
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
