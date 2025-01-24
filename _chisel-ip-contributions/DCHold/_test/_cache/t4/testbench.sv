`timescale 1ns / 1ps

module testbench;

//parameter or localparam 


// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [7:0] io_enq_bits;
reg io_deq_ready;

// Outputs or inout
wire io_enq_ready, io_enq_ready_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [7:0] io_deq_bits, io_deq_bits_golden;


integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden}));

// Instantiate the Unit Under Test (UUT)
DCHold_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready_golden),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden)
);

dut uut (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_enq_ready),
    .io_enq_valid(io_enq_valid),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits)
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
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 1;
    #10;
    reset = 0;

    // Add stimulus here
    // Initial stimulus to toggle all inputs
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0; #100;
    io_enq_valid = 1; io_enq_bits = 8'hFF; io_deq_ready = 1; #100;
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0; #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'h55;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
    end

    // Test Case 2: Buffer Full Condition
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'h55;
        #10;
        io_enq_valid = 1;
        io_enq_bits = 8'hAA;
        #10;
    end

    // Test Case 3: Asynchronous Reset
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'hAB;
        #10;
        reset = 1;
        #10;
        reset = 0;
        #10;
    end

    // Test Case 4: Data Integrity and Handshaking
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = 8'hAB;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
    end

    // Reset signal toggle to simulate a reset event
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Finish simulation

    // Test Case 5: Toggle all bits of io_enq_bits
    io_enq_valid = 1;
    for (integer i = 0; i < 256; i = i + 1) begin
        io_enq_bits = i[7:0];
        #10;
        io_enq_valid = 0;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
        #10;
    end
    // Test Case 6: Test all possible transitions for pValid
    // Transition from 0 to 1
    io_enq_valid = 1; io_enq_bits = 8'hAA; io_deq_ready = 0; #10;
    // Transition from 1 to 0
    io_enq_valid = 0; io_deq_ready = 1; #10;
    io_deq_ready = 0; #10;
    // Test Case 7: Test reset functionality during operation
    io_enq_valid = 1; io_enq_bits = 8'hCC; io_deq_ready = 0; #10;
    reset = 1; #10; reset = 0; #10;
    io_enq_valid = 0; io_deq_ready = 1; #10;
    io_deq_ready = 0; #10;
    // Test Case 8: Alternate enqueue and dequeue operations
    for (integer i = 0; i < 10; i = i + 1) begin
        io_enq_valid = 1; io_enq_bits = 8'hF0 + i; #10;
        io_enq_valid = 0;
        io_deq_ready = 1; #10;
        io_deq_ready = 0; #10;
    end
    // Test Case 9: Stress test with rapid enqueue and dequeue
    for (integer i = 0; i < 20; i = i + 1) begin
        io_enq_valid = 1; io_enq_bits = 8'hA5; #5;
        io_enq_valid = 0; io_deq_ready = 1; #5;
        io_deq_ready = 0; #5;
    end

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule

module DCHold_UInt8_golden(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  pValid; // @[golden.scala 23:23]
  reg [7:0] pData; // @[golden.scala 24:18]
  assign io_enq_ready = ~pValid; // @[golden.scala 34:19]
  assign io_deq_valid = pValid; // @[golden.scala 32:16]
  assign io_deq_bits = pData; // @[golden.scala 33:15]
  always @(posedge clock) begin
    if (reset) begin // @[golden.scala 23:23]
      pValid <= 1'h0; // @[golden.scala 23:23]
    end else if (io_enq_valid & ~pValid) begin // @[golden.scala 26:33]
      pValid <= io_enq_valid; // @[golden.scala 27:12]
    end else if (pValid & io_deq_ready) begin // @[golden.scala 29:47]
      pValid <= 1'h0; // @[golden.scala 30:12]
    end
    if (io_enq_valid & ~pValid) begin // @[golden.scala 26:33]
      pData <= io_enq_bits; // @[golden.scala 28:11]
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
  pValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pData = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
