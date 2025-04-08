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

  // Internal wires for decoupled inputs
  wire [7-1:0] aInt_ready;
  wire [7-1:0] aInt_valid;
  wire [7*8-1:0] aInt_bits;

  // Instantiate DCInput modules for each input
  DCInput_UInt8 a0 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_0_ready),
    .io_enq_valid(io_a_0_valid),
    .io_enq_bits(io_a_0_bits),
    .io_deq_ready(aInt_ready[0]),
    .io_deq_valid(aInt_valid[0]),
    .io_deq_bits(aInt_bits[7:0])
  );

  DCInput_UInt8 a1 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_1_ready),
    .io_enq_valid(io_a_1_valid),
    .io_enq_bits(io_a_1_bits),
    .io_deq_ready(aInt_ready[1]),
    .io_deq_valid(aInt_valid[1]),
    .io_deq_bits(aInt_bits[15:8])
  );

  DCInput_UInt8 a2 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_2_ready),
    .io_enq_valid(io_a_2_valid),
    .io_enq_bits(io_a_2_bits),
    .io_deq_ready(aInt_ready[2]),
    .io_deq_valid(aInt_valid[2]),
    .io_deq_bits(aInt_bits[23:16])
  );

  DCInput_UInt8 a3 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_3_ready),
    .io_enq_valid(io_a_3_valid),
    .io_enq_bits(io_a_3_bits),
    .io_deq_ready(aInt_ready[3]),
    .io_deq_valid(aInt_valid[3]),
    .io_deq_bits(aInt_bits[31:24])
  );

  DCInput_UInt8 a4 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_4_ready),
    .io_enq_valid(io_a_4_valid),
    .io_enq_bits(io_a_4_bits),
    .io_deq_ready(aInt_ready[4]),
    .io_deq_valid(aInt_valid[4]),
    .io_deq_bits(aInt_bits[39:32])
  );

  DCInput_UInt8 a5 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_5_ready),
    .io_enq_valid(io_a_5_valid),
    .io_enq_bits(io_a_5_bits),
    .io_deq_ready(aInt_ready[5]),
    .io_deq_valid(aInt_valid[5]),
    .io_deq_bits(aInt_bits[47:40])
  );

  // Internal wire for reduced output
  reg [7:0] reduction_result;
  wire all_valid = &aInt_valid[5:0];

  // Perform reduction if all inputs are valid
  always @(posedge clock) begin
    if (reset) begin
      reduction_result <= 8'b0;
    end else if (all_valid && io_z_ready) begin
      reduction_result <= aInt_bits[7:0] + aInt_bits[15:8] + aInt_bits[23:16] +
                          aInt_bits[31:24] + aInt_bits[39:32] + aInt_bits[47:40];
    end
  end

  // Connect reduced result to output using DCOutput
  wire zInt_valid;
  wire [7:0] zInt_bits;

  DCOutput_UInt8 zDcout (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(aInt_ready[6]),
    .io_enq_valid(all_valid),
    .io_enq_bits(reduction_result),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );

  assign aInt_ready = {6{all_valid && io_z_ready}};

endmodule
