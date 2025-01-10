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
DCOutput_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
);


DCOutput_UInt8 uut (
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

    // Initial stimulus
    #100;
    reset = 1;
    #100;
    reset = 0;
    #100;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Test Case 1: Basic Enqueue and Dequeue Operation
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    io_deq_ready = 1;
    #10;
    io_enq_valid = 0;
    #10;
    
    // Test Case 2: Buffer Full Condition
    io_enq_valid = 1;
    io_enq_bits = 8'h55;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    #10;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    #10;
    io_enq_valid = 0;
    #10;

    // Test Case 3: Reset Functionality
    io_enq_valid = 1;
    io_enq_bits = 8'hAB;
    #10;
    io_enq_valid = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Test Case 4: Dequeue Without Valid Data
    io_deq_ready = 1;
    #10;
    io_deq_ready = 0;
    #10;

    // Test Case 5: Continuous Data Flow
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test stimulus to toggle reset
    reset = 1;
    #10;
    reset = 0;
    #10;
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
end

endmodule