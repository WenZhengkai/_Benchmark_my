module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_reset,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 20:22]
  reg [1:0] prevState; // @[dut.scala 21:26]
  wire  s1 = io_s[0]; // @[dut.scala 27:16]
  wire  s2 = io_s[1]; // @[dut.scala 28:16]
  wire  s3 = io_s[2]; // @[dut.scala 29:16]
  wire [1:0] _GEN_1 = s2 ? 2'h2 : {{1'd0}, s1}; // @[dut.scala 34:26 35:18]
  wire [1:0] currentLevel = s3 ? 2'h3 : _GEN_1; // @[dut.scala 32:20 33:18]
  wire  _T_6 = 2'h0 == state; // @[dut.scala 61:17]
  wire  _GEN_8 = 2'h1 == state | 2'h2 == state; // @[dut.scala 61:17 68:14]
  wire  _GEN_10 = 2'h0 == state | _GEN_8; // @[dut.scala 61:17 63:14]
  wire  _GEN_11 = 2'h0 == state | 2'h1 == state; // @[dut.scala 61:17 64:14]
  wire  _T_16 = prevState < state; // @[dut.scala 80:18]
  assign io_fr3 = io_reset | _T_6; // @[dut.scala 85:18 88:12]
  assign io_fr2 = io_reset | _GEN_11; // @[dut.scala 85:18 87:12]
  assign io_fr1 = io_reset | _GEN_10; // @[dut.scala 85:18 86:12]
  assign io_dfr = io_reset | _T_16; // @[dut.scala 85:18 89:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:22]
      state <= 2'h0; // @[dut.scala 20:22]
    end else if (io_reset) begin // @[dut.scala 43:18]
      state <= 2'h0; // @[dut.scala 44:11]
    end else if (state != currentLevel) begin // @[dut.scala 47:34]
      if (s3) begin // @[dut.scala 32:20]
        state <= 2'h3; // @[dut.scala 33:18]
      end else begin
        state <= _GEN_1;
      end
    end
    if (reset) begin // @[dut.scala 21:26]
      prevState <= 2'h0; // @[dut.scala 21:26]
    end else if (io_reset) begin // @[dut.scala 43:18]
      prevState <= 2'h0; // @[dut.scala 45:15]
    end else if (state != currentLevel) begin // @[dut.scala 47:34]
      prevState <= state; // @[dut.scala 48:17]
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
