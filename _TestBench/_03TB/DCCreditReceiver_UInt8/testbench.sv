`timescale 1ns / 1ps

module testbench;

//parameter or localparam
localparam WIDTH = 8;

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [7:0] io_enq_bits;
reg io_deq_ready;

// Outputs or inout
wire io_enq_credit, io_enq_credit_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [7:0] io_deq_bits, io_deq_bits_golden;
wire [2:0] io_fifoCount, io_fifoCount_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden} === ({io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden} ^ {io_enq_credit, io_deq_valid, io_deq_bits, io_fifoCount} ^ {io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden}));

// Instantiate the Unit Under Test (UUT)
DCCreditReceiver_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_valid(io_enq_valid),
    .io_enq_credit(io_enq_credit_golden),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden),
    .io_fifoCount(io_fifoCount_golden)
);

DCCreditReceiver_UInt8 uut (
    .clock(clock),
    .reset(reset),
    .io_enq_valid(io_enq_valid),
    .io_enq_credit(io_enq_credit),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits),
    .io_fifoCount(io_fifoCount)
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
    io_enq_valid = 0;
    io_enq_bits = 0;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 2: Buffer Full Condition
    for (integer i = 0; i < 6; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
    end
    io_enq_valid = 1;
    io_enq_bits = 8'hAA; // Attempt to enqueue additional data
    #10;

    // Test Case 3: Buffer Empty Condition
    io_deq_ready = 1;
    #10;
    io_deq_ready = 0;
    #10;

    // Test Case 4: Credit Management under Normal Conditions
    for (integer i = 0; i < 100; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 5: Reset Functionality
    for (integer i = 0; i < 5; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Add a test stimulus that toggles the reset signal from 1 to 0 to simulate a reset event
    reset = 1;
    #10;
    reset = 0;
    #10;

// Additional stimulus to improve coverage
// Test Case 6: Toggle `io_enq_valid` without changing `io_enq_bits`
io_enq_valid = 1;
io_enq_bits = 8'h55;
#10;
io_enq_valid = 0;
#10;
io_enq_valid = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 7: Rapid toggling of `io_deq_ready` to check behavior
io_enq_valid = 1;
io_enq_bits = 8'hAA;
#10;
io_deq_ready = 1;
#5;
io_deq_ready = 0;
#5;
io_deq_ready = 1;
#5;
io_deq_ready = 0;
#5;
// Test Case 8: Fill the queue and then dequeue all to test wrap-around
for (integer i = 0; i < 5; i++) begin
    io_enq_valid = 1;
    io_enq_bits = i;
    #10;
end
io_enq_valid = 0;
#10;
for (integer i = 0; i < 5; i++) begin
    io_deq_ready = 1;
    #10;
end
io_deq_ready = 0;
#10;
// Test Case 9: Alternate between enqueue and dequeue to test full and empty conditions
for (integer i = 0; i < 10; i++) begin
    io_enq_valid = 1;
    io_enq_bits = i;
    #5;
    io_deq_ready = 1;
    #5;
end
// Test Case 10: Test reset functionality during operation
io_enq_valid = 1;
io_enq_bits = 8'hFF;
#10;
reset = 1;
#10;
reset = 0;
io_enq_valid = 0;
io_deq_ready = 1;
#10;
// Test Case 11: Edge case with maximum values
io_enq_valid = 1;
io_enq_bits = 8'hFF;
#10;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 12: Edge case with minimum values
io_enq_valid = 1;
io_enq_bits = 8'h00;
#10;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 13: Simultaneous enqueue and dequeue
io_enq_valid = 1;
io_enq_bits = 8'hAA;
io_deq_ready = 1;
#10;
io_enq_valid = 1;
io_enq_bits = 8'hBB;
#10;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
// Test Case 14: Enqueue with varying bit patterns
io_enq_valid = 1;
io_enq_bits = 8'hF0;
#10;
io_enq_bits = 8'h0F;
#10;
io_enq_bits = 8'hAA;
#10;
io_enq_bits = 8'h55;
#10;
io_enq_valid = 0;
#10;
// Test Case 15: Test with no valid enqueue
io_enq_valid = 0;
io_deq_ready = 1;
#10;
io_deq_ready = 0;
#10;

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule