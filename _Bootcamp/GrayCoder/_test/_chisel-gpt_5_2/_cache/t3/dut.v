module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 14:23]
  wire [63:0] grayEnc = io_in ^ _GEN_0; // @[dut.scala 14:23]
  wire [63:0] _decVec_2_T = {{2'd0}, grayEnc[63:2]}; // @[dut.scala 24:45]
  wire [63:0] decVec_2 = grayEnc ^ _decVec_2_T; // @[dut.scala 24:32]
  wire [63:0] _decVec_3_T = {{4'd0}, decVec_2[63:4]}; // @[dut.scala 24:45]
  wire [63:0] decVec_3 = decVec_2 ^ _decVec_3_T; // @[dut.scala 24:32]
  wire [63:0] _decVec_4_T = {{8'd0}, decVec_3[63:8]}; // @[dut.scala 24:45]
  wire [63:0] decVec_4 = decVec_3 ^ _decVec_4_T; // @[dut.scala 24:32]
  wire [63:0] _decVec_5_T = {{16'd0}, decVec_4[63:16]}; // @[dut.scala 24:45]
  wire [63:0] decVec_5 = decVec_4 ^ _decVec_5_T; // @[dut.scala 24:32]
  wire [63:0] _decVec_6_T = {{32'd0}, decVec_5[63:32]}; // @[dut.scala 24:45]
  wire [63:0] decVec_6 = decVec_5 ^ _decVec_6_T; // @[dut.scala 24:32]
  assign io_out = io_encode ? grayEnc : decVec_6; // @[dut.scala 28:16]
endmodule
