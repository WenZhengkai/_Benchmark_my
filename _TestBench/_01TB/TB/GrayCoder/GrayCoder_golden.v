module GrayCoder_golden(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output [63:0] io_out,
  input         io_encode
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[GrayCoder.scala 15:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[GrayCoder.scala 15:21]
  wire [63:0] _io_out_T_2 = {{32'd0}, io_in[63:32]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_3 = io_in ^ _io_out_T_2; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_4 = {{16'd0}, _io_out_T_3[63:16]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_5 = _io_out_T_3 ^ _io_out_T_4; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_6 = {{8'd0}, _io_out_T_5[63:8]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_7 = _io_out_T_5 ^ _io_out_T_6; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_8 = {{4'd0}, _io_out_T_7[63:4]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_9 = _io_out_T_7 ^ _io_out_T_8; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_10 = {{2'd0}, _io_out_T_9[63:2]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_11 = _io_out_T_9 ^ _io_out_T_10; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_12 = {{1'd0}, _io_out_T_11[63:1]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_13 = _io_out_T_11 ^ _io_out_T_12; // @[GrayCoder.scala 19:18]
  assign io_out = io_encode ? _io_out_T_1 : _io_out_T_13; // @[GrayCoder.scala 14:20 15:12 17:12]
endmodule
