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
  wire  _GEN_0 = io_sel == 3'h0 & io_c_valid; // @[dut.scala 13:19 23:28 24:23]
  wire  _GEN_1 = io_sel == 3'h0 & io_p_0_ready; // @[dut.scala 18:14 23:28 25:20]
  wire  _GEN_2 = io_sel == 3'h1 & io_c_valid; // @[dut.scala 13:19 23:28 24:23]
  wire  _GEN_3 = io_sel == 3'h1 ? io_p_1_ready : _GEN_1; // @[dut.scala 23:28 25:20]
  wire  _GEN_4 = io_sel == 3'h2 & io_c_valid; // @[dut.scala 13:19 23:28 24:23]
  wire  _GEN_5 = io_sel == 3'h2 ? io_p_2_ready : _GEN_3; // @[dut.scala 23:28 25:20]
  wire  _GEN_6 = io_sel == 3'h3 & io_c_valid; // @[dut.scala 13:19 23:28 24:23]
  wire  _GEN_7 = io_sel == 3'h3 ? io_p_3_ready : _GEN_5; // @[dut.scala 23:28 25:20]
  wire  _GEN_8 = io_sel == 3'h4 & io_c_valid; // @[dut.scala 13:19 23:28 24:23]
  wire  _GEN_9 = io_sel == 3'h4 ? io_p_4_ready : _GEN_7; // @[dut.scala 23:28 25:20]
  assign io_c_ready = io_c_valid & _GEN_9; // @[dut.scala 18:14 21:20]
  assign io_p_0_valid = io_c_valid & _GEN_0; // @[dut.scala 13:19 21:20]
  assign io_p_0_bits = io_c_bits; // @[dut.scala 14:18]
  assign io_p_1_valid = io_c_valid & _GEN_2; // @[dut.scala 13:19 21:20]
  assign io_p_1_bits = io_c_bits; // @[dut.scala 14:18]
  assign io_p_2_valid = io_c_valid & _GEN_4; // @[dut.scala 13:19 21:20]
  assign io_p_2_bits = io_c_bits; // @[dut.scala 14:18]
  assign io_p_3_valid = io_c_valid & _GEN_6; // @[dut.scala 13:19 21:20]
  assign io_p_3_bits = io_c_bits; // @[dut.scala 14:18]
  assign io_p_4_valid = io_c_valid & _GEN_8; // @[dut.scala 13:19 21:20]
  assign io_p_4_bits = io_c_bits; // @[dut.scala 14:18]
endmodule
