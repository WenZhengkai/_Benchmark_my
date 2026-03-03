module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 13:21]
  wire [1:0] _GEN_0 = io_r[2] ? 2'h3 : 2'h0; // @[dut.scala 19:{29,34} 20:33]
  wire  _state_T_5 = 2'h1 == state; // @[dut.scala 15:16]
  wire  _state_T_6 = 2'h2 == state; // @[dut.scala 15:16]
  wire [1:0] _state_st_T_3 = io_r[1] ? 2'h2 : 2'h0; // @[dut.scala 23:25]
  wire  _state_T_7 = 2'h3 == state; // @[dut.scala 15:16]
  wire [1:0] _GEN_3 = 2'h3 == state ? _GEN_0 : state; // @[dut.scala 15:16 24:19 13:21]
  wire [2:0] _GEN_7 = _state_T_7 ? 3'h4 : 3'h0; // @[dut.scala 32:17 35:19 31:8]
  wire [2:0] _GEN_8 = _state_T_6 ? 3'h2 : _GEN_7; // @[dut.scala 32:17 34:19]
  assign io_g = _state_T_5 ? 3'h1 : _GEN_8; // @[dut.scala 32:17 33:19]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:21]
      state <= 2'h0; // @[dut.scala 13:21]
    end else if (2'h0 == state) begin // @[dut.scala 15:16]
      if (io_r[0]) begin // @[dut.scala 17:28]
        state <= 2'h1; // @[dut.scala 17:33]
      end else if (io_r[1]) begin // @[dut.scala 18:29]
        state <= 2'h2; // @[dut.scala 18:34]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[dut.scala 15:16]
      if (io_r[0]) begin // @[dut.scala 22:25]
        state <= 2'h1;
      end else begin
        state <= 2'h0;
      end
    end else if (2'h2 == state) begin // @[dut.scala 15:16]
      state <= _state_st_T_3; // @[dut.scala 23:19]
    end else begin
      state <= _GEN_3;
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
