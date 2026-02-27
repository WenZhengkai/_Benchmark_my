`timescale 1ns/1ps

module tb_Control();
    // Testbench parameters
    parameter NUM_TESTS = 1000;
    parameter CLK_PERIOD = 10;
    
    // Signals
    reg clock;
    reg reset;
    reg [6:0] opcode;
    reg [6:0] funct7;
    reg [2:0] funct3;
    
    // DUT outputs
    wire [3:0] dut_aluop;
    wire dut_immsrc;
    wire dut_isbranch;
    wire dut_memread;
    wire dut_memwrite;
    wire dut_regwrite;
    wire [1:0] dut_memtoreg;
    wire dut_pcsel;
    wire dut_rdsel;
    wire dut_isjump;
    wire dut_islui;
    wire dut_use_rs1;
    wire dut_use_rs2;
    
    // Golden module outputs
    wire [3:0] ref_aluop;
    wire ref_immsrc;
    wire ref_isbranch;
    wire ref_memread;
    wire ref_memwrite;
    wire ref_regwrite;
    wire [1:0] ref_memtoreg;
    wire ref_pcsel;
    wire ref_rdsel;
    wire ref_isjump;
    wire ref_islui;
    wire ref_use_rs1;
    wire ref_use_rs2;
    
    // Test variables
    integer passed_tests = 0;
    integer failed_tests = 0;
    integer test_count = 0;
    real start_time;
    real end_time;
    reg [31:0] error_count = 0;
    reg test_failed;
    
    // Instantiate DUT (Device Under Test)
    dut dut (
        .clock(clock),
        .reset(reset),
        .io_opcode(opcode),
        .io_funct7(funct7),
        .io_funct3(funct3),
        .io_aluop(dut_aluop),
        .io_immsrc(dut_immsrc),
        .io_isbranch(dut_isbranch),
        .io_memread(dut_memread),
        .io_memwrite(dut_memwrite),
        .io_regwrite(dut_regwrite),
        .io_memtoreg(dut_memtoreg),
        .io_pcsel(dut_pcsel),
        .io_rdsel(dut_rdsel),
        .io_isjump(dut_isjump),
        .io_islui(dut_islui),
        .io_use_rs1(dut_use_rs1),
        .io_use_rs2(dut_use_rs2)
    );
    
    // Instantiate Golden Module
    Control_golden golden (
        .clock(clock),
        .reset(reset),
        .io_opcode(opcode),
        .io_funct7(funct7),
        .io_funct3(funct3),
        .io_aluop(ref_aluop),
        .io_immsrc(ref_immsrc),
        .io_isbranch(ref_isbranch),
        .io_memread(ref_memread),
        .io_memwrite(ref_memwrite),
        .io_regwrite(ref_regwrite),
        .io_memtoreg(ref_memtoreg),
        .io_pcsel(ref_pcsel),
        .io_rdsel(ref_rdsel),
        .io_isjump(ref_isjump),
        .io_islui(ref_islui),
        .io_use_rs1(ref_use_rs1),
        .io_use_rs2(ref_use_rs2)
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
        opcode = 0;
        funct7 = 0;
        funct3 = 0;
        
        // Record start time
        start_time = $time;
        
        // Reset sequence
        #(CLK_PERIOD*2);
        reset = 0;
        
        // Run tests
        for (test_count = 0; test_count < NUM_TESTS; test_count = test_count + 1) begin
            // Randomize inputs
            opcode = $urandom_range(0, 127);  // 7-bit opcode
            funct7 = $urandom_range(0, 127);  // 7-bit funct7
            funct3 = $urandom_range(0, 7);    // 3-bit funct3
            
            // Wait for outputs to stabilize
            #(CLK_PERIOD);
            
            // Check outputs
            test_failed = 0;
            
            if (dut_aluop !== ref_aluop) begin
                $display("Error at test %0d: aluop mismatch - DUT: %b, REF: %b", test_count, dut_aluop, ref_aluop);
                test_failed = 1;
            end
            
            if (dut_immsrc !== ref_immsrc) begin
                $display("Error at test %0d: immsrc mismatch - DUT: %b, REF: %b", test_count, dut_immsrc, ref_immsrc);
                test_failed = 1;
            end
            
            if (dut_isbranch !== ref_isbranch) begin
                $display("Error at test %0d: isbranch mismatch - DUT: %b, REF: %b", test_count, dut_isbranch, ref_isbranch);
                test_failed = 1;
            end
            
            if (dut_memread !== ref_memread) begin
                $display("Error at test %0d: memread mismatch - DUT: %b, REF: %b", test_count, dut_memread, ref_memread);
                test_failed = 1;
            end
            
            if (dut_memwrite !== ref_memwrite) begin
                $display("Error at test %0d: memwrite mismatch - DUT: %b, REF: %b", test_count, dut_memwrite, ref_memwrite);
                test_failed = 1;
            end
            
            if (dut_regwrite !== ref_regwrite) begin
                $display("Error at test %0d: regwrite mismatch - DUT: %b, REF: %b", test_count, dut_regwrite, ref_regwrite);
                test_failed = 1;
            end
            
            if (dut_memtoreg !== ref_memtoreg) begin
                $display("Error at test %0d: memtoreg mismatch - DUT: %b, REF: %b", test_count, dut_memtoreg, ref_memtoreg);
                test_failed = 1;
            end
            
            if (dut_pcsel !== ref_pcsel) begin
                $display("Error at test %0d: pcsel mismatch - DUT: %b, REF: %b", test_count, dut_pcsel, ref_pcsel);
                test_failed = 1;
            end
            
            if (dut_rdsel !== ref_rdsel) begin
                $display("Error at test %0d: rdsel mismatch - DUT: %b, REF: %b", test_count, dut_rdsel, ref_rdsel);
                test_failed = 1;
            end
            
            if (dut_isjump !== ref_isjump) begin
                $display("Error at test %0d: isjump mismatch - DUT: %b, REF: %b", test_count, dut_isjump, ref_isjump);
                test_failed = 1;
            end
            
            if (dut_islui !== ref_islui) begin
                $display("Error at test %0d: islui mismatch - DUT: %b, REF: %b", test_count, dut_islui, ref_islui);
                test_failed = 1;
            end
            
            if (dut_use_rs1 !== ref_use_rs1) begin
                $display("Error at test %0d: use_rs1 mismatch - DUT: %b, REF: %b", test_count, dut_use_rs1, ref_use_rs1);
                test_failed = 1;
            end
            
            if (dut_use_rs2 !== ref_use_rs2) begin
                $display("Error at test %0d: use_rs2 mismatch - DUT: %b, REF: %b", test_count, dut_use_rs2, ref_use_rs2);
                test_failed = 1;
            end
            
            // Update counters
            if (test_failed) begin
                failed_tests = failed_tests + 1;
                error_count = error_count + 1;
            end else begin
                passed_tests = passed_tests + 1;
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
        
        failure_rate = (real'(failed_tests) / real'(NUM_TESTS)) * 100.0;
        
        $display("\n");
        $display("Verification Report");
        $display("=======================");
        $display("Test Start Time: %20.0f", start_time);
        $display("\nTest Summary:");
        $display("Total Tests Run: %d", NUM_TESTS);
        $display("Tests Passed:   %d", passed_tests);
        $display("Tests Failed:   %d", failed_tests);
        $display("Failure Rate:   %.2f%%", failure_rate);
        $display("\nTest End Time: %20.0f", end_time);
        
        if (failed_tests > 0) begin
            $display("\nRESULT: %d TESTS FAILED!", failed_tests);
        end else begin
            $display("\nRESULT: ALL TESTS PASSED!");
        end
    endfunction
    
endmodule


module Control_golden(
  input        clock,
  input        reset,
  input  [6:0] io_opcode,
  input  [6:0] io_funct7,
  input  [2:0] io_funct3,
  output [3:0] io_aluop,
  output       io_immsrc,
  output       io_isbranch,
  output       io_memread,
  output       io_memwrite,
  output       io_regwrite,
  output [1:0] io_memtoreg,
  output       io_pcsel,
  output       io_rdsel,
  output       io_isjump,
  output       io_islui,
  output       io_use_rs1,
  output       io_use_rs2
);
  wire [2:0] _io_aluop_T_5 = 7'h0 == io_funct7 ? 3'h6 : 3'h0; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_7 = 7'h20 == io_funct7 ? 3'h7 : _io_aluop_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_9 = 3'h4 == io_funct3 ? 2'h2 : {{1'd0}, 7'h20 == io_funct7}; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_11 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_9; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_13 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_11}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_15 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_13; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_17 = 3'h5 == io_funct3 ? _io_aluop_T_7 : _io_aluop_T_15; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_19 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_17}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_21 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_19; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_27 = 3'h4 == io_funct3 ? 2'h2 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_29 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_27; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_31 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_29}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_33 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_31; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_35 = 3'h5 == io_funct3 ? _io_aluop_T_7 : _io_aluop_T_33; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_37 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_35}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_39 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_37; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_41 = 3'h0 == io_funct3 ? 4'h8 : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_43 = 3'h1 == io_funct3 ? 4'h8 : _io_aluop_T_41; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_45 = 3'h4 == io_funct3 ? 4'h8 : _io_aluop_T_43; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_47 = 3'h5 == io_funct3 ? 4'h8 : _io_aluop_T_45; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_49 = 3'h6 == io_funct3 ? 4'h9 : _io_aluop_T_47; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_51 = 3'h7 == io_funct3 ? 4'h9 : _io_aluop_T_49; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_53 = 7'h33 == io_opcode ? _io_aluop_T_21 : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_55 = 7'h13 == io_opcode ? _io_aluop_T_39 : _io_aluop_T_53; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_57 = 7'h3 == io_opcode ? 4'h0 : _io_aluop_T_55; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_59 = 7'h23 == io_opcode ? 4'h0 : _io_aluop_T_57; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_61 = 7'h63 == io_opcode ? _io_aluop_T_51 : _io_aluop_T_59; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_63 = 7'h6f == io_opcode ? 4'h0 : _io_aluop_T_61; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_65 = 7'h67 == io_opcode ? 4'h0 : _io_aluop_T_63; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_67 = 7'h37 == io_opcode ? 4'h0 : _io_aluop_T_65; // @[Mux.scala 81:58]
  wire  _io_immsrc_T_23 = 7'h63 == io_opcode ? 1'h0 : 7'h23 == io_opcode | (7'h3 == io_opcode | 7'h13 == io_opcode); // @[Mux.scala 81:58]
  wire  _io_regwrite_T_21 = 7'h23 == io_opcode ? 1'h0 : 7'h3 == io_opcode | (7'h13 == io_opcode | 7'h33 == io_opcode); // @[Mux.scala 81:58]
  wire  _io_regwrite_T_23 = 7'h63 == io_opcode ? 1'h0 : _io_regwrite_T_21; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_3 = 3'h1 == io_funct3 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_5 = 3'h2 == io_funct3 ? 2'h3 : _io_memtoreg_T_3; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_7 = 3'h3 == io_funct3 ? 2'h3 : _io_memtoreg_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_9 = 3'h5 == io_funct3 ? 2'h3 : _io_memtoreg_T_7; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_11 = 3'h6 == io_funct3 ? 2'h3 : _io_memtoreg_T_9; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_13 = 3'h7 == io_funct3 ? 2'h3 : _io_memtoreg_T_11; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_15 = 7'h33 == io_opcode ? 2'h2 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_17 = 7'h13 == io_opcode ? 2'h2 : _io_memtoreg_T_15; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_19 = 7'h3 == io_opcode ? 2'h1 : _io_memtoreg_T_17; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_21 = 7'h6f == io_opcode ? 2'h0 : _io_memtoreg_T_19; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_23 = 7'h37 == io_opcode ? 2'h2 : _io_memtoreg_T_21; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_9 = 3'h5 == io_funct3 ? 1'h0 : 3'h3 == io_funct3 | (3'h2 == io_funct3 | 3'h1 == io_funct3); // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_11 = 3'h6 == io_funct3 ? 1'h0 : _io_use_rs1_T_9; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_13 = 3'h7 == io_funct3 ? 1'h0 : _io_use_rs1_T_11; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_25 = 7'h6f == io_opcode ? 1'h0 : 7'h63 == io_opcode | (7'h23 == io_opcode | (7'h3 == io_opcode | (7'h13
     == io_opcode | 7'h33 == io_opcode))); // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_29 = 7'h37 == io_opcode ? 1'h0 : 7'h67 == io_opcode | _io_use_rs1_T_25; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_31 = 7'h17 == io_opcode ? 1'h0 : _io_use_rs1_T_29; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_17 = 7'h13 == io_opcode ? 1'h0 : 7'h33 == io_opcode; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_19 = 7'h3 == io_opcode ? 1'h0 : _io_use_rs2_T_17; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_25 = 7'h6f == io_opcode ? 1'h0 : 7'h63 == io_opcode | (7'h23 == io_opcode | _io_use_rs2_T_19); // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_27 = 7'h67 == io_opcode ? 1'h0 : _io_use_rs2_T_25; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_29 = 7'h37 == io_opcode ? 1'h0 : _io_use_rs2_T_27; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_31 = 7'h17 == io_opcode ? 1'h0 : _io_use_rs2_T_29; // @[Mux.scala 81:58]
  assign io_aluop = 7'h17 == io_opcode ? 4'h0 : _io_aluop_T_67; // @[Mux.scala 81:58]
  assign io_immsrc = 7'h73 == io_opcode ? 3'h7 == io_funct3 | (3'h6 == io_funct3 | 3'h5 == io_funct3) : 7'h17 ==
    io_opcode | (7'h37 == io_opcode | (7'h67 == io_opcode | (7'h6f == io_opcode | _io_immsrc_T_23))); // @[Mux.scala 81:58]
  assign io_isbranch = 7'h63 == io_opcode; // @[Mux.scala 81:61]
  assign io_memread = 7'h3 == io_opcode; // @[Mux.scala 81:61]
  assign io_memwrite = 7'h23 == io_opcode; // @[Mux.scala 81:61]
  assign io_regwrite = 7'h73 == io_opcode ? 3'h7 == io_funct3 | (3'h6 == io_funct3 | (3'h5 == io_funct3 | (3'h3 ==
    io_funct3 | (3'h2 == io_funct3 | 3'h1 == io_funct3)))) : 7'h17 == io_opcode | (7'h37 == io_opcode | (7'h67 ==
    io_opcode | (7'h6f == io_opcode | _io_regwrite_T_23))); // @[Mux.scala 81:58]
  assign io_memtoreg = 7'h73 == io_opcode ? _io_memtoreg_T_13 : _io_memtoreg_T_23; // @[Mux.scala 81:58]
  assign io_pcsel = 7'h67 == io_opcode; // @[Mux.scala 81:61]
  assign io_rdsel = 7'h17 == io_opcode; // @[Mux.scala 81:61]
  assign io_isjump = 7'h67 == io_opcode | 7'h6f == io_opcode; // @[Mux.scala 81:58]
  assign io_islui = 7'h37 == io_opcode; // @[Mux.scala 81:61]
  assign io_use_rs1 = 7'h73 == io_opcode ? _io_use_rs1_T_13 : _io_use_rs1_T_31; // @[Mux.scala 81:58]
  assign io_use_rs2 = 7'h73 == io_opcode ? 1'h0 : _io_use_rs2_T_31; // @[Mux.scala 81:58]
endmodule
