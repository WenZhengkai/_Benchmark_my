`timescale 1ns / 1ps

module testbench;

//parameter or localparam
localparam WIDTH = 8;

// Inputs
reg clock;
reg reset;
reg io_enq_valid;
reg [7:0] io_enq_bits;
reg io_deq_ready;

// Outputs or inout
wire io_enq_credit, io_enq_credit_golden;
wire io_deq_valid, io_deq_valid_golden;
wire [7:0] io_deq_bits, io_deq_bits_golden;
wire [2:0] io_fifoCount, io_fifoCount_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden} === ({io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden} ^ {io_enq_credit, io_deq_valid, io_deq_bits, io_fifoCount} ^ {io_enq_credit_golden, io_deq_valid_golden, io_deq_bits_golden, io_fifoCount_golden}));

// Instantiate the Unit Under Test (UUT)
DCCreditReceiver_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq_valid(io_enq_valid),
    .io_enq_credit(io_enq_credit_golden),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid_golden),
    .io_deq_bits(io_deq_bits_golden),
    .io_fifoCount(io_fifoCount_golden)
);

dut uut (
    .clock(clock),
    .reset(reset),
    .io_enq_valid(io_enq_valid),
    .io_enq_credit(io_enq_credit),
    .io_enq_bits(io_enq_bits),
    .io_deq_ready(io_deq_ready),
    .io_deq_valid(io_deq_valid),
    .io_deq_bits(io_deq_bits),
    .io_fifoCount(io_fifoCount)
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
    io_enq_bits = 0;
    io_deq_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 1;
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;
    io_enq_valid = 1;
    io_enq_bits = 8'hFF;
    io_deq_ready = 1;
    #100;
    io_enq_valid = 0;
    io_enq_bits = 8'h00;
    io_deq_ready = 0;
    #100;

    // Test Case 1: Basic Enqueue and Dequeue Operation
    for (integer i = 0; i < 100; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 2: Buffer Full Condition
    for (integer i = 0; i < 6; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
    end
    io_enq_valid = 1;
    io_enq_bits = 8'hAA; // Attempt to enqueue additional data
    #10;

    // Test Case 3: Buffer Empty Condition
    io_deq_ready = 1;
    #10;
    io_deq_ready = 0;
    #10;

    // Test Case 4: Credit Management under Normal Conditions
    for (integer i = 0; i < 100; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
        io_deq_ready = 1;
        #10;
    end

    // Test Case 5: Reset Functionality
    for (integer i = 0; i < 5; i++) begin
        io_enq_valid = 1;
        io_enq_bits = i;
        #10;
    end
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Add a test stimulus that toggles the reset signal from 1 to 0 to simulate a reset event
    reset = 1;
    #10;
    reset = 0;
    #10;

// Additional stimulus to improve coverage
// Test Case 6: Toggle `io_enq_valid` without changing `io_enq_bits`
io_enq_valid = 1;
io_enq_bits = 8'h55;
#10;
io_enq_valid = 0;
#10;
io_enq_valid = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 7: Rapid toggling of `io_deq_ready` to check behavior
io_enq_valid = 1;
io_enq_bits = 8'hAA;
#10;
io_deq_ready = 1;
#5;
io_deq_ready = 0;
#5;
io_deq_ready = 1;
#5;
io_deq_ready = 0;
#5;
// Test Case 8: Fill the queue and then dequeue all to test wrap-around
for (integer i = 0; i < 5; i++) begin
    io_enq_valid = 1;
    io_enq_bits = i;
    #10;
end
io_enq_valid = 0;
#10;
for (integer i = 0; i < 5; i++) begin
    io_deq_ready = 1;
    #10;
end
io_deq_ready = 0;
#10;
// Test Case 9: Alternate between enqueue and dequeue to test full and empty conditions
for (integer i = 0; i < 10; i++) begin
    io_enq_valid = 1;
    io_enq_bits = i;
    #5;
    io_deq_ready = 1;
    #5;
end
// Test Case 10: Test reset functionality during operation
io_enq_valid = 1;
io_enq_bits = 8'hFF;
#10;
reset = 1;
#10;
reset = 0;
io_enq_valid = 0;
io_deq_ready = 1;
#10;
// Test Case 11: Edge case with maximum values
io_enq_valid = 1;
io_enq_bits = 8'hFF;
#10;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 12: Edge case with minimum values
io_enq_valid = 1;
io_enq_bits = 8'h00;
#10;
io_deq_ready = 1;
#10;
io_enq_valid = 0;
#10;
// Test Case 13: Simultaneous enqueue and dequeue
io_enq_valid = 1;
io_enq_bits = 8'hAA;
io_deq_ready = 1;
#10;
io_enq_valid = 1;
io_enq_bits = 8'hBB;
#10;
io_enq_valid = 0;
io_deq_ready = 0;
#10;
// Test Case 14: Enqueue with varying bit patterns
io_enq_valid = 1;
io_enq_bits = 8'hF0;
#10;
io_enq_bits = 8'h0F;
#10;
io_enq_bits = 8'hAA;
#10;
io_enq_bits = 8'h55;
#10;
io_enq_valid = 0;
#10;
// Test Case 15: Test with no valid enqueue
io_enq_valid = 0;
io_deq_ready = 1;
#10;
io_deq_ready = 0;
#10;

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
end

endmodule

module Queue_golden(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [2:0] io_count
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:4]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire  wrap = enq_ptr_value == 3'h4; // @[Counter.scala 73:24]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire  wrap_1 = deq_ptr_value == 3'h4; // @[Counter.scala 73:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire [2:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[Decoupled.scala 326:32]
  wire [2:0] _io_count_T = maybe_full ? 3'h5 : 3'h0; // @[Decoupled.scala 333:10]
  wire [2:0] _io_count_T_3 = 3'h5 + ptr_diff; // @[Decoupled.scala 334:57]
  wire [2:0] _io_count_T_4 = deq_ptr_value > enq_ptr_value ? _io_count_T_3 : ptr_diff; // @[Decoupled.scala 334:10]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_io_deq_bits_MPORT_data = ram_io_deq_bits_MPORT_addr >= 3'h5 ? _RAND_1[7:0] :
    ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_count = ptr_match ? _io_count_T : _io_count_T_4; // @[Decoupled.scala 331:20]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      if (wrap) begin // @[Counter.scala 87:20]
        enq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      if (wrap_1) begin // @[Counter.scala 87:20]
        deq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 5; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  deq_ptr_value = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCCreditReceiver_UInt8_golden(
  input        clock,
  input        reset,
  input        io_enq_valid,
  output       io_enq_credit,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [2:0] io_fifoCount
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  outFifo_clock; // @[golden.scala 29:23]
  wire  outFifo_reset; // @[golden.scala 29:23]
  wire  outFifo_io_enq_ready; // @[golden.scala 29:23]
  wire  outFifo_io_enq_valid; // @[golden.scala 29:23]
  wire [7:0] outFifo_io_enq_bits; // @[golden.scala 29:23]
  wire  outFifo_io_deq_ready; // @[golden.scala 29:23]
  wire  outFifo_io_deq_valid; // @[golden.scala 29:23]
  wire [7:0] outFifo_io_deq_bits; // @[golden.scala 29:23]
  wire [2:0] outFifo_io_count; // @[golden.scala 29:23]
  reg  ivalid; // @[golden.scala 27:23]
  reg [7:0] idata; // @[golden.scala 28:22]
  wire  _GEN_0 = io_deq_ready ? 1'h0 : ivalid; // @[golden.scala 36:24 37:28 40:28]
  wire  _GEN_1 = io_deq_ready & ivalid; // @[golden.scala 36:24 38:18 30:31]
  wire  _nextCredit_T = outFifo_io_deq_ready & outFifo_io_deq_valid; // @[Decoupled.scala 51:35]
  reg  ocredit; // @[golden.scala 52:24]
  Queue_golden outFifo ( // @[golden.scala 29:23]
    .clock(outFifo_clock),
    .reset(outFifo_reset),
    .io_enq_ready(outFifo_io_enq_ready),
    .io_enq_valid(outFifo_io_enq_valid),
    .io_enq_bits(outFifo_io_enq_bits),
    .io_deq_ready(outFifo_io_deq_ready),
    .io_deq_valid(outFifo_io_deq_valid),
    .io_deq_bits(outFifo_io_deq_bits),
    .io_count(outFifo_io_count)
  );
  assign io_enq_credit = ocredit; // @[golden.scala 53:17]
  assign io_deq_valid = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0 ? ivalid : outFifo_io_deq_valid; // @[golden.scala 35:61 43:18 48:12]
  assign io_deq_bits = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0 ? idata : outFifo_io_deq_bits; // @[golden.scala 35:61 44:17 48:12]
  assign io_fifoCount = outFifo_io_count; // @[golden.scala 51:16]
  assign outFifo_clock = clock;
  assign outFifo_reset = reset;
  assign outFifo_io_enq_valid = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0 ? _GEN_0 : ivalid; // @[golden.scala 35:61 46:26]
  assign outFifo_io_enq_bits = idata; // @[golden.scala 32:23 35:61 47:25]
  assign outFifo_io_deq_ready = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0 ? 1'h0 : io_deq_ready; // @[golden.scala 35:61 42:26 48:12]
  always @(posedge clock) begin
    ivalid <= io_enq_valid; // @[golden.scala 27:23]
    idata <= io_enq_bits; // @[golden.scala 28:22]
    if (reset) begin // @[golden.scala 52:24]
      ocredit <= 1'h0; // @[golden.scala 52:24]
    end else if (~outFifo_io_deq_valid & outFifo_io_count == 3'h0) begin // @[golden.scala 35:61]
      ocredit <= _GEN_1;
    end else begin
      ocredit <= _nextCredit_T; // @[golden.scala 49:16]
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
  ivalid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  idata = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  ocredit = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
