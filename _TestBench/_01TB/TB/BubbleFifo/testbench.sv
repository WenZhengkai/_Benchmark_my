`timescale 1ns / 1ps

module testbench;

// parameter or localparam 
// None in the provided RTL

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [15:0] io_enq_bits;
reg io_deq_ready;

// Outputs or inout
wire io_enq_ready, io_enq_ready_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [15:0] io_deq_bits, io_deq_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;


wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden}));

// Instantiate the Unit Under Test (UUT)
BubbleFifo uut (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits)
);

BubbleFifo_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
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
    io_enq_bits = 16'h0;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add initial stimulus
    io_enq_valid = 1;
    io_enq_bits = 16'hFFFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_enq_bits = 16'h0;
    io_deq_ready = 0;
    #100;

    // Add stimulus here
    // Test Case 1: Data Buffering and Integrity
    io_enq_valid = 1;
    for(integer i = 0; i < 100; i = i + 1) begin
        io_enq_bits = 16'h1 << i;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 2: Flow Control
    io_enq_valid = 1;
    io_enq_bits = 16'h1234;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 1;
    io_enq_bits = 16'h5678;
    #10;

    // Test Case 3: Reset Capability
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Test Case 4: Sequential Data Flow Management
    io_enq_valid = 1;
    for(integer i = 0; i < 100; i = i + 1) begin
        io_enq_bits = i;
        #10;
    end
    io_deq_ready = 1;
    #100;

    // Test Case 5: Backpressure Management
    io_enq_valid = 1;
    for(integer i = 0; i < 100; i = i + 1) begin
        io_enq_bits = i;
        #10;
    end
    io_deq_ready = 0;
    #10;

    // Test Case 6: Pipeline Efficiency
    io_enq_valid = 1;
    io_enq_bits = 16'hABCD;
    #10;
    io_deq_ready = 1;
    #100;

    // Test Case 7: Reset Event
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Finalize testbench

reset = 1;
#10;
reset = 0;
#10;
io_enq_valid = 1;
io_enq_bits = 16'hAAAA;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
io_enq_valid = 1;
io_enq_bits = 16'h5555;
io_deq_ready = 0;
#10;
io_enq_valid = 0;
#10;
io_deq_ready = 1;
#10;
for (integer i = 0; i < 16; i = i + 1) begin
    io_enq_valid = 1;
    io_enq_bits = i;
    io_deq_ready = 1;
    #10;
end
io_enq_valid = 0;
io_deq_ready = 0;
#10;
io_enq_valid = 1;
io_enq_bits = 16'h1234;
io_deq_ready = 1;
#10;
io_enq_bits = 16'h5678;
#10;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
io_enq_valid = 1;
io_enq_bits = 16'h9ABC;
io_deq_ready = 1;
#10;
reset = 1;
#10;
reset = 0;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
io_enq_valid = 1;
io_enq_bits = 16'hF0F0;
io_deq_ready = 1;
#5;
io_enq_valid = 0;
io_deq_ready = 0;
#5;
io_enq_valid = 1;
io_deq_ready = 1;
#5;
io_enq_valid = 0;
io_deq_ready = 0;
#5;
for (integer i = 0; i < 32; i = i + 1) begin
    io_enq_valid = i[0];
    io_enq_bits = i;
    io_deq_ready = ~i[0];
    #5;
end

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
$finish;
end

endmodule