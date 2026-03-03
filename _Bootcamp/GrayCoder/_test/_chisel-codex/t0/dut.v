module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:27]
  wire [63:0] grayEncoded = io_in ^ _GEN_0; // @[dut.scala 15:27]
  wire [63:0] _GEN_2 = {{2'd0}, grayEncoded[63:2]}; // @[dut.scala 22:32]
  wire [63:0] stages_2 = grayEncoded ^ _GEN_2; // @[dut.scala 22:32]
  wire [63:0] _GEN_3 = {{4'd0}, stages_2[63:4]}; // @[dut.scala 22:32]
  wire [63:0] stages_3 = stages_2 ^ _GEN_3; // @[dut.scala 22:32]
  wire [63:0] _GEN_4 = {{8'd0}, stages_3[63:8]}; // @[dut.scala 22:32]
  wire [63:0] stages_4 = stages_3 ^ _GEN_4; // @[dut.scala 22:32]
  wire [63:0] _GEN_5 = {{16'd0}, stages_4[63:16]}; // @[dut.scala 22:32]
  wire [63:0] stages_5 = stages_4 ^ _GEN_5; // @[dut.scala 22:32]
  wire [63:0] _GEN_6 = {{32'd0}, stages_5[63:32]}; // @[dut.scala 22:32]
  wire [63:0] stages_6 = stages_5 ^ _GEN_6; // @[dut.scala 22:32]
  assign io_out = io_encode ? grayEncoded : stages_6; // @[dut.scala 26:16]
endmodule
