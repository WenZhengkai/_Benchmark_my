module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 14:23]
  wire [63:0] grayEnc = io_in ^ _GEN_0; // @[dut.scala 14:23]
  wire [63:0] _GEN_2 = {{2'd0}, grayEnc[63:2]}; // @[dut.scala 24:26]
  wire [63:0] dec_2 = grayEnc ^ _GEN_2; // @[dut.scala 24:26]
  wire [63:0] _GEN_3 = {{4'd0}, dec_2[63:4]}; // @[dut.scala 24:26]
  wire [63:0] dec_3 = dec_2 ^ _GEN_3; // @[dut.scala 24:26]
  wire [63:0] _GEN_4 = {{8'd0}, dec_3[63:8]}; // @[dut.scala 24:26]
  wire [63:0] dec_4 = dec_3 ^ _GEN_4; // @[dut.scala 24:26]
  wire [63:0] _GEN_5 = {{16'd0}, dec_4[63:16]}; // @[dut.scala 24:26]
  wire [63:0] dec_5 = dec_4 ^ _GEN_5; // @[dut.scala 24:26]
  wire [63:0] _GEN_6 = {{32'd0}, dec_5[63:32]}; // @[dut.scala 24:26]
  wire [63:0] dec_6 = dec_5 ^ _GEN_6; // @[dut.scala 24:26]
  assign io_out = io_encode ? grayEnc : dec_6; // @[dut.scala 28:16]
endmodule
