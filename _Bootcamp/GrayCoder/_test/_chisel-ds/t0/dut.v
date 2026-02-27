module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _grayEncoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 13:36]
  wire [63:0] grayEncoded = io_in ^ _grayEncoded_T; // @[dut.scala 13:27]
  wire [63:0] _io_out_T_2 = {{2'd0}, grayEncoded[63:2]}; // @[dut.scala 20:33]
  wire [63:0] _io_out_T_3 = grayEncoded ^ _io_out_T_2; // @[dut.scala 20:23]
  wire [63:0] _io_out_T_4 = {{4'd0}, _io_out_T_3[63:4]}; // @[dut.scala 20:33]
  wire [63:0] _io_out_T_5 = _io_out_T_3 ^ _io_out_T_4; // @[dut.scala 20:23]
  wire [63:0] _io_out_T_6 = {{8'd0}, _io_out_T_5[63:8]}; // @[dut.scala 20:33]
  wire [63:0] _io_out_T_7 = _io_out_T_5 ^ _io_out_T_6; // @[dut.scala 20:23]
  wire [63:0] _io_out_T_8 = {{16'd0}, _io_out_T_7[63:16]}; // @[dut.scala 20:33]
  wire [63:0] _io_out_T_9 = _io_out_T_7 ^ _io_out_T_8; // @[dut.scala 20:23]
  wire [63:0] _io_out_T_10 = {{32'd0}, _io_out_T_9[63:32]}; // @[dut.scala 20:33]
  wire [63:0] _io_out_T_11 = _io_out_T_9 ^ _io_out_T_10; // @[dut.scala 20:23]
  assign io_out = io_encode ? grayEncoded : _io_out_T_11; // @[dut.scala 26:16]
endmodule
