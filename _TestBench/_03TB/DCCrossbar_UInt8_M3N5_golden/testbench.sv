`timescale 1ns / 1ps

module testbench;

  // parameter or localparam
  localparam WIDTH = 8;

  // Inputs
  reg clock;
  reg reset;
  reg [2:0] io_sel_0;
  reg [2:0] io_sel_1;
  reg [2:0] io_sel_2;
  reg io_c_0_valid;
  reg [WIDTH-1:0] io_c_0_bits;
  reg io_c_1_valid;
  reg [WIDTH-1:0] io_c_1_bits;
  reg io_c_2_valid;
  reg [WIDTH-1:0] io_c_2_bits;
  reg io_p_0_ready;
  reg io_p_1_ready;
  reg io_p_2_ready;
  reg io_p_3_ready;
  reg io_p_4_ready;

  // Outputs or inout
  wire io_c_0_ready, io_c_0_ready_golden;
  wire io_c_1_ready, io_c_1_ready_golden;
  wire io_c_2_ready, io_c_2_ready_golden;
  wire io_p_0_valid, io_p_0_valid_golden;
  wire [WIDTH-1:0] io_p_0_bits, io_p_0_bits_golden;
  wire io_p_1_valid, io_p_1_valid_golden;
  wire [WIDTH-1:0] io_p_1_bits, io_p_1_bits_golden;
  wire io_p_2_valid, io_p_2_valid_golden;
  wire [WIDTH-1:0] io_p_2_bits, io_p_2_bits_golden;
  wire io_p_3_valid, io_p_3_valid_golden;
  wire [WIDTH-1:0] io_p_3_bits, io_p_3_bits_golden;
  wire io_p_4_valid, io_p_4_valid_golden;
  wire [WIDTH-1:0] io_p_4_bits, io_p_4_bits_golden;


integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_c_0_ready_golden, io_c_1_ready_golden, io_c_2_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} === ({io_c_0_ready_golden, io_c_1_ready_golden, io_c_2_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} ^ {io_c_0_ready, io_c_1_ready, io_c_2_ready, io_p_0_valid, io_p_0_bits, io_p_1_valid, io_p_1_bits, io_p_2_valid, io_p_2_bits, io_p_3_valid, io_p_3_bits, io_p_4_valid, io_p_4_bits} ^ {io_c_0_ready_golden, io_c_1_ready_golden, io_c_2_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden}));

  // Instantiate the Unit Under Test (UUT)
  DCCrossbar_UInt8_M3N5_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_sel_2(io_sel_2),
    .io_c_0_ready(io_c_0_ready_golden),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready_golden),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_c_2_ready(io_c_2_ready_golden),
    .io_c_2_valid(io_c_2_valid),
    .io_c_2_bits(io_c_2_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid_golden),
    .io_p_0_bits(io_p_0_bits_golden),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid_golden),
    .io_p_1_bits(io_p_1_bits_golden),
    .io_p_2_ready(io_p_2_ready),
    .io_p_2_valid(io_p_2_valid_golden),
    .io_p_2_bits(io_p_2_bits_golden),
    .io_p_3_ready(io_p_3_ready),
    .io_p_3_valid(io_p_3_valid_golden),
    .io_p_3_bits(io_p_3_bits_golden),
    .io_p_4_ready(io_p_4_ready),
    .io_p_4_valid(io_p_4_valid_golden),
    .io_p_4_bits(io_p_4_bits_golden)
  );

  DCCrossbar_UInt8_M3N5 uut (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_sel_2(io_sel_2),
    .io_c_0_ready(io_c_0_ready),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_c_2_ready(io_c_2_ready),
    .io_c_2_valid(io_c_2_valid),
    .io_c_2_bits(io_c_2_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid),
    .io_p_0_bits(io_p_0_bits),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid),
    .io_p_1_bits(io_p_1_bits),
    .io_p_2_ready(io_p_2_ready),
    .io_p_2_valid(io_p_2_valid),
    .io_p_2_bits(io_p_2_bits),
    .io_p_3_ready(io_p_3_ready),
    .io_p_3_valid(io_p_3_valid),
    .io_p_3_bits(io_p_3_bits),
    .io_p_4_ready(io_p_4_ready),
    .io_p_4_valid(io_p_4_valid),
    .io_p_4_bits(io_p_4_bits)
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
    io_sel_0 = 0;
    io_sel_1 = 0;
    io_sel_2 = 0;
    io_c_0_valid = 0;
    io_c_0_bits = 0;
    io_c_1_valid = 0;
    io_c_1_bits = 0;
    io_c_2_valid = 0;
    io_c_2_bits = 0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_sel_0 = 3'b000;
    io_sel_1 = 3'b001;
    io_sel_2 = 3'b010;
    #100;
    io_sel_0 = 3'b111;
    io_sel_1 = 3'b110;
    io_sel_2 = 3'b101;
    #100;
    io_sel_0 = 3'b000;
    io_sel_1 = 3'b001;
    io_sel_2 = 3'b010;
    #100;

    // Test Case 1: Basic Data Routing
    for (integer i = 0; i < 100; i = i + 1) begin
      io_sel_0 = $random % 5;
      io_sel_1 = $random % 5;
      io_sel_2 = $random % 5;
      io_c_0_valid = 1;
      io_c_1_valid = 1;
      io_c_2_valid = 1;
      io_c_0_bits = $random;
      io_c_1_bits = $random;
      io_c_2_bits = $random;
      io_p_0_ready = 1;
      io_p_1_ready = 1;
      io_p_2_ready = 1;
      io_p_3_ready = 1;
      io_p_4_ready = 1;
      #10;
    end

    // Test Case 2: Arbitration and Collision Handling
    for (integer j = 0; j < 100; j = j + 1) begin
      io_sel_0 = 3'b000;
      io_sel_1 = 3'b000;
      io_sel_2 = 3'b000;
      io_c_0_valid = 1;
      io_c_1_valid = 1;
      io_c_2_valid = 1;
      io_c_0_bits = j;
      io_c_1_bits = j + 1;
      io_c_2_bits = j + 2;
      io_p_0_ready = 1;
      io_p_1_ready = 1;
      io_p_2_ready = 1;
      io_p_3_ready = 1;
      io_p_4_ready = 1;
      #10;
    end

    // Test Case 3: Flow Control Mechanism
    for (integer k = 0; k < 100; k = k + 1) begin
      io_sel_0 = $random % 5;
      io_sel_1 = $random % 5;
      io_sel_2 = $random % 5;
      io_c_0_valid = 1;
      io_c_1_valid = 1;
      io_c_2_valid = 1;
      io_c_0_bits = $random;
      io_c_1_bits = $random;
      io_c_2_bits = $random;
      io_p_0_ready = k % 2;
      io_p_1_ready = (k + 1) % 2;
      io_p_2_ready = k % 2;
      io_p_3_ready = (k + 1) % 2;
      io_p_4_ready = k % 2;
      #10;
    end

    // Test Case 4: System Reset and Initialization
    for (integer l = 0; l < 100; l = l + 1) begin
      reset = 1;
      #10;
      reset = 0;
      io_sel_0 = $random % 5;
      io_sel_1 = $random % 5;
      io_sel_2 = $random % 5;
      io_c_0_valid = 1;
      io_c_1_valid = 1;
      io_c_2_valid = 1;
      io_c_0_bits = $random;
      io_c_1_bits = $random;
      io_c_2_bits = $random;
      io_p_0_ready = 1;
      io_p_1_ready = 1;
      io_p_2_ready = 1;
      io_p_3_ready = 1;
      io_p_4_ready = 1;
      #10;
    end

    // Test Case 5: Scalability and Modular Design Verification
    for (integer m = 0; m < 100; m = m + 1) begin
      io_sel_0 = m % 5;
      io_sel_1 = (m + 1) % 5;
      io_sel_2 = (m + 2) % 5;
      io_c_0_valid = 1;
      io_c_1_valid = 1;
      io_c_2_valid = 1;
      io_c_0_bits = m;
      io_c_1_bits = m + 1;
      io_c_2_bits = m + 2;
      io_p_0_ready = 1;
      io_p_1_ready = 1;
      io_p_2_ready = 1;
      io_p_3_ready = 1;
      io_p_4_ready = 1;
      #10;
    end

    // Final reset toggle test
    reset = 1;
    #10;
    reset = 0;

// Additional stimuli for improving coverage
  // Initialize Inputs
  clock = 0;
  reset = 1;
  io_sel_0 = 0;
  io_sel_1 = 0;
  io_sel_2 = 0;
  io_c_0_valid = 0;
  io_c_0_bits = 0;
  io_c_1_valid = 0;
  io_c_1_bits = 0;
  io_c_2_valid = 0;
  io_c_2_bits = 0;
  io_p_0_ready = 0;
  io_p_1_ready = 0;
  io_p_2_ready = 0;
  io_p_3_ready = 0;
  io_p_4_ready = 0;
  // Wait 100 ns for global reset to finish
  #100;
  reset = 0;
  // Additional Test Case 1: Toggle all select lines and check all paths
  for (integer n = 0; n < 5; n = n + 1) begin
    io_sel_0 = n;
    io_sel_1 = (n + 1) % 5;
    io_sel_2 = (n + 2) % 5;
    io_c_0_valid = 1;
    io_c_1_valid = 1;
    io_c_2_valid = 1;
    io_c_0_bits = $random;
    io_c_1_bits = $random;
    io_c_2_bits = $random;
    io_p_0_ready = (n % 2) == 0;
    io_p_1_ready = ((n + 1) % 2) == 0;
    io_p_2_ready = (n % 2) == 0;
    io_p_3_ready = ((n + 1) % 2) == 0;
    io_p_4_ready = (n % 2) == 0;
    #10;
  end
  // Additional Test Case 2: Ensure all ready signals toggle
  for (integer p = 0; p < 10; p = p + 1) begin
    io_sel_0 = $random % 5;
    io_sel_1 = $random % 5;
    io_sel_2 = $random % 5;
    io_c_0_valid = 1;
    io_c_1_valid = 1;
    io_c_2_valid = 1;
    io_c_0_bits = $random;
    io_c_1_bits = $random;
    io_c_2_bits = $random;
    io_p_0_ready = p % 2;
    io_p_1_ready = (p + 1) % 2;
    io_p_2_ready = p % 2;
    io_p_3_ready = (p + 1) % 2;
    io_p_4_ready = p % 2;
    #10;
  end
  // Additional Test Case 3: Test all valid combinations
  io_c_0_valid = 1;
  io_c_1_valid = 0;
  io_c_2_valid = 1;
  io_c_0_bits = 8'hFF;
  io_c_1_bits = 8'hAA;
  io_c_2_bits = 8'h55;
  io_p_0_ready = 1;
  io_p_1_ready = 0;
  io_p_2_ready = 0;
  io_p_3_ready = 1;
  io_p_4_ready = 0;
  #10;
  io_c_0_valid = 0;
  io_c_1_valid = 1;
  io_c_2_valid = 0;
  io_c_0_bits = 8'h00;
  io_c_1_bits = 8'h11;
  io_c_2_bits = 8'h22;
  io_p_0_ready = 0;
  io_p_1_ready = 1;
  io_p_2_ready = 1;
  io_p_3_ready = 0;
  io_p_4_ready = 1;
  #10;
  // Additional Test Case 4: Exhaustively test all select and ready combinations
  for (integer q = 0; q < 8; q = q + 1) begin
    io_sel_0 = q % 5;
    io_sel_1 = (q + 1) % 5;
    io_sel_2 = (q + 2) % 5;
    io_c_0_valid = q % 2;
    io_c_1_valid = (q + 1) % 2;
    io_c_2_valid = q % 2;
    io_c_0_bits = q;
    io_c_1_bits = q + 1;
    io_c_2_bits = q + 2;
    io_p_0_ready = (q + 1) % 2;
    io_p_1_ready = q % 2;
    io_p_2_ready = (q + 1) % 2;
    io_p_3_ready = q % 2;
    io_p_4_ready = (q + 1) % 2;
    #10;
  end
  // Final reset toggle test
  reset = 1;
  #10;
  reset = 0;

  $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
$finish;

  end

endmodule