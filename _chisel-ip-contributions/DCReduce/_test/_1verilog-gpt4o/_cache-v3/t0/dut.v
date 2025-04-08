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

  // Internal wires for DCInput instances
  wire [5:0] aInt_ready;
  wire [5:0] aInt_valid;
  wire [7:0] aInt_bits [5:0];

  // Internal wire for reduction result
  wire [7:0] result;
  
  // Instantiate DCInput modules for each input
  DCInput_UInt8 a_0 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_0_ready),
    .io_enq_valid(io_a_0_valid),
    .io_enq_bits(io_a_0_bits),
    .io_deq_ready(aInt_ready[0]),
    .io_deq_valid(aInt_valid[0]),
    .io_deq_bits(aInt_bits[0])
  );

  DCInput_UInt8 a_1 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_1_ready),
    .io_enq_valid(io_a_1_valid),
    .io_enq_bits(io_a_1_bits),
    .io_deq_ready(aInt_ready[1]),
    .io_deq_valid(aInt_valid[1]),
    .io_deq_bits(aInt_bits[1])
  );

  DCInput_UInt8 a_2 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_2_ready),
    .io_enq_valid(io_a_2_valid),
    .io_enq_bits(io_a_2_bits),
    .io_deq_ready(aInt_ready[2]),
    .io_deq_valid(aInt_valid[2]),
    .io_deq_bits(aInt_bits[2])
  );

  DCInput_UInt8 a_3 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_3_ready),
    .io_enq_valid(io_a_3_valid),
    .io_enq_bits(io_a_3_bits),
    .io_deq_ready(aInt_ready[3]),
    .io_deq_valid(aInt_valid[3]),
    .io_deq_bits(aInt_bits[3])
  );

  DCInput_UInt8 a_4 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_4_ready),
    .io_enq_valid(io_a_4_valid),
    .io_enq_bits(io_a_4_bits),
    .io_deq_ready(aInt_ready[4]),
    .io_deq_valid(aInt_valid[4]),
    .io_deq_bits(aInt_bits[4])
  );

  DCInput_UInt8 a_5 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_5_ready),
    .io_enq_valid(io_a_5_valid),
    .io_enq_bits(io_a_5_bits),
    .io_deq_ready(aInt_ready[5]),
    .io_deq_valid(aInt_valid[5]),
    .io_deq_bits(aInt_bits[5])
  );

  // All inputs are valid when they are all ready and valid
  wire all_valid = &aInt_valid;

  // Perform the reduction operation (addition as an example)
  assign result = aInt_bits[0] + aInt_bits[1] + aInt_bits[2] + aInt_bits[3] + aInt_bits[4] + aInt_bits[5];

  // Output decoupling logic using DCOutput
  wire zInt_ready;
  wire zInt_valid;
  wire [7:0] zInt_bits;

  assign zInt_valid = all_valid;
  assign zInt_bits = result;

  // Ready signaling for inputs
  assign aInt_ready = {6{zInt_ready & all_valid}};

  DCOutput_UInt8 zDcout (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(zInt_ready),
    .io_enq_valid(zInt_valid),
    .io_enq_bits(zInt_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );

endmodule
