`timescale 1ns / 1ps

module testbench;

  // parameter or localparam
  // No parameters or localparams in the provided RTL

  // Inputs
  reg clock;
  reg reset;
  reg io_dataIn_valid;
  reg [4:0] io_dataIn_bits;
  reg io_dataOut_ready;

  // Outputs or inout
  wire io_dataIn_ready, io_dataIn_ready_golden;
  wire io_dataOut_valid, io_dataOut_valid_golden;
  wire [7:0] io_dataOut_bits, io_dataOut_bits_golden;

  integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden} === ({io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden} ^ {io_dataIn_ready, io_dataOut_valid, io_dataOut_bits} ^ {io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden}));

  // Instantiate the Unit Under Test (UUT)
  DCDeserializer_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_dataIn_ready(io_dataIn_ready_golden),
    .io_dataIn_valid(io_dataIn_valid),
    .io_dataIn_bits(io_dataIn_bits),
    .io_dataOut_ready(io_dataOut_ready),
    .io_dataOut_valid(io_dataOut_valid_golden),
    .io_dataOut_bits(io_dataOut_bits_golden)
  );

  dut uut (
    .clock(clock),
    .reset(reset),
    .io_dataIn_ready(io_dataIn_ready),
    .io_dataIn_valid(io_dataIn_valid),
    .io_dataIn_bits(io_dataIn_bits),
    .io_dataOut_ready(io_dataOut_ready),
    .io_dataOut_valid(io_dataOut_valid),
    .io_dataOut_bits(io_dataOut_bits)
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
    io_dataIn_valid = 0;
    io_dataIn_bits = 5'b0;
    io_dataOut_ready = 0;

    // Wait 100 ns for global reset to finish
    #100; reset = 0;

    // Add stimulus here
    // Initial stimulus to testbench
    io_dataIn_valid = 0; io_dataIn_bits = 5'b0; io_dataOut_ready = 0;
    #100; io_dataIn_valid = 1; io_dataIn_bits = 5'b11111; io_dataOut_ready = 1;
    #100; io_dataIn_valid = 0; io_dataIn_bits = 5'b0; io_dataOut_ready = 0;

    // Test Case 1: Basic Deserialization Test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_dataIn_valid = 1;
      io_dataIn_bits = 5'b10101;
      #10;
      io_dataIn_bits = 5'b01010;
      #10;
    end

    // Test Case 2: Reset Functionality Test
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Test Case 3: Data Ready and Valid Handshake Test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_dataIn_valid = 1;
      io_dataOut_ready = 0;
      io_dataIn_bits = 5'b10101;
      #10;
      io_dataOut_ready = 1;
      #10;
    end

    // Test Case 4: Cycle Management and Output Construction Test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_dataIn_valid = 1;
      io_dataIn_bits = 5'b11111;
      #10;
      io_dataIn_bits = 5'b00000;
      #10;
    end

    // Test Case 5: Exception Handling Test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_dataIn_valid = 1;
      io_dataIn_bits = 5'b10101;
      #10;
      io_dataIn_valid = 0;
      #10;
      io_dataIn_valid = 1;
      io_dataIn_bits = 5'b01010;
      #10;
    end

    // Final reset stimulus
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Finish simulation

// Additional stimulus to improve coverage
// Test Case 6: Ensure all bits in io_dataOut_bits toggle
// This will ensure that each bit in the output toggles from 0 to 1 and 1 to 0.
io_dataIn_valid = 1;
io_dataOut_ready = 1;
io_dataIn_bits = 5'b00000; // All bits low
#10;
io_dataIn_bits = 5'b11111; // All bits high
#10;
io_dataIn_bits = 5'b10101; // Alternate bits
#10;
io_dataIn_bits = 5'b01010; // Alternate bits
#10;
// Test Case 7: Test reset functionality during operation
// This will help ensure the reset condition is tested during various states.
io_dataIn_valid = 1;
io_dataIn_bits = 5'b11011;
#10;
reset = 1; // Assert reset during operation
#10;
reset = 0; // Deassert reset
#10;
io_dataIn_bits = 5'b00100;
#10;
// Test Case 8: Ensure condition coverage on cycleCount and dataValid
// This will help cover all branches and conditions.
io_dataIn_valid = 1;
io_dataIn_bits = 5'b01101;
#10;
io_dataIn_bits = 5'b10010;
#10;
io_dataOut_ready = 0; // Change output ready to test dataValid behavior
#10;
io_dataOut_ready = 1;
#10;
// Test Case 9: Edge case testing with minimum and maximum values
// This will ensure edge cases are handled properly.
io_dataIn_valid = 1;
io_dataIn_bits = 5'b00000; // Minimum value
#10;
io_dataIn_bits = 5'b11111; // Maximum value
#10;
// Test Case 10: Randomized testing for robustness
// This will help in catching any unforeseen issues.
for (integer i = 0; i < 10; i = i + 1) begin
  io_dataIn_valid = $random;
  io_dataIn_bits = $random % 32; // Random 5-bit value
  io_dataOut_ready = $random;
  #10;
end

$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

$finish;
  end

endmodule

module DCDeserializer_golden(
  input        clock,
  input        reset,
  output       io_dataIn_ready,
  input        io_dataIn_valid,
  input  [4:0] io_dataIn_bits,
  input        io_dataOut_ready,
  output       io_dataOut_valid,
  output [7:0] io_dataOut_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  cycleCount; // @[golden.scala 25:27]
  reg [4:0] dataSelect_0; // @[golden.scala 26:23]
  reg [4:0] dataSelect_1; // @[golden.scala 26:23]
  reg  dataValid; // @[golden.scala 27:26]
  wire [9:0] _io_dataOut_bits_T = {dataSelect_1,dataSelect_0}; // @[golden.scala 29:41]
  wire  _T = io_dataIn_ready & io_dataIn_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_2 = cycleCount | dataValid; // @[golden.scala 35:41 36:17 27:26]
  wire  _T_2 = io_dataOut_ready & io_dataOut_valid; // @[Decoupled.scala 51:35]
  assign io_dataIn_ready = ~dataValid | dataValid & io_dataOut_ready; // @[golden.scala 31:33]
  assign io_dataOut_valid = dataValid; // @[golden.scala 30:20]
  assign io_dataOut_bits = _io_dataOut_bits_T[7:0]; // @[golden.scala 29:{41,41}]
  always @(posedge clock) begin
    if (reset) begin // @[golden.scala 25:27]
      cycleCount <= 1'h0; // @[golden.scala 25:27]
    end else if (_T) begin // @[golden.scala 33:24]
      if (cycleCount) begin // @[golden.scala 35:41]
        cycleCount <= 1'h0; // @[golden.scala 37:18]
      end else begin
        cycleCount <= cycleCount + 1'h1; // @[golden.scala 39:18]
      end
    end
    if (_T) begin // @[golden.scala 33:24]
      if (~cycleCount) begin // @[golden.scala 34:28]
        dataSelect_0 <= io_dataIn_bits; // @[golden.scala 34:28]
      end
    end
    if (_T) begin // @[golden.scala 33:24]
      if (cycleCount) begin // @[golden.scala 34:28]
        dataSelect_1 <= io_dataIn_bits; // @[golden.scala 34:28]
      end
    end
    if (reset) begin // @[golden.scala 27:26]
      dataValid <= 1'h0; // @[golden.scala 27:26]
    end else if (_T_2) begin // @[golden.scala 42:25]
      dataValid <= 1'h0; // @[golden.scala 43:15]
    end else if (_T) begin // @[golden.scala 33:24]
      dataValid <= _GEN_2;
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
  cycleCount = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataSelect_0 = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  dataSelect_1 = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  dataValid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
