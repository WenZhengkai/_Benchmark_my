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
  wire  _grants_T_1 = io_in_0_valid | io_in_1_valid | io_in_2_valid; // @[dut.scala 52:60]
  wire  grants_1 = ~io_in_0_valid; // @[dut.scala 52:70]
  wire  grants_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 52:70]
  wire  grants_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 52:70]
  wire [7:0] _GEN_3 = grants_1 ? io_in_1_bits : io_in_0_bits; // @[dut.scala 31:21 32:19]
  wire  _GEN_4 = grants_1 ? io_in_1_valid : io_in_0_valid; // @[dut.scala 31:21 33:20]
  wire [7:0] _GEN_6 = grants_2 ? io_in_2_bits : _GEN_3; // @[dut.scala 31:21 32:19]
  wire  _GEN_7 = grants_2 ? io_in_2_valid : _GEN_4; // @[dut.scala 31:21 33:20]
  wire [1:0] _GEN_8 = grants_2 ? 2'h2 : {{1'd0}, grants_1}; // @[dut.scala 31:21 34:17]
  wire  _GEN_10 = grants_3 ? io_in_3_valid : _GEN_7; // @[dut.scala 31:21 33:20]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 29:33]
  assign io_in_1_ready = grants_1 & io_out_ready; // @[dut.scala 29:33]
  assign io_in_2_ready = grants_2 & io_out_ready; // @[dut.scala 29:33]
  assign io_in_3_ready = grants_3 & io_out_ready; // @[dut.scala 29:33]
  assign io_out_valid = ~(_grants_T_1 | io_in_3_valid) ? 1'h0 : _GEN_10; // @[dut.scala 39:33 40:18]
  assign io_out_bits = grants_3 ? io_in_3_bits : _GEN_6; // @[dut.scala 31:21 32:19]
  assign io_chosen = grants_3 ? 2'h3 : _GEN_8; // @[dut.scala 31:21 34:17]
endmodule
