`timescale 1ns / 1ps

module testbench;

//parameter or localparam 
// No parameters or localparams in the RTL

// Inputs
reg clock;
reg reset;
reg io_remap_ldsts_oh_0_0;
reg io_remap_ldsts_oh_0_1;
reg io_remap_pdsts_0;
reg io_com_remap_ldsts_oh_0_0;
reg io_com_remap_ldsts_oh_0_1;
reg io_com_remap_pdsts_0;

// Outputs or inout
wire io_remap_table_out_0_0_golden, io_remap_table_out_0_0;
wire io_remap_table_out_0_1_golden, io_remap_table_out_0_1;
wire io_remap_table_out_1_0_golden, io_remap_table_out_1_0;
wire io_remap_table_out_1_1_golden, io_remap_table_out_1_1;
wire io_com_remap_table_out_0_0_golden, io_com_remap_table_out_0_0;
wire io_com_remap_table_out_0_1_golden, io_com_remap_table_out_0_1;
wire io_com_remap_table_out_1_0_golden, io_com_remap_table_out_1_0;
wire io_com_remap_table_out_1_1_golden, io_com_remap_table_out_1_1;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_remap_table_out_0_0_golden, io_remap_table_out_0_1_golden, io_remap_table_out_1_0_golden, io_remap_table_out_1_1_golden, io_com_remap_table_out_0_0_golden, io_com_remap_table_out_0_1_golden, io_com_remap_table_out_1_0_golden, io_com_remap_table_out_1_1_golden} === ({io_remap_table_out_0_0_golden, io_remap_table_out_0_1_golden, io_remap_table_out_1_0_golden, io_remap_table_out_1_1_golden, io_com_remap_table_out_0_0_golden, io_com_remap_table_out_0_1_golden, io_com_remap_table_out_1_0_golden, io_com_remap_table_out_1_1_golden} ^ {io_remap_table_out_0_0_golden, io_remap_table_out_0_1_golden, io_remap_table_out_1_0_golden, io_remap_table_out_1_1_golden, io_com_remap_table_out_0_0_golden, io_com_remap_table_out_0_1_golden, io_com_remap_table_out_1_0_golden, io_com_remap_table_out_1_1_golden} ^ {io_remap_table_out_0_0, io_remap_table_out_0_1, io_remap_table_out_1_0, io_remap_table_out_1_1, io_com_remap_table_out_0_0, io_com_remap_table_out_0_1, io_com_remap_table_out_1_0, io_com_remap_table_out_1_1}));

// Instantiate the Unit Under Test (UUT)
RemapperModule uut (
  .clock(clock),
  .reset(reset),
  .io_remap_ldsts_oh_0_0(io_remap_ldsts_oh_0_0),
  .io_remap_ldsts_oh_0_1(io_remap_ldsts_oh_0_1),
  .io_remap_pdsts_0(io_remap_pdsts_0),
  .io_com_remap_ldsts_oh_0_0(io_com_remap_ldsts_oh_0_0),
  .io_com_remap_ldsts_oh_0_1(io_com_remap_ldsts_oh_0_1),
  .io_com_remap_pdsts_0(io_com_remap_pdsts_0),
  .io_remap_table_out_0_0(io_remap_table_out_0_0),
  .io_remap_table_out_0_1(io_remap_table_out_0_1),
  .io_remap_table_out_1_0(io_remap_table_out_1_0),
  .io_remap_table_out_1_1(io_remap_table_out_1_1),
  .io_com_remap_table_out_0_0(io_com_remap_table_out_0_0),
  .io_com_remap_table_out_0_1(io_com_remap_table_out_0_1),
  .io_com_remap_table_out_1_0(io_com_remap_table_out_1_0),
  .io_com_remap_table_out_1_1(io_com_remap_table_out_1_1)
);

RemapperModule_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_remap_ldsts_oh_0_0(io_remap_ldsts_oh_0_0),
  .io_remap_ldsts_oh_0_1(io_remap_ldsts_oh_0_1),
  .io_remap_pdsts_0(io_remap_pdsts_0),
  .io_com_remap_ldsts_oh_0_0(io_com_remap_ldsts_oh_0_0),
  .io_com_remap_ldsts_oh_0_1(io_com_remap_ldsts_oh_0_1),
  .io_com_remap_pdsts_0(io_com_remap_pdsts_0),
  .io_remap_table_out_0_0(io_remap_table_out_0_0_golden),
  .io_remap_table_out_0_1(io_remap_table_out_0_1_golden),
  .io_remap_table_out_1_0(io_remap_table_out_1_0_golden),
  .io_remap_table_out_1_1(io_remap_table_out_1_1_golden),
  .io_com_remap_table_out_0_0(io_com_remap_table_out_0_0_golden),
  .io_com_remap_table_out_0_1(io_com_remap_table_out_0_1_golden),
  .io_com_remap_table_out_1_0(io_com_remap_table_out_1_0_golden),
  .io_com_remap_table_out_1_1(io_com_remap_table_out_1_1_golden)
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
    io_remap_ldsts_oh_0_0 = 0;
    io_remap_ldsts_oh_0_1 = 0;
    io_remap_pdsts_0 = 0;
    io_com_remap_ldsts_oh_0_0 = 0;
    io_com_remap_ldsts_oh_0_1 = 0;
    io_com_remap_pdsts_0 = 0;
    
    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, and finally set all inputs back to zero
    io_remap_ldsts_oh_0_0 = 0; io_remap_ldsts_oh_0_1 = 0; io_remap_pdsts_0 = 0;
    io_com_remap_ldsts_oh_0_0 = 0; io_com_remap_ldsts_oh_0_1 = 0; io_com_remap_pdsts_0 = 0;
    #100;
    io_remap_ldsts_oh_0_0 = 1; io_remap_ldsts_oh_0_1 = 1; io_remap_pdsts_0 = 1;
    io_com_remap_ldsts_oh_0_0 = 1; io_com_remap_ldsts_oh_0_1 = 1; io_com_remap_pdsts_0 = 1;
    #100;
    io_remap_ldsts_oh_0_0 = 0; io_remap_ldsts_oh_0_1 = 0; io_remap_pdsts_0 = 0;
    io_com_remap_ldsts_oh_0_0 = 0; io_com_remap_ldsts_oh_0_1 = 0; io_com_remap_pdsts_0 = 0;
    #100;

    // Test Case 1: Normal Operating Mode for Remapping Load/Store Signals
    for (integer i = 0; i < 100; i = i + 1) begin
        io_remap_ldsts_oh_0_0 = i[0];
        io_remap_ldsts_oh_0_1 = i[1];
        io_remap_pdsts_0 = i[2];
        #10;
    end

    // Test Case 2: Normal Operating Mode for Remapping Combined Load/Store Signals
    for (integer i = 0; i < 100; i = i + 1) begin
        io_com_remap_ldsts_oh_0_0 = i[0];
        io_com_remap_ldsts_oh_0_1 = i[1];
        io_com_remap_pdsts_0 = i[2];
        #10;
    end

    // Test Case 3: Reset Condition
    reset = 1;
    #10;
    reset = 0;
    #100;

    // Test Case 4: Boundary Conditions for Input Signals
    io_remap_ldsts_oh_0_0 = 0; io_remap_ldsts_oh_0_1 = 0; io_remap_pdsts_0 = 0;
    io_com_remap_ldsts_oh_0_0 = 0; io_com_remap_ldsts_oh_0_1 = 0; io_com_remap_pdsts_0 = 0;
    #100;
    io_remap_ldsts_oh_0_0 = 1; io_remap_ldsts_oh_0_1 = 1; io_remap_pdsts_0 = 1;
    io_com_remap_ldsts_oh_0_0 = 1; io_com_remap_ldsts_oh_0_1 = 1; io_com_remap_pdsts_0 = 1;
    #100;

    // Test Case 5: Unused Paths Verification
    for (integer i = 0; i < 100; i = i + 1) begin
        io_remap_ldsts_oh_0_0 = i[0];
        io_remap_ldsts_oh_0_1 = i[1];
        io_remap_pdsts_0 = i[2];
        io_com_remap_ldsts_oh_0_0 = i[0];
        io_com_remap_ldsts_oh_0_1 = i[1];
        io_com_remap_pdsts_0 = i[2];
        #10;
    end

    // Final reset stimulus
    reset = 1;
    #10;
    reset = 0;
    #100;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule