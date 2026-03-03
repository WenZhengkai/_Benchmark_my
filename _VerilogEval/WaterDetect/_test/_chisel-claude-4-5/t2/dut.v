module dut(
  input        clock,
  input        reset,
  input  [3:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  s1 = io_s[1]; // @[dut.scala 14:16]
  wire  s2 = io_s[2]; // @[dut.scala 15:16]
  wire  s3 = io_s[3]; // @[dut.scala 16:16]
  reg [2:0] state; // @[dut.scala 22:22]
  wire  _T = s1 & s2; // @[dut.scala 26:11]
  wire  _T_3 = ~s3; // @[dut.scala 28:26]
  wire [2:0] _GEN_0 = s1 & ~s2 & _T_3 ? 3'h3 : 3'h4; // @[dut.scala 30:32 31:18 33:18]
  wire [2:0] _GEN_1 = _T & ~s3 ? 3'h2 : _GEN_0; // @[dut.scala 28:31 29:18]
  wire [2:0] currentLevel = s1 & s2 & s3 ? 3'h1 : _GEN_1; // @[dut.scala 26:24 27:18]
  wire  _T_9 = currentLevel == 3'h1; // @[dut.scala 42:21]
  wire  _isRising_T_1 = state == 3'h3; // @[dut.scala 43:52]
  wire  _isRising_T_3 = state == 3'h4; // @[dut.scala 43:80]
  wire  _T_10 = currentLevel == 3'h2; // @[dut.scala 44:27]
  wire  _T_11 = currentLevel == 3'h3; // @[dut.scala 46:27]
  wire  _GEN_3 = currentLevel == 3'h3 & _isRising_T_3; // @[dut.scala 46:45 47:14 49:14]
  wire  _GEN_4 = currentLevel == 3'h2 ? _isRising_T_1 | _isRising_T_3 : _GEN_3; // @[dut.scala 44:45 45:14]
  wire  _GEN_7 = _T_11 ? 1'h0 : 1'h1; // @[dut.scala 53:10 67:45 75:12]
  wire  _GEN_9 = _T_10 ? 1'h0 : 1'h1; // @[dut.scala 54:10 64:45]
  wire  _GEN_10 = _T_10 ? 1'h0 : _GEN_7; // @[dut.scala 53:10 64:45]
  assign io_fr3 = _T_9 ? 1'h0 : _GEN_10; // @[dut.scala 59:35 61:12]
  assign io_fr2 = _T_9 ? 1'h0 : _GEN_9; // @[dut.scala 59:35 62:12]
  assign io_fr1 = _T_9 ? 1'h0 : 1'h1; // @[dut.scala 59:35 63:12]
  assign io_dfr = currentLevel == 3'h1 ? state == 3'h2 | state == 3'h3 | state == 3'h4 : _GEN_4; // @[dut.scala 42:35 43:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:22]
      state <= 3'h4; // @[dut.scala 22:22]
    end else if (s1 & s2 & s3) begin // @[dut.scala 26:24]
      state <= 3'h1; // @[dut.scala 27:18]
    end else if (_T & ~s3) begin // @[dut.scala 28:31]
      state <= 3'h2; // @[dut.scala 29:18]
    end else if (s1 & ~s2 & _T_3) begin // @[dut.scala 30:32]
      state <= 3'h3; // @[dut.scala 31:18]
    end else begin
      state <= 3'h4; // @[dut.scala 33:18]
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
  state = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
