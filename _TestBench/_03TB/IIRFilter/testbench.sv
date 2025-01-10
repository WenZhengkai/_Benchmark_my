`timescale 1ns / 1ps

module testbench;

//parameter or localparam 
// No parameters or localparams in the provided RTL

// Inputs
reg clock;
reg reset;
reg io_input_valid;
reg [3:0] io_input_bits;
reg [2:0] io_num_0;
reg [2:0] io_num_1;
reg [2:0] io_num_2;
reg [2:0] io_num_3;
reg [2:0] io_den_0;
reg [2:0] io_den_1;
reg io_output_ready;

// Outputs or inout
wire io_input_ready, io_input_ready_golden;
wire io_output_valid, io_output_valid_golden;
wire [10:0] io_output_bits, io_output_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_input_ready_golden, io_output_valid_golden, io_output_bits_golden} === ({io_input_ready_golden, io_output_valid_golden, io_output_bits_golden} ^ {io_input_ready, io_output_valid, io_output_bits} ^ {io_input_ready_golden, io_output_valid_golden, io_output_bits_golden}));

// Instantiate the Unit Under Test (UUT)
IIRFilter_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_input_ready(io_input_ready_golden),
    .io_input_valid(io_input_valid),
    .io_input_bits(io_input_bits),
    .io_num_0(io_num_0),
    .io_num_1(io_num_1),
    .io_num_2(io_num_2),
    .io_num_3(io_num_3),
    .io_den_0(io_den_0),
    .io_den_1(io_den_1),
    .io_output_ready(io_output_ready),
    .io_output_valid(io_output_valid_golden),
    .io_output_bits(io_output_bits_golden)
);


IIRFilter uut (
    .clock(clock),
    .reset(reset),
    .io_input_ready(io_input_ready),
    .io_input_valid(io_input_valid),
    .io_input_bits(io_input_bits),
    .io_num_0(io_num_0),
    .io_num_1(io_num_1),
    .io_num_2(io_num_2),
    .io_num_3(io_num_3),
    .io_den_0(io_den_0),
    .io_den_1(io_den_1),
    .io_output_ready(io_output_ready),
    .io_output_valid(io_output_valid),
    .io_output_bits(io_output_bits)
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
    io_input_valid = 0;
    io_input_bits = 4'b0000;
    io_num_0 = 3'b000;
    io_num_1 = 3'b000;
    io_num_2 = 3'b000;
    io_num_3 = 3'b000;
    io_den_0 = 3'b000;
    io_den_1 = 3'b000;
    io_output_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here

    // Initial stimulus
    io_input_valid = 1;
    io_input_bits = 4'b0000;
    io_num_0 = 3'b001;
    io_num_1 = 3'b010;
    io_num_2 = 3'b011;
    io_num_3 = 3'b100;
    io_den_0 = 3'b001;
    io_den_1 = 3'b010;
    io_output_ready = 1;

    // Apply initial input pattern and toggle inputs
    for (integer i = 0; i < 16; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 1: Data Input Handling
    io_input_valid = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 2: Coefficient Configuration
    io_num_0 = 3'b001;
    io_num_1 = 3'b010;
    io_num_2 = 3'b011;
    io_num_3 = 3'b100;
    io_den_0 = 3'b001;
    io_den_1 = 3'b010;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 3: Recursive Filtering Operation
    io_input_valid = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = $random;
        #10;
    end

    // Test Case 4: Output Generation
    io_output_ready = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 5: State Machine Control
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_valid = (i % 2 == 0);
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 6: Memory Management
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 7: Multiply-Accumulate Operations
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 8: Input and Output Synchronization
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_valid = (i % 2 == 0);
        io_output_ready = (i % 3 == 0);
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 9: Signal Integrity and Error Handling
    reset = 1;
    #10;
    reset = 0;
    #10;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Final reset event to simulate a reset condition
    reset = 1;
    #10;
    reset = 0;
    #10;

// Additional Test Stimuli
// Ensure all states and transitions in the FSM are covered
// Test Case 10: Transition through all FSM states
reset = 1;
#10;
reset = 0;
io_input_valid = 1;
io_input_bits = 4'b0010;
io_output_ready = 0;
#10;
// Transition from state 0 to state 1
io_input_valid = 1;
#10;
// Transition from state 1 to state 2
io_input_valid = 0;
#10;
// Transition from state 2 to state 3
io_output_ready = 1;
#10;
// Transition from state 3 to state 0
io_output_ready = 0;
#10;
// Test Case 11: Ensure all branches and conditions are covered
// Use a combination of coefficients and input values to explore all branches
io_num_0 = 3'b011;
io_num_1 = 3'b110;
io_num_2 = 3'b101;
io_num_3 = 3'b111;
io_den_0 = 3'b100;
io_den_1 = 3'b011;
io_input_valid = 1;
io_output_ready = 1;
#10;
// Test Case 12: Toggle all bits of input signals
// Iterate through all possible values for input bits to ensure toggle coverage
for (integer i = 0; i < 16; i = i + 1) begin
    io_input_bits = i[3:0];
    #10;
end
// Test Case 13: Ensure toggle coverage for output signals
// Generate output by toggling input and observing the output
io_input_valid = 1;
io_output_ready = 1;
for (integer i = 0; i < 16; i = i + 1) begin
    io_input_bits = i[3:0];
    #10;
    io_output_ready = ~io_output_ready; // Toggle output ready signal
end
// Test Case 14: Reset condition and edge cases
// Test reset functionality and edge cases for input and output
reset = 1;
#10;
reset = 0;
io_input_valid = 1;
io_input_bits = 4'b1111; // Edge case with maximum input value
io_output_ready = 1;
#10;
io_input_bits = 4'b0000; // Edge case with minimum input value
#10;
// Finalize testing with a reset to ensure proper reset behavior
reset = 1;
#10;
reset = 0;
#10;
$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
$finish;
end

endmodule