`timescale 1ns / 1ps

module testbench;

  // Inputs
  reg clock;
  reg reset;
  reg io_in_0_valid;
  reg [7:0] io_in_0_bits;
  reg io_in_1_valid;
  reg [7:0] io_in_1_bits;
  reg io_in_2_valid;
  reg [7:0] io_in_2_bits;
  reg io_in_3_valid;
  reg [7:0] io_in_3_bits;
  reg io_out_ready;

  // Outputs
  wire io_in_0_ready_golden, io_in_0_ready;
  wire io_in_1_ready_golden, io_in_1_ready;
  wire io_in_2_ready_golden, io_in_2_ready;
  wire io_in_3_ready_golden, io_in_3_ready;
  wire io_out_valid_golden, io_out_valid;
  wire [7:0] io_out_bits_golden, io_out_bits;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden} === ({io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden} ^ {io_in_0_ready, io_in_1_ready, io_in_2_ready, io_in_3_ready, io_out_valid, io_out_bits} ^ {io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden}));

  // Instantiate the Unit Under Test (UUT)
  MyRoutingArbiter uut (
    .clock(clock),
    .reset(reset),
    .io_in_0_ready(io_in_0_ready),
    .io_in_0_valid(io_in_0_valid),
    .io_in_0_bits(io_in_0_bits),
    .io_in_1_ready(io_in_1_ready),
    .io_in_1_valid(io_in_1_valid),
    .io_in_1_bits(io_in_1_bits),
    .io_in_2_ready(io_in_2_ready),
    .io_in_2_valid(io_in_2_valid),
    .io_in_2_bits(io_in_2_bits),
    .io_in_3_ready(io_in_3_ready),
    .io_in_3_valid(io_in_3_valid),
    .io_in_3_bits(io_in_3_bits),
    .io_out_ready(io_out_ready),
    .io_out_valid(io_out_valid),
    .io_out_bits(io_out_bits)
  );

  MyRoutingArbiter_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_in_0_ready(io_in_0_ready_golden),
    .io_in_0_valid(io_in_0_valid),
    .io_in_0_bits(io_in_0_bits),
    .io_in_1_ready(io_in_1_ready_golden),
    .io_in_1_valid(io_in_1_valid),
    .io_in_1_bits(io_in_1_bits),
    .io_in_2_ready(io_in_2_ready_golden),
    .io_in_2_valid(io_in_2_valid),
    .io_in_2_bits(io_in_2_bits),
    .io_in_3_ready(io_in_3_ready_golden),
    .io_in_3_valid(io_in_3_valid),
    .io_in_3_bits(io_in_3_bits),
    .io_out_ready(io_out_ready),
    .io_out_valid(io_out_valid_golden),
    .io_out_bits(io_out_bits_golden)
  );

  // Clock toggle generation
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
    io_in_0_valid = 0;
    io_in_0_bits = 8'h00;
    io_in_1_valid = 0;
    io_in_1_bits = 8'h00;
    io_in_2_valid = 0;
    io_in_2_bits = 8'h00;
    io_in_3_valid = 0;
    io_in_3_bits = 8'h00;
    io_out_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_out_ready = 1;
    #100;
    io_in_0_valid = 1;
    io_in_0_bits = 8'hFF;
    io_in_1_valid = 1;
    io_in_1_bits = 8'hAA;
    io_in_2_valid = 1;
    io_in_2_bits = 8'h55;
    io_in_3_valid = 1;
    io_in_3_bits = 8'h00;
    #100;
    io_in_0_valid = 0;
    io_in_1_valid = 0;
    io_in_2_valid = 0;
    io_in_3_valid = 0;
    io_out_ready = 0;

    // Test Case 1: Single Active Input - Highest Priority
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_0_valid = 1;
      io_in_0_bits = 8'hAA;
      io_out_ready = 1;
      #10;
      io_in_0_valid = 0;
      io_out_ready = 0;
      #10;
    end

    // Test Case 2: Multiple Active Inputs - Priority Handling
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_1_valid = 1;
      io_in_1_bits = 8'hBB;
      io_in_3_valid = 1;
      io_in_3_bits = 8'hCC;
      io_out_ready = 1;
      #10;
      io_in_1_valid = 0;
      io_in_3_valid = 0;
      io_out_ready = 0;
      #10;
    end

    // Test Case 3: Output Not Ready
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_0_valid = 1;
      io_in_0_bits = 8'h11;
      io_in_1_valid = 1;
      io_in_1_bits = 8'h22;
      io_in_2_valid = 1;
      io_in_2_bits = 8'h33;
      io_in_3_valid = 1;
      io_in_3_bits = 8'h44;
      io_out_ready = 0;
      #10;
      io_in_0_valid = 0;
      io_in_1_valid = 0;
      io_in_2_valid = 0;
      io_in_3_valid = 0;
      #10;
    end

    // Test Case 4: Lowest Priority Input Selected
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_3_valid = 1;
      io_in_3_bits = 8'hDD;
      io_out_ready = 1;
      #10;
      io_in_3_valid = 0;
      io_out_ready = 0;
      #10;
    end

    // Additional Test Case 5: Test all bits transition
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_0_valid = 1;
      io_in_0_bits = 8'hFF;
      io_in_1_valid = 1;
      io_in_1_bits = 8'h00;
      io_in_2_valid = 1;
      io_in_2_bits = 8'hAA;
      io_in_3_valid = 1;
      io_in_3_bits = 8'h55;
      io_out_ready = 1;
      #10;
      io_in_0_valid = 0;
      io_in_1_valid = 0;
      io_in_2_valid = 0;
      io_in_3_valid = 0;
      io_out_ready = 0;
      #10;
    end

    // Additional Test Case 6: Random pattern test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in_0_valid = $random;
      io_in_0_bits = $random;
      io_in_1_valid = $random;
      io_in_1_bits = $random;
      io_in_2_valid = $random;
      io_in_2_bits = $random;
      io_in_3_valid = $random;
      io_in_3_bits = $random;
      io_out_ready = $random;
      #10;
    end

    // Simulate a reset event
    #100;
    reset = 1;
    #10;
    reset = 0;

    // End simulation
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
  end

endmodule