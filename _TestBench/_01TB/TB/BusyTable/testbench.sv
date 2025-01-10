`timescale 1ns / 1ps

module testbench;

// Inputs
reg clock;
reg reset;
reg io_wakeups_0_valid;
reg [7:0] io_wakeups_0_bits_uop_pdst;
reg [7:0] io_wakeups_0_bits_speculative_mask;
reg io_wakeups_0_bits_rebusy;
reg io_wakeups_1_valid;
reg [7:0] io_wakeups_1_bits_uop_pdst;
reg [7:0] io_wakeups_1_bits_speculative_mask;
reg io_wakeups_1_bits_rebusy;
reg [7:0] io_ren_uops_0_pdst;
reg [7:0] io_ren_uops_1_pdst;
reg io_rebusy_reqs_0;
reg io_rebusy_reqs_1;
reg [1:0] io_child_rebusys;

// Outputs
wire [1:0] io_busy_table_golden, io_busy_table;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_busy_table_golden} === ({io_busy_table_golden} ^ {io_busy_table} ^ {io_busy_table_golden}));

// Instantiate the Unit Under Test (UUT)
BusyTable uut (
    .clock(clock),
    .reset(reset),
    .io_wakeups_0_valid(io_wakeups_0_valid),
    .io_wakeups_0_bits_uop_pdst(io_wakeups_0_bits_uop_pdst),
    .io_wakeups_0_bits_speculative_mask(io_wakeups_0_bits_speculative_mask),
    .io_wakeups_0_bits_rebusy(io_wakeups_0_bits_rebusy),
    .io_wakeups_1_valid(io_wakeups_1_valid),
    .io_wakeups_1_bits_uop_pdst(io_wakeups_1_bits_uop_pdst),
    .io_wakeups_1_bits_speculative_mask(io_wakeups_1_bits_speculative_mask),
    .io_wakeups_1_bits_rebusy(io_wakeups_1_bits_rebusy),
    .io_ren_uops_0_pdst(io_ren_uops_0_pdst),
    .io_ren_uops_1_pdst(io_ren_uops_1_pdst),
    .io_rebusy_reqs_0(io_rebusy_reqs_0),
    .io_rebusy_reqs_1(io_rebusy_reqs_1),
    .io_child_rebusys(io_child_rebusys),
    .io_busy_table(io_busy_table)
);

BusyTable_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_wakeups_0_valid(io_wakeups_0_valid),
    .io_wakeups_0_bits_uop_pdst(io_wakeups_0_bits_uop_pdst),
    .io_wakeups_0_bits_speculative_mask(io_wakeups_0_bits_speculative_mask),
    .io_wakeups_0_bits_rebusy(io_wakeups_0_bits_rebusy),
    .io_wakeups_1_valid(io_wakeups_1_valid),
    .io_wakeups_1_bits_uop_pdst(io_wakeups_1_bits_uop_pdst),
    .io_wakeups_1_bits_speculative_mask(io_wakeups_1_bits_speculative_mask),
    .io_wakeups_1_bits_rebusy(io_wakeups_1_bits_rebusy),
    .io_ren_uops_0_pdst(io_ren_uops_0_pdst),
    .io_ren_uops_1_pdst(io_ren_uops_1_pdst),
    .io_rebusy_reqs_0(io_rebusy_reqs_0),
    .io_rebusy_reqs_1(io_rebusy_reqs_1),
    .io_child_rebusys(io_child_rebusys),
    .io_busy_table(io_busy_table_golden)
);

// Clock toggle generation
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
    io_wakeups_0_valid = 0;
    io_wakeups_0_bits_uop_pdst = 0;
    io_wakeups_0_bits_speculative_mask = 0;
    io_wakeups_0_bits_rebusy = 0;
    io_wakeups_1_valid = 0;
    io_wakeups_1_bits_uop_pdst = 0;
    io_wakeups_1_bits_speculative_mask = 0;
    io_wakeups_1_bits_rebusy = 0;
    io_ren_uops_0_pdst = 0;
    io_ren_uops_1_pdst = 0;
    io_rebusy_reqs_0 = 0;
    io_rebusy_reqs_1 = 0;
    io_child_rebusys = 0;
    
    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Original stimulus
    io_wakeups_0_valid = 1;
    io_wakeups_1_valid = 1;
    io_wakeups_0_bits_speculative_mask = 8'hFF;
    io_wakeups_1_bits_speculative_mask = 8'hFF;
    io_wakeups_0_bits_uop_pdst = 8'h01;
    io_wakeups_1_bits_uop_pdst = 8'h02;
    io_wakeups_0_bits_rebusy = 1;
    io_wakeups_1_bits_rebusy = 1;
    io_ren_uops_0_pdst = 8'h03;
    io_ren_uops_1_pdst = 8'h04;
    io_rebusy_reqs_0 = 1;
    io_rebusy_reqs_1 = 1;
    io_child_rebusys = 2'b11;
    
    // Additional stimuli to improve coverage
    // Test various combinations of inputs to trigger all conditions and branches
    for (integer i = 0; i < 256; i = i + 1) begin
        #10;
        io_wakeups_0_bits_uop_pdst = i;
        io_wakeups_1_bits_uop_pdst = 255 - i;
        io_ren_uops_0_pdst = i + 1;
        io_ren_uops_1_pdst = 255 - i - 1;
        io_wakeups_0_valid = ~io_wakeups_0_valid;
        io_wakeups_1_valid = ~io_wakeups_1_valid;
        io_rebusy_reqs_0 = ~io_rebusy_reqs_0;
        io_rebusy_reqs_1 = ~io_rebusy_reqs_1;
        io_wakeups_0_bits_rebusy = i[0];
        io_wakeups_1_bits_rebusy = i[1];
        io_child_rebusys = i[1:0];
    end
    
    // Additional stimuli to ensure all branches and toggles are covered
    io_wakeups_0_valid = 0;
    io_wakeups_1_valid = 0;
    io_wakeups_0_bits_rebusy = 0;
    io_wakeups_1_bits_rebusy = 0;
    io_rebusy_reqs_0 = 0;
    io_rebusy_reqs_1 = 0;
    #10;
    
    io_wakeups_0_valid = 1;
    io_wakeups_1_valid = 1;
    io_wakeups_0_bits_rebusy = 0;
    io_wakeups_1_bits_rebusy = 0;
    io_rebusy_reqs_0 = 1;
    io_rebusy_reqs_1 = 1;
    #10;
    
    io_wakeups_0_valid = 1;
    io_wakeups_1_valid = 1;
    io_wakeups_0_bits_rebusy = 1;
    io_wakeups_1_bits_rebusy = 1;
    io_rebusy_reqs_0 = 0;
    io_rebusy_reqs_1 = 0;
    #10;
    
    io_wakeups_0_valid = 1;
    io_wakeups_1_valid = 1;
    io_wakeups_0_bits_rebusy = 1;
    io_wakeups_1_bits_rebusy = 1;
    io_rebusy_reqs_0 = 1;
    io_rebusy_reqs_1 = 1;
    #10;
    
    // Reset stimulus
    #50;
    reset = 1;
    #10;
    reset = 0;
    
    // Additional stimuli to improve FSM and TOGGLE coverage
    // Ensure all possible state transitions are covered
    io_wakeups_0_valid = 0;
    io_wakeups_0_bits_speculative_mask = 8'h00;
    io_wakeups_0_bits_rebusy = 0;
    io_wakeups_1_valid = 0;
    io_wakeups_1_bits_speculative_mask = 8'h00;
    io_wakeups_1_bits_rebusy = 0;
    io_ren_uops_0_pdst = 8'h00;
    io_ren_uops_1_pdst = 8'h00;
    io_rebusy_reqs_0 = 0;
    io_rebusy_reqs_1 = 0;
    io_child_rebusys = 2'b00;
    #10;

    io_wakeups_0_valid = 1;
    io_wakeups_0_bits_speculative_mask = 8'hAA;
    io_wakeups_0_bits_rebusy = 1;
    io_wakeups_1_valid = 1;
    io_wakeups_1_bits_speculative_mask = 8'h55;
    io_wakeups_1_bits_rebusy = 1;
    io_ren_uops_0_pdst = 8'hFF;
    io_ren_uops_1_pdst = 8'hFE;
    io_rebusy_reqs_0 = 1;
    io_rebusy_reqs_1 = 1;
    io_child_rebusys = 2'b10;
    #10;

    io_wakeups_0_valid = 0;
    io_wakeups_0_bits_speculative_mask = 8'hF0;
    io_wakeups_0_bits_rebusy = 0;
    io_wakeups_1_valid = 0;
    io_wakeups_1_bits_speculative_mask = 8'h0F;
    io_wakeups_1_bits_rebusy = 0;
    io_ren_uops_0_pdst = 8'h01;
    io_ren_uops_1_pdst = 8'h02;
    io_rebusy_reqs_0 = 0;
    io_rebusy_reqs_1 = 0;
    io_child_rebusys = 2'b01;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule