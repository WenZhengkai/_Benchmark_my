`timescale 1ns / 1ps

module testbench;

//parameter or localparam 

// Inputs
reg clock;
reg reset;
reg io_f2_flush;
reg io_fromFtq_req_valid;
reg [31:0] io_fromFtq_req_bits_startAddr;
reg io_f2_ready;

// Outputs or inout
wire io_fromFtq_req_ready, io_fromFtq_req_ready_golden;
wire io_f1_valid, io_f1_valid_golden;
wire [31:0] io_f1_pc_0, io_f1_pc_0_golden;
wire [31:0] io_f1_pc_1, io_f1_pc_1_golden;
wire [31:0] io_f1_pc_2, io_f1_pc_2_golden;
wire [31:0] io_f1_pc_3, io_f1_pc_3_golden;
wire [31:0] io_f1_half_snpc_0, io_f1_half_snpc_0_golden;
wire [31:0] io_f1_half_snpc_1, io_f1_half_snpc_1_golden;
wire [31:0] io_f1_half_snpc_2, io_f1_half_snpc_2_golden;
wire [31:0] io_f1_half_snpc_3, io_f1_half_snpc_3_golden;
wire [4:0] io_f1_cut_ptr_0, io_f1_cut_ptr_0_golden;
wire [4:0] io_f1_cut_ptr_1, io_f1_cut_ptr_1_golden;
wire [4:0] io_f1_cut_ptr_2, io_f1_cut_ptr_2_golden;
wire [4:0] io_f1_cut_ptr_3, io_f1_cut_ptr_3_golden;
wire [4:0] io_f1_cut_ptr_4, io_f1_cut_ptr_4_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_fromFtq_req_ready_golden, io_f1_valid_golden, io_f1_pc_0_golden, io_f1_pc_1_golden, io_f1_pc_2_golden, io_f1_pc_3_golden, io_f1_half_snpc_0_golden, io_f1_half_snpc_1_golden, io_f1_half_snpc_2_golden, io_f1_half_snpc_3_golden, io_f1_cut_ptr_0_golden, io_f1_cut_ptr_1_golden, io_f1_cut_ptr_2_golden, io_f1_cut_ptr_3_golden, io_f1_cut_ptr_4_golden} === ({io_fromFtq_req_ready_golden, io_f1_valid_golden, io_f1_pc_0_golden, io_f1_pc_1_golden, io_f1_pc_2_golden, io_f1_pc_3_golden, io_f1_half_snpc_0_golden, io_f1_half_snpc_1_golden, io_f1_half_snpc_2_golden, io_f1_half_snpc_3_golden, io_f1_cut_ptr_0_golden, io_f1_cut_ptr_1_golden, io_f1_cut_ptr_2_golden, io_f1_cut_ptr_3_golden, io_f1_cut_ptr_4_golden} ^ {io_fromFtq_req_ready, io_f1_valid, io_f1_pc_0, io_f1_pc_1, io_f1_pc_2, io_f1_pc_3, io_f1_half_snpc_0, io_f1_half_snpc_1, io_f1_half_snpc_2, io_f1_half_snpc_3, io_f1_cut_ptr_0, io_f1_cut_ptr_1, io_f1_cut_ptr_2, io_f1_cut_ptr_3, io_f1_cut_ptr_4} ^ {io_fromFtq_req_ready_golden, io_f1_valid_golden, io_f1_pc_0_golden, io_f1_pc_1_golden, io_f1_pc_2_golden, io_f1_pc_3_golden, io_f1_half_snpc_0_golden, io_f1_half_snpc_1_golden, io_f1_half_snpc_2_golden, io_f1_half_snpc_3_golden, io_f1_cut_ptr_0_golden, io_f1_cut_ptr_1_golden, io_f1_cut_ptr_2_golden, io_f1_cut_ptr_3_golden, io_f1_cut_ptr_4_golden}));


// Instantiate the Unit Under Test (UUT)
IFU_f0f1_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_f2_flush(io_f2_flush),
  .io_fromFtq_req_ready(io_fromFtq_req_ready_golden),
  .io_fromFtq_req_valid(io_fromFtq_req_valid),
  .io_fromFtq_req_bits_startAddr(io_fromFtq_req_bits_startAddr),
  .io_f1_valid(io_f1_valid_golden),
  .io_f2_ready(io_f2_ready),
  .io_f1_pc_0(io_f1_pc_0_golden),
  .io_f1_pc_1(io_f1_pc_1_golden),
  .io_f1_pc_2(io_f1_pc_2_golden),
  .io_f1_pc_3(io_f1_pc_3_golden),
  .io_f1_half_snpc_0(io_f1_half_snpc_0_golden),
  .io_f1_half_snpc_1(io_f1_half_snpc_1_golden),
  .io_f1_half_snpc_2(io_f1_half_snpc_2_golden),
  .io_f1_half_snpc_3(io_f1_half_snpc_3_golden),
  .io_f1_cut_ptr_0(io_f1_cut_ptr_0_golden),
  .io_f1_cut_ptr_1(io_f1_cut_ptr_1_golden),
  .io_f1_cut_ptr_2(io_f1_cut_ptr_2_golden),
  .io_f1_cut_ptr_3(io_f1_cut_ptr_3_golden),
  .io_f1_cut_ptr_4(io_f1_cut_ptr_4_golden)
);

IFU_f0f1 uut (
  .clock(clock),
  .reset(reset),
  .io_f2_flush(io_f2_flush),
  .io_fromFtq_req_ready(io_fromFtq_req_ready),
  .io_fromFtq_req_valid(io_fromFtq_req_valid),
  .io_fromFtq_req_bits_startAddr(io_fromFtq_req_bits_startAddr),
  .io_f1_valid(io_f1_valid),
  .io_f2_ready(io_f2_ready),
  .io_f1_pc_0(io_f1_pc_0),
  .io_f1_pc_1(io_f1_pc_1),
  .io_f1_pc_2(io_f1_pc_2),
  .io_f1_pc_3(io_f1_pc_3),
  .io_f1_half_snpc_0(io_f1_half_snpc_0),
  .io_f1_half_snpc_1(io_f1_half_snpc_1),
  .io_f1_half_snpc_2(io_f1_half_snpc_2),
  .io_f1_half_snpc_3(io_f1_half_snpc_3),
  .io_f1_cut_ptr_0(io_f1_cut_ptr_0),
  .io_f1_cut_ptr_1(io_f1_cut_ptr_1),
  .io_f1_cut_ptr_2(io_f1_cut_ptr_2),
  .io_f1_cut_ptr_3(io_f1_cut_ptr_3),
  .io_f1_cut_ptr_4(io_f1_cut_ptr_4)
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
    io_f2_flush = 0;
    io_fromFtq_req_valid = 0;
    io_fromFtq_req_bits_startAddr = 32'h0;
    io_f2_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_fromFtq_req_valid = 1;
    io_fromFtq_req_bits_startAddr = 32'h0;
    io_f2_ready = 1;
    #100;
    io_fromFtq_req_bits_startAddr = 32'hFFFFFFFF;
    #100;
    io_fromFtq_req_bits_startAddr = 32'h0;
    #100;

    // Test Case 1: Basic Fetch Request Handling
    for (integer i = 0; i < 100; i = i + 1) begin
        io_fromFtq_req_bits_startAddr = i * 32'h4;
        #10;
    end

    // Test Case 2: Flush Signal Handling
    for (integer i = 0; i < 100; i = i + 1) begin
        io_f2_flush = (i % 2 == 0);
        #10;
    end

    // Test Case 3: Half-step Next Program Counter Calculation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_fromFtq_req_bits_startAddr = 32'h100 + i * 32'h2;
        #10;
    end

    // Test Case 4: Ready Signal Integration and Output Validity
    for (integer i = 0; i < 100; i = i + 1) begin
        io_f2_ready = (i % 2 == 0);
        #10;
    end

    // Test Case 5: Cut Pointer Generation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_fromFtq_req_bits_startAddr = 32'h200 + i * 32'h1;
        #10;
    end

    // Test Case 6: State Transition Management
    for (integer i = 0; i < 100; i = i + 1) begin
        io_f2_flush = (i % 3 == 0);
        io_f2_ready = (i % 2 == 0);
        #10;
    end

    // Reset Event
    reset = 1;
    #10;
    reset = 0;

    // End simulation

    // Additional stimuli to improve coverage
    // Ensure the reset logic is fully exercised
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test Case 7: Comprehensive FTQ Request Handling
    for (integer i = 0; i < 32; i = i + 1) begin
        io_fromFtq_req_valid = 1;
        io_fromFtq_req_bits_startAddr = i * 32'h8;
        io_f2_ready = 1;
        #10;
        io_f2_ready = 0;
        #10;
    end
    // Test Case 8: Flush Signal with Valid FTQ Request
    io_fromFtq_req_valid = 1;
    io_fromFtq_req_bits_startAddr = 32'h10;
    io_f2_ready = 1;
    io_f2_flush = 1;
    #10;
    io_f2_flush = 0;
    #10;
    // Test Case 9: Toggle all bits of io_fromFtq_req_bits_startAddr
    io_fromFtq_req_valid = 1;
    for (integer i = 0; i < 32; i = i + 1) begin
        io_fromFtq_req_bits_startAddr = 1 << i;
        #10;
    end
    // Test Case 10: Toggle f1_valid and f1_fire conditions
    io_fromFtq_req_valid = 1;
    io_f2_ready = 1;
    io_fromFtq_req_bits_startAddr = 32'h20;
    #10;
    io_f2_ready = 0;
    #10;
    io_f2_ready = 1;
    #10;
    // Test Case 11: Ensure all branches are covered with alternating signals
    for (integer i = 0; i < 10; i = i + 1) begin
        io_f2_flush = (i % 2 == 0);
        io_f2_ready = (i % 3 == 0);
        io_fromFtq_req_valid = (i % 4 == 0);
        io_fromFtq_req_bits_startAddr = 32'h30 + i;
        #10;
    end
    // Test Case 12: Ensure all cut pointers are exercised
    io_fromFtq_req_valid = 1;
    for (integer i = 0; i < 32; i = i + 1) begin
        io_fromFtq_req_bits_startAddr = i * 32'h10;
        #10;
    end
    // Test Case 13: Edge case with maximum address value
    io_fromFtq_req_valid = 1;
    io_fromFtq_req_bits_startAddr = 32'hFFFFFFFC;
    io_f2_ready = 1;
    #10;
    // Reset the system and re-test
    reset = 1;
    #10;
    reset = 0;
    io_fromFtq_req_valid = 0;
    io_f2_flush = 0;
    io_f2_ready = 0;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule