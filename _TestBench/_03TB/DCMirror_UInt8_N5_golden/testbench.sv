`timescale 1ns / 1ps

module testbench;

//parameter or localparam 
// No parameters or localparams in the given RTL

// Inputs
reg clock;
reg reset;
reg [4:0] io_dst;
reg io_c_valid;
reg [7:0] io_c_bits;
reg io_p_0_ready;
reg io_p_1_ready;
reg io_p_2_ready;
reg io_p_3_ready;
reg io_p_4_ready;

// Outputs or inout
  wire io_c_ready, io_c_ready_golden;
  wire io_p_0_valid, io_p_0_valid_golden;
  wire [7:0] io_p_0_bits, io_p_0_bits_golden;
  wire io_p_1_valid, io_p_1_valid_golden;
  wire [7:0] io_p_1_bits, io_p_1_bits_golden;
  wire io_p_2_valid, io_p_2_valid_golden;
  wire [7:0] io_p_2_bits, io_p_2_bits_golden;
  wire io_p_3_valid, io_p_3_valid_golden;
  wire [7:0] io_p_3_bits, io_p_3_bits_golden;
  wire io_p_4_valid, io_p_4_valid_golden;
  wire [7:0] io_p_4_bits, io_p_4_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} === ({io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} ^ {io_c_ready, io_p_0_valid, io_p_0_bits, io_p_1_valid, io_p_1_bits, io_p_2_valid, io_p_2_bits, io_p_3_valid, io_p_3_bits, io_p_4_valid, io_p_4_bits} ^ {io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden}));

// Instantiate the Unit Under Test (UUT)
DCMirror_UInt8_N5_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_dst(io_dst),
  .io_c_ready(io_c_ready_golden),
  .io_c_valid(io_c_valid),
  .io_c_bits(io_c_bits),
  .io_p_0_ready(io_p_0_ready),
  .io_p_0_valid(io_p_0_valid_golden),
  .io_p_0_bits(io_p_0_bits_golden),
  .io_p_1_ready(io_p_1_ready),
  .io_p_1_valid(io_p_1_valid_golden),
  .io_p_1_bits(io_p_1_bits_golden),
  .io_p_2_ready(io_p_2_ready),
  .io_p_2_valid(io_p_2_valid_golden),
  .io_p_2_bits(io_p_2_bits_golden),
  .io_p_3_ready(io_p_3_ready),
  .io_p_3_valid(io_p_3_valid_golden),
  .io_p_3_bits(io_p_3_bits_golden),
  .io_p_4_ready(io_p_4_ready),
  .io_p_4_valid(io_p_4_valid_golden),
  .io_p_4_bits(io_p_4_bits_golden)
);


DCMirror_UInt8_N5 uut (
  .clock(clock),
  .reset(reset),
  .io_dst(io_dst),
  .io_c_ready(io_c_ready),
  .io_c_valid(io_c_valid),
  .io_c_bits(io_c_bits),
  .io_p_0_ready(io_p_0_ready),
  .io_p_0_valid(io_p_0_valid),
  .io_p_0_bits(io_p_0_bits),
  .io_p_1_ready(io_p_1_ready),
  .io_p_1_valid(io_p_1_valid),
  .io_p_1_bits(io_p_1_bits),
  .io_p_2_ready(io_p_2_ready),
  .io_p_2_valid(io_p_2_valid),
  .io_p_2_bits(io_p_2_bits),
  .io_p_3_ready(io_p_3_ready),
  .io_p_3_valid(io_p_3_valid),
  .io_p_3_bits(io_p_3_bits),
  .io_p_4_ready(io_p_4_ready),
  .io_p_4_valid(io_p_4_valid),
  .io_p_4_bits(io_p_4_bits)
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
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, then to one, then back to zero
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #100;
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hFF;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #100;
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #100;

    // Test Case 1: Basic Data Routing
    io_dst = 5'b10101;
    io_c_valid = 1;
    io_c_bits = 8'hAA;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hAA + i;
        #10;
    end

    // Test Case 2: Channel Not Ready
    io_dst = 5'b10101;
    io_c_valid = 1;
    io_c_bits = 8'hBB;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 0; // Channel 2 not ready
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hBB + i;
        #10;
    end

    // Test Case 3: Dynamic Update of Destination Mask
    io_dst = 5'b01110;
    io_c_valid = 1;
    io_c_bits = 8'hCC;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hCC + i;
        #10;
    end

    // Test Case 4: Reset Functionality
    reset = 1;
    #20;
    reset = 0;
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hDD;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hDD + i;
        #10;
    end

    // Test Case 5: All Channels Busy
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hEE;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hEE + i;
        #10;
    end

    // Test Case 6: Sequential Data Processing
    for (integer j = 0; j < 5; j++) begin
        io_dst = 5'b11111 >> j;
        io_c_valid = 1;
        io_c_bits = 8'hFF;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        io_p_2_ready = 1;
        io_p_3_ready = 1;
        io_p_4_ready = 1;
        #10;
        for (integer i = 0; i < 100; i++) begin
            io_c_bits = 8'hFF + i;
            #10;
        end
    end

    // Final Reset Event
    reset = 1;
    #20;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    
    $finish;
end

endmodule