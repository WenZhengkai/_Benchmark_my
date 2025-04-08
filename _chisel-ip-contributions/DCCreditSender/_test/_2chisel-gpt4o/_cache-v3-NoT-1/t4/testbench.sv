`timescale 1ns / 1ps

module testbench;

// parameter or localparam
// None for this module

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [7:0] io_enq_bits;
reg io_deq_credit;

// Outputs or inout
wire io_enq_ready, io_enq_ready_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [7:0] io_deq_bits, io_deq_bits_golden;
wire [2:0] io_curCredit, io_curCredit_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_curCredit_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_curCredit_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits, io_curCredit} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_curCredit_golden}));

// Instantiate the Unit Under Test (UUT)
DCCreditSender_UInt8_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready_golden),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_valid(io_deq_valid_golden),
  .io_deq_credit(io_deq_credit),
  .io_deq_bits(io_deq_bits_golden),
  .io_curCredit(io_curCredit_golden)
);

dut uut (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_valid(io_deq_valid),
  .io_deq_credit(io_deq_credit),
  .io_deq_bits(io_deq_bits),
  .io_curCredit(io_curCredit)
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
    reset = 0;
    io_enq_valid = 0;
    io_enq_bits = 8'h0;
    io_deq_credit = 0;

    // Wait 100 ns for global reset to finish
    #100; reset = 1;
    #100; reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, then to one, then back to zero
    io_enq_valid = 0; io_enq_bits = 8'h0; io_deq_credit = 0;
    #100;
    io_enq_valid = 1; io_enq_bits = 8'hFF; io_deq_credit = 1;
    #100;
    io_enq_valid = 0; io_enq_bits = 8'h0; io_deq_credit = 0;
    #100;

    // Test Case 1: Credit Initialization and Reset Behavior
    reset = 1;
    #10; reset = 0;

    // Test Case 2: Credit Increment on Receiver Acknowledgment
    #10; io_deq_credit = 1;
    #10; io_deq_credit = 0;

    // Test Case 3: Credit Decrement on Data Send
    io_enq_valid = 1;
    for (integer i = 0; i < 100; i++) begin
        #10; io_enq_bits = 8'h01 << i % 8;
    end
    io_enq_valid = 0;

    // Test Case 4: Data Transmission Control
    io_enq_valid = 1;
    for (integer i = 0; i < 100; i++) begin
        #10; io_enq_bits = 8'hAA >> i % 8;
    end
    io_enq_valid = 0;

    // Test Case 5: Handling Edge Cases and Signal Integrity
    for (integer i = 0; i < 100; i++) begin
        #10; io_enq_valid = ~io_enq_valid;
        io_deq_credit = ~io_deq_credit;
    end

    // Test Case 6: Continuous Operation under High Data Throughput
    io_deq_credit = 1;
    io_enq_valid = 1;
    for (integer i = 0; i < 100; i++) begin
        #10; io_enq_bits = 8'hFF;
    end
    io_enq_valid = 0;
    io_deq_credit = 0;

    // Test stimulus that toggles the reset signal
    #10; reset = 1;
    #10; reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
end

endmodule

module DCCreditSender_UInt8_golden(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  output       io_deq_valid,
  input        io_deq_credit,
  output [7:0] io_deq_bits,
  output [2:0] io_curCredit
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  icredit; // @[golden.scala 27:24]
  reg [2:0] curCredit; // @[golden.scala 28:26]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _curCredit_T_1 = curCredit + 3'h1; // @[golden.scala 30:28]
  wire [2:0] _curCredit_T_3 = curCredit - 3'h1; // @[golden.scala 32:28]
  reg [7:0] dataOut; // @[Reg.scala 19:16]
  reg  validOut; // @[golden.scala 36:25]
  assign io_enq_ready = curCredit > 3'h0; // @[golden.scala 34:29]
  assign io_deq_valid = validOut; // @[golden.scala 37:16]
  assign io_deq_bits = dataOut; // @[golden.scala 38:15]
  assign io_curCredit = curCredit; // @[golden.scala 39:16]
  always @(posedge clock) begin
    icredit <= io_deq_credit; // @[golden.scala 27:24]
    if (reset) begin // @[golden.scala 28:26]
      curCredit <= 3'h5; // @[golden.scala 28:26]
    end else if (icredit & ~_T) begin // @[golden.scala 29:33]
      curCredit <= _curCredit_T_1; // @[golden.scala 30:15]
    end else if (~icredit & _T) begin // @[golden.scala 31:39]
      curCredit <= _curCredit_T_3; // @[golden.scala 32:15]
    end
    if (_T) begin // @[Reg.scala 20:18]
      dataOut <= io_enq_bits; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[golden.scala 36:25]
      validOut <= 1'h0; // @[golden.scala 36:25]
    end else begin
      validOut <= _T; // @[golden.scala 36:25]
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
  icredit = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  curCredit = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  dataOut = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  validOut = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
