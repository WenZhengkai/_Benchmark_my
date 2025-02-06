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
  output [7:0] io_out_bits,
  output [1:0] io_chosen
);
  wire  grants_1 = ~io_in_0_valid; // @[dut.scala 23:82]
  wire  grants_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 23:82]
  wire  grants_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 23:82]
  wire [7:0] _GEN_0 = io_in_0_valid ? io_in_0_bits : io_in_3_bits; // @[dut.scala 14:15 33:39 34:19]
  wire [1:0] _GEN_2 = io_in_0_valid ? 2'h0 : 2'h3; // @[dut.scala 16:13 33:39 36:17]
  wire [7:0] _GEN_3 = io_in_1_valid & grants_1 ? io_in_1_bits : _GEN_0; // @[dut.scala 33:39 34:19]
  wire [1:0] _GEN_5 = io_in_1_valid & grants_1 ? 2'h1 : _GEN_2; // @[dut.scala 33:39 36:17]
  wire [7:0] _GEN_6 = io_in_2_valid & grants_2 ? io_in_2_bits : _GEN_3; // @[dut.scala 33:39 34:19]
  wire [1:0] _GEN_8 = io_in_2_valid & grants_2 ? 2'h2 : _GEN_5; // @[dut.scala 33:39 36:17]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 32:33]
  assign io_in_1_ready = grants_1 & io_out_ready; // @[dut.scala 32:33]
  assign io_in_2_ready = grants_2 & io_out_ready; // @[dut.scala 32:33]
  assign io_in_3_ready = grants_3 & io_out_ready; // @[dut.scala 32:33]
  assign io_out_valid = io_in_3_valid & grants_3 | (io_in_2_valid & grants_2 | (io_in_1_valid & grants_1 | io_in_0_valid
    )); // @[dut.scala 33:39 35:20]
  assign io_out_bits = io_in_3_valid & grants_3 ? io_in_3_bits : _GEN_6; // @[dut.scala 33:39 34:19]
  assign io_chosen = io_in_3_valid & grants_3 ? 2'h3 : _GEN_8; // @[dut.scala 33:39 36:17]
endmodule
