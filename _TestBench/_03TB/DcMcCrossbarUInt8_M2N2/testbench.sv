`timescale 1ns / 1ps

module testbench;

//parameter or localparam 


// Inputs
reg clock;
reg reset;
reg [1:0] io_sel_0;
reg [1:0] io_sel_1;
reg io_c_0_valid;
reg [7:0] io_c_0_bits;
reg io_c_1_valid;
reg [7:0] io_c_1_bits;
reg io_p_0_ready;
reg io_p_1_ready;

// Outputs or inout
wire io_c_0_ready, io_c_0_ready_golden;
wire io_c_1_ready, io_c_1_ready_golden;
wire io_p_0_valid, io_p_0_valid_golden;
wire [7:0] io_p_0_bits, io_p_0_bits_golden;
wire io_p_1_valid, io_p_1_valid_golden;
wire [7:0] io_p_1_bits, io_p_1_bits_golden;


integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden} === ({io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden} ^ {io_c_0_ready, io_c_1_ready, io_p_0_valid, io_p_0_bits, io_p_1_valid, io_p_1_bits} ^ {io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden}));

// Instantiate the Unit Under Test (UUT)
DcMcCrossbarUInt8_M2N2_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_c_0_ready(io_c_0_ready_golden),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready_golden),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid_golden),
    .io_p_0_bits(io_p_0_bits_golden),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid_golden),
    .io_p_1_bits(io_p_1_bits_golden)
);


DcMcCrossbarUInt8_M2N2 uut (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_c_0_ready(io_c_0_ready),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid),
    .io_p_0_bits(io_p_0_bits),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid),
    .io_p_1_bits(io_p_1_bits)
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
    io_sel_0 = 2'b00;
    io_sel_1 = 2'b00;
    io_c_0_valid = 0;
    io_c_0_bits = 8'h00;
    io_c_1_valid = 0;
    io_c_1_bits = 8'h00;
    io_p_0_ready = 0;
    io_p_1_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, and finally set all inputs back to zero
    io_sel_0 = 2'b00; io_sel_1 = 2'b00; io_c_0_valid = 0; io_c_0_bits = 8'h00; io_c_1_valid = 0; io_c_1_bits = 8'h00; io_p_0_ready = 0; io_p_1_ready = 0;
    #100;
    io_sel_0 = 2'b11; io_sel_1 = 2'b11; io_c_0_valid = 1; io_c_0_bits = 8'hFF; io_c_1_valid = 1; io_c_1_bits = 8'hFF; io_p_0_ready = 1; io_p_1_ready = 1;
    #100;
    io_sel_0 = 2'b00; io_sel_1 = 2'b00; io_c_0_valid = 0; io_c_0_bits = 8'h00; io_c_1_valid = 0; io_c_1_bits = 8'h00; io_p_0_ready = 0; io_p_1_ready = 0;
    #100;

    // Test Case 1: Dynamic Data Routing
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = i % 2;
        io_sel_1 = (i + 1) % 2;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = i;
        io_c_1_bits = 100 - i;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        #10;
    end

    // Test Case 2: Flow Control Management with Backpressure
    io_sel_0 = 2'b01;
    io_sel_1 = 2'b10;
    io_c_0_valid = 1;
    io_c_1_valid = 1;
    io_c_0_bits = 8'hAA;
    io_c_1_bits = 8'h55;
    io_p_0_ready = 0; // Simulate backpressure
    io_p_1_ready = 1;
    #100;

    // Test Case 3: Arbitration and Fairness
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = 2'b01;
        io_sel_1 = 2'b01;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = i;
        io_c_1_bits = 100 - i;
        io_p_0_ready = (i % 2 == 0);
        io_p_1_ready = (i % 2 == 1);
        #10;
    end

    // Test Case 4: Reset and Initialization
    reset = 1;
    #20;
    reset = 0;
    #100;

    // Test Case 5: Clock Synchronized Operations
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = i % 4;
        io_sel_1 = (i + 1) % 4;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = 8'hFF >> i;
        io_c_1_bits = 8'hFF << i;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        #10;
    end

    // Toggle reset signal to simulate a reset event
    reset = 1;
    #20;
    reset = 0;
    #100;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    // Be sure to save the following code in the final generated testbench.sv
    $finish;
end

endmodule