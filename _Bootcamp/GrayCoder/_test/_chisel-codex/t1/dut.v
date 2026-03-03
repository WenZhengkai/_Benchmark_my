module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:27]
  wire [63:0] grayEncoded = io_in ^ _GEN_0; // @[dut.scala 15:27]
  wire [63:0] _GEN_2 = {{2'd0}, grayEncoded[63:2]}; // @[dut.scala 23:38]
  wire [63:0] decodeVec_2 = grayEncoded ^ _GEN_2; // @[dut.scala 23:38]
  wire [63:0] _GEN_3 = {{4'd0}, decodeVec_2[63:4]}; // @[dut.scala 23:38]
  wire [63:0] decodeVec_3 = decodeVec_2 ^ _GEN_3; // @[dut.scala 23:38]
  wire [63:0] _GEN_4 = {{8'd0}, decodeVec_3[63:8]}; // @[dut.scala 23:38]
  wire [63:0] decodeVec_4 = decodeVec_3 ^ _GEN_4; // @[dut.scala 23:38]
  wire [63:0] _GEN_5 = {{16'd0}, decodeVec_4[63:16]}; // @[dut.scala 23:38]
  wire [63:0] decodeVec_5 = decodeVec_4 ^ _GEN_5; // @[dut.scala 23:38]
  wire [63:0] _GEN_6 = {{32'd0}, decodeVec_5[63:32]}; // @[dut.scala 23:38]
  wire [63:0] decodeVec_6 = decodeVec_5 ^ _GEN_6; // @[dut.scala 23:38]
  assign io_out = io_encode ? grayEncoded : decodeVec_6; // @[dut.scala 27:16]
endmodule
