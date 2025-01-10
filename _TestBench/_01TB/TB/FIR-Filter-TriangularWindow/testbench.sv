`timescale 1ns / 1ps

module testbench;

//parameter or localparam 

// Inputs
reg clock;
reg reset;
reg [11:0] io_in;

// Outputs or inout
wire [29:0] io_out, io_out_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));

// Instantiate the Unit Under Test (UUT)
MyFir uut (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out)
);

MyFir_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out_golden)
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
    io_in = 12'b0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: toggle io_in
    io_in = 12'b0;
    #100;
    io_in = 12'b111111111111;
    #100;
    io_in = 12'b0;
    #100;

    // Test Case 1: Normal Operating Mode
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = i[11:0];
        #10;
    end

    // Test Case 2: Coefficient Effectiveness
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = (i % 2 == 0) ? 12'hFFF : 12'h000;
        #10;
    end

    // Test Case 3: Reset Functionality
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'hAAA;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'h555;
        #10;
    end

    // Test Case 4: Boundary Input Conditions
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'h000;
        #10;
    end
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'hFFF;
        #10;
    end

    // Test Case 5: Clock Edge Sensitivity
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = (i % 2 == 0) ? 12'hF0F : 12'h0F0;
        #10;
    end

    // Simulate a reset event
    reset = 1;
    #10;
    reset = 0;

    // Finish simulation
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule