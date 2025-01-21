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
DCInput_UInt8_golden golden_model (
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
    reset = 1;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus to check basic functionality
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_deq_ready = 0;
    
    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = $random;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 2: Enqueue with Buffer Full
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    #10;
    io_enq_valid = 1;
    io_enq_bits = 8'hBB;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;

    // Test Case 3: Dequeue with Buffer Empty
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    io_deq_ready = 0;

    // Test Case 4: Reset Functionality
    io_enq_valid = 1;
    io_enq_bits = 8'hCC;
    #10;
    reset = 1;
    #10;
    reset = 0;
    io_enq_valid = 0;
    io_deq_ready = 0;

    // Test Case 5: Continuous Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Toggle reset signal to simulate a reset event
    #100;
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Be sure to save the following code in the final generated testbench.sv

    // Additional stimulus to improve coverage
    // Test Case 6: Toggle all bits of hold register
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'b00000000;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    io_enq_valid = 1;
    io_enq_bits = 8'b11111111;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;
    // Test Case 7: Transition through all bits of io_enq_bits
    for (integer i = 0; i < 256; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end
    // Test Case 8: Rapid toggling of io_deq_ready without valid data
    #100;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 1;
    #5;
    io_deq_ready = 0;
    #5;
    io_deq_ready = 1;
    #5;
    io_deq_ready = 0;
    #5;
    // Test Case 9: Enqueue data when io_deq_ready is toggling
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    io_deq_ready = 1;
    #5;
    io_deq_ready = 0;
    #5;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #5;
    io_deq_ready = 0;
    #5;
    // Test Case 10: Reset during active operation
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'h55;
    io_deq_ready = 1;
    #10;
    reset = 1;
    #10;
    reset = 0;
    io_enq_valid = 0;
    io_deq_ready = 0;
    #10;
    // Test Case 11: Check all branches and conditions
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'h01;
    io_deq_ready = 1;
    #10;
    io_enq_valid = 0;
    #10;
    io_enq_valid = 1;
    io_enq_bits = 8'h02;
    io_deq_ready = 0;
    #10;
    io_enq_valid = 0;
    io_deq_ready = 1;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule

module DCInput_UInt8_golden(
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
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  ready_r; // @[golden.scala 22:24]
  reg  occupied; // @[golden.scala 23:25]
  reg [7:0] hold; // @[golden.scala 24:17]
  wire  drain = occupied & io_deq_ready; // @[golden.scala 28:21]
  wire  load = io_enq_valid & ready_r & (~io_deq_ready | drain); // @[golden.scala 29:35]
  wire  _GEN_1 = drain ? 1'h0 : occupied; // @[golden.scala 41:21 42:14 23:25]
  wire  _GEN_2 = load | _GEN_1; // @[golden.scala 38:14 39:14]
  assign io_enq_ready = ready_r; // @[golden.scala 46:16]
  assign io_deq_valid = io_enq_valid | occupied; // @[golden.scala 37:32]
  assign io_deq_bits = occupied ? hold : io_enq_bits; // @[golden.scala 31:18 32:17 34:17]
  always @(posedge clock) begin
    ready_r <= reset | (~occupied & ~load | drain & ~load); // @[golden.scala 22:{24,24} 45:11]
    if (reset) begin // @[golden.scala 23:25]
      occupied <= 1'h0; // @[golden.scala 23:25]
    end else begin
      occupied <= _GEN_2;
    end
    if (load) begin // @[golden.scala 38:14]
      hold <= io_enq_bits; // @[golden.scala 40:10]
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
  ready_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  occupied = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  hold = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
