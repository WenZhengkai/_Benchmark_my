module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _encoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 12:32]
  wire [63:0] encoded = io_in ^ _encoded_T; // @[dut.scala 12:23]
  wire [63:0] _T_2 = {{2'd0}, encoded[63:2]}; // @[dut.scala 19:31]
  wire [63:0] _T_3 = encoded ^ _T_2; // @[dut.scala 19:21]
  wire [63:0] _T_4 = {{4'd0}, _T_3[63:4]}; // @[dut.scala 19:31]
  wire [63:0] _T_5 = _T_3 ^ _T_4; // @[dut.scala 19:21]
  wire [63:0] _T_6 = {{8'd0}, _T_5[63:8]}; // @[dut.scala 19:31]
  wire [63:0] _T_7 = _T_5 ^ _T_6; // @[dut.scala 19:21]
  wire [63:0] _T_8 = {{16'd0}, _T_7[63:16]}; // @[dut.scala 19:31]
  wire [63:0] _T_9 = _T_7 ^ _T_8; // @[dut.scala 19:21]
  wire [63:0] _T_10 = {{32'd0}, _T_9[63:32]}; // @[dut.scala 19:31]
  wire [63:0] result = _T_9 ^ _T_10; // @[dut.scala 19:21]
  assign io_out = io_encode ? encoded : result; // @[dut.scala 23:16]
endmodule
