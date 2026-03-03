module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 14:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[dut.scala 14:21]
  wire [63:0] _intermediates_2_T = {{2'd0}, _io_out_T_1[63:2]}; // @[dut.scala 26:68]
  wire [63:0] intermediates_2 = _io_out_T_1 ^ _intermediates_2_T; // @[dut.scala 26:48]
  wire [63:0] _intermediates_3_T = {{4'd0}, intermediates_2[63:4]}; // @[dut.scala 26:68]
  wire [63:0] intermediates_3 = intermediates_2 ^ _intermediates_3_T; // @[dut.scala 26:48]
  wire [63:0] _intermediates_4_T = {{8'd0}, intermediates_3[63:8]}; // @[dut.scala 26:68]
  wire [63:0] intermediates_4 = intermediates_3 ^ _intermediates_4_T; // @[dut.scala 26:48]
  wire [63:0] _intermediates_5_T = {{16'd0}, intermediates_4[63:16]}; // @[dut.scala 26:68]
  wire [63:0] intermediates_5 = intermediates_4 ^ _intermediates_5_T; // @[dut.scala 26:48]
  wire [63:0] _intermediates_6_T = {{32'd0}, intermediates_5[63:32]}; // @[dut.scala 26:68]
  wire [63:0] intermediates_6 = intermediates_5 ^ _intermediates_6_T; // @[dut.scala 26:48]
  assign io_out = io_encode ? _io_out_T_1 : intermediates_6; // @[dut.scala 12:19 14:12 30:12]
endmodule
