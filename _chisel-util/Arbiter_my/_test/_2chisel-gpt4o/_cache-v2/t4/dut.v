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
  wire [7:0] _GEN_1 = io_in_0_valid ? io_in_0_bits : 8'h0; // @[dut.scala 13:16 23:38 25:19]
  wire [1:0] _GEN_2 = io_in_0_valid ? 2'h0 : 2'h3; // @[dut.scala 14:16 23:38 26:17]
  wire [7:0] _GEN_4 = grant_1 & io_in_1_valid ? io_in_1_bits : _GEN_1; // @[dut.scala 23:38 25:19]
  wire [1:0] _GEN_5 = grant_1 & io_in_1_valid ? 2'h1 : _GEN_2; // @[dut.scala 23:38 26:17]
  wire [7:0] _GEN_7 = grant_2 & io_in_2_valid ? io_in_2_bits : _GEN_4; // @[dut.scala 23:38 25:19]
  wire [1:0] _GEN_8 = grant_2 & io_in_2_valid ? 2'h2 : _GEN_5; // @[dut.scala 23:38 26:17]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 22:32]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[dut.scala 22:32]
  assign io_in_2_ready = grant_2 & io_out_ready; // @[dut.scala 22:32]
  assign io_in_3_ready = grant_3 & io_out_ready; // @[dut.scala 22:32]
  assign io_out_valid = grant_3 & io_in_3_valid | (grant_2 & io_in_2_valid | (grant_1 & io_in_1_valid | io_in_0_valid)); // @[dut.scala 23:38 24:20]
  assign io_out_bits = grant_3 & io_in_3_valid ? io_in_3_bits : _GEN_7; // @[dut.scala 23:38 25:19]
  assign io_chosen = grant_3 & io_in_3_valid ? 2'h3 : _GEN_8; // @[dut.scala 23:38 26:17]
endmodule
