module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:19]
  wire [63:0] enc = io_in ^ _GEN_0; // @[dut.scala 15:19]
  wire [63:0] _decodeVec_2_T = {{2'd0}, enc[63:2]}; // @[dut.scala 25:58]
  wire [63:0] decodeVec_2 = enc ^ _decodeVec_2_T; // @[dut.scala 25:38]
  wire [63:0] _decodeVec_3_T = {{4'd0}, decodeVec_2[63:4]}; // @[dut.scala 25:58]
  wire [63:0] decodeVec_3 = decodeVec_2 ^ _decodeVec_3_T; // @[dut.scala 25:38]
  wire [63:0] _decodeVec_4_T = {{8'd0}, decodeVec_3[63:8]}; // @[dut.scala 25:58]
  wire [63:0] decodeVec_4 = decodeVec_3 ^ _decodeVec_4_T; // @[dut.scala 25:38]
  wire [63:0] _decodeVec_5_T = {{16'd0}, decodeVec_4[63:16]}; // @[dut.scala 25:58]
  wire [63:0] decodeVec_5 = decodeVec_4 ^ _decodeVec_5_T; // @[dut.scala 25:38]
  wire [63:0] _decodeVec_6_T = {{32'd0}, decodeVec_5[63:32]}; // @[dut.scala 25:58]
  wire [63:0] decodeVec_6 = decodeVec_5 ^ _decodeVec_6_T; // @[dut.scala 25:38]
  assign io_out = io_encode ? enc : decodeVec_6; // @[dut.scala 30:16]
endmodule
