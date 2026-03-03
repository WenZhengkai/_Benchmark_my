module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 23:32]
  wire [63:0] decVec_1 = io_in ^ _GEN_0; // @[dut.scala 23:32]
  wire [63:0] _GEN_1 = {{2'd0}, decVec_1[63:2]}; // @[dut.scala 23:32]
  wire [63:0] decVec_2 = decVec_1 ^ _GEN_1; // @[dut.scala 23:32]
  wire [63:0] _GEN_2 = {{4'd0}, decVec_2[63:4]}; // @[dut.scala 23:32]
  wire [63:0] decVec_3 = decVec_2 ^ _GEN_2; // @[dut.scala 23:32]
  wire [63:0] _GEN_3 = {{8'd0}, decVec_3[63:8]}; // @[dut.scala 23:32]
  wire [63:0] decVec_4 = decVec_3 ^ _GEN_3; // @[dut.scala 23:32]
  wire [63:0] _GEN_4 = {{16'd0}, decVec_4[63:16]}; // @[dut.scala 23:32]
  wire [63:0] decVec_5 = decVec_4 ^ _GEN_4; // @[dut.scala 23:32]
  wire [63:0] _GEN_5 = {{32'd0}, decVec_5[63:32]}; // @[dut.scala 23:32]
  wire [63:0] decVec_6 = decVec_5 ^ _GEN_5; // @[dut.scala 23:32]
  assign io_out = io_encode ? decVec_1 : decVec_6; // @[dut.scala 29:16]
endmodule
