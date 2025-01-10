module Neuron(
  input         clock,
  input         reset,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  input  [15:0] io_in_5,
  input  [15:0] io_in_6,
  input  [15:0] io_in_7,
  input  [15:0] io_weights_0,
  input  [15:0] io_weights_1,
  input  [15:0] io_weights_2,
  input  [15:0] io_weights_3,
  input  [15:0] io_weights_4,
  input  [15:0] io_weights_5,
  input  [15:0] io_weights_6,
  input  [15:0] io_weights_7,
  output [15:0] io_out
);
  wire [31:0] _mac_T = $signed(io_in_0) * $signed(io_weights_0); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_1 = $signed(io_in_1) * $signed(io_weights_1); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_2 = $signed(io_in_2) * $signed(io_weights_2); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_3 = $signed(io_in_3) * $signed(io_weights_3); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_4 = $signed(io_in_4) * $signed(io_weights_4); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_5 = $signed(io_in_5) * $signed(io_weights_5); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_6 = $signed(io_in_6) * $signed(io_weights_6); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_7 = $signed(io_in_7) * $signed(io_weights_7); // @[Neuron.scala 12:77]
  wire [31:0] _mac_T_10 = $signed(_mac_T) + $signed(_mac_T_1); // @[Neuron.scala 12:89]
  wire [31:0] _mac_T_13 = $signed(_mac_T_10) + $signed(_mac_T_2); // @[Neuron.scala 12:89]
  wire [31:0] _mac_T_16 = $signed(_mac_T_13) + $signed(_mac_T_3); // @[Neuron.scala 12:89]
  wire [31:0] _mac_T_19 = $signed(_mac_T_16) + $signed(_mac_T_4); // @[Neuron.scala 12:89]
  wire [31:0] _mac_T_22 = $signed(_mac_T_19) + $signed(_mac_T_5); // @[Neuron.scala 12:89]
  wire [31:0] _mac_T_25 = $signed(_mac_T_22) + $signed(_mac_T_6); // @[Neuron.scala 12:89]
  wire [31:0] mac = $signed(_mac_T_25) + $signed(_mac_T_7); // @[Neuron.scala 12:89]
  wire [31:0] _io_out_T_1 = $signed(mac) <= 32'sh0 ? $signed(32'sh0) : $signed(mac); // @[Neuron.scala 20:46]
  wire [23:0] _GEN_0 = _io_out_T_1[31:8]; // @[Neuron.scala 13:10]
  assign io_out = _GEN_0[15:0]; // @[Neuron.scala 13:10]
endmodule
