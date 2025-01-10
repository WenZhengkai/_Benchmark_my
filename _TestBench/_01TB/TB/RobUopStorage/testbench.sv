`timescale 1ns / 1ps

module testbench;

// parameter or localparam

// Inputs
reg clock;
reg reset;
reg io_enq_uops_0_valid;
reg [31:0] io_enq_uops_0_pc;
reg [6:0] io_enq_uops_0_opcode;
reg [4:0] io_enq_uops_0_dst;
reg io_enq_uops_1_valid;
reg [31:0] io_enq_uops_1_pc;
reg [6:0] io_enq_uops_1_opcode;
reg [4:0] io_enq_uops_1_dst;
reg io_enq_valids_0;
reg io_enq_valids_1;
reg io_rob_tail;
reg io_next_rob_head;

// Outputs or inout
wire io_rob_compact_uop_rdata_0_valid_golden, io_rob_compact_uop_rdata_0_valid;
wire [6:0] io_rob_compact_uop_rdata_0_opcode_golden, io_rob_compact_uop_rdata_0_opcode;
wire [4:0] io_rob_compact_uop_rdata_0_dst_golden, io_rob_compact_uop_rdata_0_dst;
wire io_rob_compact_uop_rdata_1_valid_golden, io_rob_compact_uop_rdata_1_valid;
wire [6:0] io_rob_compact_uop_rdata_1_opcode_golden, io_rob_compact_uop_rdata_1_opcode;
wire [4:0] io_rob_compact_uop_rdata_1_dst_golden, io_rob_compact_uop_rdata_1_dst;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_rob_compact_uop_rdata_0_valid_golden, io_rob_compact_uop_rdata_0_opcode_golden, io_rob_compact_uop_rdata_0_dst_golden, io_rob_compact_uop_rdata_1_valid_golden, io_rob_compact_uop_rdata_1_opcode_golden, io_rob_compact_uop_rdata_1_dst_golden} === ({io_rob_compact_uop_rdata_0_valid_golden, io_rob_compact_uop_rdata_0_opcode_golden, io_rob_compact_uop_rdata_0_dst_golden, io_rob_compact_uop_rdata_1_valid_golden, io_rob_compact_uop_rdata_1_opcode_golden, io_rob_compact_uop_rdata_1_dst_golden} ^ {io_rob_compact_uop_rdata_0_valid_golden, io_rob_compact_uop_rdata_0_opcode_golden, io_rob_compact_uop_rdata_0_dst_golden, io_rob_compact_uop_rdata_1_valid_golden, io_rob_compact_uop_rdata_1_opcode_golden, io_rob_compact_uop_rdata_1_dst_golden} ^ {io_rob_compact_uop_rdata_0_valid, io_rob_compact_uop_rdata_0_opcode, io_rob_compact_uop_rdata_0_dst, io_rob_compact_uop_rdata_1_valid, io_rob_compact_uop_rdata_1_opcode, io_rob_compact_uop_rdata_1_dst}));

// Instantiate the Unit Under Test (UUT)
RobUopStorage uut (
    .clock(clock),
    .reset(reset),
    .io_enq_uops_0_valid(io_enq_uops_0_valid),
    .io_enq_uops_0_pc(io_enq_uops_0_pc),
    .io_enq_uops_0_opcode(io_enq_uops_0_opcode),
    .io_enq_uops_0_dst(io_enq_uops_0_dst),
    .io_enq_uops_1_valid(io_enq_uops_1_valid),
    .io_enq_uops_1_pc(io_enq_uops_1_pc),
    .io_enq_uops_1_opcode(io_enq_uops_1_opcode),
    .io_enq_uops_1_dst(io_enq_uops_1_dst),
    .io_enq_valids_0(io_enq_valids_0),
    .io_enq_valids_1(io_enq_valids_1),
    .io_rob_tail(io_rob_tail),
    .io_next_rob_head(io_next_rob_head),
    .io_rob_compact_uop_rdata_0_valid(io_rob_compact_uop_rdata_0_valid),
    .io_rob_compact_uop_rdata_0_opcode(io_rob_compact_uop_rdata_0_opcode),
    .io_rob_compact_uop_rdata_0_dst(io_rob_compact_uop_rdata_0_dst),
    .io_rob_compact_uop_rdata_1_valid(io_rob_compact_uop_rdata_1_valid),
    .io_rob_compact_uop_rdata_1_opcode(io_rob_compact_uop_rdata_1_opcode),
    .io_rob_compact_uop_rdata_1_dst(io_rob_compact_uop_rdata_1_dst)
);


RobUopStorage_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_uops_0_valid(io_enq_uops_0_valid),
    .io_enq_uops_0_pc(io_enq_uops_0_pc),
    .io_enq_uops_0_opcode(io_enq_uops_0_opcode),
    .io_enq_uops_0_dst(io_enq_uops_0_dst),
    .io_enq_uops_1_valid(io_enq_uops_1_valid),
    .io_enq_uops_1_pc(io_enq_uops_1_pc),
    .io_enq_uops_1_opcode(io_enq_uops_1_opcode),
    .io_enq_uops_1_dst(io_enq_uops_1_dst),
    .io_enq_valids_0(io_enq_valids_0),
    .io_enq_valids_1(io_enq_valids_1),
    .io_rob_tail(io_rob_tail),
    .io_next_rob_head(io_next_rob_head),
    .io_rob_compact_uop_rdata_0_valid(io_rob_compact_uop_rdata_0_valid_golden),
    .io_rob_compact_uop_rdata_0_opcode(io_rob_compact_uop_rdata_0_opcode_golden),
    .io_rob_compact_uop_rdata_0_dst(io_rob_compact_uop_rdata_0_dst_golden),
    .io_rob_compact_uop_rdata_1_valid(io_rob_compact_uop_rdata_1_valid_golden),
    .io_rob_compact_uop_rdata_1_opcode(io_rob_compact_uop_rdata_1_opcode_golden),
    .io_rob_compact_uop_rdata_1_dst(io_rob_compact_uop_rdata_1_dst_golden)
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
    io_enq_uops_0_valid = 0;
    io_enq_uops_0_pc = 32'h0;
    io_enq_uops_0_opcode = 7'h0;
    io_enq_uops_0_dst = 5'h0;
    io_enq_uops_1_valid = 0;
    io_enq_uops_1_pc = 32'h0;
    io_enq_uops_1_opcode = 7'h0;
    io_enq_uops_1_dst = 5'h0;
    io_enq_valids_0 = 0;
    io_enq_valids_1 = 0;
    io_rob_tail = 0;
    io_next_rob_head = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to one, wait 100ns, then back to zero
    io_enq_uops_0_valid = 1;
    io_enq_uops_0_pc = 32'hFFFFFFFF;
    io_enq_uops_0_opcode = 7'h7F;
    io_enq_uops_0_dst = 5'h1F;
    io_enq_uops_1_valid = 1;
    io_enq_uops_1_pc = 32'hFFFFFFFF;
    io_enq_uops_1_opcode = 7'h7F;
    io_enq_uops_1_dst = 5'h1F;
    io_enq_valids_0 = 1;
    io_enq_valids_1 = 1;
    io_rob_tail = 1;
    io_next_rob_head = 1;
    #100;
    io_enq_uops_0_valid = 0;
    io_enq_uops_0_pc = 32'h0;
    io_enq_uops_0_opcode = 7'h0;
    io_enq_uops_0_dst = 5'h0;
    io_enq_uops_1_valid = 0;
    io_enq_uops_1_pc = 32'h0;
    io_enq_uops_1_opcode = 7'h0;
    io_enq_uops_1_dst = 5'h0;
    io_enq_valids_0 = 0;
    io_enq_valids_1 = 0;
    io_rob_tail = 0;
    io_next_rob_head = 0;
    #100;

    // Test Case 1: Dual uop Enqueueing and Commitment
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_uops_0_valid = 1;
        io_enq_uops_0_opcode = 7'h1 << (i % 7);
        io_enq_uops_0_dst = 5'h1 << (i % 5);
        io_enq_uops_1_valid = 1;
        io_enq_uops_1_opcode = 7'h1 << ((i + 1) % 7);
        io_enq_uops_1_dst = 5'h1 << ((i + 1) % 5);
        io_enq_valids_0 = 1;
        io_enq_valids_1 = 1;
        io_rob_tail = i % 2;
        io_next_rob_head = (i + 1) % 2;
        #10;
    end

    // Test Case 2: Bypass Logic Verification
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_uops_0_valid = 1;
        io_enq_uops_0_opcode = 7'h3F;
        io_enq_uops_0_dst = 5'h1F;
        io_enq_valids_0 = 1;
        io_rob_tail = i % 2;
        io_next_rob_head = (i + 1) % 2;
        #10;
    end

    // Test Case 3: Reset and Initialization
    reset = 1;
    #10;
    reset = 0;

    // Test Case 4: Enqueue Validity Control
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_uops_0_valid = 1;
        io_enq_uops_0_opcode = 7'h7F;
        io_enq_uops_0_dst = 5'h1F;
        io_enq_uops_1_valid = 0;
        io_enq_valids_0 = 1;
        io_enq_valids_1 = 0;
        io_rob_tail = i % 2;
        io_next_rob_head = (i + 1) % 2;
        #10;
    end

    // Reset event simulation
    reset = 1;
    #10;
    reset = 0;

    // Be sure to save the following code in the final generated testbench.sv
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule