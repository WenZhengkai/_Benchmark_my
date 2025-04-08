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
  wire [1:0] _selectedChannel_T = io_in_2_valid ? 2'h2 : 2'h3; // @[Mux.scala 47:70]
  wire [1:0] _selectedChannel_T_1 = io_in_1_valid ? 2'h1 : _selectedChannel_T; // @[Mux.scala 47:70]
  wire [1:0] selectedChannel = io_in_0_valid ? 2'h0 : _selectedChannel_T_1; // @[Mux.scala 47:70]
  wire  _io_out_bits_T = selectedChannel == 2'h0; // @[dut.scala 33:24]
  wire  _io_out_bits_T_1 = selectedChannel == 2'h1; // @[dut.scala 33:24]
  wire  _io_out_bits_T_2 = selectedChannel == 2'h2; // @[dut.scala 33:24]
  wire  _io_out_bits_T_3 = selectedChannel == 2'h3; // @[dut.scala 33:24]
  wire [7:0] _io_out_bits_T_4 = _io_out_bits_T ? io_in_0_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_5 = _io_out_bits_T_1 ? io_in_1_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_6 = _io_out_bits_T_2 ? io_in_2_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_7 = _io_out_bits_T_3 ? io_in_3_bits : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_8 = _io_out_bits_T_4 | _io_out_bits_T_5; // @[Mux.scala 27:73]
  wire [7:0] _io_out_bits_T_9 = _io_out_bits_T_8 | _io_out_bits_T_6; // @[Mux.scala 27:73]
  assign io_in_0_ready = _io_out_bits_T & io_out_ready; // @[dut.scala 40:45]
  assign io_in_1_ready = _io_out_bits_T_1 & io_out_ready; // @[dut.scala 40:45]
  assign io_in_2_ready = _io_out_bits_T_2 & io_out_ready; // @[dut.scala 40:45]
  assign io_in_3_ready = _io_out_bits_T_3 & io_out_ready; // @[dut.scala 40:45]
  assign io_out_valid = io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid; // @[dut.scala 20:47]
  assign io_out_bits = _io_out_bits_T_9 | _io_out_bits_T_7; // @[Mux.scala 27:73]
endmodule
