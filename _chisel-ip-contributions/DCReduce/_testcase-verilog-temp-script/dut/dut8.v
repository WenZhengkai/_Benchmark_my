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

  // Internal signals
  wire [7:0] aInt_bits [5:0];
  wire aInt_valid [5:0];
  wire aInt_ready [5:0];
  
  reg [7:0] reduction_result;
  reg result_valid;

  // Instances of DCInput_UInt8 for each input
  DCInput_UInt8 a0 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_0_ready),
    .io_enq_valid(io_a_0_valid),
    .io_enq_bits(io_a_0_bits),
    .io_deq_ready(aInt_ready[0]),
    .io_deq_valid(aInt_valid[0]),
    .io_deq_bits(aInt_bits[0])
  );
  
  DCInput_UInt8 a1 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_1_ready),
    .io_enq_valid(io_a_1_valid),
    .io_enq_bits(io_a_1_bits),
    .io_deq_ready(aInt_ready[1]),
    .io_deq_valid(aInt_valid[1]),
    .io_deq_bits(aInt_bits[1])
  );

  DCInput_UInt8 a2 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_2_ready),
    .io_enq_valid(io_a_2_valid),
    .io_enq_bits(io_a_2_bits),
    .io_deq_ready(aInt_ready[2]),
    .io_deq_valid(aInt_valid[2]),
    .io_deq_bits(aInt_bits[2])
  );

  DCInput_UInt8 a3 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_3_ready),
    .io_enq_valid(io_a_3_valid),
    .io_enq_bits(io_a_3_bits),
    .io_deq_ready(aInt_ready[3]),
    .io_deq_valid(aInt_valid[3]),
    .io_deq_bits(aInt_bits[3])
  );

  DCInput_UInt8 a4 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_4_ready),
    .io_enq_valid(io_a_4_valid),
    .io_enq_bits(io_a_4_bits),
    .io_deq_ready(aInt_ready[4]),
    .io_deq_valid(aInt_valid[4]),
    .io_deq_bits(aInt_bits[4])
  );

  DCInput_UInt8 a5 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_5_ready),
    .io_enq_valid(io_a_5_valid),
    .io_enq_bits(io_a_5_bits),
    .io_deq_ready(aInt_ready[5]),
    .io_deq_valid(aInt_valid[5]),
    .io_deq_bits(aInt_bits[5])
  );

  // Combine inputs using addition as the reduction operation.
  // You can modify this section to change the reduction operation.
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      reduction_result <= 8'h00;
      result_valid <= 1'b0;
    end else if (&aInt_valid) begin
      reduction_result <= aInt_bits[0] + aInt_bits[1] + aInt_bits[2] + 
                          aInt_bits[3] + aInt_bits[4] + aInt_bits[5];
      result_valid <= 1'b1;
    end else begin
      result_valid <= 1'b0;
    end
  end

  // Output readiness and validity
  assign io_z_valid = result_valid;
  assign io_z_bits = reduction_result;

  generate
    genvar i;
    for (i = 0; i < 6; i = i + 1) begin : ready_ctrl
      assign aInt_ready[i] = result_valid & io_z_ready;
    end
  endgenerate

  // Instance of DCOutput_UInt8
  DCOutput_UInt8 zDcout (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_z_ready),
    .io_enq_valid(io_z_valid),
    .io_enq_bits(io_z_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );
  
endmodule
