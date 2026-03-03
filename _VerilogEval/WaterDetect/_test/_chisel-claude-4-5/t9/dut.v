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
  wire  _T_3 = ~s3; // @[dut.scala 22:26]
  wire  _T_8 = s1 & ~s2 & _T_3; // @[dut.scala 24:24]
  wire [1:0] _GEN_1 = s2 & s1 & ~s3 ? 2'h2 : {{1'd0}, _T_8}; // @[dut.scala 22:31 23:18]
  wire [1:0] _GEN_2 = s3 & s2 & s1 ? 2'h3 : _GEN_1; // @[dut.scala 20:24 21:18]
  reg [2:0] prevLevel; // @[dut.scala 31:26]
  wire [2:0] currentLevel = {{1'd0}, _GEN_2}; // @[dut.scala 19:33]
  wire  isRising = prevLevel < currentLevel; // @[dut.scala 38:28]
  wire  nominalFr3 = 3'h0 == currentLevel; // @[dut.scala 45:24]
  wire  _GEN_6 = 3'h1 == currentLevel | 3'h2 == currentLevel; // @[dut.scala 45:24 52:18]
  wire  nominalFr1 = nominalFr3 | _GEN_6; // @[dut.scala 45:24 47:18]
  wire  nominalFr2 = nominalFr3 | 3'h1 == currentLevel; // @[dut.scala 45:24 48:18]
  wire  supplementalFlow = isRising & currentLevel != 3'h3; // @[dut.scala 70:35]
  assign io_fr3 = reset | nominalFr3; // @[dut.scala 75:10 83:22 86:12]
  assign io_fr2 = reset | nominalFr2; // @[dut.scala 74:10 83:22 85:12]
  assign io_fr1 = reset | nominalFr1; // @[dut.scala 73:10 83:22 84:12]
  assign io_dfr = reset | supplementalFlow; // @[dut.scala 76:10 83:22 87:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 31:26]
      prevLevel <= 3'h0; // @[dut.scala 31:26]
    end else begin
      prevLevel <= currentLevel; // @[dut.scala 35:13]
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
  prevLevel = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
