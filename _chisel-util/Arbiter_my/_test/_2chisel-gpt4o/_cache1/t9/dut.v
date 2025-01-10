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
  wire  grants_1 = ~io_in_0_valid; // @[dut.scala 36:78]
  wire  grants_2 = ~(io_in_0_valid | io_in_1_valid); // @[dut.scala 36:78]
  wire  grants_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[dut.scala 36:78]
  wire [1:0] _io_chosen_T = io_in_2_valid ? 2'h2 : 2'h3; // @[Mux.scala 47:70]
  wire [1:0] _io_chosen_T_1 = io_in_1_valid ? 2'h1 : _io_chosen_T; // @[Mux.scala 47:70]
  wire [7:0] _io_out_bits_T_1 = grants_1 ? io_in_1_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_2 = grants_2 ? io_in_2_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_3 = grants_3 ? io_in_3_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_4 = io_in_0_bits | _io_out_bits_T_1; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_5 = _io_out_bits_T_4 | _io_out_bits_T_2; // @[Mux.scala 27:73]
  assign io_in_0_ready = io_out_ready; // @[dut.scala 28:23]
  assign io_in_1_ready = grants_1 & io_out_ready; // @[dut.scala 28:23]
  assign io_in_2_ready = grants_2 & io_out_ready; // @[dut.scala 28:23]
  assign io_in_3_ready = grants_3 & io_out_ready; // @[dut.scala 28:23]
  assign io_out_valid = io_in_0_valid | io_in_1_valid & grants_1 | io_in_2_valid & grants_2 | io_in_3_valid & grants_3; // @[dut.scala 24:78]
  assign io_out_bits = _io_out_bits_T_5 | _io_out_bits_T_3; // @[Mux.scala 27:73]
  assign io_chosen = io_in_0_valid ? 2'h0 : _io_chosen_T_1; // @[Mux.scala 47:70]
endmodule
