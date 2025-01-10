module Arbiter4_UInt8(
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
  wire [1:0] _GEN_0 = io_in_2_valid ? 2'h2 : 2'h3; // @[golden.scala 36:13 39:26 40:17]
  wire [7:0] _GEN_1 = io_in_2_valid ? io_in_2_bits : io_in_3_bits; // @[golden.scala 37:15 39:26 41:19]
  wire [1:0] _GEN_2 = io_in_1_valid ? 2'h1 : _GEN_0; // @[golden.scala 39:26 40:17]
  wire [7:0] _GEN_3 = io_in_1_valid ? io_in_1_bits : _GEN_1; // @[golden.scala 39:26 41:19]
  wire  grant_1 = ~io_in_0_valid; // @[golden.scala 10:78]
  wire  grant_2 = ~(io_in_0_valid | io_in_1_valid); // @[golden.scala 10:78]
  wire  grant_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[golden.scala 10:78]
  assign io_in_0_ready = io_out_ready; // @[golden.scala 47:19]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[golden.scala 47:19]
  assign io_in_2_ready = grant_2 & io_out_ready; // @[golden.scala 47:19]
  assign io_in_3_ready = grant_3 & io_out_ready; // @[golden.scala 47:19]
  assign io_out_valid = ~grant_3 | io_in_3_valid; // @[golden.scala 48:31]
  assign io_out_bits = io_in_0_valid ? io_in_0_bits : _GEN_3; // @[golden.scala 39:26 41:19]
  assign io_chosen = io_in_0_valid ? 2'h0 : _GEN_2; // @[golden.scala 39:26 40:17]
endmodule
