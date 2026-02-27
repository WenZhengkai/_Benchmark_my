module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 15:22]
  reg [1:0] prevState; // @[dut.scala 16:26]
  wire [1:0] _GEN_0 = io_s[0] ? 2'h2 : 2'h3; // @[dut.scala 37:25 38:13 40:13]
  wire  _io_fr3_T = state == 2'h3; // @[dut.scala 45:19]
  wire  _io_fr2_T = state == 2'h2; // @[dut.scala 46:19]
  assign io_fr3 = state == 2'h3; // @[dut.scala 45:19]
  assign io_fr2 = state == 2'h2 | _io_fr3_T; // @[dut.scala 46:43]
  assign io_fr1 = state == 2'h1 | _io_fr2_T | _io_fr3_T; // @[dut.scala 47:76]
  assign io_dfr = prevState < state; // @[dut.scala 48:23]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      state <= 2'h0; // @[dut.scala 15:22]
    end else if (io_reset) begin // @[dut.scala 25:18]
      state <= 2'h3; // @[dut.scala 26:11]
    end else if (io_s[2] & io_s[1] & io_s[0]) begin // @[dut.scala 33:41]
      state <= 2'h0; // @[dut.scala 34:13]
    end else if (io_s[1] & io_s[0]) begin // @[dut.scala 35:36]
      state <= 2'h1; // @[dut.scala 36:13]
    end else begin
      state <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 16:26]
      prevState <= 2'h0; // @[dut.scala 16:26]
    end else if (io_reset) begin // @[dut.scala 25:18]
      prevState <= 2'h3; // @[dut.scala 27:15]
    end else begin
      prevState <= state; // @[dut.scala 30:15]
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
  _RAND_1 = {1{`RANDOM}};
  prevState = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
