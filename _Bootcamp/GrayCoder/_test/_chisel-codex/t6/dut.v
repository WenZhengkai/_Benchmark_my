module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _GEN_0 = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:20]
  wire [63:0] gray = io_in ^ _GEN_0; // @[dut.scala 15:20]
  wire [63:0] _GEN_2 = {{2'd0}, gray[63:2]}; // @[dut.scala 23:44]
  wire [63:0] decodeStages_2 = gray ^ _GEN_2; // @[dut.scala 23:44]
  wire [63:0] _GEN_3 = {{4'd0}, decodeStages_2[63:4]}; // @[dut.scala 23:44]
  wire [63:0] decodeStages_3 = decodeStages_2 ^ _GEN_3; // @[dut.scala 23:44]
  wire [63:0] _GEN_4 = {{8'd0}, decodeStages_3[63:8]}; // @[dut.scala 23:44]
  wire [63:0] decodeStages_4 = decodeStages_3 ^ _GEN_4; // @[dut.scala 23:44]
  wire [63:0] _GEN_5 = {{16'd0}, decodeStages_4[63:16]}; // @[dut.scala 23:44]
  wire [63:0] decodeStages_5 = decodeStages_4 ^ _GEN_5; // @[dut.scala 23:44]
  wire [63:0] _GEN_6 = {{32'd0}, decodeStages_5[63:32]}; // @[dut.scala 23:44]
  wire [63:0] decodeStages_6 = decodeStages_5 ^ _GEN_6; // @[dut.scala 23:44]
  assign io_out = io_encode ? gray : decodeStages_6; // @[dut.scala 27:16]
endmodule
