module dut(
  input        clock,
  input        reset,
  input  [2:0] io_sel,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);
  wire  _GEN_1 = 3'h0 == io_sel & io_p_0_ready; // @[dut.scala 22:14 33:26 36:18]
  wire  _GEN_3 = 3'h1 == io_sel ? io_p_1_ready : _GEN_1; // @[dut.scala 33:26 36:18]
  wire  _GEN_5 = 3'h2 == io_sel ? io_p_2_ready : _GEN_3; // @[dut.scala 33:26 36:18]
  wire  _GEN_7 = 3'h3 == io_sel ? io_p_3_ready : _GEN_5; // @[dut.scala 33:26 36:18]
  assign io_c_ready = 3'h4 == io_sel ? io_p_4_ready : _GEN_7; // @[dut.scala 33:26 36:18]
  assign io_p_0_valid = 3'h0 == io_sel & io_c_valid; // @[dut.scala 33:26 35:21 39:21]
  assign io_p_0_bits = io_c_bits; // @[dut.scala 27:18]
  assign io_p_1_valid = 3'h1 == io_sel & io_c_valid; // @[dut.scala 33:26 35:21 39:21]
  assign io_p_1_bits = io_c_bits; // @[dut.scala 27:18]
  assign io_p_2_valid = 3'h2 == io_sel & io_c_valid; // @[dut.scala 33:26 35:21 39:21]
  assign io_p_2_bits = io_c_bits; // @[dut.scala 27:18]
  assign io_p_3_valid = 3'h3 == io_sel & io_c_valid; // @[dut.scala 33:26 35:21 39:21]
  assign io_p_3_bits = io_c_bits; // @[dut.scala 27:18]
  assign io_p_4_valid = 3'h4 == io_sel & io_c_valid; // @[dut.scala 33:26 35:21 39:21]
  assign io_p_4_bits = io_c_bits; // @[dut.scala 27:18]
endmodule
