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

dut uut (
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

module IFU_f0f1_golden(
  input         clock,
  input         reset,
  input         io_f2_flush,
  output        io_fromFtq_req_ready,
  input         io_fromFtq_req_valid,
  input  [31:0] io_fromFtq_req_bits_startAddr,
  output        io_f1_valid,
  input         io_f2_ready,
  output [31:0] io_f1_pc_0,
  output [31:0] io_f1_pc_1,
  output [31:0] io_f1_pc_2,
  output [31:0] io_f1_pc_3,
  output [31:0] io_f1_half_snpc_0,
  output [31:0] io_f1_half_snpc_1,
  output [31:0] io_f1_half_snpc_2,
  output [31:0] io_f1_half_snpc_3,
  output [4:0]  io_f1_cut_ptr_0,
  output [4:0]  io_f1_cut_ptr_1,
  output [4:0]  io_f1_cut_ptr_2,
  output [4:0]  io_f1_cut_ptr_3,
  output [4:0]  io_f1_cut_ptr_4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  f0_fire = io_fromFtq_req_ready & io_fromFtq_req_valid; // @[Decoupled.scala 51:35]
  reg  f1_valid; // @[IFU_f0f1.scala 50:30]
  reg [31:0] f1_ftq_req_startAddr; // @[Reg.scala 19:16]
  wire  f1_fire = f1_valid & io_f2_ready; // @[IFU_f0f1.scala 54:32]
  wire  _GEN_1 = f1_fire ? 1'h0 : f1_valid; // @[IFU_f0f1.scala 50:30 64:{35,46}]
  wire  _GEN_2 = f0_fire & ~io_f2_flush | _GEN_1; // @[IFU_f0f1.scala 63:{35,46}]
  wire [32:0] _T_2 = {{1'd0}, f1_ftq_req_startAddr}; // @[IFU_f0f1.scala 66:83]
  wire [5:0] _T_19 = {1'h0,f1_ftq_req_startAddr[5:1]}; // @[Cat.scala 33:92]
  wire [6:0] _T_20 = {{1'd0}, _T_19}; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_25 = _T_19 + 6'h1; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_29 = _T_19 + 6'h2; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_33 = _T_19 + 6'h3; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_37 = _T_19 + 6'h4; // @[IFU_f0f1.scala 70:122]
  assign io_fromFtq_req_ready = f1_fire | ~f1_valid; // @[IFU_f0f1.scala 56:26]
  assign io_f1_valid = f1_valid; // @[IFU_f0f1.scala 72:15]
  assign io_f1_pc_0 = _T_2[31:0]; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_1 = f1_ftq_req_startAddr + 32'h2; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_2 = f1_ftq_req_startAddr + 32'h4; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_3 = f1_ftq_req_startAddr + 32'h6; // @[IFU_f0f1.scala 66:83]
  assign io_f1_half_snpc_0 = f1_ftq_req_startAddr + 32'h4; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_1 = f1_ftq_req_startAddr + 32'h6; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_2 = f1_ftq_req_startAddr + 32'h8; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_3 = f1_ftq_req_startAddr + 32'ha; // @[IFU_f0f1.scala 68:83]
  assign io_f1_cut_ptr_0 = _T_20[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_1 = _T_25[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_2 = _T_29[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_3 = _T_33[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_4 = _T_37[4:0]; // @[IFU_f0f1.scala 70:19]
  always @(posedge clock) begin
    if (reset) begin // @[IFU_f0f1.scala 50:30]
      f1_valid <= 1'h0; // @[IFU_f0f1.scala 50:30]
    end else if (io_f2_flush) begin // @[IFU_f0f1.scala 62:35]
      f1_valid <= 1'h0; // @[IFU_f0f1.scala 62:46]
    end else begin
      f1_valid <= _GEN_2;
    end
    if (f0_fire) begin // @[Reg.scala 20:18]
      f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[Reg.scala 20:22]
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
  f1_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  f1_ftq_req_startAddr = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
