`timescale 1ns/1ps

module Writeback_tb;

    // Parameters
    parameter TEST_COUNT = 1000;
    parameter CLK_PERIOD = 10; // 10ns = 100MHz
    
    // Testbench signals
    reg         clock;
    reg         reset;
    reg  [31:0] io_csr_read_data_in;
    reg  [31:0] io_wb_reg_pc;
    reg  [31:0] io_wb_readdata;
    reg  [31:0] io_wb_aluresult;
    reg  [1:0]  io_wb_memtoreg;
    
    wire [31:0] dut_io_writedata;
    wire [31:0] ref_io_writedata;
    
    // Test statistics
    integer tests_passed = 0;
    integer tests_failed = 0;
    integer test_number = 0;
    time start_time;
    time end_time;
    
    // Instantiate DUT (Design Under Test)
    dut dut (
        .clock(clock),
        .reset(reset),
        .io_csr_read_data_in(io_csr_read_data_in),
        .io_wb_reg_pc(io_wb_reg_pc),
        .io_wb_readdata(io_wb_readdata),
        .io_wb_aluresult(io_wb_aluresult),
        .io_wb_memtoreg(io_wb_memtoreg),
        .io_writedata(dut_io_writedata)
    );
    
    // Instantiate golden reference module
    Writeback_golden uut (
        .clock(clock),
        .reset(reset),
        .io_csr_read_data_in(io_csr_read_data_in),
        .io_wb_reg_pc(io_wb_reg_pc),
        .io_wb_readdata(io_wb_readdata),
        .io_wb_aluresult(io_wb_aluresult),
        .io_wb_memtoreg(io_wb_memtoreg),
        .io_writedata(ref_io_writedata)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #(CLK_PERIOD/2) clock = ~clock;
    end
    
    // Test stimulus and verification
    initial begin
        // Initialize
        reset = 1;
        io_csr_read_data_in = 0;
        io_wb_reg_pc = 0;
        io_wb_readdata = 0;
        io_wb_aluresult = 0;
        io_wb_memtoreg = 0;
        
        // Record start time
        start_time = $time;
        $display("Test Start Time: %0t", start_time);
        
        // Release reset
        #(CLK_PERIOD*2) reset = 0;
        
        // Run tests
        for (test_number = 0; test_number < TEST_COUNT; test_number = test_number + 1) begin
            // Generate random inputs
            io_csr_read_data_in = $random;
            io_wb_reg_pc = $random;
            io_wb_readdata = $random;
            io_wb_aluresult = $random;
            io_wb_memtoreg = $random % 4; // Ensure 2-bit value
            
            // Wait for outputs to stabilize
            #(CLK_PERIOD);
            
            // Compare outputs
            if (dut_io_writedata === ref_io_writedata) begin
                tests_passed = tests_passed + 1;
            end else begin
                tests_failed = tests_failed + 1;
                $display("Test %0d FAILED at time %0t:", test_number, $time);
                $display("  Inputs: csr_read_data_in=0x%h, wb_reg_pc=0x%h, wb_readdata=0x%h, wb_aluresult=0x%h, wb_memtoreg=%b", 
                         io_csr_read_data_in, io_wb_reg_pc, io_wb_readdata, io_wb_aluresult, io_wb_memtoreg);
                $display("  DUT Output: 0x%h", dut_io_writedata);
                $display("  REF Output: 0x%h", ref_io_writedata);
            end
            
            // Small delay between tests
            #(CLK_PERIOD/4);
        end
        
        // Record end time
        end_time = $time;
        
        // Print verification report
        print_verification_report();
        
        // End simulation
        $finish;
    end
    
    // Function to print verification report
    function void print_verification_report();
        real failure_rate;
        
        //failure_rate = (real(tests_failed) / real(TEST_COUNT)) * 100.0;
        failure_rate =(100.0 * tests_failed) / TEST_COUNT;
        
        $display("\nVerification Report");
        $display("=======================");
        $display("Test Start Time: %20t", start_time);
        $display("");
        $display("Test Summary:");
        $display("Total Tests Run: %d", TEST_COUNT);
        $display("Tests Passed:   %d", tests_passed);
        $display("Tests Failed:   %d", tests_failed);
        $display("Failure Rate:   %0.2f%%", failure_rate);
        $display("");
        $display("Test End Time: %20t", end_time);
        $display("");
        
        if (tests_failed > 0) begin
            $display("RESULT: %d TESTS FAILED!", tests_failed);
        end else begin
            $display("RESULT: ALL TESTS PASSED!");
        end
    endfunction
    
endmodule

module Writeback_golden(
  input         clock,
  input         reset,
  input  [31:0] io_csr_read_data_in,
  input  [31:0] io_wb_reg_pc,
  input  [31:0] io_wb_readdata,
  input  [31:0] io_wb_aluresult,
  input  [1:0]  io_wb_memtoreg,
  output [31:0] io_writedata
);
  wire [31:0] _io_writedata_T_1 = 2'h1 == io_wb_memtoreg ? io_wb_readdata : io_wb_reg_pc; // @[Mux.scala 81:58]
  wire [31:0] _io_writedata_T_3 = 2'h2 == io_wb_memtoreg ? io_wb_aluresult : _io_writedata_T_1; // @[Mux.scala 81:58]
  assign io_writedata = 2'h3 == io_wb_memtoreg ? io_csr_read_data_in : _io_writedata_T_3; // @[Mux.scala 81:58]
endmodule
