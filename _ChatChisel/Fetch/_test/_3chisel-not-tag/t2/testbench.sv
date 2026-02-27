`timescale 1ns/1ps

module tb_Fetch();

    // Parameters
    parameter NUM_TESTS = 1000;
    parameter CLK_PERIOD = 10;
    
    // Testbench signals
    reg         clock;
    reg         reset;
    reg  [31:0] io_trap_vector;
    reg  [31:0] io_mret_vector;
    reg  [31:0] io_target_pc;
    reg  [31:0] io_mem_pc;
    reg         io_pcsrc;
    reg         io_branch;
    reg         io_trap;
    reg         io_mret;
    reg         io_pc_stall;
    reg         io_if_id_stall;
    reg         io_if_id_flush;
    reg         io_predict;
    wire [31:0] io_id_pc;
    wire [31:0] io_inst;
    reg  [31:0] io_fetch_data;
    wire [31:0] io_fetch_address;
    
    // DUT and reference outputs
    wire [31:0] dut_io_id_pc;
    wire [31:0] dut_io_inst;
    wire [31:0] dut_io_fetch_address;
    
    wire [31:0] ref_io_id_pc;
    wire [31:0] ref_io_inst;
    wire [31:0] ref_io_fetch_address;
    
    // Test control
    integer test_count = 0;
    integer pass_count = 0;
    integer fail_count = 0;
    integer start_time = 0;
    integer end_time = 0;
    
    // Instantiate DUT
    dut dut (
        .clock(clock),
        .reset(reset),
        .io_trap_vector(io_trap_vector),
        .io_mert_vector(io_mret_vector),
        .io_target_pc(io_target_pc),
        .io_mem_pc(io_mem_pc),
        .io_pcsrc(io_pcsrc),
        .io_branch(io_branch),
        .io_trap(io_trap),
        .io_mert(io_mret),
        .io_pc_stall(io_pc_stall),
        .io_if_id_stall(io_if_id_stall),
        .io_if_id_flush(io_if_id_flush),
        //.io_predict(io_predict),
        .io_id_pc(dut_io_id_pc),
        .io_inst(dut_io_inst),
        .io_fetch_data(io_fetch_data),
        .io_fetch_address(dut_io_fetch_address)
    );
    
    // Instantiate golden reference
    Fetch_golden uut (
        .clock(clock),
        .reset(reset),
        .io_trap_vector(io_trap_vector),
        .io_mert_vector(io_mret_vector),
        .io_target_pc(io_target_pc),
        .io_mem_pc(io_mem_pc),
        .io_pcsrc(io_pcsrc),
        .io_branch(io_branch),
        .io_trap(io_trap),
        .io_mert(io_mret),
        .io_pc_stall(io_pc_stall),
        .io_if_id_stall(io_if_id_stall),
        .io_if_id_flush(io_if_id_flush),
        .io_id_pc(ref_io_id_pc),
        .io_inst(ref_io_inst),
        .io_fetch_data(io_fetch_data),
        .io_fetch_address(ref_io_fetch_address)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #(CLK_PERIOD/2) clock = ~clock;
    end
    
    // Test stimulus
    initial begin
        // Initialize
        reset = 1;
        io_trap_vector = 0;
        io_mret_vector = 0;
        io_target_pc = 0;
        io_mem_pc = 0;
        io_pcsrc = 0;
        io_branch = 0;
        io_trap = 0;
        io_mret = 0;
        io_pc_stall = 0;
        io_if_id_stall = 0;
        io_if_id_flush = 0;
        io_predict = 0;
        io_fetch_data = 0;
        
        // Reset
        #(CLK_PERIOD*2);
        reset = 0;
        
        // Record start time
        start_time = $time;
        
        // Run tests
        for (test_count = 0; test_count < NUM_TESTS; test_count = test_count + 1) begin
            // Randomize inputs
            io_trap_vector  = $random;
            io_mret_vector  = $random;
            io_target_pc    = $random;
            io_mem_pc       = $random;
            io_pcsrc        = $random;
            io_branch       = $random;
            io_trap         = $random % 100 < 2;  // 2% chance of trap
            io_mret         = $random % 100 < 2;  // 2% chance of mret
            io_pc_stall     = $random % 100 < 10; // 10% chance of stall
            io_if_id_stall  = $random % 100 < 10;
            io_if_id_flush  = $random % 100 < 5;
            io_predict      = 0;
            io_fetch_data   = $random;
            
            // Wait for next clock edge
            @(posedge clock);
            
            // Compare outputs
            if (dut_io_id_pc !== ref_io_id_pc || 
                dut_io_inst !== ref_io_inst || 
                dut_io_fetch_address !== ref_io_fetch_address) begin
                $display("Test %0d FAILED at time %0d", test_count, $time);
                $display("  Inputs: trap_vector=%h, mret_vector=%h, target_pc=%h, mem_pc=%h", 
                         io_trap_vector, io_mret_vector, io_target_pc, io_mem_pc);
                $display("          pcsrc=%b, branch=%b, trap=%b, mret=%b", 
                         io_pcsrc, io_branch, io_trap, io_mret);
                $display("          pc_stall=%b, if_id_stall=%b, if_id_flush=%b, predict=%b", 
                         io_pc_stall, io_if_id_stall, io_if_id_flush, io_predict);
                $display("          fetch_data=%h", io_fetch_data);
                $display("  DUT Outputs: id_pc=%h, inst=%h, fetch_address=%h", 
                         dut_io_id_pc, dut_io_inst, dut_io_fetch_address);
                $display("  REF Outputs: id_pc=%h, inst=%h, fetch_address=%h", 
                         ref_io_id_pc, ref_io_inst, ref_io_fetch_address);
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
    
    // Task to print verification report
    task print_report;
        real failure_rate;
        begin
            failure_rate = (100.0 * fail_count) / NUM_TESTS;
            
            $display("\n");
            $display("Verification Report");
            $display("=======================");
            $display("Test Start Time:          %0d", start_time);
            $display("\nTest Summary:");
            $display("Total Tests Run: %0d", NUM_TESTS);
            $display("Tests Passed:   %0d", pass_count);
            $display("Tests Failed:   %0d", fail_count);
            $display("Failure Rate:   %.2f%%", failure_rate);
            $display("\nTest End Time:           %0d", end_time);
            
            if (fail_count > 0) begin
                $display("\nRESULT: %0d TESTS FAILED!", fail_count);
            end else begin
                $display("\nRESULT: ALL TESTS PASSED!");
            end
        end
    endtask

endmodule

module BHT_golden(
  input         clock,
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
  reg [25:0] bhtTable_tag [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_tag_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[BHT.scala 24:21]
  wire [25:0] bhtTable_tag_bhtEntry_data; // @[BHT.scala 24:21]
  wire [25:0] bhtTable_tag_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_tag_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_tag_MPORT_en; // @[BHT.scala 24:21]
  reg  bhtTable_valid [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_valid_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[BHT.scala 24:21]
  wire  bhtTable_valid_bhtEntry_data; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_en; // @[BHT.scala 24:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[BHT.scala 24:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[BHT.scala 24:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_MPORT_en; // @[BHT.scala 24:21]
  assign bhtTable_tag_bhtEntry_en = 1'h1;
  assign bhtTable_tag_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:6];
  assign bhtTable_tag_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_en = 1'h1;
  assign bhtTable_valid_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_en = 1'h1;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_matched = bhtTable_tag_bhtEntry_data == io_pc[31:6]; // @[BHT.scala 30:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[BHT.scala 31:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[BHT.scala 32:18]
  always @(posedge clock) begin
    if (bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[BHT.scala 24:21]
    end
    if (bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[BHT.scala 24:21]
    end
    if (bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[BHT.scala 24:21]
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
module BTB_golden(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  output        io_btb_taken
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [1:0] btbTable [0:15]; // @[BTB.scala 14:21]
  wire  btbTable_btbEntry_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_16_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_16_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_16_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_17_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_17_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_17_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_19_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_19_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_19_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_20_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_20_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_20_data; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_1_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_1_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_2_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_2_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_2_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_3_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_3_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_3_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_4_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_4_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_4_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_5_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_5_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_5_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_6_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_6_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_6_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_6_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_7_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_7_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_7_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_7_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_8_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_8_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_8_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_8_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_9_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_9_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_9_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_9_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_10_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_10_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_10_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_10_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_11_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_11_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_11_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_11_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_12_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_12_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_12_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_12_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_13_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_13_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_13_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_13_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_14_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_14_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_14_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_14_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_15_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_15_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_15_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_15_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_18_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_18_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_18_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_18_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_21_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_21_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_21_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_21_en; // @[BTB.scala 14:21]
  wire  _T_4 = btbTable_MPORT_16_data < 2'h3; // @[BTB.scala 33:38]
  wire  _T_10 = btbTable_MPORT_19_data > 2'h0; // @[BTB.scala 38:38]
  wire  _GEN_35 = io_pcsrc & _T_4; // @[BTB.scala 14:21 31:28]
  wire  _GEN_41 = io_pcsrc ? 1'h0 : 1'h1; // @[BTB.scala 14:21 31:28 38:20]
  wire  _GEN_44 = io_pcsrc ? 1'h0 : _T_10; // @[BTB.scala 14:21 31:28]
  assign btbTable_btbEntry_en = 1'h1;
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_16_en = io_branch & io_pcsrc;
  assign btbTable_MPORT_16_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_16_data = btbTable[btbTable_MPORT_16_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_17_en = io_branch & _GEN_35;
  assign btbTable_MPORT_17_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_17_data = btbTable[btbTable_MPORT_17_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_19_en = io_branch & _GEN_41;
  assign btbTable_MPORT_19_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_19_data = btbTable[btbTable_MPORT_19_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_20_en = io_branch & _GEN_44;
  assign btbTable_MPORT_20_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_20_data = btbTable[btbTable_MPORT_20_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_data = 2'h0;
  assign btbTable_MPORT_addr = 4'h0;
  assign btbTable_MPORT_mask = 1'h1;
  assign btbTable_MPORT_en = reset;
  assign btbTable_MPORT_1_data = 2'h0;
  assign btbTable_MPORT_1_addr = 4'h1;
  assign btbTable_MPORT_1_mask = 1'h1;
  assign btbTable_MPORT_1_en = reset;
  assign btbTable_MPORT_2_data = 2'h0;
  assign btbTable_MPORT_2_addr = 4'h2;
  assign btbTable_MPORT_2_mask = 1'h1;
  assign btbTable_MPORT_2_en = reset;
  assign btbTable_MPORT_3_data = 2'h0;
  assign btbTable_MPORT_3_addr = 4'h3;
  assign btbTable_MPORT_3_mask = 1'h1;
  assign btbTable_MPORT_3_en = reset;
  assign btbTable_MPORT_4_data = 2'h0;
  assign btbTable_MPORT_4_addr = 4'h4;
  assign btbTable_MPORT_4_mask = 1'h1;
  assign btbTable_MPORT_4_en = reset;
  assign btbTable_MPORT_5_data = 2'h0;
  assign btbTable_MPORT_5_addr = 4'h5;
  assign btbTable_MPORT_5_mask = 1'h1;
  assign btbTable_MPORT_5_en = reset;
  assign btbTable_MPORT_6_data = 2'h0;
  assign btbTable_MPORT_6_addr = 4'h6;
  assign btbTable_MPORT_6_mask = 1'h1;
  assign btbTable_MPORT_6_en = reset;
  assign btbTable_MPORT_7_data = 2'h0;
  assign btbTable_MPORT_7_addr = 4'h7;
  assign btbTable_MPORT_7_mask = 1'h1;
  assign btbTable_MPORT_7_en = reset;
  assign btbTable_MPORT_8_data = 2'h0;
  assign btbTable_MPORT_8_addr = 4'h8;
  assign btbTable_MPORT_8_mask = 1'h1;
  assign btbTable_MPORT_8_en = reset;
  assign btbTable_MPORT_9_data = 2'h0;
  assign btbTable_MPORT_9_addr = 4'h9;
  assign btbTable_MPORT_9_mask = 1'h1;
  assign btbTable_MPORT_9_en = reset;
  assign btbTable_MPORT_10_data = 2'h0;
  assign btbTable_MPORT_10_addr = 4'ha;
  assign btbTable_MPORT_10_mask = 1'h1;
  assign btbTable_MPORT_10_en = reset;
  assign btbTable_MPORT_11_data = 2'h0;
  assign btbTable_MPORT_11_addr = 4'hb;
  assign btbTable_MPORT_11_mask = 1'h1;
  assign btbTable_MPORT_11_en = reset;
  assign btbTable_MPORT_12_data = 2'h0;
  assign btbTable_MPORT_12_addr = 4'hc;
  assign btbTable_MPORT_12_mask = 1'h1;
  assign btbTable_MPORT_12_en = reset;
  assign btbTable_MPORT_13_data = 2'h0;
  assign btbTable_MPORT_13_addr = 4'hd;
  assign btbTable_MPORT_13_mask = 1'h1;
  assign btbTable_MPORT_13_en = reset;
  assign btbTable_MPORT_14_data = 2'h0;
  assign btbTable_MPORT_14_addr = 4'he;
  assign btbTable_MPORT_14_mask = 1'h1;
  assign btbTable_MPORT_14_en = reset;
  assign btbTable_MPORT_15_data = 2'h0;
  assign btbTable_MPORT_15_addr = 4'hf;
  assign btbTable_MPORT_15_mask = 1'h1;
  assign btbTable_MPORT_15_en = reset;
  assign btbTable_MPORT_18_data = btbTable_MPORT_17_data + 2'h1;
  assign btbTable_MPORT_18_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_18_mask = 1'h1;
  assign btbTable_MPORT_18_en = io_branch & _GEN_35;
  assign btbTable_MPORT_21_data = btbTable_MPORT_20_data - 2'h1;
  assign btbTable_MPORT_21_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_21_mask = 1'h1;
  assign btbTable_MPORT_21_en = io_branch & _GEN_44;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[BTB.scala 27:28]
  always @(posedge clock) begin
    if (btbTable_MPORT_en & btbTable_MPORT_mask) begin
      btbTable[btbTable_MPORT_addr] <= btbTable_MPORT_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_2_en & btbTable_MPORT_2_mask) begin
      btbTable[btbTable_MPORT_2_addr] <= btbTable_MPORT_2_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_3_en & btbTable_MPORT_3_mask) begin
      btbTable[btbTable_MPORT_3_addr] <= btbTable_MPORT_3_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_4_en & btbTable_MPORT_4_mask) begin
      btbTable[btbTable_MPORT_4_addr] <= btbTable_MPORT_4_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_5_en & btbTable_MPORT_5_mask) begin
      btbTable[btbTable_MPORT_5_addr] <= btbTable_MPORT_5_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_6_en & btbTable_MPORT_6_mask) begin
      btbTable[btbTable_MPORT_6_addr] <= btbTable_MPORT_6_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_7_en & btbTable_MPORT_7_mask) begin
      btbTable[btbTable_MPORT_7_addr] <= btbTable_MPORT_7_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_8_en & btbTable_MPORT_8_mask) begin
      btbTable[btbTable_MPORT_8_addr] <= btbTable_MPORT_8_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_9_en & btbTable_MPORT_9_mask) begin
      btbTable[btbTable_MPORT_9_addr] <= btbTable_MPORT_9_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_10_en & btbTable_MPORT_10_mask) begin
      btbTable[btbTable_MPORT_10_addr] <= btbTable_MPORT_10_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_11_en & btbTable_MPORT_11_mask) begin
      btbTable[btbTable_MPORT_11_addr] <= btbTable_MPORT_11_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_12_en & btbTable_MPORT_12_mask) begin
      btbTable[btbTable_MPORT_12_addr] <= btbTable_MPORT_12_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_13_en & btbTable_MPORT_13_mask) begin
      btbTable[btbTable_MPORT_13_addr] <= btbTable_MPORT_13_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_14_en & btbTable_MPORT_14_mask) begin
      btbTable[btbTable_MPORT_14_addr] <= btbTable_MPORT_14_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_15_en & btbTable_MPORT_15_mask) begin
      btbTable[btbTable_MPORT_15_addr] <= btbTable_MPORT_15_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_18_en & btbTable_MPORT_18_mask) begin
      btbTable[btbTable_MPORT_18_addr] <= btbTable_MPORT_18_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_21_en & btbTable_MPORT_21_mask) begin
      btbTable[btbTable_MPORT_21_addr] <= btbTable_MPORT_21_data; // @[BTB.scala 14:21]
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
    btbTable[initvar] = _RAND_0[1:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Fetch_golden(
  input         clock,
  input         reset,
  input  [31:0] io_trap_vector,
  input  [31:0] io_mert_vector,
  input  [31:0] io_target_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  input         io_trap,
  input         io_mert,
  input         io_pc_stall,
  input         io_if_id_stall,
  input         io_if_id_flush,
  output [31:0] io_id_pc,
  output [31:0] io_inst,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bht_clock; // @[dut.scala 60:19]
  wire [31:0] bht_io_pc; // @[dut.scala 60:19]
  wire [31:0] bht_io_mem_pc; // @[dut.scala 60:19]
  wire  bht_io_pcsrc; // @[dut.scala 60:19]
  wire [31:0] bht_io_target_pc; // @[dut.scala 60:19]
  wire  bht_io_matched; // @[dut.scala 60:19]
  wire  bht_io_valid; // @[dut.scala 60:19]
  wire [31:0] bht_io_bht_pred_pc; // @[dut.scala 60:19]
  wire  btb_clock; // @[dut.scala 70:19]
  wire  btb_reset; // @[dut.scala 70:19]
  wire [31:0] btb_io_pc; // @[dut.scala 70:19]
  wire [31:0] btb_io_mem_pc; // @[dut.scala 70:19]
  wire  btb_io_pcsrc; // @[dut.scala 70:19]
  wire  btb_io_branch; // @[dut.scala 70:19]
  wire  btb_io_btb_taken; // @[dut.scala 70:19]
  reg [31:0] pc_reg; // @[dut.scala 35:23]
  reg [31:0] id_pc_reg; // @[dut.scala 36:26]
  reg [31:0] inst_reg; // @[dut.scala 37:25]
  wire [31:0] _next_pc_T_1 = pc_reg + 32'h4; // @[dut.scala 45:32]
  wire  matched = bht_io_matched; // @[dut.scala 65:29]
  wire  valid = bht_io_valid; // @[dut.scala 66:25]
  wire  btb_taken = btb_io_btb_taken; // @[dut.scala 75:33]
  wire  _next_pc_T_4 = matched & valid & btb_taken; // @[dut.scala 50:23]
  wire [31:0] bht_pred_pc = bht_io_bht_pred_pc; // @[dut.scala 40:25 67:15]
  wire [31:0] _next_pc_T_5 = _next_pc_T_4 ? bht_pred_pc : _next_pc_T_1; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_6 = io_pcsrc ? io_target_pc : _next_pc_T_5; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_7 = io_mert ? io_mert_vector : _next_pc_T_6; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_8 = io_trap ? io_trap_vector : _next_pc_T_7; // @[Mux.scala 101:16]
  BHT_golden bht ( // @[dut.scala 60:19]
    .clock(bht_clock),
    .io_pc(bht_io_pc),
    .io_mem_pc(bht_io_mem_pc),
    .io_pcsrc(bht_io_pcsrc),
    .io_target_pc(bht_io_target_pc),
    .io_matched(bht_io_matched),
    .io_valid(bht_io_valid),
    .io_bht_pred_pc(bht_io_bht_pred_pc)
  );
  BTB_golden btb ( // @[dut.scala 70:19]
    .clock(btb_clock),
    .reset(btb_reset),
    .io_pc(btb_io_pc),
    .io_mem_pc(btb_io_mem_pc),
    .io_pcsrc(btb_io_pcsrc),
    .io_branch(btb_io_branch),
    .io_btb_taken(btb_io_btb_taken)
  );
  assign io_id_pc = id_pc_reg; // @[dut.scala 89:12]
  assign io_inst = inst_reg; // @[dut.scala 90:11]
  assign io_fetch_address = pc_reg; // @[dut.scala 93:20]
  assign bht_clock = clock;
  assign bht_io_pc = pc_reg; // @[dut.scala 61:13]
  assign bht_io_mem_pc = io_mem_pc; // @[dut.scala 62:17]
  assign bht_io_pcsrc = io_pcsrc; // @[dut.scala 63:16]
  assign bht_io_target_pc = io_target_pc; // @[dut.scala 64:20]
  assign btb_clock = clock;
  assign btb_reset = reset;
  assign btb_io_pc = pc_reg; // @[dut.scala 71:13]
  assign btb_io_mem_pc = io_mem_pc; // @[dut.scala 72:17]
  assign btb_io_pcsrc = io_pcsrc; // @[dut.scala 73:16]
  assign btb_io_branch = io_branch; // @[dut.scala 74:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 35:23]
      pc_reg <= 32'h80000000; // @[dut.scala 35:23]
    end else if (reset) begin // @[dut.scala 53:22]
      pc_reg <= 32'h80000000; // @[dut.scala 54:12]
    end else if (~io_pc_stall) begin // @[dut.scala 55:28]
      if (reset) begin // @[Mux.scala 101:16]
        pc_reg <= 32'h80000000;
      end else begin
        pc_reg <= _next_pc_T_8;
      end
    end
    if (reset) begin // @[dut.scala 36:26]
      id_pc_reg <= 32'h0; // @[dut.scala 36:26]
    end else if (reset) begin // @[dut.scala 78:22]
      id_pc_reg <= 32'h0; // @[dut.scala 79:15]
    end else if (io_if_id_flush) begin // @[dut.scala 81:30]
      id_pc_reg <= pc_reg; // @[dut.scala 83:15]
    end else if (~io_if_id_stall) begin // @[dut.scala 84:31]
      id_pc_reg <= pc_reg; // @[dut.scala 85:15]
    end
    if (reset) begin // @[dut.scala 37:25]
      inst_reg <= 32'h0; // @[dut.scala 37:25]
    end else if (reset) begin // @[dut.scala 78:22]
      inst_reg <= 32'h0; // @[dut.scala 80:14]
    end else if (io_if_id_flush) begin // @[dut.scala 81:30]
      inst_reg <= 32'h0; // @[dut.scala 82:14]
    end else if (~io_if_id_stall) begin // @[dut.scala 84:31]
      inst_reg <= io_fetch_data; // @[dut.scala 86:14]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  id_pc_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  inst_reg = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
