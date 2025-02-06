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
  wire  grant_1 = ~io_in_0_valid; // @[dut.scala 36:78]
  wire  grant_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 36:78]
  wire  grant_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 36:78]
  wire [1:0] _GEN_0 = io_in_2_valid ? 2'h2 : 2'h3; // @[dut.scala 18:13 21:22 22:17]
  wire [7:0] _GEN_1 = io_in_2_valid ? io_in_2_bits : io_in_3_bits; // @[dut.scala 19:15 21:22 23:19]
  wire [1:0] _GEN_2 = io_in_1_valid ? 2'h1 : _GEN_0; // @[dut.scala 21:22 22:17]
  wire [7:0] _GEN_3 = io_in_1_valid ? io_in_1_bits : _GEN_1; // @[dut.scala 21:22 23:19]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 29:71]
  assign io_in_1_ready = io_out_ready & grant_1; // @[dut.scala 29:71]
  assign io_in_2_ready = io_out_ready & grant_2; // @[dut.scala 29:71]
  assign io_in_3_ready = io_out_ready & grant_3; // @[dut.scala 29:71]
  assign io_out_valid = io_in_0_valid | io_in_1_valid & grant_1 | io_in_2_valid & grant_2 | io_in_3_valid & grant_3; // @[dut.scala 28:83]
  assign io_out_bits = io_in_0_valid ? io_in_0_bits : _GEN_3; // @[dut.scala 21:22 23:19]
  assign io_chosen = io_in_0_valid ? 2'h0 : _GEN_2; // @[dut.scala 21:22 22:17]
endmodule
