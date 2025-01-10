`timescale 1ns / 1ps

module testbench;

  //parameter or localparam 

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

  // Outputs or inout
  wire io_in_0_ready, io_in_0_ready_golden;
  wire io_in_1_ready, io_in_1_ready_golden;
  wire io_in_2_ready, io_in_2_ready_golden;
  wire io_in_3_ready, io_in_3_ready_golden;
  wire io_out_valid, io_out_valid_golden;
  wire [7:0] io_out_bits, io_out_bits_golden;
  wire [1:0] io_chosen, io_chosen_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden, io_chosen_golden} === ({io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden, io_chosen_golden} ^ {io_in_0_ready, io_in_1_ready, io_in_2_ready, io_in_3_ready, io_out_valid, io_out_bits, io_chosen} ^ {io_in_0_ready_golden, io_in_1_ready_golden, io_in_2_ready_golden, io_in_3_ready_golden, io_out_valid_golden, io_out_bits_golden, io_chosen_golden}));

  // Instantiate the Unit Under Test (UUT)
  Arbiter4_UInt8_golden golden_model (
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
    .io_out_bits(io_out_bits_golden),
    .io_chosen(io_chosen_golden)
  );

    Arbiter4_UInt8 uut (
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
    .io_out_bits(io_out_bits),
    .io_chosen(io_chosen)
  );

  //clk toggle generate
  always #5 clock = ~clock;

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
    io_in_0_valid = 0;
    io_in_0_bits = 8'h0;
    io_in_1_valid = 0;
    io_in_1_bits = 8'h0;
    io_in_2_valid = 0;
    io_in_2_bits = 8'h0;
    io_in_3_valid = 0;
    io_in_3_bits = 8'h0;
    io_out_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_in_0_valid = 0;
    io_in_1_valid = 0;
    io_in_2_valid = 0;
    io_in_3_valid = 0;
    io_out_ready = 1;
    #100;
    io_in_0_valid = 1;
    io_in_1_valid = 1;
    io_in_2_valid = 1;
    io_in_3_valid = 1;
    io_in_0_bits = 8'hFF;
    io_in_1_bits = 8'hFE;
    io_in_2_bits = 8'hFD;
    io_in_3_bits = 8'hFC;
    #100;
    io_in_0_valid = 0;
    io_in_1_valid = 0;
    io_in_2_valid = 0;
    io_in_3_valid = 0;
    #100;

    // Test Case 1: Priority-Based Data Arbitration
    io_out_ready = 1;
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = 1;
      io_in_1_valid = 1;
      io_in_2_valid = 1;
      io_in_3_valid = 1;
      io_in_0_bits = i;
      io_in_1_bits = i + 1;
      io_in_2_bits = i + 2;
      io_in_3_bits = i + 3;
      #10;
    end

    // Test Case 2: Valid Data Forwarding with Lower Priority Input
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = 0;
      io_in_1_valid = 0;
      io_in_2_valid = 1;
      io_in_3_valid = 0;
      io_in_2_bits = i;
      #10;
    end

    // Test Case 3: Output Not Ready
    io_out_ready = 0;
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = 1;
      io_in_1_valid = 0;
      io_in_2_valid = 0;
      io_in_3_valid = 0;
      io_in_0_bits = i;
      #10;
    end

    // Test Case 4: Dynamic Input Ready Signaling
    io_out_ready = 1;
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = (i % 4 == 0);
      io_in_1_valid = (i % 4 == 1);
      io_in_2_valid = (i % 4 == 2);
      io_in_3_valid = (i % 4 == 3);
      io_in_0_bits = i;
      io_in_1_bits = i + 1;
      io_in_2_bits = i + 2;
      io_in_3_bits = i + 3;
      #10;
    end

    // Test Case 5: All Inputs Invalid
    io_out_ready = 1;
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = 0;
      io_in_1_valid = 0;
      io_in_2_valid = 0;
      io_in_3_valid = 0;
      #10;
    end

    // Test Case 6: Chosen Input Indication
    io_out_ready = 1;
    for(integer i=0; i<100; i++) begin
      io_in_0_valid = (i % 4 == 0);
      io_in_1_valid = (i % 4 == 1);
      io_in_2_valid = (i % 4 == 2);
      io_in_3_valid = (i % 4 == 3);
      io_in_0_bits = i;
      io_in_1_bits = i + 1;
      io_in_2_bits = i + 2;
      io_in_3_bits = i + 3;
      #10;
    end

    // Reset stimulus
    reset = 1;
    #10;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
  end

endmodule