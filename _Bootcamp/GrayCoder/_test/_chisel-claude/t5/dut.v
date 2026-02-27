module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  input         io_encode,
  output [63:0] io_out
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[dut.scala 14:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[dut.scala 14:21]
  wire [63:0] _intermediate_2_T = {{2'd0}, _io_out_T_1[63:2]}; // @[dut.scala 27:65]
  wire [63:0] intermediate_2 = _io_out_T_1 ^ _intermediate_2_T; // @[dut.scala 27:46]
  wire [63:0] _intermediate_3_T = {{4'd0}, intermediate_2[63:4]}; // @[dut.scala 27:65]
  wire [63:0] intermediate_3 = intermediate_2 ^ _intermediate_3_T; // @[dut.scala 27:46]
  wire [63:0] _intermediate_4_T = {{8'd0}, intermediate_3[63:8]}; // @[dut.scala 27:65]
  wire [63:0] intermediate_4 = intermediate_3 ^ _intermediate_4_T; // @[dut.scala 27:46]
  wire [63:0] _intermediate_5_T = {{16'd0}, intermediate_4[63:16]}; // @[dut.scala 27:65]
  wire [63:0] intermediate_5 = intermediate_4 ^ _intermediate_5_T; // @[dut.scala 27:46]
  wire [63:0] _intermediate_6_T = {{32'd0}, intermediate_5[63:32]}; // @[dut.scala 27:65]
  wire [63:0] intermediate_6 = intermediate_5 ^ _intermediate_6_T; // @[dut.scala 27:46]
  assign io_out = io_encode ? _io_out_T_1 : intermediate_6; // @[dut.scala 12:19 14:12 31:12]
endmodule
