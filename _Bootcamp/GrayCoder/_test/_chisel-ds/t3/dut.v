module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _encoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 13:32]
  wire [63:0] encoded = io_in ^ _encoded_T; // @[dut.scala 13:23]
  wire [63:0] _decoded_1_T = {{2'd0}, io_in[63:2]}; // @[dut.scala 20:52]
  wire [63:0] decoded_1 = io_in ^ _decoded_1_T; // @[dut.scala 20:34]
  wire [63:0] _decoded_2_T = {{4'd0}, decoded_1[63:4]}; // @[dut.scala 20:52]
  wire [63:0] decoded_2 = decoded_1 ^ _decoded_2_T; // @[dut.scala 20:34]
  wire [63:0] _decoded_3_T = {{8'd0}, decoded_2[63:8]}; // @[dut.scala 20:52]
  wire [63:0] decoded_3 = decoded_2 ^ _decoded_3_T; // @[dut.scala 20:34]
  wire [63:0] _decoded_4_T = {{16'd0}, decoded_3[63:16]}; // @[dut.scala 20:52]
  wire [63:0] decoded_4 = decoded_3 ^ _decoded_4_T; // @[dut.scala 20:34]
  wire [63:0] _decoded_5_T = {{32'd0}, decoded_4[63:32]}; // @[dut.scala 20:52]
  wire [63:0] decoded_5 = decoded_4 ^ _decoded_5_T; // @[dut.scala 20:34]
  assign io_out = io_encode ? encoded : decoded_5; // @[dut.scala 24:16]
endmodule
