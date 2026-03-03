module dut(
  input        clock,
  input        reset,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input  [7:0] io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [7:0] io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input  [7:0] io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input  [7:0] io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
  wire [1:0] _sel_T = io_in_2_valid ? 2'h2 : 2'h3; // @[Mux.scala 47:70]
  wire [1:0] _sel_T_1 = io_in_1_valid ? 2'h1 : _sel_T; // @[Mux.scala 47:70]
  wire [1:0] sel = io_in_0_valid ? 2'h0 : _sel_T_1; // @[Mux.scala 47:70]
  wire [7:0] _GEN_1 = 2'h1 == sel ? io_in_1_bits : io_in_0_bits; // @[dut.scala 22:{15,15}]
  wire [7:0] _GEN_2 = 2'h2 == sel ? io_in_2_bits : _GEN_1; // @[dut.scala 22:{15,15}]
  assign io_in_0_ready = io_out_ready & io_out_valid & sel == 2'h0; // @[dut.scala 26:52]
  assign io_in_1_ready = io_out_ready & io_out_valid & sel == 2'h1; // @[dut.scala 26:52]
  assign io_in_2_ready = io_out_ready & io_out_valid & sel == 2'h2; // @[dut.scala 26:52]
  assign io_in_3_ready = io_out_ready & io_out_valid & sel == 2'h3; // @[dut.scala 26:52]
  assign io_out_valid = io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid; // @[dut.scala 13:47]
  assign io_out_bits = 2'h3 == sel ? io_in_3_bits : _GEN_2; // @[dut.scala 22:{15,15}]
endmodule
