module dut(
  input   clock,
  input   reset,
  input   bump_left,
  input   bump_right,
  input   ground,
  output  walk_left,
  output  walk_right,
  output  aaah
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 22:24]
  wire  _T_3 = ~ground; // @[dut.scala 26:14]
  wire  _GEN_2 = bump_right ? 1'h0 : 1'h1; // @[dut.scala 40:{28,36} 41:36]
  wire [1:0] _GEN_5 = ground ? 2'h1 : state; // @[dut.scala 51:22 22:24 51:30]
  assign walk_left = state == 2'h0; // @[dut.scala 55:26]
  assign walk_right = state == 2'h1; // @[dut.scala 56:26]
  assign aaah = state == 2'h2 | state == 2'h3; // @[dut.scala 57:46]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[dut.scala 24:19]
      state <= 2'h0; // @[dut.scala 26:23 27:17]
    end else if (2'h0 == state) begin // @[dut.scala 24:19]
      if (~ground) begin // @[dut.scala 36:23]
        state <= 2'h2; // @[dut.scala 37:17]
      end else begin
        state <= {{1'd0}, bump_left};
      end
    end else if (2'h1 == state) begin // @[dut.scala 24:19]
      if (_T_3) begin // @[dut.scala 47:22]
        state <= 2'h3; // @[dut.scala 47:30]
      end else begin
        state <= {{1'd0}, _GEN_2}; // @[dut.scala 22:24]
      end
    end else if (2'h2 == state) begin // @[dut.scala 24:19]
      if (ground) begin
        state <= 2'h0;
      end
    end else if (2'h3 == state) begin // @[dut.scala 22:24]
      state <= _GEN_5;
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
  if (reset) begin
    state = 2'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
