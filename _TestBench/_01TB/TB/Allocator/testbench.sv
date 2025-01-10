`timescale 1ns / 1ps

module testbench;

//parameter or localparam

// Inputs
reg clock;
reg reset;
reg [31:0] io_s1_req_rmeta_0_0_tag;
reg [31:0] io_s1_req_rmeta_0_1_tag;
reg [31:0] io_s1_req_rmeta_1_0_tag;
reg [31:0] io_s1_req_rmeta_1_1_tag;
reg [31:0] io_s1_req_tag;
reg io_s1_hits_0;
reg io_s1_hits_1;

// Outputs or inout
wire io_s1_meta_write_way_golden, io_s1_meta_write_way;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_s1_meta_write_way_golden} === ({io_s1_meta_write_way_golden} ^ {io_s1_meta_write_way} ^ {io_s1_meta_write_way_golden}));

// Instantiate the Unit Under Test (UUT)
Allocator uut (
    .clock(clock),
    .reset(reset),
    .io_s1_req_rmeta_0_0_tag(io_s1_req_rmeta_0_0_tag),
    .io_s1_req_rmeta_0_1_tag(io_s1_req_rmeta_0_1_tag),
    .io_s1_req_rmeta_1_0_tag(io_s1_req_rmeta_1_0_tag),
    .io_s1_req_rmeta_1_1_tag(io_s1_req_rmeta_1_1_tag),
    .io_s1_req_tag(io_s1_req_tag),
    .io_s1_hits_0(io_s1_hits_0),
    .io_s1_hits_1(io_s1_hits_1),
    .io_s1_meta_write_way(io_s1_meta_write_way)
);

Allocator_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_s1_req_rmeta_0_0_tag(io_s1_req_rmeta_0_0_tag),
    .io_s1_req_rmeta_0_1_tag(io_s1_req_rmeta_0_1_tag),
    .io_s1_req_rmeta_1_0_tag(io_s1_req_rmeta_1_0_tag),
    .io_s1_req_rmeta_1_1_tag(io_s1_req_rmeta_1_1_tag),
    .io_s1_req_tag(io_s1_req_tag),
    .io_s1_hits_0(io_s1_hits_0),
    .io_s1_hits_1(io_s1_hits_1),
    .io_s1_meta_write_way(io_s1_meta_write_way_golden)
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
    io_s1_req_rmeta_0_0_tag = 32'h0;
    io_s1_req_rmeta_0_1_tag = 32'h0;
    io_s1_req_rmeta_1_0_tag = 32'h0;
    io_s1_req_rmeta_1_1_tag = 32'h0;
    io_s1_req_tag = 32'h0;
    io_s1_hits_0 = 0;
    io_s1_hits_1 = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, and finally set all inputs back to zero
    io_s1_req_rmeta_0_0_tag = 32'h0;
    io_s1_req_rmeta_0_1_tag = 32'h0;
    io_s1_req_rmeta_1_0_tag = 32'h0;
    io_s1_req_rmeta_1_1_tag = 32'h0;
    io_s1_req_tag = 32'h0;
    #100;
    io_s1_req_rmeta_0_0_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_0_1_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_1_0_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_1_1_tag = 32'hFFFFFFFF;
    io_s1_req_tag = 32'hFFFFFFFF;
    #100;
    io_s1_req_rmeta_0_0_tag = 32'h0;
    io_s1_req_rmeta_0_1_tag = 32'h0;
    io_s1_req_rmeta_1_0_tag = 32'h0;
    io_s1_req_rmeta_1_1_tag = 32'h0;
    io_s1_req_tag = 32'h0;
    #100;

    // Test Case 1: Allocation Decision with Hits
    io_s1_hits_0 = 1;
    io_s1_hits_1 = 0;
    #10;
    io_s1_hits_0 = 0;
    io_s1_hits_1 = 1;
    #10;

    // Test Case 2: Computation of Allocation Way without Hits
    io_s1_hits_0 = 0;
    io_s1_hits_1 = 0;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_s1_req_rmeta_0_0_tag = $random;
        io_s1_req_rmeta_0_1_tag = $random;
        io_s1_req_rmeta_1_0_tag = $random;
        io_s1_req_rmeta_1_1_tag = $random;
        io_s1_req_tag = $random;
        #10;
    end

    // Test Case 3: Metadata Writing Decision with Computed Way
    for (integer i = 0; i < 100; i = i + 1) begin
        io_s1_req_rmeta_0_0_tag = $random;
        io_s1_req_rmeta_0_1_tag = $random;
        io_s1_req_rmeta_1_0_tag = $random;
        io_s1_req_rmeta_1_1_tag = $random;
        io_s1_req_tag = $random;
        #10;
    end

    // Test Case 4: XOR Reduction Logic Verification
    for (integer i = 0; i < 100; i = i + 1) begin
        io_s1_req_rmeta_0_0_tag = 1 << i;
        io_s1_req_rmeta_0_1_tag = 1 << (31 - i);
        io_s1_req_rmeta_1_0_tag = 1 << i;
        io_s1_req_rmeta_1_1_tag = 1 << (31 - i);
        io_s1_req_tag = 1 << (i % 32);
        #10;
    end

    // Test Case 5: Handling Edge Cases
    io_s1_req_rmeta_0_0_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_0_1_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_1_0_tag = 32'hFFFFFFFF;
    io_s1_req_rmeta_1_1_tag = 32'hFFFFFFFF;
    io_s1_req_tag = 32'hFFFFFFFF;
    #10;
    io_s1_req_rmeta_0_0_tag = 32'h00000000;
    io_s1_req_rmeta_0_1_tag = 32'h00000000;
    io_s1_req_rmeta_1_0_tag = 32'h00000000;
    io_s1_req_rmeta_1_1_tag = 32'h00000000;
    io_s1_req_tag = 32'h00000000;
    #10;

    // Reset stimulus
    reset = 1;
    #10;
    reset = 0;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule