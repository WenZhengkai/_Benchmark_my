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

DCCreditSender_UInt8 uut (
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