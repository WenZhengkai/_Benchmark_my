module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 15:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[dut.scala 15:21]
  wire [63:0] _decodeSteps_2_T = {{2'd0}, _io_out_T_1[63:2]}; // @[dut.scala 29:62]
  wire [63:0] decodeSteps_2 = _io_out_T_1 ^ _decodeSteps_2_T; // @[dut.scala 29:44]
  wire [63:0] _decodeSteps_3_T = {{4'd0}, decodeSteps_2[63:4]}; // @[dut.scala 29:62]
  wire [63:0] decodeSteps_3 = decodeSteps_2 ^ _decodeSteps_3_T; // @[dut.scala 29:44]
  wire [63:0] _decodeSteps_4_T = {{8'd0}, decodeSteps_3[63:8]}; // @[dut.scala 29:62]
  wire [63:0] decodeSteps_4 = decodeSteps_3 ^ _decodeSteps_4_T; // @[dut.scala 29:44]
  wire [63:0] _decodeSteps_5_T = {{16'd0}, decodeSteps_4[63:16]}; // @[dut.scala 29:62]
  wire [63:0] decodeSteps_5 = decodeSteps_4 ^ _decodeSteps_5_T; // @[dut.scala 29:44]
  wire [63:0] _decodeSteps_6_T = {{32'd0}, decodeSteps_5[63:32]}; // @[dut.scala 29:62]
  wire [63:0] decodeSteps_6 = decodeSteps_5 ^ _decodeSteps_6_T; // @[dut.scala 29:44]
  assign io_out = io_encode ? _io_out_T_1 : decodeSteps_6; // @[dut.scala 13:19 15:12 33:12]
endmodule
