`timescale 1ns/1ps

module BHT_tb;

  // Parameters
  parameter NUM_TESTS = 1000;
  parameter CLK_PERIOD = 10;

  // Signals
  reg         clock;
  reg         reset;
  reg  [31:0] io_pc;
  reg  [31:0] io_mem_pc;
  reg         io_pcsrc;
  reg  [31:0] io_target_pc;
  
  // DUT outputs
  wire        dut_matched;
  wire        dut_valid;
  wire [31:0] dut_bht_pred_pc;
  
  // Reference outputs
  wire        ref_matched;
  wire        ref_valid;
  wire [31:0] ref_bht_pred_pc;
  
  // Test variables
  integer test_count = 0;
  integer pass_count = 0;
  integer fail_count = 0;
  integer start_time = 0;
  integer end_time = 0;
  
  // Instantiate DUT
  dut dut (
    .clock(clock),
    .reset(reset),
    .io_pc(io_pc),
    .io_mem_pc(io_mem_pc),
    .io_pcsrc(io_pcsrc),
    .io_target_pc(io_target_pc),
    .io_matched(dut_matched),
    .io_valid(dut_valid),
    .io_bht_pred_pc(dut_bht_pred_pc)
  );
  
  // Instantiate golden reference
  BHT_golden goldenModule (
    .clock(clock),
    .reset(reset),
    .io_pc(io_pc),
    .io_mem_pc(io_mem_pc),
    .io_pcsrc(io_pcsrc),
    .io_target_pc(io_target_pc),
    .io_matched(ref_matched),
    .io_valid(ref_valid),
    .io_bht_pred_pc(ref_bht_pred_pc)
  );
  
  // Clock generation
  initial begin
    clock = 1'b0;
    forever #(CLK_PERIOD/2) clock = ~clock;
  end
  
  // Reset generation
  initial begin
    reset = 1'b1;
    #(CLK_PERIOD*2) reset = 1'b0;
  end
  
  // Test stimulus and verification
  initial begin
    // Initialize inputs
    io_pc = 32'h0;
    io_mem_pc = 32'h0;
    io_pcsrc = 1'b0;
    io_target_pc = 32'h0;
    
    // Wait for reset to complete
    @(negedge reset);
    
    // Record start time
    start_time = $time;
    
    // Run tests
    for (test_count = 0; test_count < NUM_TESTS; test_count = test_count + 1) begin
      // Generate random inputs
      io_pc = $random;
      io_mem_pc = $random;
      io_pcsrc = $random % 2;
      io_target_pc = $random;
      
      // Wait for outputs to stabilize
      @(posedge clock);
      #1; // small delay after clock edge
      
      // Compare outputs
      if ((dut_matched !== ref_matched) || 
          (dut_valid !== ref_valid) || 
          (dut_bht_pred_pc !== ref_bht_pred_pc)) begin
        $display("Test %0d FAILED at time %0d", test_count, $time);
        $display("  Inputs: pc=%h, mem_pc=%h, pcsrc=%b, target_pc=%h", 
                 io_pc, io_mem_pc, io_pcsrc, io_target_pc);
        $display("  DUT Outputs: matched=%b, valid=%b, pred_pc=%h", 
                 dut_matched, dut_valid, dut_bht_pred_pc);
        $display("  REF Outputs: matched=%b, valid=%b, pred_pc=%h", 
                 ref_matched, ref_valid, ref_bht_pred_pc);
        fail_count = fail_count + 1;
      end else begin
        pass_count = pass_count + 1;
      end
    end
    
    // Record end time
    end_time = $time;
    
    // Print verification report
    print_report();
    
    // Finish simulation
    $finish;
  end
  
  // Function to print verification report
  function void print_report();
    real failure_rate;
    
    failure_rate = (real'(fail_count) / real'(NUM_TESTS)) * 100.0;
    
    $display("\n");
    $display("Verification Report");
    $display("=======================");
    $display("Test Start Time:        %0d", start_time);
    $display("");
    $display("Test Summary:");
    $display("Total Tests Run: %0d", NUM_TESTS);
    $display("Tests Passed:   %0d", pass_count);
    $display("Tests Failed:   %0d", fail_count);
    $display("Failure Rate:   %0.2f%%", failure_rate);
    $display("");
    $display("Test End Time:         %0d", end_time);
    $display("");
    
    if (fail_count > 0) begin
      $display("RESULT: %0d TESTS FAILED!", fail_count);
    end else begin
      $display("RESULT: ALL TESTS PASSED!");
    end
    
    $display("\n");
  endfunction
  
endmodule

module BHT_golden(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input  [31:0] io_target_pc,
  output        io_matched,
  output        io_valid,
  output [31:0] io_bht_pred_pc
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
  reg [25:0] bhtTable_tag [0:15] = '{default:26'b0};
  wire  bhtTable_tag_bhtEntry_en; // @[dut.scala 24:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[dut.scala 24:21]
  wire [25:0] bhtTable_tag_bhtEntry_data; // @[dut.scala 24:21]
  wire [25:0] bhtTable_tag_MPORT_data; // @[dut.scala 24:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[dut.scala 24:21]
  wire  bhtTable_tag_MPORT_mask; // @[dut.scala 24:21]
  wire  bhtTable_tag_MPORT_en; // @[dut.scala 24:21]
  reg  bhtTable_valid [0:15]; // @[dut.scala 24:21]
  wire  bhtTable_valid_bhtEntry_en; // @[dut.scala 24:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[dut.scala 24:21]
  wire  bhtTable_valid_bhtEntry_data; // @[dut.scala 24:21]
  wire  bhtTable_valid_MPORT_data; // @[dut.scala 24:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[dut.scala 24:21]
  wire  bhtTable_valid_MPORT_mask; // @[dut.scala 24:21]
  wire  bhtTable_valid_MPORT_en; // @[dut.scala 24:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[dut.scala 24:21]
  wire  bhtTable_target_pc_bhtEntry_en; // @[dut.scala 24:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[dut.scala 24:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[dut.scala 24:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[dut.scala 24:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[dut.scala 24:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[dut.scala 24:21]
  wire  bhtTable_target_pc_MPORT_en; // @[dut.scala 24:21]
  assign bhtTable_tag_bhtEntry_en = 1'h1;
  assign bhtTable_tag_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[dut.scala 24:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:6];
  assign bhtTable_tag_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_en = 1'h1;
  assign bhtTable_valid_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[dut.scala 24:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_en = 1'h1;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[dut.scala 24:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_matched = bhtTable_tag_bhtEntry_data == io_pc[31:6]; // @[dut.scala 30:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[dut.scala 31:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[dut.scala 32:18]
  always @(posedge clock) begin
    if (bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[dut.scala 24:21]
    end
    if (bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[dut.scala 24:21]
    end
    if (bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[dut.scala 24:21]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_tag[initvar] = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_valid[initvar] = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_target_pc[initvar] = _RAND_2[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

