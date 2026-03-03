module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_rst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  s1 = io_s[0]; // @[dut.scala 18:16]
  wire  s2 = io_s[1]; // @[dut.scala 19:16]
  wire  s3 = io_s[2]; // @[dut.scala 20:16]
  wire [1:0] _GEN_1 = s2 ? 2'h2 : {{1'd0}, s1}; // @[dut.scala 30:18 31:11]
  wire [1:0] level = s3 ? 2'h3 : _GEN_1; // @[dut.scala 28:12 29:11]
  reg [1:0] prevLevel; // @[dut.scala 40:26]
  wire  rising = level > prevLevel; // @[dut.scala 41:25]
  wire  _GEN_5 = 2'h1 == level | 2'h0 == level; // @[dut.scala 55:17 63:13]
  wire  _GEN_6 = 2'h1 == level ? 1'h0 : 2'h0 == level; // @[dut.scala 55:17 63:49]
  wire  _GEN_7 = 2'h2 == level | _GEN_5; // @[dut.scala 55:17 60:13]
  wire  _GEN_8 = 2'h2 == level ? 1'h0 : _GEN_5; // @[dut.scala 55:17 60:31]
  wire  _GEN_9 = 2'h2 == level ? 1'h0 : _GEN_6; // @[dut.scala 55:17 60:49]
  wire  n_fr1 = 2'h3 == level ? 1'h0 : _GEN_7; // @[dut.scala 55:17 57:13]
  wire  n_fr2 = 2'h3 == level ? 1'h0 : _GEN_8; // @[dut.scala 55:17 57:31]
  wire  n_fr3 = 2'h3 == level ? 1'h0 : _GEN_9; // @[dut.scala 55:17 57:49]
  assign io_fr3 = io_rst | n_fr3; // @[dut.scala 72:16 75:12 80:12]
  assign io_fr2 = io_rst | n_fr2; // @[dut.scala 72:16 74:12 79:12]
  assign io_fr1 = io_rst | n_fr1; // @[dut.scala 72:16 73:12 78:12]
  assign io_dfr = io_rst | rising; // @[dut.scala 72:16 76:12 81:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 40:26]
      prevLevel <= 2'h0; // @[dut.scala 40:26]
    end else if (io_rst) begin // @[dut.scala 44:16]
      prevLevel <= 2'h0; // @[dut.scala 45:15]
    end else if (s3) begin // @[dut.scala 28:12]
      prevLevel <= 2'h3; // @[dut.scala 29:11]
    end else if (s2) begin // @[dut.scala 30:18]
      prevLevel <= 2'h2; // @[dut.scala 31:11]
    end else begin
      prevLevel <= {{1'd0}, s1};
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
  prevLevel = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
