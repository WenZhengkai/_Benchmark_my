`timescale 1ns/1ps

module ALU_tb;

  // Parameters
  parameter NUM_TESTS = 1000;
  parameter CLK_PERIOD = 10;

  // Signals
  reg         clock;
  reg         reset;
  reg  [31:0] alu_in1;
  reg  [31:0] alu_in2;
  reg  [3:0]  aluop;
  wire        dut_zero;
  wire [31:0] dut_alu_result;
  wire        ref_zero;
  wire [31:0] ref_alu_result;

  // Test variables
  integer test_num;
  integer mismatch_count;
  integer total_tests;
  integer error_detected;
  integer test_pass;
  integer test_fail;
  reg [31:0] expected_result;
  reg        expected_zero;

  // File handles for logging
  integer log_file;
  integer report_file;

  // Instantiate DUT
  dut dut (
    .clock(clock),
    .reset(reset),
    .io_alu_in1(alu_in1),
    .io_alu_in2(alu_in2),
    .io_aluop(aluop),
    .io_zero(dut_zero),
    .io_alu_result(dut_alu_result)
  );

  // Instantiate golden reference model
  ALU_golden golden_ref (
    .clock(clock),
    .reset(reset),
    .io_alu_in1(alu_in1),
    .io_alu_in2(alu_in2),
    .io_aluop(aluop),
    .io_zero(ref_zero),
    .io_alu_result(ref_alu_result)
  );

  // Clock generation
  initial begin
    clock = 0;
    forever #(CLK_PERIOD/2) clock = ~clock;
  end

  // Test stimulus and checking
  initial begin
    // Initialize
    reset = 1;
    alu_in1 = 0;
    alu_in2 = 0;
    aluop = 0;
    mismatch_count = 0;
    total_tests = 0;
    test_pass = 0;
    test_fail = 0;
    
    // Open log files
    log_file = $fopen("alu_test.log", "w");
    report_file = $fopen("alu_test_report.txt", "w");
    
    $fdisplay(log_file, "ALU Verification Test Log");
    $fdisplay(log_file, "=========================");
    $fdisplay(report_file, "ALU Verification Report");
    $fdisplay(report_file, "=======================");
    $fdisplay(report_file, "Test Start Time: %t", $time);
    
    // Release reset
    #(CLK_PERIOD*2) reset = 0;
    
    // Run tests
    for (test_num = 0; test_num < NUM_TESTS; test_num = test_num + 1) begin
      // Generate random inputs
      alu_in1 = $random;
      alu_in2 = $random;
      aluop = $random % 10; // aluop can be 0-9
      
      // Wait for results to stabilize
      @(posedge clock);
      #1; // small delay for signal settling
      
      // Compare outputs
      error_detected = 0;
      
      if (dut_alu_result !== ref_alu_result) begin
        $fdisplay(log_file, "ERROR at test #%0d: alu_result mismatch!", test_num);
        $fdisplay(log_file, "  Inputs: in1=0x%h, in2=0x%h, aluop=0x%h", alu_in1, alu_in2, aluop);
        $fdisplay(log_file, "  DUT Result: 0x%h", dut_alu_result);
        $fdisplay(log_file, "  REF Result: 0x%h", ref_alu_result);
        error_detected = 1;
      end
      
      if (dut_zero !== ref_zero) begin
        $fdisplay(log_file, "ERROR at test #%0d: zero flag mismatch!", test_num);
        $fdisplay(log_file, "  Inputs: in1=0x%h, in2=0x%h, aluop=0x%h", alu_in1, alu_in2, aluop);
        $fdisplay(log_file, "  DUT Zero: %b", dut_zero);
        $fdisplay(log_file, "  REF Zero: %b", ref_zero);
        error_detected = 1;
      end
      
      if (error_detected) begin
        mismatch_count = mismatch_count + 1;
        test_fail = test_fail + 1;
      end else begin
        test_pass = test_pass + 1;
      end
      
      total_tests = total_tests + 1;
    end
    
    // Generate final report
    $fdisplay(report_file, "\nTest Summary:");
    $fdisplay(report_file, "Total Tests Run: %0d", total_tests);
    $fdisplay(report_file, "Tests Passed:   %0d", test_pass);
    $fdisplay(report_file, "Tests Failed:   %0d", test_fail);
    $fdisplay(report_file, "Failure Rate:   %0.2f%%", (test_fail*100.0)/total_tests);
    $fdisplay(report_file, "\nTest End Time: %t", $time);
    
    if (mismatch_count == 0) begin
      $fdisplay(report_file, "\nRESULT: ALL TESTS PASSED!");
      $display("ALU Verification: ALL %0d TESTS PASSED!", total_tests);
    end else begin
      $fdisplay(report_file, "\nRESULT: %0d TESTS FAILED!", mismatch_count);
      $display("ALU Verification: %0d of %0d TESTS FAILED!", mismatch_count, total_tests);
    end
    
    // Close files and finish
    $fclose(log_file);
    $fclose(report_file);
    $finish;
  end

  // Waveform dumping (for debugging)
  initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, ALU_tb);
  end

endmodule


module ALU_golden(
  input         clock,
  input         reset,
  input  [31:0] io_alu_in1,
  input  [31:0] io_alu_in2,
  input  [3:0]  io_aluop,
  output        io_zero,
  output [31:0] io_alu_result
);
  wire [31:0] add_result = io_alu_in1 + io_alu_in2; // @[ALU.scala 13:31]
  wire [31:0] sub_result = io_alu_in1 - io_alu_in2; // @[ALU.scala 14:31]
  wire [31:0] xor_result = io_alu_in1 ^ io_alu_in2; // @[ALU.scala 15:31]
  wire [31:0] or_result = io_alu_in1 | io_alu_in2; // @[ALU.scala 16:30]
  wire [31:0] and_result = io_alu_in1 & io_alu_in2; // @[ALU.scala 17:31]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in1}; // @[ALU.scala 18:31]
  wire [62:0] sll_result = _GEN_0 << io_alu_in2[4:0]; // @[ALU.scala 18:31]
  wire [31:0] srl_result = io_alu_in1 >> io_alu_in2[4:0]; // @[ALU.scala 19:31]
  wire [31:0] sra_result = $signed(io_alu_in1) >>> io_alu_in2[4:0]; // @[ALU.scala 20:60]
  wire  slt_result = $signed(io_alu_in1) < $signed(io_alu_in2); // @[ALU.scala 21:38]
  wire  sltu_result = io_alu_in1 < io_alu_in2; // @[ALU.scala 22:32]
  wire [31:0] _io_alu_result_T_1 = 4'h0 == io_aluop ? add_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_3 = 4'h1 == io_aluop ? sub_result : _io_alu_result_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_5 = 4'h2 == io_aluop ? xor_result : _io_alu_result_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_7 = 4'h3 == io_aluop ? or_result : _io_alu_result_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_9 = 4'h4 == io_aluop ? and_result : _io_alu_result_T_7; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_11 = 4'h5 == io_aluop ? sll_result : {{31'd0}, _io_alu_result_T_9}; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_13 = 4'h6 == io_aluop ? {{31'd0}, srl_result} : _io_alu_result_T_11; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_15 = 4'h7 == io_aluop ? {{31'd0}, sra_result} : _io_alu_result_T_13; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_17 = 4'h8 == io_aluop ? {{62'd0}, slt_result} : _io_alu_result_T_15; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_19 = 4'h9 == io_aluop ? {{62'd0}, sltu_result} : _io_alu_result_T_17; // @[Mux.scala 81:58]
  assign io_zero = io_alu_in1 == io_alu_in2; // @[ALU.scala 24:26]
  assign io_alu_result = _io_alu_result_T_19[31:0]; // @[ALU.scala 26:17]
endmodule
