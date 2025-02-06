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
  wire  grant_1 = ~io_in_0_valid; // @[dut.scala 39:78]
  wire  grant_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 39:78]
  wire  grant_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 39:78]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 30:19]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[dut.scala 30:19]
  assign io_in_2_ready = grant_2 & io_out_ready; // @[dut.scala 30:19]
  assign io_in_3_ready = grant_3 & io_out_ready; // @[dut.scala 30:19]
  assign io_out_valid = 1'h1; // @[dut.scala 28:34]
  assign io_out_bits = io_in_0_bits; // @[dut.scala 21:20 23:19]
  assign io_chosen = 2'h0; // @[dut.scala 21:20 22:17]
endmodule
