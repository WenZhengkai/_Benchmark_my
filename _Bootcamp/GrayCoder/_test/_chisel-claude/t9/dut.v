module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _grayEncoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 16:36]
  wire [63:0] grayEncoded = io_in ^ _grayEncoded_T; // @[dut.scala 16:27]
  wire [63:0] _decodeIterations_2_T = {{2'd0}, grayEncoded[63:2]}; // @[dut.scala 29:75]
  wire [63:0] decodeIterations_2 = grayEncoded ^ _decodeIterations_2_T; // @[dut.scala 29:52]
  wire [63:0] _decodeIterations_3_T = {{4'd0}, decodeIterations_2[63:4]}; // @[dut.scala 29:75]
  wire [63:0] decodeIterations_3 = decodeIterations_2 ^ _decodeIterations_3_T; // @[dut.scala 29:52]
  wire [63:0] _decodeIterations_4_T = {{8'd0}, decodeIterations_3[63:8]}; // @[dut.scala 29:75]
  wire [63:0] decodeIterations_4 = decodeIterations_3 ^ _decodeIterations_4_T; // @[dut.scala 29:52]
  wire [63:0] _decodeIterations_5_T = {{16'd0}, decodeIterations_4[63:16]}; // @[dut.scala 29:75]
  wire [63:0] decodeIterations_5 = decodeIterations_4 ^ _decodeIterations_5_T; // @[dut.scala 29:52]
  wire [63:0] _decodeIterations_6_T = {{32'd0}, decodeIterations_5[63:32]}; // @[dut.scala 29:75]
  wire [63:0] decodeIterations_6 = decodeIterations_5 ^ _decodeIterations_6_T; // @[dut.scala 29:52]
  assign io_out = io_encode ? grayEncoded : decodeIterations_6; // @[dut.scala 36:16]
endmodule
