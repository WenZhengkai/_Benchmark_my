module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _grayEncoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 16:36]
  wire [63:0] grayEncoded = io_in ^ _grayEncoded_T; // @[dut.scala 16:27]
  wire [63:0] _decodeIters_2_T = {{2'd0}, grayEncoded[63:2]}; // @[dut.scala 29:60]
  wire [63:0] decodeIters_2 = grayEncoded ^ _decodeIters_2_T; // @[dut.scala 29:42]
  wire [63:0] _decodeIters_3_T = {{4'd0}, decodeIters_2[63:4]}; // @[dut.scala 29:60]
  wire [63:0] decodeIters_3 = decodeIters_2 ^ _decodeIters_3_T; // @[dut.scala 29:42]
  wire [63:0] _decodeIters_4_T = {{8'd0}, decodeIters_3[63:8]}; // @[dut.scala 29:60]
  wire [63:0] decodeIters_4 = decodeIters_3 ^ _decodeIters_4_T; // @[dut.scala 29:42]
  wire [63:0] _decodeIters_5_T = {{16'd0}, decodeIters_4[63:16]}; // @[dut.scala 29:60]
  wire [63:0] decodeIters_5 = decodeIters_4 ^ _decodeIters_5_T; // @[dut.scala 29:42]
  wire [63:0] _decodeIters_6_T = {{32'd0}, decodeIters_5[63:32]}; // @[dut.scala 29:60]
  wire [63:0] decodeIters_6 = decodeIters_5 ^ _decodeIters_6_T; // @[dut.scala 29:42]
  assign io_out = io_encode ? grayEncoded : decodeIters_6; // @[dut.scala 36:16]
endmodule
