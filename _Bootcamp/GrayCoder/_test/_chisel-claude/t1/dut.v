module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 16:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[dut.scala 16:21]
  wire [63:0] _intermediateValues_2_T = {{2'd0}, _io_out_T_1[63:2]}; // @[dut.scala 29:83]
  wire [63:0] intermediateValues_2 = _io_out_T_1 ^ _intermediateValues_2_T; // @[dut.scala 29:58]
  wire [63:0] _intermediateValues_3_T = {{4'd0}, intermediateValues_2[63:4]}; // @[dut.scala 29:83]
  wire [63:0] intermediateValues_3 = intermediateValues_2 ^ _intermediateValues_3_T; // @[dut.scala 29:58]
  wire [63:0] _intermediateValues_4_T = {{8'd0}, intermediateValues_3[63:8]}; // @[dut.scala 29:83]
  wire [63:0] intermediateValues_4 = intermediateValues_3 ^ _intermediateValues_4_T; // @[dut.scala 29:58]
  wire [63:0] _intermediateValues_5_T = {{16'd0}, intermediateValues_4[63:16]}; // @[dut.scala 29:83]
  wire [63:0] intermediateValues_5 = intermediateValues_4 ^ _intermediateValues_5_T; // @[dut.scala 29:58]
  wire [63:0] _intermediateValues_6_T = {{32'd0}, intermediateValues_5[63:32]}; // @[dut.scala 29:83]
  wire [63:0] intermediateValues_6 = intermediateValues_5 ^ _intermediateValues_6_T; // @[dut.scala 29:58]
  assign io_out = io_encode ? _io_out_T_1 : intermediateValues_6; // @[dut.scala 14:19 16:12 33:12]
endmodule
