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
  wire  _GEN_0 = 3'h0 == io_sel & io_c_valid; // @[dut.scala 15:19 20:{22,22}]
  wire  _GEN_1 = 3'h1 == io_sel & io_c_valid; // @[dut.scala 15:19 20:{22,22}]
  wire  _GEN_2 = 3'h2 == io_sel & io_c_valid; // @[dut.scala 15:19 20:{22,22}]
  wire  _GEN_3 = 3'h3 == io_sel & io_c_valid; // @[dut.scala 15:19 20:{22,22}]
  wire  _GEN_4 = 3'h4 == io_sel & io_c_valid; // @[dut.scala 15:19 20:{22,22}]
  wire  _GEN_6 = 3'h1 == io_sel ? io_p_1_ready : io_p_0_ready; // @[dut.scala 21:{14,14}]
  wire  _GEN_7 = 3'h2 == io_sel ? io_p_2_ready : _GEN_6; // @[dut.scala 21:{14,14}]
  wire  _GEN_8 = 3'h3 == io_sel ? io_p_3_ready : _GEN_7; // @[dut.scala 21:{14,14}]
  wire  _GEN_9 = 3'h4 == io_sel ? io_p_4_ready : _GEN_8; // @[dut.scala 21:{14,14}]
  assign io_c_ready = io_c_valid & _GEN_9; // @[dut.scala 24:19]
  assign io_p_0_valid = 3'h0 != io_sel ? 1'h0 : _GEN_0; // @[dut.scala 32:26 33:21]
  assign io_p_0_bits = io_c_bits; // @[dut.scala 16:18]
  assign io_p_1_valid = 3'h1 != io_sel ? 1'h0 : _GEN_1; // @[dut.scala 32:26 33:21]
  assign io_p_1_bits = io_c_bits; // @[dut.scala 16:18]
  assign io_p_2_valid = 3'h2 != io_sel ? 1'h0 : _GEN_2; // @[dut.scala 32:26 33:21]
  assign io_p_2_bits = io_c_bits; // @[dut.scala 16:18]
  assign io_p_3_valid = 3'h3 != io_sel ? 1'h0 : _GEN_3; // @[dut.scala 32:26 33:21]
  assign io_p_3_bits = io_c_bits; // @[dut.scala 16:18]
  assign io_p_4_valid = 3'h4 != io_sel ? 1'h0 : _GEN_4; // @[dut.scala 32:26 33:21]
  assign io_p_4_bits = io_c_bits; // @[dut.scala 16:18]
endmodule
