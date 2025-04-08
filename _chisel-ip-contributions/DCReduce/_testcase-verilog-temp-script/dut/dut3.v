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

  wire [5:0] aInt_ready;
  wire [5:0] aInt_valid;
  wire [7:0] aInt_bits [5:0];

  wire zInt_ready;
  reg zInt_valid;
  reg [7:0] zInt_bits;

  // DCInput Instances
  DCInput_UInt8 aInt_0 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_0_ready), .io_enq_valid(io_a_0_valid), .io_enq_bits(io_a_0_bits),
    .io_deq_ready(aInt_ready[0]), .io_deq_valid(aInt_valid[0]), .io_deq_bits(aInt_bits[0])
  );

  DCInput_UInt8 aInt_1 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_1_ready), .io_enq_valid(io_a_1_valid), .io_enq_bits(io_a_1_bits),
    .io_deq_ready(aInt_ready[1]), .io_deq_valid(aInt_valid[1]), .io_deq_bits(aInt_bits[1])
  );

  DCInput_UInt8 aInt_2 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_2_ready), .io_enq_valid(io_a_2_valid), .io_enq_bits(io_a_2_bits),
    .io_deq_ready(aInt_ready[2]), .io_deq_valid(aInt_valid[2]), .io_deq_bits(aInt_bits[2])
  );

  DCInput_UInt8 aInt_3 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_3_ready), .io_enq_valid(io_a_3_valid), .io_enq_bits(io_a_3_bits),
    .io_deq_ready(aInt_ready[3]), .io_deq_valid(aInt_valid[3]), .io_deq_bits(aInt_bits[3])
  );

  DCInput_UInt8 aInt_4 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_4_ready), .io_enq_valid(io_a_4_valid), .io_enq_bits(io_a_4_bits),
    .io_deq_ready(aInt_ready[4]), .io_deq_valid(aInt_valid[4]), .io_deq_bits(aInt_bits[4])
  );

  DCInput_UInt8 aInt_5 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_5_ready), .io_enq_valid(io_a_5_valid), .io_enq_bits(io_a_5_bits),
    .io_deq_ready(aInt_ready[5]), .io_deq_valid(aInt_valid[5]), .io_deq_bits(aInt_bits[5])
  );

  // DCOutput Instance
  DCOutput_UInt8 zDcout (
    .clock(clock), .reset(reset),
    .io_enq_ready(zInt_ready), .io_enq_valid(zInt_valid), .io_enq_bits(zInt_bits),
    .io_deq_ready(io_z_ready), .io_deq_valid(io_z_valid), .io_deq_bits(io_z_bits)
  );

  // All valid check
  wire all_valid = &aInt_valid[5:0];

  // Reduction operation
  always @(*) begin
    zInt_bits = aInt_bits[0];
    if (all_valid) begin
      zInt_bits = aInt_bits[0] + aInt_bits[1] + aInt_bits[2] + aInt_bits[3] +
                  aInt_bits[4] + aInt_bits[5];
    end
  end

  // Output control logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      zInt_valid <= 1'b0;
      aInt_ready <= 6'b0;
    end else begin
      aInt_ready <= {6{zInt_ready & all_valid}};
      zInt_valid <= all_valid & zInt_ready;
    end
  end

endmodule
