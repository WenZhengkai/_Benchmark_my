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

  // Internal wires for holding intermediate connections
  wire [7:0] aInt_bits[5:0];
  wire       aInt_valid[5:0];
  wire       aInt_ready[5:0];

  // Instantiate 6 DCInput_UInt8 modules for each input
  genvar i;
  generate
    for (i = 0; i < 6; i = i + 1) begin: GenInputs
      DCInput_UInt8 aInt(
        .clock(clock),
        .reset(reset),
        .io_enq_ready(io_a_0_ready + i),
        .io_enq_valid(io_a_0_valid + i),
        .io_enq_bits(io_a_0_bits + i),
        .io_deq_ready(aInt_ready[i]),
        .io_deq_valid(aInt_valid[i]),
        .io_deq_bits(aInt_bits[i])
      );
    end
  endgenerate

  // Reduction Operation: Assume summing all the inputs for demonstration
  wire [7:0] sum = aInt_bits[0] + aInt_bits[1] + aInt_bits[2] +
                   aInt_bits[3] + aInt_bits[4] + aInt_bits[5];

  // Determine if all inputs are valid
  wire all_valid = aInt_valid[0] & aInt_valid[1] & aInt_valid[2] &
                   aInt_valid[3] & aInt_valid[4] & aInt_valid[5];

  // Internal connection for DCOutput
  wire [7:0] zInt_bits;
  wire       zInt_valid;
  wire       zInt_ready;

  // Instantiate DCOutput_UInt8 module for the output
  DCOutput_UInt8 zDcout(
    .clock(clock),
    .reset(reset),
    .io_enq_ready(zInt_ready),
    .io_enq_valid(zInt_valid),
    .io_enq_bits(zInt_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );

  // Output logic
  assign zInt_bits = sum;
  assign zInt_valid = all_valid;
  
  // Ready signals when all valid and output ready
  assign aInt_ready[0] = all_valid & zInt_ready;
  assign aInt_ready[1] = all_valid & zInt_ready;
  assign aInt_ready[2] = all_valid & zInt_ready;
  assign aInt_ready[3] = all_valid & zInt_ready;
  assign aInt_ready[4] = all_valid & zInt_ready;
  assign aInt_ready[5] = all_valid & zInt_ready;

endmodule
