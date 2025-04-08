`timescale 1ns / 1ps

module testbench;

parameter DEPTH = 16;

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
wire [4:0] io_count, io_count_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden} === ({io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden} ^ {io_enq_ready, io_deq_valid, io_deq_bits, io_count} ^ {io_enq_ready_golden, io_deq_valid_golden, io_deq_bits_golden, io_count_golden}));

// Instantiate the Unit Under Test (UUT)
Queue_16_UInt8_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready_golden),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_ready(io_deq_ready),
  .io_deq_valid(io_deq_valid_golden),
  .io_deq_bits(io_deq_bits_golden),
  .io_count(io_count_golden)
);


dut uut (
  .clock(clock),
  .reset(reset),
  .io_enq_ready(io_enq_ready),
  .io_enq_valid(io_enq_valid),
  .io_enq_bits(io_enq_bits),
  .io_deq_ready(io_deq_ready),
  .io_deq_valid(io_deq_valid),
  .io_deq_bits(io_deq_bits),
  .io_count(io_count)
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
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0;
    #100;
    io_enq_valid = 1; io_enq_bits = 8'hFF; io_deq_ready = 1;
    #100;
    io_enq_valid = 0; io_enq_bits = 8'h00; io_deq_ready = 0;
    #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_enq_valid = 0;
        #10;
        io_deq_ready = 1;
        #10;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 2: Queue Full Condition
    for (integer i = 0; i < DEPTH; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
    end
    io_enq_valid = 1;
    io_enq_bits = 8'hAA;
    #10;
    io_enq_valid = 0;

    // Test Case 3: Queue Empty Condition
    io_deq_ready = 1;
    #100;
    io_deq_ready = 0;

    // Test Case 4: Reset Functionality
    reset = 1;
    #10;
    reset = 0;

    // Test Case 5: Concurrent Enqueue and Dequeue
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 6: Boundary Conditions and Pointer Wrap-around
    for (integer i = 0; i < 200; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Test Case 7: Stress Test
    for (integer i = 0; i < 100; i = i + 1) begin
        io_enq_valid = 1;
        io_enq_bits = i[7:0];
        #10;
        io_deq_ready = 1;
        #10;
        io_enq_valid = 0;
        io_deq_ready = 0;
        #10;
    end

    // Toggle reset signal
    reset = 1;
    #10;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
end

endmodule

module Queue_16_UInt8_golden(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [4:0] io_count
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[golden.scala 30:16]
  wire  ram_io_deq_bits_MPORT_en; // @[golden.scala 30:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[golden.scala 30:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[golden.scala 30:16]
  wire [7:0] ram_MPORT_data; // @[golden.scala 30:16]
  wire [3:0] ram_MPORT_addr; // @[golden.scala 30:16]
  wire  ram_MPORT_mask; // @[golden.scala 30:16]
  wire  ram_MPORT_en; // @[golden.scala 30:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[golden.scala 33:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[golden.scala 34:33]
  wire  empty = ptr_match & ~maybe_full; // @[golden.scala 35:25]
  wire  full = ptr_match & maybe_full; // @[golden.scala 36:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[golden.scala 65:32]
  wire [4:0] _io_count_T_1 = maybe_full & ptr_match ? 5'h10 : 5'h0; // @[golden.scala 68:20]
  wire [4:0] _GEN_11 = {{1'd0}, ptr_diff}; // @[golden.scala 68:62]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[golden.scala 30:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[golden.scala 60:19]
  assign io_deq_valid = ~empty; // @[golden.scala 59:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[golden.scala 62:15]
  assign io_count = _io_count_T_1 | _GEN_11; // @[golden.scala 68:62]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[golden.scala 30:16]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[golden.scala 43:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[golden.scala 47:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[golden.scala 33:27]
      maybe_full <= 1'h0; // @[golden.scala 33:27]
    end else if (do_enq != do_deq) begin // @[golden.scala 50:27]
      maybe_full <= do_enq; // @[golden.scala 51:16]
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
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
