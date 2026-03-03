module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:20]
  wire [63:0] gray = io_in ^ _GEN_0; // @[dut.scala 15:20]
  wire [63:0] _GEN_2 = {{2'd0}, gray[63:2]}; // @[dut.scala 20:23]
  wire [63:0] _T_3 = gray ^ _GEN_2; // @[dut.scala 20:23]
  wire [63:0] _GEN_3 = {{4'd0}, _T_3[63:4]}; // @[dut.scala 20:23]
  wire [63:0] _T_5 = _T_3 ^ _GEN_3; // @[dut.scala 20:23]
  wire [63:0] _GEN_4 = {{8'd0}, _T_5[63:8]}; // @[dut.scala 20:23]
  wire [63:0] _T_7 = _T_5 ^ _GEN_4; // @[dut.scala 20:23]
  wire [63:0] _GEN_5 = {{16'd0}, _T_7[63:16]}; // @[dut.scala 20:23]
  wire [63:0] _T_9 = _T_7 ^ _GEN_5; // @[dut.scala 20:23]
  wire [63:0] _GEN_6 = {{32'd0}, _T_9[63:32]}; // @[dut.scala 20:23]
  wire [63:0] decoded = _T_9 ^ _GEN_6; // @[dut.scala 20:23]
  assign io_out = io_encode ? gray : decoded; // @[dut.scala 23:16]
endmodule
