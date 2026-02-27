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
  wire [1:0] _GEN_0 = 3'h0 == io_s ? 2'h3 : state; // @[dut.scala 43:18 15:22 47:28]
  wire [1:0] _GEN_1 = 3'h4 == io_s ? 2'h2 : _GEN_0; // @[dut.scala 43:18 46:28]
  wire  _io_dfr_T = prevState < state; // @[dut.scala 62:30]
  wire  _GEN_5 = 2'h2 == state ? 1'h0 : 2'h3 == state; // @[dut.scala 51:19 65:16]
  wire  _GEN_6 = 2'h2 == state | 2'h3 == state; // @[dut.scala 51:19 66:16]
  wire  _GEN_7 = 2'h2 == state ? _io_dfr_T : 2'h3 == state; // @[dut.scala 51:19 68:16]
  wire  _GEN_8 = 2'h1 == state ? 1'h0 : _GEN_5; // @[dut.scala 51:19 59:16]
  wire  _GEN_9 = 2'h1 == state ? 1'h0 : _GEN_6; // @[dut.scala 51:19 60:16]
  wire  _GEN_10 = 2'h1 == state | _GEN_6; // @[dut.scala 51:19 61:16]
  wire  _GEN_11 = 2'h1 == state ? prevState < state : _GEN_7; // @[dut.scala 51:19 62:16]
  wire  _GEN_12 = 2'h0 == state ? 1'h0 : _GEN_8; // @[dut.scala 51:19 53:16]
  wire  _GEN_13 = 2'h0 == state ? 1'h0 : _GEN_9; // @[dut.scala 51:19 54:16]
  wire  _GEN_14 = 2'h0 == state ? 1'h0 : _GEN_10; // @[dut.scala 51:19 55:16]
  wire  _GEN_15 = 2'h0 == state ? 1'h0 : _GEN_11; // @[dut.scala 51:19 56:16]
  assign io_fr3 = io_reset | _GEN_12; // @[dut.scala 31:18 34:12]
  assign io_fr2 = io_reset | _GEN_13; // @[dut.scala 31:18 35:12]
  assign io_fr1 = io_reset | _GEN_14; // @[dut.scala 31:18 36:12]
  assign io_dfr = io_reset | _GEN_15; // @[dut.scala 31:18 37:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      state <= 2'h0; // @[dut.scala 15:22]
    end else if (io_reset) begin // @[dut.scala 31:18]
      state <= 2'h3; // @[dut.scala 32:11]
    end else if (3'h7 == io_s) begin // @[dut.scala 43:18]
      state <= 2'h0; // @[dut.scala 44:28]
    end else if (3'h6 == io_s) begin // @[dut.scala 43:18]
      state <= 2'h1; // @[dut.scala 45:28]
    end else begin
      state <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 16:26]
      prevState <= 2'h0; // @[dut.scala 16:26]
    end else if (io_reset) begin // @[dut.scala 31:18]
      prevState <= 2'h3; // @[dut.scala 33:15]
    end else begin
      prevState <= state; // @[dut.scala 40:15]
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
