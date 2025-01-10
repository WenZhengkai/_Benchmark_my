`timescale 1ns / 1ps

module testbench;

parameter DEPTH = 16;

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
wire [4:0] io_count, io_count_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits, io_count} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden}));

// Instantiate the Unit Under Test (UUT)
Queue_16_UInt8_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready_golden),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_ready(io_deq_ready),
  .io_deq_valid(io_deq_valid_golden),
  .io_deq_bits(io_deq_bits_golden),
  .io_count(io_count_golden)
);


Queue_16_UInt8 uut (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_ready(io_deq_ready),
  .io_deq_valid(io_deq_valid),
  .io_deq_bits(io_deq_bits),
  .io_count(io_count)
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
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0;
    #100;
    io_enq_valid = 1; io_enq_bits = 8'hFF; io_deq_ready = 1;
    #100;
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0;
    #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_enq_valid = 0;
        #10;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 2: Queue Full Condition
    for (integer i = 0; i < DEPTH; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
    end
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    #10;
    io_enq_valid = 0;

    // Test Case 3: Queue Empty Condition
    io_deq_ready = 1;
    #100;
    io_deq_ready = 0;

    // Test Case 4: Reset Functionality
    reset = 1;
    #10;
    reset = 0;

    // Test Case 5: Concurrent Enqueue and Dequeue
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 6: Boundary Conditions and Pointer Wrap-around
    for (integer i = 0; i < 200; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 7: Stress Test
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Toggle reset signal
    reset = 1;
    #10;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
end

endmodule