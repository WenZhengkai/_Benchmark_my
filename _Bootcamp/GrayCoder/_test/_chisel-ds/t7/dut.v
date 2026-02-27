module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _encoded_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 13:32]
  wire [63:0] encoded = io_in ^ _encoded_T; // @[dut.scala 13:23]
  wire [63:0] _io_out_T_2 = {{2'd0}, encoded[63:2]}; // @[dut.scala 19:33]
  wire [63:0] _io_out_T_3 = encoded ^ _io_out_T_2; // @[dut.scala 19:23]
  wire [63:0] _io_out_T_4 = {{4'd0}, _io_out_T_3[63:4]}; // @[dut.scala 19:33]
  wire [63:0] _io_out_T_5 = _io_out_T_3 ^ _io_out_T_4; // @[dut.scala 19:23]
  wire [63:0] _io_out_T_6 = {{8'd0}, _io_out_T_5[63:8]}; // @[dut.scala 19:33]
  wire [63:0] _io_out_T_7 = _io_out_T_5 ^ _io_out_T_6; // @[dut.scala 19:23]
  wire [63:0] _io_out_T_8 = {{16'd0}, _io_out_T_7[63:16]}; // @[dut.scala 19:33]
  wire [63:0] _io_out_T_9 = _io_out_T_7 ^ _io_out_T_8; // @[dut.scala 19:23]
  wire [63:0] _io_out_T_10 = {{32'd0}, _io_out_T_9[63:32]}; // @[dut.scala 19:33]
  wire [63:0] _io_out_T_11 = _io_out_T_9 ^ _io_out_T_10; // @[dut.scala 19:23]
  assign io_out = io_encode ? encoded : _io_out_T_11; // @[dut.scala 25:16]
endmodule
