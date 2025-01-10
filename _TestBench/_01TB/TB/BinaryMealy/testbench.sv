`timescale 1ns / 1ps

module testbench;

// parameter or localparam

// Inputs
reg clock;
reg reset;
reg io_in;

// Outputs or inout
wire io_out, io_out_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));

// Instantiate the Unit Under Test (UUT)
BinaryMealy uut (
    .clock(clock), 
    .reset(reset), 
    .io_in(io_in), 
    .io_out(io_out)
);

BinaryMealy_golden golden_model (
    .clock(clock), 
    .reset(reset), 
    .io_in(io_in), 
    .io_out(io_out_golden)
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
    io_in = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, then one, then zero again
    io_in = 0; #100;
    io_in = 1; #100;
    io_in = 0; #100;

    // Test Case 1: State Transitions and Output Behavior
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = $random % 2; // Random binary input
        #10;
    end

    // Test Case 2: Asynchronous Reset Functionality
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = $random % 2; // Random binary input
        if (i % 10 == 0) begin
            reset = 1;
            #10;
            reset = 0;
        end
        #10;
    end

    // Test Case 3: Behavior Under Various Clock Frequencies
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = $random % 2; // Random binary input
        #10;
    end

    // Test Case 4: Loopback from State `3'h4`
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = i % 2; // Alternating binary input
        #10;
    end

    // Reset toggle stimulus
    reset = 1;
    #10;
    reset = 0;

    // End simulation
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule