module MyRoutingArbiter_golden(
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
  wire [1:0] _channel_T = io_in_2_valid ? 2'h2 : 2'h3; // @[Mux.scala 47:70]
  wire [1:0] _channel_T_1 = io_in_1_valid ? 2'h1 : _channel_T; // @[Mux.scala 47:70]
  wire [1:0] channel = io_in_0_valid ? 2'h0 : _channel_T_1; // @[Mux.scala 47:70]
  wire [7:0] _GEN_1 = 2'h1 == channel ? io_in_1_bits : io_in_0_bits; // @[MyRoutingArbiter.scala 15:{15,15}]
  wire [7:0] _GEN_2 = 2'h2 == channel ? io_in_2_bits : _GEN_1; // @[MyRoutingArbiter.scala 15:{15,15}]
  assign io_in_0_ready = io_out_ready & channel == 2'h0; // @[MyRoutingArbiter.scala 17:27]
  assign io_in_1_ready = io_out_ready & channel == 2'h1; // @[MyRoutingArbiter.scala 17:27]
  assign io_in_2_ready = io_out_ready & channel == 2'h2; // @[MyRoutingArbiter.scala 17:27]
  assign io_in_3_ready = io_out_ready & channel == 2'h3; // @[MyRoutingArbiter.scala 17:27]
  assign io_out_valid = io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid; // @[MyRoutingArbiter.scala 11:47]
  assign io_out_bits = 2'h3 == channel ? io_in_3_bits : _GEN_2; // @[MyRoutingArbiter.scala 15:{15,15}]
endmodule
