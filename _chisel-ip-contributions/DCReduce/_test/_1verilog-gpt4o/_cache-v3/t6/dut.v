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
  wire [5:0] valid_signals;
  wire [5:0] ready_signals;
  wire [7:0] a_wire [5:0];
  reg  [7:0] reduction_result;
  
  // Input Decoupling Instances
  DCInput_UInt8 a0 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_0_ready), .io_enq_valid(io_a_0_valid), .io_enq_bits(io_a_0_bits),
    .io_deq_ready(ready_signals[0]), .io_deq_valid(valid_signals[0]), .io_deq_bits(a_wire[0])
  );
  
  DCInput_UInt8 a1 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_1_ready), .io_enq_valid(io_a_1_valid), .io_enq_bits(io_a_1_bits),
    .io_deq_ready(ready_signals[1]), .io_deq_valid(valid_signals[1]), .io_deq_bits(a_wire[1])
  );
  
  DCInput_UInt8 a2 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_2_ready), .io_enq_valid(io_a_2_valid), .io_enq_bits(io_a_2_bits),
    .io_deq_ready(ready_signals[2]), .io_deq_valid(valid_signals[2]), .io_deq_bits(a_wire[2])
  );

  DCInput_UInt8 a3 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_3_ready), .io_enq_valid(io_a_3_valid), .io_enq_bits(io_a_3_bits),
    .io_deq_ready(ready_signals[3]), .io_deq_valid(valid_signals[3]), .io_deq_bits(a_wire[3])
  );

  DCInput_UInt8 a4 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_4_ready), .io_enq_valid(io_a_4_valid), .io_enq_bits(io_a_4_bits),
    .io_deq_ready(ready_signals[4]), .io_deq_valid(valid_signals[4]), .io_deq_bits(a_wire[4])
  );

  DCInput_UInt8 a5 (
    .clock(clock), .reset(reset),
    .io_enq_ready(io_a_5_ready), .io_enq_valid(io_a_5_valid), .io_enq_bits(io_a_5_bits),
    .io_deq_ready(ready_signals[5]), .io_deq_valid(valid_signals[5]), .io_deq_bits(a_wire[5])
  );

  // All valid signals combined
  wire all_valid = &valid_signals;

  // Reduction operation
  wire [7:0] reduced_sum = a_wire[0] + a_wire[1] + a_wire[2] + a_wire[3] + a_wire[4] + a_wire[5];
  
  // Output Decoupling Instance
  DCOutput_UInt8 zDcout (
    .clock(clock), .reset(reset),
    .io_enq_ready(), .io_enq_valid(reduction_result_valid), .io_enq_bits(reduction_result),
    .io_deq_ready(io_z_ready), .io_deq_valid(io_z_valid), .io_deq_bits(io_z_bits)
  );

  // Logic for managing ready signals and output
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      reduction_result <= 8'b0;
      reduction_result_valid <= 1'b0;
    end else if (all_valid && io_z_ready) begin
      reduction_result <= reduced_sum;
      reduction_result_valid <= 1'b1;
    end else begin
      reduction_result_valid <= 1'b0;
    end
  end

  assign ready_signals = all_valid && io_z_ready ? 6'b111111 : 6'b0;
endmodule
