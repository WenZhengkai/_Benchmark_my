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
DCHold_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
);

DCHold_UInt8 uut (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits)
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
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #10;
    reset = 0;

    // Add stimulus here
    // Initial stimulus to toggle all inputs
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0; #100;
    io_enq_valid = 1; io_enq_bits = 8'hFF; io_deq_ready = 1; #100;
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0; #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'h55;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
    end

    // Test Case 2: Buffer Full Condition
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'h55;
        #10;
        io_enq_valid = 1;
        io_enq_bits = 8'hAA;
        #10;
    end

    // Test Case 3: Asynchronous Reset
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'hAB;
        #10;
        reset = 1;
        #10;
        reset = 0;
        #10;
    end

    // Test Case 4: Data Integrity and Handshaking
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'hAB;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
    end

    // Reset signal toggle to simulate a reset event
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Finish simulation

    // Test Case 5: Toggle all bits of io_enq_bits
    io_enq_valid = 1;
    for (integer i = 0; i < 256; i = i + 1) begin
        io_enq_bits = i[7:0];
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
        #10;
    end
    // Test Case 6: Test all possible transitions for pValid
    // Transition from 0 to 1
    io_enq_valid = 1; io_enq_bits = 8'hAA; io_deq_ready = 0; #10;
    // Transition from 1 to 0
    io_enq_valid = 0; io_deq_ready = 1; #10;
    io_deq_ready = 0; #10;
    // Test Case 7: Test reset functionality during operation
    io_enq_valid = 1; io_enq_bits = 8'hCC; io_deq_ready = 0; #10;
    reset = 1; #10; reset = 0; #10;
    io_enq_valid = 0; io_deq_ready = 1; #10;
    io_deq_ready = 0; #10;
    // Test Case 8: Alternate enqueue and dequeue operations
    for (integer i = 0; i < 10; i = i + 1) begin
        io_enq_valid = 1; io_enq_bits = 8'hF0 + i; #10;
        io_enq_valid = 0;
        io_deq_ready = 1; #10;
        io_deq_ready = 0; #10;
    end
    // Test Case 9: Stress test with rapid enqueue and dequeue
    for (integer i = 0; i < 20; i = i + 1) begin
        io_enq_valid = 1; io_enq_bits = 8'hA5; #5;
        io_enq_valid = 0; io_deq_ready = 1; #5;
        io_deq_ready = 0; #5;
    end

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule