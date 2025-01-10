`timescale 1ns / 1ps

module testbench;

  // Inputs
  reg clock;
  reg reset;
  reg [15:0] io_initial_allocation;
  reg io_alloc_pregs_0_valid;
  reg [3:0] io_alloc_pregs_0_bits;
  reg io_alloc_pregs_1_valid;
  reg [3:0] io_alloc_pregs_1_bits;
  reg io_reqs_0;
  reg io_reqs_1;
  reg io_dealloc_0_valid;
  reg [3:0] io_dealloc_0_bits;
  reg io_dealloc_1_valid;
  reg [3:0] io_dealloc_1_bits;
  reg [1:0] io_brupdate_b2_uop_br_tag;
  reg io_brupdate_b2_mispredict;
  reg io_rollback;

  // Outputs
  wire [15:0] io_dealloc_mask_golden, io_dealloc_mask;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_dealloc_mask_golden} === ({io_dealloc_mask_golden} ^ {io_dealloc_mask} ^ {io_dealloc_mask_golden}));

  // Instantiate the Unit Under Test (UUT)
  FreeList_mask uut (
    .clock(clock),
    .reset(reset),
    .io_initial_allocation(io_initial_allocation),
    .io_alloc_pregs_0_valid(io_alloc_pregs_0_valid),
    .io_alloc_pregs_0_bits(io_alloc_pregs_0_bits),
    .io_alloc_pregs_1_valid(io_alloc_pregs_1_valid),
    .io_alloc_pregs_1_bits(io_alloc_pregs_1_bits),
    .io_reqs_0(io_reqs_0),
    .io_reqs_1(io_reqs_1),
    .io_dealloc_0_valid(io_dealloc_0_valid),
    .io_dealloc_0_bits(io_dealloc_0_bits),
    .io_dealloc_1_valid(io_dealloc_1_valid),
    .io_dealloc_1_bits(io_dealloc_1_bits),
    .io_brupdate_b2_uop_br_tag(io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict(io_brupdate_b2_mispredict),
    .io_rollback(io_rollback),
    .io_dealloc_mask(io_dealloc_mask)
  );


  FreeList_mask_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_initial_allocation(io_initial_allocation),
    .io_alloc_pregs_0_valid(io_alloc_pregs_0_valid),
    .io_alloc_pregs_0_bits(io_alloc_pregs_0_bits),
    .io_alloc_pregs_1_valid(io_alloc_pregs_1_valid),
    .io_alloc_pregs_1_bits(io_alloc_pregs_1_bits),
    .io_reqs_0(io_reqs_0),
    .io_reqs_1(io_reqs_1),
    .io_dealloc_0_valid(io_dealloc_0_valid),
    .io_dealloc_0_bits(io_dealloc_0_bits),
    .io_dealloc_1_valid(io_dealloc_1_valid),
    .io_dealloc_1_bits(io_dealloc_1_bits),
    .io_brupdate_b2_uop_br_tag(io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict(io_brupdate_b2_mispredict),
    .io_rollback(io_rollback),
    .io_dealloc_mask(io_dealloc_mask_golden)
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
    reset = 0;
    io_initial_allocation = 0;
    io_alloc_pregs_0_valid = 0;
    io_alloc_pregs_0_bits = 0;
    io_alloc_pregs_1_valid = 0;
    io_alloc_pregs_1_bits = 0;
    io_reqs_0 = 0;
    io_reqs_1 = 0;
    io_dealloc_0_valid = 0;
    io_dealloc_0_bits = 0;
    io_dealloc_1_valid = 0;
    io_dealloc_1_bits = 0;
    io_brupdate_b2_uop_br_tag = 0;
    io_brupdate_b2_mispredict = 0;
    io_rollback = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, then set all inputs back to zero
    io_initial_allocation = 16'h0;
    #100;
    io_initial_allocation = 16'hFFFF;
    #100;
    io_initial_allocation = 16'h0;
    #100;

    // Test Case 1: System Initialization and Initial Allocation Mask Handling
    io_initial_allocation = 16'hAAAA;
    #100;
    io_initial_allocation = 16'h5555;
    #100;
    io_initial_allocation = 16'h0;
    #100;

    // Test Case 2: Register Deallocation Request Processing
    for (integer i = 0; i < 16; i = i + 1) begin
      io_dealloc_0_valid = 1;
      io_dealloc_0_bits = i;
      #10;
    end

    // Test Case 3: Multiple Deallocation Requests Handling
    for (integer i = 0; i < 16; i = i + 1) begin
      io_dealloc_0_valid = 1;
      io_dealloc_0_bits = i;
      io_dealloc_1_valid = 1;
      io_dealloc_1_bits = 15 - i;
      #10;
    end

    // Test Case 4: Branch Misprediction and Rollback Handling
    io_brupdate_b2_mispredict = 1;
    io_rollback = 1;
    #10;
    io_brupdate_b2_mispredict = 0;
    io_rollback = 0;
    #100;

    // Test Case 5: Allocation Requests and Freelist Update
    for (integer i = 0; i < 16; i = i + 1) begin
      io_alloc_pregs_0_valid = 1;
      io_alloc_pregs_0_bits = i;
      io_alloc_pregs_1_valid = 1;
      io_alloc_pregs_1_bits = 15 - i;
      #10;
      io_dealloc_0_valid = 1;
      io_dealloc_0_bits = i;
      io_dealloc_1_valid = 1;
      io_dealloc_1_bits = 15 - i;
      #10;
    end

    // Test Case 6: Synchronous Operation Verification
    reset = 1;
    #10;
    reset = 0;
    #100;

    // Final reset stimulus
    reset = 1;
    #10;
    reset = 0;

    // Additional stimuli to improve coverage
    // Test Case 7: Toggle all inputs to cover all possible transitions
    for (integer i = 0; i < 16; i = i + 1) begin
      io_alloc_pregs_0_valid = i[0];
      io_alloc_pregs_0_bits = i[3:0];
      io_alloc_pregs_1_valid = ~i[0];
      io_alloc_pregs_1_bits = ~i[3:0];
      io_reqs_0 = i[0];
      io_reqs_1 = ~i[0];
      io_dealloc_0_valid = i[1];
      io_dealloc_0_bits = i[3:0];
      io_dealloc_1_valid = ~i[1];
      io_dealloc_1_bits = ~i[3:0];
      io_brupdate_b2_uop_br_tag = i[1:0];
      io_brupdate_b2_mispredict = i[0];
      io_rollback = ~i[0];
      #10;
    end

    // Ensure enough coverage with random stimuli
    for (integer i = 0; i < 100; i = i + 1) begin
      io_alloc_pregs_0_valid = $random;
      io_alloc_pregs_0_bits = $random;
      io_alloc_pregs_1_valid = $random;
      io_alloc_pregs_1_bits = $random;
      io_dealloc_0_valid = $random;
      io_dealloc_0_bits = $random;
      io_dealloc_1_valid = $random;
      io_dealloc_1_bits = $random;
      io_brupdate_b2_uop_br_tag = $random;
      io_brupdate_b2_mispredict = $random;
      io_rollback = $random;
      #10;
    end
    
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
  end

endmodule