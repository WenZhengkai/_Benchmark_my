module dut(
  input        clock,
  input        reset,
  output       io_a_0_ready,
  input        io_a_0_valid,
  input  [7:0] io_a_0_bits,
  output       io_a_1_ready,
  input        io_a_1_valid,
  input  [7:0] io_a_1_bits,
  output       io_a_2_ready,
  input        io_a_2_valid,
  input  [7:0] io_a_2_bits,
  output       io_a_3_ready,
  input        io_a_3_valid,
  input  [7:0] io_a_3_bits,
  output       io_a_4_ready,
  input        io_a_4_valid,
  input  [7:0] io_a_4_bits,
  output       io_a_5_ready,
  input        io_a_5_valid,
  input  [7:0] io_a_5_bits,
  input        io_z_ready,
  output       io_z_valid,
  output [7:0] io_z_bits
);

  // Internal signals for DCInput instances
  wire a0_valid, a1_valid, a2_valid, a3_valid, a4_valid, a5_valid;
  wire [7:0] a0_bits, a1_bits, a2_bits, a3_bits, a4_bits, a5_bits;
  
  // Instantiate DCInput for each input
  DCInput_UInt8 a0 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_0_ready),
    .io_enq_valid(io_a_0_valid),
    .io_enq_bits(io_a_0_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a0_valid),
    .io_deq_bits(a0_bits)
  );
  
  DCInput_UInt8 a1 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_1_ready),
    .io_enq_valid(io_a_1_valid),
    .io_enq_bits(io_a_1_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a1_valid),
    .io_deq_bits(a1_bits)
  );

  DCInput_UInt8 a2 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_2_ready),
    .io_enq_valid(io_a_2_valid),
    .io_enq_bits(io_a_2_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a2_valid),
    .io_deq_bits(a2_bits)
  );

  DCInput_UInt8 a3 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_3_ready),
    .io_enq_valid(io_a_3_valid),
    .io_enq_bits(io_a_3_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a3_valid),
    .io_deq_bits(a3_bits)
  );

  DCInput_UInt8 a4 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_4_ready),
    .io_enq_valid(io_a_4_valid),
    .io_enq_bits(io_a_4_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a4_valid),
    .io_deq_bits(a4_bits)
  );

  DCInput_UInt8 a5 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_5_ready),
    .io_enq_valid(io_a_5_valid),
    .io_enq_bits(io_a_5_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(a5_valid),
    .io_deq_bits(a5_bits)
  );
  
  // Combine all valid signals
  wire all_valid = a0_valid & a1_valid & a2_valid & a3_valid & a4_valid & a5_valid;

  // Reduction operation: bitwise AND in this case
  wire [7:0] reduction_result = a0_bits & a1_bits & a2_bits & a3_bits & a4_bits & a5_bits;

  // Internal wires for the reduction result and valid signal
  wire z_int_valid;
  wire [7:0] z_int_bits;

  assign z_int_valid = all_valid & io_z_ready;
  assign z_int_bits = reduction_result;

  // Instantiate DCOutput for output
  DCOutput_UInt8 z_out (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(z_int_valid),
    .io_enq_valid(z_int_valid),
    .io_enq_bits(z_int_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );

endmodule
