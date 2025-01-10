`timescale 1ns / 1ps

module testbench;

//parameter or localparam

// Inputs
reg clock;
reg reset;
reg [63:0] io_in;
reg io_encode;

// Outputs or inout
wire [63:0] io_out_golden, io_out;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));

// Instantiate the Unit Under Test (UUT)
GrayCoder uut (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out),
  .io_encode(io_encode)
);

GrayCoder_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out_golden),
  .io_encode(io_encode)
);

//clk toggle generate
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
    io_in = 64'h0;
    io_encode = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_in = 64'h0;
    #100;
    io_in = 64'hFFFFFFFFFFFFFFFF;
    #100;
    io_in = 64'h0;
    #100;

    // Test Case 1: Basic Encoding Operation
    io_in = 64'hAAAA_AAAA_AAAA_AAAA;
    io_encode = 1;
    #10;

    // Test Case 2: Basic Decoding Operation
    io_in = 64'h5555_5555_5555_5555; // Assuming this is the Gray code for 0xAAAA_AAAA_AAAA_AAAA
    io_encode = 0;
    #10;

    // Test Case 3: 64-bit Wide Data Handling
    io_in = 64'hFFFF_FFFF_FFFF_FFFF;
    io_encode = 1;
    #10;
    io_encode = 0;
    #10;

    // Test Case 4: Zero and One Transition
    for (integer i = 0; i < 64; i = i + 1) begin
      io_in = 64'h1 << i;
      io_encode = 1;
      #10;
    end

    // Test Case 5: Full Cycle Encode-Decode
    io_in = 64'h1234_5678_9ABC_DEF0;
    io_encode = 1;
    #10;
    io_in = io_out;
    io_encode = 0;
    #10;

    // Test Case 6: Unchanged Input on Mode Switch
    io_in = 64'h0F0F_0F0F_0F0F_0F0F;
    io_encode = 1;
    #10;
    io_encode = 0;
    #10;

    // Additional stimuli to improve coverage
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in = $random;
      io_encode = $random % 2;
      #10;
    end

    // Reset event simulation
    reset = 1;
    #10;
    reset = 0;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule