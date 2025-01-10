`timescale 1ns / 1ps

module testbench;

  // parameter or localparam
  // (No parameters or localparams in the provided RTL)

  // Inputs
  reg clock;
  reg reset;
  reg io_a_0_valid;
  reg [7:0] io_a_0_bits;
  reg io_a_1_valid;
  reg [7:0] io_a_1_bits;
  reg io_a_2_valid;
  reg [7:0] io_a_2_bits;
  reg io_a_3_valid;
  reg [7:0] io_a_3_bits;
  reg io_a_4_valid;
  reg [7:0] io_a_4_bits;
  reg io_a_5_valid;
  reg [7:0] io_a_5_bits;
  reg io_z_ready;

  // Outputs or inout
  wire io_a_0_ready, io_a_0_ready_golden;
  wire io_a_1_ready, io_a_1_ready_golden;
  wire io_a_2_ready, io_a_2_ready_golden;
  wire io_a_3_ready, io_a_3_ready_golden;
  wire io_a_4_ready, io_a_4_ready_golden;
  wire io_a_5_ready, io_a_5_ready_golden;
  wire io_z_valid, io_z_valid_golden;
  wire [7:0] io_z_bits, io_z_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden} === ({io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden} ^ {io_a_0_ready, io_a_1_ready, io_a_2_ready, io_a_3_ready, io_a_4_ready, io_a_5_ready, io_z_valid, io_z_bits} ^ {io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden}));

  // Instantiate the Unit Under Test (UUT)
  DCReduce_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_a_0_ready(io_a_0_ready_golden),
    .io_a_0_valid(io_a_0_valid),
    .io_a_0_bits(io_a_0_bits),
    .io_a_1_ready(io_a_1_ready_golden),
    .io_a_1_valid(io_a_1_valid),
    .io_a_1_bits(io_a_1_bits),
    .io_a_2_ready(io_a_2_ready_golden),
    .io_a_2_valid(io_a_2_valid),
    .io_a_2_bits(io_a_2_bits),
    .io_a_3_ready(io_a_3_ready_golden),
    .io_a_3_valid(io_a_3_valid),
    .io_a_3_bits(io_a_3_bits),
    .io_a_4_ready(io_a_4_ready_golden),
    .io_a_4_valid(io_a_4_valid),
    .io_a_4_bits(io_a_4_bits),
    .io_a_5_ready(io_a_5_ready_golden),
    .io_a_5_valid(io_a_5_valid),
    .io_a_5_bits(io_a_5_bits),
    .io_z_ready(io_z_ready),
    .io_z_valid(io_z_valid_golden),
    .io_z_bits(io_z_bits_golden)
  );


  DCReduce uut (
    .clock(clock),
    .reset(reset),
    .io_a_0_ready(io_a_0_ready),
    .io_a_0_valid(io_a_0_valid),
    .io_a_0_bits(io_a_0_bits),
    .io_a_1_ready(io_a_1_ready),
    .io_a_1_valid(io_a_1_valid),
    .io_a_1_bits(io_a_1_bits),
    .io_a_2_ready(io_a_2_ready),
    .io_a_2_valid(io_a_2_valid),
    .io_a_2_bits(io_a_2_bits),
    .io_a_3_ready(io_a_3_ready),
    .io_a_3_valid(io_a_3_valid),
    .io_a_3_bits(io_a_3_bits),
    .io_a_4_ready(io_a_4_ready),
    .io_a_4_valid(io_a_4_valid),
    .io_a_4_bits(io_a_4_bits),
    .io_a_5_ready(io_a_5_ready),
    .io_a_5_valid(io_a_5_valid),
    .io_a_5_bits(io_a_5_bits),
    .io_z_ready(io_z_ready),
    .io_z_valid(io_z_valid),
    .io_z_bits(io_z_bits)
  );

  // clk toggle generate
  always #5 clock = ~clock;

  always @(posedge clock) begin
    total_tests = total_tests + 1; 
    if (match) begin
        $display("\033[1;32mtestcase is passed!!!\033[0m");
    end
    else begin
        $display("\033[1;31mtestcase is failed!!!\033[0m");
        failed_tests = failed_tests + 1; 
    end
end

  initial begin
    // Initialize Inputs
    clock = 0;
    reset = 1;
    io_a_0_valid = 0;
    io_a_0_bits = 8'h00;
    io_a_1_valid = 0;
    io_a_1_bits = 8'h00;
    io_a_2_valid = 0;
    io_a_2_bits = 8'h00;
    io_a_3_valid = 0;
    io_a_3_bits = 8'h00;
    io_a_4_valid = 0;
    io_a_4_bits = 8'h00;
    io_a_5_valid = 0;
    io_a_5_bits = 8'h00;
    io_z_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_a_0_valid = 1;
    io_a_1_valid = 1;
    io_a_2_valid = 1;
    io_a_3_valid = 1;
    io_a_4_valid = 1;
    io_a_5_valid = 1;
    io_z_ready = 1;
    #100;

    // Test Case 1: Multi-Channel Data Aggregation
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = $random;
      io_a_1_bits = $random;
      io_a_2_bits = $random;
      io_a_3_bits = $random;
      io_a_4_bits = $random;
      io_a_5_bits = $random;
      #10;
    end

    // Test Case 2: Bitwise XOR Reduction
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = i;
      io_a_1_bits = ~i;
      io_a_2_bits = i + 1;
      io_a_3_bits = ~i + 1;
      io_a_4_bits = i + 2;
      io_a_5_bits = ~i + 2;
      #10;
    end

    // Test Case 3: Data Validity and Readiness Handling
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_valid = i % 2;
      io_a_1_valid = (i + 1) % 2;
      io_a_2_valid = i % 2;
      io_a_3_valid = (i + 1) % 2;
      io_a_4_valid = i % 2;
      io_a_5_valid = (i + 1) % 2;
      #10;
    end

    // Test Case 4: Output Data Management
    for (integer i = 0; i < 100; i = i + 1) begin
      io_z_ready = i % 2;
      #10;
    end

    // Test Case 5: Internal Buffering and Signal Management
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = 8'hFF >> i;
      io_a_1_bits = 8'hAA << i;
      io_a_2_bits = 8'h55 >> i;
      io_a_3_bits = 8'h00 << i;
      io_a_4_bits = 8'hFF >> i;
      io_a_5_bits = 8'hAA << i;
      #10;
    end

    // Test Case 6: Synchronization with External Clock
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = 8'h0F;
      io_a_1_bits = 8'hF0;
      io_a_2_bits = 8'h0F;
      io_a_3_bits = 8'hF0;
      io_a_4_bits = 8'h0F;
      io_a_5_bits = 8'hF0;
      #10;
    end

    // Test Case 7: Reset Capability
    for (integer i = 0; i < 100; i = i + 1) begin
      if (i == 50) reset = 1;
      else reset = 0;
      #10;
    end

    // Final reset toggle
    reset = 1;
    #10;
    reset = 0;

    // Finish simulation

    // Test Case 8: Ensure all lines and conditions are covered
    // This includes edge cases for the ready and valid signals.
    // We will toggle the valid signals and ensure the ready signals are asserted accordingly.
    io_a_0_valid = 1;
    io_a_1_valid = 0;
    io_a_2_valid = 1;
    io_a_3_valid = 0;
    io_a_4_valid = 1;
    io_a_5_valid = 0;
    #10;
    io_a_0_valid = 0;
    io_a_1_valid = 1;
    io_a_2_valid = 0;
    io_a_3_valid = 1;
    io_a_4_valid = 0;
    io_a_5_valid = 1;
    #10;
    // Test Case 9: Toggle all input bits to ensure full coverage of toggle conditions
    io_a_0_bits = 8'hFF;
    io_a_1_bits = 8'h00;
    io_a_2_bits = 8'hFF;
    io_a_3_bits = 8'h00;
    io_a_4_bits = 8'hFF;
    io_a_5_bits = 8'h00;
    #10;
    io_a_0_bits = 8'h00;
    io_a_1_bits = 8'hFF;
    io_a_2_bits = 8'h00;
    io_a_3_bits = 8'hFF;
    io_a_4_bits = 8'h00;
    io_a_5_bits = 8'hFF;
    #10;
    // Test Case 10: Ensure all branches and conditions are covered
    // This includes toggling the reset signal to verify reset behavior
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test Case 11: Test edge cases for the XOR reduction logic
    // Use specific bit patterns to ensure all intermediate XOR results are covered
    io_a_0_bits = 8'hAA;
    io_a_1_bits = 8'h55;
    io_a_2_bits = 8'hAA;
    io_a_3_bits = 8'h55;
    io_a_4_bits = 8'hAA;
    io_a_5_bits = 8'h55;
    #10;
    io_a_0_bits = 8'h55;
    io_a_1_bits = 8'hAA;
    io_a_2_bits = 8'h55;
    io_a_3_bits = 8'hAA;
    io_a_4_bits = 8'h55;
    io_a_5_bits = 8'hAA;
    #10;
    // Test Case 12: Ensure all possible transitions between states are covered
    // This includes alternating ready and valid signals
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    // Test Case 13: Toggle signals to ensure complete toggle coverage
    for (integer j = 0; j < 8; j = j + 1) begin
      io_a_0_bits = 1 << j;
      io_a_1_bits = ~(1 << j);
      io_a_2_bits = 1 << j;
      io_a_3_bits = ~(1 << j);
      io_a_4_bits = 1 << j;
      io_a_5_bits = ~(1 << j);
      #10;
    end
    // Final reset to ensure all states transition back to initial state
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Additional stimuli to improve coverage
    // Test Case 14: Ensure all bits in 'hold' undergo transitions
    for (integer i = 0; i < 256; i = i + 1) begin
      io_a_0_bits = i;
      io_a_1_bits = ~i;
      io_a_2_bits = i ^ 8'hFF;
      io_a_3_bits = i & 8'hAA;
      io_a_4_bits = i | 8'h55;
      io_a_5_bits = i ^ 8'h55;
      #10;
    end
    // Test Case 15: Toggle all bits in 'hold' to cover all transitions
    io_a_0_bits = 8'hFF;
    io_a_1_bits = 8'h00;
    io_a_2_bits = 8'hFF;
    io_a_3_bits = 8'h00;
    io_a_4_bits = 8'hFF;
    io_a_5_bits = 8'h00;
    #10;
    io_a_0_bits = 8'h00;
    io_a_1_bits = 8'hFF;
    io_a_2_bits = 8'h00;
    io_a_3_bits = 8'hFF;
    io_a_4_bits = 8'h00;
    io_a_5_bits = 8'hFF;
    #10;
    // Test Case 16: Alternate valid signals to ensure complete condition coverage
    io_a_0_valid = 1;
    io_a_1_valid = 0;
    io_a_2_valid = 1;
    io_a_3_valid = 0;
    io_a_4_valid = 1;
    io_a_5_valid = 0;
    #10;
    io_a_0_valid = 0;
    io_a_1_valid = 1;
    io_a_2_valid = 0;
    io_a_3_valid = 1;
    io_a_4_valid = 0;
    io_a_5_valid = 1;
    #10;
    // Test Case 17: Ensure all possible transitions between states are covered
    // This includes alternating ready and valid signals
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    // Test Case 18: Ensure all conditions in ternary operators are covered
    io_a_0_bits = 8'hAA;
    io_a_1_bits = 8'h55;
    io_a_2_bits = 8'hAA;
    io_a_3_bits = 8'h55;
    io_a_4_bits = 8'hAA;
    io_a_5_bits = 8'h55;
    #10;
    io_a_0_bits = 8'h55;
    io_a_1_bits = 8'hAA;
    io_a_2_bits = 8'h55;
    io_a_3_bits = 8'hAA;
    io_a_4_bits = 8'h55;
    io_a_5_bits = 8'hAA;
    #10;
    // Test Case 19: Reset signal toggling to verify reset behavior
    reset = 1;
    #10;
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test Case 20: Randomize inputs to ensure all branches and signal transitions
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = $random;
      io_a_1_bits = $random;
      io_a_2_bits = $random;
      io_a_3_bits = $random;
      io_a_4_bits = $random;
      io_a_5_bits = $random;
      io_a_0_valid = $random % 2;
      io_a_1_valid = $random % 2;
      io_a_2_valid = $random % 2;
      io_a_3_valid = $random % 2;
      io_a_4_valid = $random % 2;
      io_a_5_valid = $random % 2;
      io_z_ready = $random % 2;
      #10;
    end

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
  end

endmodule