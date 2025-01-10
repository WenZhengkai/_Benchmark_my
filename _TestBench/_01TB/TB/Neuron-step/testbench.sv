`timescale 1ns / 1ps

module testbench;

// parameter or localparam

// Inputs
reg clock;
reg reset;
reg [15:0] io_in_0;
reg [15:0] io_in_1;
reg [15:0] io_in_2;
reg [15:0] io_in_3;
reg [15:0] io_in_4;
reg [15:0] io_in_5;
reg [15:0] io_in_6;
reg [15:0] io_in_7;
reg [15:0] io_weights_0;
reg [15:0] io_weights_1;
reg [15:0] io_weights_2;
reg [15:0] io_weights_3;
reg [15:0] io_weights_4;
reg [15:0] io_weights_5;
reg [15:0] io_weights_6;
reg [15:0] io_weights_7;

// Outputs or inout
wire [15:0] io_out, io_out_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));


// Instantiate the Unit Under Test (UUT)
Neuron uut (
  .clock(clock),
  .reset(reset),
  .io_in_0(io_in_0),
  .io_in_1(io_in_1),
  .io_in_2(io_in_2),
  .io_in_3(io_in_3),
  .io_in_4(io_in_4),
  .io_in_5(io_in_5),
  .io_in_6(io_in_6),
  .io_in_7(io_in_7),
  .io_weights_0(io_weights_0),
  .io_weights_1(io_weights_1),
  .io_weights_2(io_weights_2),
  .io_weights_3(io_weights_3),
  .io_weights_4(io_weights_4),
  .io_weights_5(io_weights_5),
  .io_weights_6(io_weights_6),
  .io_weights_7(io_weights_7),
  .io_out(io_out)
);

Neuron_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_in_0(io_in_0),
  .io_in_1(io_in_1),
  .io_in_2(io_in_2),
  .io_in_3(io_in_3),
  .io_in_4(io_in_4),
  .io_in_5(io_in_5),
  .io_in_6(io_in_6),
  .io_in_7(io_in_7),
  .io_weights_0(io_weights_0),
  .io_weights_1(io_weights_1),
  .io_weights_2(io_weights_2),
  .io_weights_3(io_weights_3),
  .io_weights_4(io_weights_4),
  .io_weights_5(io_weights_5),
  .io_weights_6(io_weights_6),
  .io_weights_7(io_weights_7),
  .io_out(io_out_golden)
);


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

// clk toggle generate
always #5 clock = ~clock;

initial begin
    // Initialize Inputs
    clock = 0;
    reset = 0;
    io_in_0 = 0;
    io_in_1 = 0;
    io_in_2 = 0;
    io_in_3 = 0;
    io_in_4 = 0;
    io_in_5 = 0;
    io_in_6 = 0;
    io_in_7 = 0;
    io_weights_0 = 0;
    io_weights_1 = 0;
    io_weights_2 = 0;
    io_weights_3 = 0;
    io_weights_4 = 0;
    io_weights_5 = 0;
    io_weights_6 = 0;
    io_weights_7 = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #10;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    #100; 
    io_in_0 = 16'hFFFF; io_in_1 = 16'hFFFF; io_in_2 = 16'hFFFF; io_in_3 = 16'hFFFF;
    io_in_4 = 16'hFFFF; io_in_5 = 16'hFFFF; io_in_6 = 16'hFFFF; io_in_7 = 16'hFFFF;
    io_weights_0 = 16'hFFFF; io_weights_1 = 16'hFFFF; io_weights_2 = 16'hFFFF; io_weights_3 = 16'hFFFF;
    io_weights_4 = 16'hFFFF; io_weights_5 = 16'hFFFF; io_weights_6 = 16'hFFFF; io_weights_7 = 16'hFFFF;
    #100;
    io_in_0 = 16'h0000; io_in_1 = 16'h0000; io_in_2 = 16'h0000; io_in_3 = 16'h0000;
    io_in_4 = 16'h0000; io_in_5 = 16'h0000; io_in_6 = 16'h0000; io_in_7 = 16'h0000;
    io_weights_0 = 16'h0000; io_weights_1 = 16'h0000; io_weights_2 = 16'h0000; io_weights_3 = 16'h0000;
    io_weights_4 = 16'h0000; io_weights_5 = 16'h0000; io_weights_6 = 16'h0000; io_weights_7 = 16'h0000;
    #100;

    // Test Case 1: Normal Operating Mode
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = 16'h0010 << i;
        io_weights_0 = 16'h0002 << i;
        io_in_1 = 16'h0010 << i;
        io_weights_1 = 16'h0002 << i;
        io_in_2 = 16'h0010 << i;
        io_weights_2 = 16'h0002 << i;
        io_in_3 = 16'h0010 << i;
        io_weights_3 = 16'h0002 << i;
        io_in_4 = 16'h0010 << i;
        io_weights_4 = 16'h0002 << i;
        io_in_5 = 16'h0010 << i;
        io_weights_5 = 16'h0002 << i;
        io_in_6 = 16'h0010 << i;
        io_weights_6 = 16'h0002 << i;
        io_in_7 = 16'h0010 << i;
        io_weights_7 = 16'h0002 << i;
        #10;
    end

    // Test Case 2: Non-Positive MAC Result
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = 16'hFFFE >> i;
        io_weights_0 = 16'h0002 >> i;
        io_in_1 = 16'h0000;
        io_weights_1 = 16'h0000;
        io_in_2 = 16'h0000;
        io_weights_2 = 16'h0000;
        io_in_3 = 16'h0000;
        io_weights_3 = 16'h0000;
        io_in_4 = 16'h0000;
        io_weights_4 = 16'h0000;
        io_in_5 = 16'h0000;
        io_weights_5 = 16'h0000;
        io_in_6 = 16'h0000;
        io_weights_6 = 16'h0000;
        io_in_7 = 16'h0000;
        io_weights_7 = 16'h0000;
        #10;
    end

    // Test Case 3: Overflow Scenario
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = 16'h7FFF;
        io_weights_0 = 16'h7FFF;
        io_in_1 = 16'h7FFF;
        io_weights_1 = 16'h7FFF;
        io_in_2 = 16'h7FFF;
        io_weights_2 = 16'h7FFF;
        io_in_3 = 16'h7FFF;
        io_weights_3 = 16'h7FFF;
        io_in_4 = 16'h7FFF;
        io_weights_4 = 16'h7FFF;
        io_in_5 = 16'h7FFF;
        io_weights_5 = 16'h7FFF;
        io_in_6 = 16'h7FFF;
        io_weights_6 = 16'h7FFF;
        io_in_7 = 16'h7FFF;
        io_weights_7 = 16'h7FFF;
        #10;
    end

    // Test Case 4: Reset Functionality
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = 16'h0001 << i;
        io_weights_0 = 16'h0001 << i;
        io_in_1 = 16'h0001 << i;
        io_weights_1 = 16'h0001 << i;
        io_in_2 = 16'h0001 << i;
        io_weights_2 = 16'h0001 << i;
        io_in_3 = 16'h0001 << i;
        io_weights_3 = 16'h0001 << i;
        io_in_4 = 16'h0001 << i;
        io_weights_4 = 16'h0001 << i;
        io_in_5 = 16'h0001 << i;
        io_weights_5 = 16'h0001 << i;
        io_in_6 = 16'h0001 << i;
        io_weights_6 = 16'h0001 << i;
        io_in_7 = 16'h0001 << i;
        io_weights_7 = 16'h0001 << i;
        #10;
        reset = 1;
        #10;
        reset = 0;
    end

    // Test Case 5: Synchronous Operation Verification
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = 16'h0001 << i;
        io_weights_0 = 16'h0001 << i;
        io_in_1 = 16'h0001 << i;
        io_weights_1 = 16'h0001 << i;
        io_in_2 = 16'h0001 << i;
        io_weights_2 = 16'h0001 << i;
        io_in_3 = 16'h0001 << i;
        io_weights_3 = 16'h0001 << i;
        io_in_4 = 16'h0001 << i;
        io_weights_4 = 16'h0001 << i;
        io_in_5 = 16'h0001 << i;
        io_weights_5 = 16'h0001 << i;
        io_in_6 = 16'h0001 << i;
        io_weights_6 = 16'h0001 << i;
        io_in_7 = 16'h0001 << i;
        io_weights_7 = 16'h0001 << i;
        #10;
    end

    // Additional Stimulus for Improved Coverage
    // Test Case 6: Randomized Inputs and Weights
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in_0 = $random;
        io_weights_0 = $random;
        io_in_1 = $random;
        io_weights_1 = $random;
        io_in_2 = $random;
        io_weights_2 = $random;
        io_in_3 = $random;
        io_weights_3 = $random;
        io_in_4 = $random;
        io_weights_4 = $random;
        io_in_5 = $random;
        io_weights_5 = $random;
        io_in_6 = $random;
        io_weights_6 = $random;
        io_in_7 = $random;
        io_weights_7 = $random;
        #10;
    end

    // Test Case 7: Edge Cases for Activation Function
    io_in_0 = 16'h8000; io_weights_0 = 16'h8000;
    io_in_1 = 16'h8000; io_weights_1 = 16'h8000;
    io_in_2 = 16'h8000; io_weights_2 = 16'h8000;
    io_in_3 = 16'h8000; io_weights_3 = 16'h8000;
    io_in_4 = 16'h8000; io_weights_4 = 16'h8000;
    io_in_5 = 16'h8000; io_weights_5 = 16'h8000;
    io_in_6 = 16'h8000; io_weights_6 = 16'h8000;
    io_in_7 = 16'h8000; io_weights_7 = 16'h8000;
    #100;

    // Final reset stimulus
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Be sure to save the following code in the final generated testbench.sv
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule