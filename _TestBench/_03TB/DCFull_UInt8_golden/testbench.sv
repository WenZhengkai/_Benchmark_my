`timescale 1ns / 1ps

module testbench;

//parameter or localparam 

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [7:0] io_enq_bits;
reg io_deq_ready;

// Outputs or inout
wire io_enq_ready, io_enq_ready_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [7:0] io_deq_bits, io_deq_bits_golden;


integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden}));


// Instantiate the Unit Under Test (UUT)
DCFull_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
);


DCFull_UInt8 uut (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits)
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
    reset = 0;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Initial stimulus
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #10;
    reset = 0;

    // Add stimulus here
    // Test Case 1: Enqueue Data Successfully
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 2: Dequeue Data Successfully
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 3: State Transition on Data Enqueue and Dequeue
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = i % 2;
        io_enq_bits = $random;
        io_deq_ready = (i+1) % 2;
        #10;
    end

    // Test Case 4: Reset Functionality
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = $random;
        io_enq_bits = $random;
        io_deq_ready = $random;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;

    // Test Case 5: Data Integrity and Flow Control
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = $random;
        io_enq_bits = $random;
        io_deq_ready = $random;
        #10;
    end

    // Simulate reset event
    reset = 1;
    #10;
    reset = 0;

    // Be sure to save the following code in the final generated testbench.sv

    // Initialize Inputs
    clock = 0;
    reset = 0;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    // Initial stimulus
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;
    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #10;
    reset = 0;
    // Add stimulus here
    // Test Case 1: Enqueue Data Successfully
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
    end
    // Test Case 2: Dequeue Data Successfully
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
    end
    // Test Case 3: State Transition on Data Enqueue and Dequeue
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = i % 2;
        io_enq_bits = $random;
        io_deq_ready = (i+1) % 2;
        #10;
    end
    // Test Case 4: Reset Functionality
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = $random;
        io_enq_bits = $random;
        io_deq_ready = $random;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;
    // Test Case 5: Data Integrity and Flow Control
    for(integer i=0; i<100; i=i+1) begin
        io_enq_valid = $random;
        io_enq_bits = $random;
        io_deq_ready = $random;
        #10;
    end
    // Additional Test Stimuli for Full Coverage
    // Test Case 6: Test all state transitions and edge cases
    io_enq_valid = 0;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 1;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    io_enq_valid = 1;
    io_deq_ready = 1;
    #10;
    // Test Case 7: Toggle io_enq_bits and io_deq_bits transitions
    io_enq_valid = 1;
    io_deq_ready = 1;
    for(integer i=0; i<256; i=i+1) begin
        io_enq_bits = i[7:0];
        #10;
    end
    // Simulate reset event
    reset = 1;
    #10;
    reset = 0;
    // Be sure to save the following code in the final generated testbench.sv

// Additional Test Stimuli for Coverage Improvement
// Ensure all states and transitions are covered
// Test state transitions and edge cases
    // Reset to initialize the 
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test transition from Idle to Enqueue
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    io_deq_ready = 0;
    #10;
    // Test transition from Enqueue to Hold
    io_enq_valid = 0;
    io_deq_ready = 0;
    #10;
    // Test transition from Hold to Dequeue
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    // Test transition from Dequeue back to Idle
    io_enq_valid = 0;
    io_deq_ready = 0;
    #10;
    // Test simultaneous enqueue and dequeue
    io_enq_valid = 1;
    io_enq_bits = 8'h55;
    io_deq_ready = 1;
    #10;
    // Test quick toggle of enqueue and dequeue signals
    io_enq_valid = 1;
    io_deq_ready = 0;
    #5;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #5;
    // Test enqueue without dequeue ready
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 0;
    #10;
    // Test dequeue without enqueue valid
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    // Test enqueue and dequeue with alternating readiness
    io_enq_valid = 1;
    io_deq_ready = 1;
    #5;
    io_enq_valid = 0;
    io_deq_ready = 0;
    #5;
    // Test edge case of rapid enqueue and dequeue toggling
    io_enq_valid = 1;
    io_deq_ready = 1;
    #2;
    io_enq_valid = 0;
    io_deq_ready = 0;
    #2;
    io_enq_valid = 1;
    io_deq_ready = 1;
    #2;
    // Test all possible data inputs to ensure toggle coverage
    for (integer i = 0; i < 256; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        io_deq_ready = 1;
        #5;
    end
    // Final reset to ensure proper reset behavior
    reset = 1;
    #10;
    reset = 0;

// Test Case 8: Ensure transition from state 0 to state 2
io_enq_valid = 0;
io_deq_ready = 0;
#10;
io_enq_valid = 0;
io_deq_ready = 1;
#10;
// Test Case 9: Ensure transition from state 0 to state 3
io_enq_valid = 1;
io_deq_ready = 0;
#10;
// Test Case 10: Ensure transition from state 3 to state 0
io_enq_valid = 0;
io_deq_ready = 1;
#10;
// Test Case 11: Ensure transition from state 3 to state 2
io_enq_valid = 0;
io_deq_ready = 0;
#10;
// Test Case 12: Test all possible combinations of enq_valid and deq_ready
io_enq_valid = 1;
io_deq_ready = 1;
#10;
io_enq_valid = 1;
io_deq_ready = 0;
#10;
io_enq_valid = 0;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
// Test Case 13: Toggle all bits of io_enq_bits
for (integer i = 0; i < 256; i = i + 1) begin
    io_enq_valid = 1;
    io_enq_bits = i[7:0];
    io_deq_ready = 1;
    #10;
end
// Test Case 14: Rapid toggling of io_enq_valid and io_deq_ready
io_enq_valid = 1;
io_deq_ready = 1;
#2;
io_enq_valid = 0;
io_deq_ready = 0;
#2;
io_enq_valid = 1;
io_deq_ready = 1;
#2;
io_enq_valid = 0;
io_deq_ready = 0;
#2;
// Test Case 15: Reset during operation
io_enq_valid = 1;
io_deq_ready = 1;
#5;
reset = 1;
#5;
reset = 0;
#5;
io_enq_valid = 1;
io_deq_ready = 0;
#5;
reset = 1;
#5;
reset = 0;
#5;
io_enq_valid = 0;
io_deq_ready = 1;
#5;
reset = 1;
#5;
reset = 0;
#5;

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule