`timescale 1ns / 1ps

module testbench;

  // parameter or localparam
  // (No parameters or localparams in the provided RTL)

  // Inputs
  reg clock;
  reg reset;
  reg io_a_0_valid;
  reg [7:0] io_a_0_bits;
  reg io_a_1_valid;
  reg [7:0] io_a_1_bits;
  reg io_a_2_valid;
  reg [7:0] io_a_2_bits;
  reg io_a_3_valid;
  reg [7:0] io_a_3_bits;
  reg io_a_4_valid;
  reg [7:0] io_a_4_bits;
  reg io_a_5_valid;
  reg [7:0] io_a_5_bits;
  reg io_z_ready;

  // Outputs or inout
  wire io_a_0_ready, io_a_0_ready_golden;
  wire io_a_1_ready, io_a_1_ready_golden;
  wire io_a_2_ready, io_a_2_ready_golden;
  wire io_a_3_ready, io_a_3_ready_golden;
  wire io_a_4_ready, io_a_4_ready_golden;
  wire io_a_5_ready, io_a_5_ready_golden;
  wire io_z_valid, io_z_valid_golden;
  wire [7:0] io_z_bits, io_z_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden} === ({io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden} ^ {io_a_0_ready, io_a_1_ready, io_a_2_ready, io_a_3_ready, io_a_4_ready, io_a_5_ready, io_z_valid, io_z_bits} ^ {io_a_0_ready_golden, io_a_1_ready_golden, io_a_2_ready_golden, io_a_3_ready_golden, io_a_4_ready_golden, io_a_5_ready_golden, io_z_valid_golden, io_z_bits_golden}));

  // Instantiate the Unit Under Test (UUT)
  DCReduce_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_a_0_ready(io_a_0_ready_golden),
    .io_a_0_valid(io_a_0_valid),
    .io_a_0_bits(io_a_0_bits),
    .io_a_1_ready(io_a_1_ready_golden),
    .io_a_1_valid(io_a_1_valid),
    .io_a_1_bits(io_a_1_bits),
    .io_a_2_ready(io_a_2_ready_golden),
    .io_a_2_valid(io_a_2_valid),
    .io_a_2_bits(io_a_2_bits),
    .io_a_3_ready(io_a_3_ready_golden),
    .io_a_3_valid(io_a_3_valid),
    .io_a_3_bits(io_a_3_bits),
    .io_a_4_ready(io_a_4_ready_golden),
    .io_a_4_valid(io_a_4_valid),
    .io_a_4_bits(io_a_4_bits),
    .io_a_5_ready(io_a_5_ready_golden),
    .io_a_5_valid(io_a_5_valid),
    .io_a_5_bits(io_a_5_bits),
    .io_z_ready(io_z_ready),
    .io_z_valid(io_z_valid_golden),
    .io_z_bits(io_z_bits_golden)
  );


  dut uut (
    .clock(clock),
    .reset(reset),
    .io_a_0_ready(io_a_0_ready),
    .io_a_0_valid(io_a_0_valid),
    .io_a_0_bits(io_a_0_bits),
    .io_a_1_ready(io_a_1_ready),
    .io_a_1_valid(io_a_1_valid),
    .io_a_1_bits(io_a_1_bits),
    .io_a_2_ready(io_a_2_ready),
    .io_a_2_valid(io_a_2_valid),
    .io_a_2_bits(io_a_2_bits),
    .io_a_3_ready(io_a_3_ready),
    .io_a_3_valid(io_a_3_valid),
    .io_a_3_bits(io_a_3_bits),
    .io_a_4_ready(io_a_4_ready),
    .io_a_4_valid(io_a_4_valid),
    .io_a_4_bits(io_a_4_bits),
    .io_a_5_ready(io_a_5_ready),
    .io_a_5_valid(io_a_5_valid),
    .io_a_5_bits(io_a_5_bits),
    .io_z_ready(io_z_ready),
    .io_z_valid(io_z_valid),
    .io_z_bits(io_z_bits)
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
    io_a_0_valid = 0;
    io_a_0_bits = 8'h00;
    io_a_1_valid = 0;
    io_a_1_bits = 8'h00;
    io_a_2_valid = 0;
    io_a_2_bits = 8'h00;
    io_a_3_valid = 0;
    io_a_3_bits = 8'h00;
    io_a_4_valid = 0;
    io_a_4_bits = 8'h00;
    io_a_5_valid = 0;
    io_a_5_bits = 8'h00;
    io_z_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_a_0_valid = 1;
    io_a_1_valid = 1;
    io_a_2_valid = 1;
    io_a_3_valid = 1;
    io_a_4_valid = 1;
    io_a_5_valid = 1;
    io_z_ready = 1;
    #100;

    // Test Case 1: Multi-Channel Data Aggregation
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = $random;
      io_a_1_bits = $random;
      io_a_2_bits = $random;
      io_a_3_bits = $random;
      io_a_4_bits = $random;
      io_a_5_bits = $random;
      #10;
    end

    // Test Case 2: Bitwise XOR Reduction
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = i;
      io_a_1_bits = ~i;
      io_a_2_bits = i + 1;
      io_a_3_bits = ~i + 1;
      io_a_4_bits = i + 2;
      io_a_5_bits = ~i + 2;
      #10;
    end

    // Test Case 3: Data Validity and Readiness Handling
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_valid = i % 2;
      io_a_1_valid = (i + 1) % 2;
      io_a_2_valid = i % 2;
      io_a_3_valid = (i + 1) % 2;
      io_a_4_valid = i % 2;
      io_a_5_valid = (i + 1) % 2;
      #10;
    end

    // Test Case 4: Output Data Management
    for (integer i = 0; i < 100; i = i + 1) begin
      io_z_ready = i % 2;
      #10;
    end

    // Test Case 5: Internal Buffering and Signal Management
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = 8'hFF >> i;
      io_a_1_bits = 8'hAA << i;
      io_a_2_bits = 8'h55 >> i;
      io_a_3_bits = 8'h00 << i;
      io_a_4_bits = 8'hFF >> i;
      io_a_5_bits = 8'hAA << i;
      #10;
    end

    // Test Case 6: Synchronization with External Clock
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = 8'h0F;
      io_a_1_bits = 8'hF0;
      io_a_2_bits = 8'h0F;
      io_a_3_bits = 8'hF0;
      io_a_4_bits = 8'h0F;
      io_a_5_bits = 8'hF0;
      #10;
    end

    // Test Case 7: Reset Capability
    for (integer i = 0; i < 100; i = i + 1) begin
      if (i == 50) reset = 1;
      else reset = 0;
      #10;
    end

    // Final reset toggle
    reset = 1;
    #10;
    reset = 0;

    // Finish simulation

    // Test Case 8: Ensure all lines and conditions are covered
    // This includes edge cases for the ready and valid signals.
    // We will toggle the valid signals and ensure the ready signals are asserted accordingly.
    io_a_0_valid = 1;
    io_a_1_valid = 0;
    io_a_2_valid = 1;
    io_a_3_valid = 0;
    io_a_4_valid = 1;
    io_a_5_valid = 0;
    #10;
    io_a_0_valid = 0;
    io_a_1_valid = 1;
    io_a_2_valid = 0;
    io_a_3_valid = 1;
    io_a_4_valid = 0;
    io_a_5_valid = 1;
    #10;
    // Test Case 9: Toggle all input bits to ensure full coverage of toggle conditions
    io_a_0_bits = 8'hFF;
    io_a_1_bits = 8'h00;
    io_a_2_bits = 8'hFF;
    io_a_3_bits = 8'h00;
    io_a_4_bits = 8'hFF;
    io_a_5_bits = 8'h00;
    #10;
    io_a_0_bits = 8'h00;
    io_a_1_bits = 8'hFF;
    io_a_2_bits = 8'h00;
    io_a_3_bits = 8'hFF;
    io_a_4_bits = 8'h00;
    io_a_5_bits = 8'hFF;
    #10;
    // Test Case 10: Ensure all branches and conditions are covered
    // This includes toggling the reset signal to verify reset behavior
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test Case 11: Test edge cases for the XOR reduction logic
    // Use specific bit patterns to ensure all intermediate XOR results are covered
    io_a_0_bits = 8'hAA;
    io_a_1_bits = 8'h55;
    io_a_2_bits = 8'hAA;
    io_a_3_bits = 8'h55;
    io_a_4_bits = 8'hAA;
    io_a_5_bits = 8'h55;
    #10;
    io_a_0_bits = 8'h55;
    io_a_1_bits = 8'hAA;
    io_a_2_bits = 8'h55;
    io_a_3_bits = 8'hAA;
    io_a_4_bits = 8'h55;
    io_a_5_bits = 8'hAA;
    #10;
    // Test Case 12: Ensure all possible transitions between states are covered
    // This includes alternating ready and valid signals
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    // Test Case 13: Toggle signals to ensure complete toggle coverage
    for (integer j = 0; j < 8; j = j + 1) begin
      io_a_0_bits = 1 << j;
      io_a_1_bits = ~(1 << j);
      io_a_2_bits = 1 << j;
      io_a_3_bits = ~(1 << j);
      io_a_4_bits = 1 << j;
      io_a_5_bits = ~(1 << j);
      #10;
    end
    // Final reset to ensure all states transition back to initial state
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Additional stimuli to improve coverage
    // Test Case 14: Ensure all bits in 'hold' undergo transitions
    for (integer i = 0; i < 256; i = i + 1) begin
      io_a_0_bits = i;
      io_a_1_bits = ~i;
      io_a_2_bits = i ^ 8'hFF;
      io_a_3_bits = i & 8'hAA;
      io_a_4_bits = i | 8'h55;
      io_a_5_bits = i ^ 8'h55;
      #10;
    end
    // Test Case 15: Toggle all bits in 'hold' to cover all transitions
    io_a_0_bits = 8'hFF;
    io_a_1_bits = 8'h00;
    io_a_2_bits = 8'hFF;
    io_a_3_bits = 8'h00;
    io_a_4_bits = 8'hFF;
    io_a_5_bits = 8'h00;
    #10;
    io_a_0_bits = 8'h00;
    io_a_1_bits = 8'hFF;
    io_a_2_bits = 8'h00;
    io_a_3_bits = 8'hFF;
    io_a_4_bits = 8'h00;
    io_a_5_bits = 8'hFF;
    #10;
    // Test Case 16: Alternate valid signals to ensure complete condition coverage
    io_a_0_valid = 1;
    io_a_1_valid = 0;
    io_a_2_valid = 1;
    io_a_3_valid = 0;
    io_a_4_valid = 1;
    io_a_5_valid = 0;
    #10;
    io_a_0_valid = 0;
    io_a_1_valid = 1;
    io_a_2_valid = 0;
    io_a_3_valid = 1;
    io_a_4_valid = 0;
    io_a_5_valid = 1;
    #10;
    // Test Case 17: Ensure all possible transitions between states are covered
    // This includes alternating ready and valid signals
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    io_z_ready = 0;
    #10;
    io_z_ready = 1;
    #10;
    // Test Case 18: Ensure all conditions in ternary operators are covered
    io_a_0_bits = 8'hAA;
    io_a_1_bits = 8'h55;
    io_a_2_bits = 8'hAA;
    io_a_3_bits = 8'h55;
    io_a_4_bits = 8'hAA;
    io_a_5_bits = 8'h55;
    #10;
    io_a_0_bits = 8'h55;
    io_a_1_bits = 8'hAA;
    io_a_2_bits = 8'h55;
    io_a_3_bits = 8'hAA;
    io_a_4_bits = 8'h55;
    io_a_5_bits = 8'hAA;
    #10;
    // Test Case 19: Reset signal toggling to verify reset behavior
    reset = 1;
    #10;
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    // Test Case 20: Randomize inputs to ensure all branches and signal transitions
    for (integer i = 0; i < 100; i = i + 1) begin
      io_a_0_bits = $random;
      io_a_1_bits = $random;
      io_a_2_bits = $random;
      io_a_3_bits = $random;
      io_a_4_bits = $random;
      io_a_5_bits = $random;
      io_a_0_valid = $random % 2;
      io_a_1_valid = $random % 2;
      io_a_2_valid = $random % 2;
      io_a_3_valid = $random % 2;
      io_a_4_valid = $random % 2;
      io_a_5_valid = $random % 2;
      io_z_ready = $random % 2;
      #10;
    end

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
  reg  ready_r; // @[DCInput.scala 23:24]
  reg  occupied; // @[DCInput.scala 24:25]
  reg [7:0] hold; // @[DCInput.scala 25:17]
  wire  drain = occupied & io_deq_ready; // @[DCInput.scala 29:21]
  wire  load = io_enq_valid & ready_r & (~io_deq_ready | drain); // @[DCInput.scala 30:35]
  wire  _GEN_1 = drain ? 1'h0 : occupied; // @[DCInput.scala 42:21 43:14 24:25]
  wire  _GEN_2 = load | _GEN_1; // @[DCInput.scala 39:14 40:14]
  assign io_enq_ready = ready_r; // @[DCInput.scala 47:16]
  assign io_deq_valid = io_enq_valid | occupied; // @[DCInput.scala 38:32]
  assign io_deq_bits = occupied ? hold : io_enq_bits; // @[DCInput.scala 32:18 33:17 35:17]
  always @(posedge clock) begin
    ready_r <= reset | (~occupied & ~load | drain & ~load); // @[DCInput.scala 23:{24,24} 46:11]
    if (reset) begin // @[DCInput.scala 24:25]
      occupied <= 1'h0; // @[DCInput.scala 24:25]
    end else begin
      occupied <= _GEN_2;
    end
    if (load) begin // @[DCInput.scala 39:14]
      hold <= io_enq_bits; // @[DCInput.scala 41:10]
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
module DCOutput_UInt8_golden(
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
  reg  rValid; // @[DCOutput.scala 18:23]
  wire  _rValid_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg [7:0] io_deq_bits_r; // @[Reg.scala 19:16]
  assign io_enq_ready = io_deq_ready | ~rValid; // @[DCOutput.scala 20:32]
  assign io_deq_valid = rValid; // @[DCOutput.scala 23:16]
  assign io_deq_bits = io_deq_bits_r; // @[DCOutput.scala 22:15]
  always @(posedge clock) begin
    if (reset) begin // @[DCOutput.scala 18:23]
      rValid <= 1'h0; // @[DCOutput.scala 18:23]
    end else begin
      rValid <= _rValid_T | rValid & ~io_deq_ready; // @[DCOutput.scala 21:10]
    end
    if (_rValid_T) begin // @[Reg.scala 20:18]
      io_deq_bits_r <= io_enq_bits; // @[Reg.scala 20:22]
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
  rValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_deq_bits_r = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCReduce_golden(
  input        clock,
  input        reset,
  output       io_a_0_ready,
  input        io_a_0_valid,
  input  [7:0] io_a_0_bits,
  output       io_a_1_ready,
  input        io_a_1_valid,
  input  [7:0] io_a_1_bits,
  output       io_a_2_ready,
  input        io_a_2_valid,
  input  [7:0] io_a_2_bits,
  output       io_a_3_ready,
  input        io_a_3_valid,
  input  [7:0] io_a_3_bits,
  output       io_a_4_ready,
  input        io_a_4_valid,
  input  [7:0] io_a_4_bits,
  output       io_a_5_ready,
  input        io_a_5_valid,
  input  [7:0] io_a_5_bits,
  input        io_z_ready,
  output       io_z_valid,
  output [7:0] io_z_bits
);
  wire  aInt_tout_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_1_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_1_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_2_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_2_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_3_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_3_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_4_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_4_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_5_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_5_io_deq_bits; // @[DCInput.scala 53:22]
  wire  zDcout_tout_clock; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_reset; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_enq_ready; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_enq_valid; // @[DCOutput.scala 29:22]
  wire [7:0] zDcout_tout_io_enq_bits; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_deq_ready; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_deq_valid; // @[DCOutput.scala 29:22]
  wire [7:0] zDcout_tout_io_deq_bits; // @[DCOutput.scala 29:22]
  wire  all_valid = aInt_tout_io_deq_valid & aInt_tout_1_io_deq_valid & aInt_tout_2_io_deq_valid &
    aInt_tout_3_io_deq_valid & aInt_tout_4_io_deq_valid & aInt_tout_5_io_deq_valid; // @[golden.scala 26:46]
  wire [7:0] _zInt_bits_T = aInt_tout_io_deq_bits ^ aInt_tout_1_io_deq_bits; // @[golden.scala 45:39]
  wire [7:0] _zInt_bits_T_1 = _zInt_bits_T ^ aInt_tout_2_io_deq_bits; // @[golden.scala 45:39]
  wire [7:0] _zInt_bits_T_2 = _zInt_bits_T_1 ^ aInt_tout_3_io_deq_bits; // @[golden.scala 45:39]
  wire [7:0] _zInt_bits_T_3 = _zInt_bits_T_2 ^ aInt_tout_4_io_deq_bits; // @[golden.scala 45:39]
  wire  zInt_ready = zDcout_tout_io_enq_ready; // @[golden.scala 23:18 DCOutput.scala 30:17]
  DCInput_UInt8_golden aInt_tout ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_clock),
    .reset(aInt_tout_reset),
    .io_enq_ready(aInt_tout_io_enq_ready),
    .io_enq_valid(aInt_tout_io_enq_valid),
    .io_enq_bits(aInt_tout_io_enq_bits),
    .io_deq_ready(aInt_tout_io_deq_ready),
    .io_deq_valid(aInt_tout_io_deq_valid),
    .io_deq_bits(aInt_tout_io_deq_bits)
  );
  DCInput_UInt8_golden aInt_tout_1 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_1_clock),
    .reset(aInt_tout_1_reset),
    .io_enq_ready(aInt_tout_1_io_enq_ready),
    .io_enq_valid(aInt_tout_1_io_enq_valid),
    .io_enq_bits(aInt_tout_1_io_enq_bits),
    .io_deq_ready(aInt_tout_1_io_deq_ready),
    .io_deq_valid(aInt_tout_1_io_deq_valid),
    .io_deq_bits(aInt_tout_1_io_deq_bits)
  );
  DCInput_UInt8_golden aInt_tout_2 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_2_clock),
    .reset(aInt_tout_2_reset),
    .io_enq_ready(aInt_tout_2_io_enq_ready),
    .io_enq_valid(aInt_tout_2_io_enq_valid),
    .io_enq_bits(aInt_tout_2_io_enq_bits),
    .io_deq_ready(aInt_tout_2_io_deq_ready),
    .io_deq_valid(aInt_tout_2_io_deq_valid),
    .io_deq_bits(aInt_tout_2_io_deq_bits)
  );
  DCInput_UInt8_golden aInt_tout_3 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_3_clock),
    .reset(aInt_tout_3_reset),
    .io_enq_ready(aInt_tout_3_io_enq_ready),
    .io_enq_valid(aInt_tout_3_io_enq_valid),
    .io_enq_bits(aInt_tout_3_io_enq_bits),
    .io_deq_ready(aInt_tout_3_io_deq_ready),
    .io_deq_valid(aInt_tout_3_io_deq_valid),
    .io_deq_bits(aInt_tout_3_io_deq_bits)
  );
  DCInput_UInt8_golden aInt_tout_4 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_4_clock),
    .reset(aInt_tout_4_reset),
    .io_enq_ready(aInt_tout_4_io_enq_ready),
    .io_enq_valid(aInt_tout_4_io_enq_valid),
    .io_enq_bits(aInt_tout_4_io_enq_bits),
    .io_deq_ready(aInt_tout_4_io_deq_ready),
    .io_deq_valid(aInt_tout_4_io_deq_valid),
    .io_deq_bits(aInt_tout_4_io_deq_bits)
  );
  DCInput_UInt8_golden aInt_tout_5 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_5_clock),
    .reset(aInt_tout_5_reset),
    .io_enq_ready(aInt_tout_5_io_enq_ready),
    .io_enq_valid(aInt_tout_5_io_enq_valid),
    .io_enq_bits(aInt_tout_5_io_enq_bits),
    .io_deq_ready(aInt_tout_5_io_deq_ready),
    .io_deq_valid(aInt_tout_5_io_deq_valid),
    .io_deq_bits(aInt_tout_5_io_deq_bits)
  );
  DCOutput_UInt8_golden zDcout_tout ( // @[DCOutput.scala 29:22]
    .clock(zDcout_tout_clock),
    .reset(zDcout_tout_reset),
    .io_enq_ready(zDcout_tout_io_enq_ready),
    .io_enq_valid(zDcout_tout_io_enq_valid),
    .io_enq_bits(zDcout_tout_io_enq_bits),
    .io_deq_ready(zDcout_tout_io_deq_ready),
    .io_deq_valid(zDcout_tout_io_deq_valid),
    .io_deq_bits(zDcout_tout_io_deq_bits)
  );
  assign io_a_0_ready = aInt_tout_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_1_ready = aInt_tout_1_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_2_ready = aInt_tout_2_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_3_ready = aInt_tout_3_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_4_ready = aInt_tout_4_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_5_ready = aInt_tout_5_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_z_valid = zDcout_tout_io_deq_valid; // @[golden.scala 39:8]
  assign io_z_bits = zDcout_tout_io_deq_bits; // @[golden.scala 39:8]
  assign aInt_tout_clock = clock;
  assign aInt_tout_reset = reset;
  assign aInt_tout_io_enq_valid = io_a_0_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_io_enq_bits = io_a_0_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign aInt_tout_1_clock = clock;
  assign aInt_tout_1_reset = reset;
  assign aInt_tout_1_io_enq_valid = io_a_1_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_1_io_enq_bits = io_a_1_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_1_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign aInt_tout_2_clock = clock;
  assign aInt_tout_2_reset = reset;
  assign aInt_tout_2_io_enq_valid = io_a_2_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_2_io_enq_bits = io_a_2_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_2_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign aInt_tout_3_clock = clock;
  assign aInt_tout_3_reset = reset;
  assign aInt_tout_3_io_enq_valid = io_a_3_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_3_io_enq_bits = io_a_3_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_3_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign aInt_tout_4_clock = clock;
  assign aInt_tout_4_reset = reset;
  assign aInt_tout_4_io_enq_valid = io_a_4_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_4_io_enq_bits = io_a_4_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_4_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign aInt_tout_5_clock = clock;
  assign aInt_tout_5_reset = reset;
  assign aInt_tout_5_io_enq_valid = io_a_5_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_5_io_enq_bits = io_a_5_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_5_io_deq_ready = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign zDcout_tout_clock = clock;
  assign zDcout_tout_reset = reset;
  assign zDcout_tout_io_enq_valid = all_valid & zInt_ready; // @[golden.scala 28:18]
  assign zDcout_tout_io_enq_bits = _zInt_bits_T_3 ^ aInt_tout_5_io_deq_bits; // @[golden.scala 45:39]
  assign zDcout_tout_io_deq_ready = io_z_ready; // @[golden.scala 39:8]
endmodule
