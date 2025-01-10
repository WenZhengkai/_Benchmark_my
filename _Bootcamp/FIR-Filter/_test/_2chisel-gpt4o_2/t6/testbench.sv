`timescale 1ns / 1ps

module testbench;

//parameter or localparam 

// Inputs
reg clock;
reg reset;
reg [11:0] io_in;

// Outputs or inout
wire [29:0] io_out, io_out_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));

// Instantiate the Unit Under Test (UUT)
dut uut (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out)
);

MyFir_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out_golden)
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
    reset = 0;
    io_in = 12'b0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: toggle io_in
    io_in = 12'b0;
    #100;
    io_in = 12'b111111111111;
    #100;
    io_in = 12'b0;
    #100;

    // Test Case 1: Normal Operating Mode
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = i[11:0];
        #10;
    end

    // Test Case 2: Coefficient Effectiveness
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = (i % 2 == 0) ? 12'hFFF : 12'h000;
        #10;
    end

    // Test Case 3: Reset Functionality
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'hAAA;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'h555;
        #10;
    end

    // Test Case 4: Boundary Input Conditions
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'h000;
        #10;
    end
    for (integer i = 0; i < 50; i = i + 1) begin
        io_in = 12'hFFF;
        #10;
    end

    // Test Case 5: Clock Edge Sensitivity
    for (integer i = 0; i < 100; i = i + 1) begin
        io_in = (i % 2 == 0) ? 12'hF0F : 12'h0F0;
        #10;
    end

    // Simulate a reset event
    reset = 1;
    #10;
    reset = 0;

    // Finish simulation
    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule

module MyFir_golden(
  input         clock,
  input         reset,
  input  [11:0] io_in,
  output [29:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] delays_REG; // @[FIR-FILTER.scala 20:20]
  reg [11:0] delays_REG_1; // @[FIR-FILTER.scala 20:20]
  reg [11:0] delays_REG_2; // @[FIR-FILTER.scala 20:20]
  reg [11:0] delays_REG_3; // @[FIR-FILTER.scala 20:20]
  reg [11:0] delays_REG_4; // @[FIR-FILTER.scala 20:20]
  reg [11:0] delays_REG_5; // @[FIR-FILTER.scala 20:20]
  wire [12:0] mults_0 = io_in * 1'h0; // @[FIR-FILTER.scala 25:79]
  wire [22:0] mults_1 = delays_REG * 11'h555; // @[FIR-FILTER.scala 25:79]
  wire [23:0] mults_2 = delays_REG_1 * 12'haab; // @[FIR-FILTER.scala 25:79]
  wire [24:0] mults_3 = delays_REG_2 * 13'h1000; // @[FIR-FILTER.scala 25:79]
  wire [23:0] mults_4 = delays_REG_3 * 12'haab; // @[FIR-FILTER.scala 25:79]
  wire [22:0] mults_5 = delays_REG_4 * 11'h555; // @[FIR-FILTER.scala 25:79]
  wire [12:0] mults_6 = delays_REG_5 * 1'h0; // @[FIR-FILTER.scala 25:79]
  wire [22:0] _GEN_0 = {{10'd0}, mults_0}; // @[FIR-FILTER.scala 28:30]
  wire [23:0] _result_T = _GEN_0 + mults_1; // @[FIR-FILTER.scala 28:30]
  wire [24:0] _result_T_1 = _result_T + mults_2; // @[FIR-FILTER.scala 28:30]
  wire [25:0] _result_T_2 = _result_T_1 + mults_3; // @[FIR-FILTER.scala 28:30]
  wire [25:0] _GEN_1 = {{2'd0}, mults_4}; // @[FIR-FILTER.scala 28:30]
  wire [26:0] _result_T_3 = _result_T_2 + _GEN_1; // @[FIR-FILTER.scala 28:30]
  wire [26:0] _GEN_2 = {{4'd0}, mults_5}; // @[FIR-FILTER.scala 28:30]
  wire [27:0] _result_T_4 = _result_T_3 + _GEN_2; // @[FIR-FILTER.scala 28:30]
  wire [27:0] _GEN_3 = {{15'd0}, mults_6}; // @[FIR-FILTER.scala 28:30]
  wire [28:0] result = _result_T_4 + _GEN_3; // @[FIR-FILTER.scala 28:30]
  assign io_out = {{1'd0}, result}; // @[FIR-FILTER.scala 31:10]
  always @(posedge clock) begin
    delays_REG <= io_in; // @[FIR-FILTER.scala 20:20]
    delays_REG_1 <= delays_REG; // @[FIR-FILTER.scala 19:37 20:10]
    delays_REG_2 <= delays_REG_1; // @[FIR-FILTER.scala 19:37 20:10]
    delays_REG_3 <= delays_REG_2; // @[FIR-FILTER.scala 19:37 20:10]
    delays_REG_4 <= delays_REG_3; // @[FIR-FILTER.scala 19:37 20:10]
    delays_REG_5 <= delays_REG_4; // @[FIR-FILTER.scala 19:37 20:10]
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
  delays_REG = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  delays_REG_1 = _RAND_1[11:0];
  _RAND_2 = {1{`RANDOM}};
  delays_REG_2 = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  delays_REG_3 = _RAND_3[11:0];
  _RAND_4 = {1{`RANDOM}};
  delays_REG_4 = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  delays_REG_5 = _RAND_5[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
