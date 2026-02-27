module DCDemux_UInt8_golden(
  input        clock,
  input        reset,
  input  [3:0] io_sel,
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
  output [7:0] io_p_4_bits,
  input        io_p_5_ready,
  output       io_p_5_valid,
  output [7:0] io_p_5_bits,
  input        io_p_6_ready,
  output       io_p_6_valid,
  output [7:0] io_p_6_bits,
  input        io_p_7_ready,
  output       io_p_7_valid,
  output [7:0] io_p_7_bits,
  input        io_p_8_ready,
  output       io_p_8_valid,
  output [7:0] io_p_8_bits,
  input        io_p_9_ready,
  output       io_p_9_valid,
  output [7:0] io_p_9_bits
);
  wire  _GEN_1 = 4'h0 == io_sel & io_p_0_ready; // @[golden.scala 23:14 28:26 30:18]
  wire  _GEN_3 = 4'h1 == io_sel ? io_p_1_ready : _GEN_1; // @[golden.scala 28:26 30:18]
  wire  _GEN_5 = 4'h2 == io_sel ? io_p_2_ready : _GEN_3; // @[golden.scala 28:26 30:18]
  wire  _GEN_7 = 4'h3 == io_sel ? io_p_3_ready : _GEN_5; // @[golden.scala 28:26 30:18]
  wire  _GEN_9 = 4'h4 == io_sel ? io_p_4_ready : _GEN_7; // @[golden.scala 28:26 30:18]
  wire  _GEN_11 = 4'h5 == io_sel ? io_p_5_ready : _GEN_9; // @[golden.scala 28:26 30:18]
  wire  _GEN_13 = 4'h6 == io_sel ? io_p_6_ready : _GEN_11; // @[golden.scala 28:26 30:18]
  wire  _GEN_15 = 4'h7 == io_sel ? io_p_7_ready : _GEN_13; // @[golden.scala 28:26 30:18]
  wire  _GEN_17 = 4'h8 == io_sel ? io_p_8_ready : _GEN_15; // @[golden.scala 28:26 30:18]
  assign io_c_ready = 4'h9 == io_sel ? io_p_9_ready : _GEN_17; // @[golden.scala 28:26 30:18]
  assign io_p_0_valid = 4'h0 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_0_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_1_valid = 4'h1 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_1_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_2_valid = 4'h2 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_2_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_3_valid = 4'h3 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_3_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_4_valid = 4'h4 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_4_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_5_valid = 4'h5 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_5_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_6_valid = 4'h6 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_6_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_7_valid = 4'h7 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_7_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_8_valid = 4'h8 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_8_bits = io_c_bits; // @[golden.scala 26:18]
  assign io_p_9_valid = 4'h9 == io_sel & io_c_valid; // @[golden.scala 28:26 29:21 33:21]
  assign io_p_9_bits = io_c_bits; // @[golden.scala 26:18]
endmodule
