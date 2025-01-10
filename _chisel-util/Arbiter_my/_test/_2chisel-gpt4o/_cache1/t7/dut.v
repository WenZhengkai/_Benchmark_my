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
  wire  _grants_T_1 = io_in_0_valid | io_in_1_valid | io_in_2_valid; // @[dut.scala 38:59]
  wire  grants_1 = ~io_in_0_valid; // @[dut.scala 38:69]
  wire  grants_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 38:69]
  wire  grants_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 38:69]
  wire [1:0] _io_chosen_T = io_in_2_valid ? 2'h2 : 2'h3; // @[Mux.scala 47:70]
  wire [1:0] _io_chosen_T_1 = io_in_1_valid ? 2'h1 : _io_chosen_T; // @[Mux.scala 47:70]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 28:33]
  assign io_in_1_ready = grants_1 & io_out_ready; // @[dut.scala 28:33]
  assign io_in_2_ready = grants_2 & io_out_ready; // @[dut.scala 28:33]
  assign io_in_3_ready = grants_3 & io_out_ready; // @[dut.scala 28:33]
  assign io_out_valid = _grants_T_1 | io_in_3_valid; // @[dut.scala 24:34]
  assign io_out_bits = io_in_0_bits; // @[Mux.scala 47:70]
  assign io_chosen = io_in_0_valid ? 2'h0 : _io_chosen_T_1; // @[Mux.scala 47:70]
endmodule
