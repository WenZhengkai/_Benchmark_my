`timescale 1ns / 1ps

module testbench;

//parameter or localparam
localparam DEPTH = 10;
localparam WIDTH = 8;

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [WIDTH-1:0] io_enq_bits;
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
RegFifo_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
);


RegFifo uut (
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
    reset = 1;
    io_enq_valid = 0;
    io_enq_bits = 0;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here

    // Initial stimulus
    io_enq_valid = 1'b0; io_enq_bits = 8'h00; io_deq_ready = 1'b0; #100;
    io_enq_valid = 1'b1; io_enq_bits = 8'hFF; io_deq_ready = 1'b1; #100;
    io_enq_valid = 1'b0; io_enq_bits = 8'h00; io_deq_ready = 1'b0; #100;

    // Test Case 1: Data Enqueue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1'b1;
        io_enq_bits = i[WIDTH-1:0];
        #10;
    end

    // Test Case 2: Data Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_deq_ready = 1'b1;
        #10;
    end

    // Test Case 3: FIFO Full Condition
    for (integer i = 0; i < DEPTH; i = i + 1) begin
        io_enq_valid = 1'b1;
        io_enq_bits = i[WIDTH-1:0];
        #10;
    end
    io_enq_valid = 1'b1; io_enq_bits = 8'hAA; #10; // Attempt to enqueue beyond full

    // Test Case 4: FIFO Empty Condition After Reset
    reset = 1'b1; #10; reset = 1'b0; #100;
    io_deq_ready = 1'b1; #10;

    // Test Case 5: Circular Buffer Wrap-around
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1'b1;
        io_enq_bits = i[WIDTH-1:0];
        io_deq_ready = 1'b1;
        #10;
    end

    // Test Case 6: Simultaneous Enqueue and Dequeue Operations
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1'b1;
        io_enq_bits = i[WIDTH-1:0];
        io_deq_ready = 1'b1;
        #10;
    end

    // Test Case 7: Dequeue From Empty FIFO
    reset = 1'b1; #10; reset = 1'b0; #100;
    io_deq_ready = 1'b1; #10;

    // Reset stimulus
    reset = 1'b1; #10; reset = 1'b0; #100;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    // Finish simulation
    $finish;
end

endmodule