`timescale 1ns / 1ps

module testbench;

//parameter or localparam

// Inputs
reg clock;
reg reset;
reg [63:0] io_in;
reg io_encode;

// Outputs or inout
wire [63:0] io_out_golden, io_out;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_out_golden} === ({io_out_golden} ^ {io_out} ^ {io_out_golden}));

// Instantiate the Unit Under Test (UUT)
dut uut (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out),
  .io_encode(io_encode)
);

GrayCoder_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_in(io_in),
  .io_out(io_out_golden),
  .io_encode(io_encode)
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
    io_in = 64'h0;
    io_encode = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_in = 64'h0;
    #100;
    io_in = 64'hFFFFFFFFFFFFFFFF;
    #100;
    io_in = 64'h0;
    #100;

    // Test Case 1: Basic Encoding Operation
    io_in = 64'hAAAA_AAAA_AAAA_AAAA;
    io_encode = 1;
    #10;

    // Test Case 2: Basic Decoding Operation
    io_in = 64'h5555_5555_5555_5555; // Assuming this is the Gray code for 0xAAAA_AAAA_AAAA_AAAA
    io_encode = 0;
    #10;

    // Test Case 3: 64-bit Wide Data Handling
    io_in = 64'hFFFF_FFFF_FFFF_FFFF;
    io_encode = 1;
    #10;
    io_encode = 0;
    #10;

    // Test Case 4: Zero and One Transition
    for (integer i = 0; i < 64; i = i + 1) begin
      io_in = 64'h1 << i;
      io_encode = 1;
      #10;
    end

    // Test Case 5: Full Cycle Encode-Decode
    io_in = 64'h1234_5678_9ABC_DEF0;
    io_encode = 1;
    #10;
    io_in = io_out;
    io_encode = 0;
    #10;

    // Test Case 6: Unchanged Input on Mode Switch
    io_in = 64'h0F0F_0F0F_0F0F_0F0F;
    io_encode = 1;
    #10;
    io_encode = 0;
    #10;

    // Additional stimuli to improve coverage
    for (integer i = 0; i < 100; i = i + 1) begin
      io_in = $random;
      io_encode = $random % 2;
      #10;
    end

    // Reset event simulation
    reset = 1;
    #10;
    reset = 0;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
end

endmodule

module GrayCoder_golden(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output [63:0] io_out,
  input         io_encode
);
  wire [63:0] _io_out_T = {{1'd0}, io_in[63:1]}; // @[GrayCoder.scala 15:30]
  wire [63:0] _io_out_T_1 = io_in ^ _io_out_T; // @[GrayCoder.scala 15:21]
  wire [63:0] _io_out_T_2 = {{32'd0}, io_in[63:32]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_3 = io_in ^ _io_out_T_2; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_4 = {{16'd0}, _io_out_T_3[63:16]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_5 = _io_out_T_3 ^ _io_out_T_4; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_6 = {{8'd0}, _io_out_T_5[63:8]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_7 = _io_out_T_5 ^ _io_out_T_6; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_8 = {{4'd0}, _io_out_T_7[63:4]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_9 = _io_out_T_7 ^ _io_out_T_8; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_10 = {{2'd0}, _io_out_T_9[63:2]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_11 = _io_out_T_9 ^ _io_out_T_10; // @[GrayCoder.scala 19:18]
  wire [63:0] _io_out_T_12 = {{1'd0}, _io_out_T_11[63:1]}; // @[GrayCoder.scala 19:24]
  wire [63:0] _io_out_T_13 = _io_out_T_11 ^ _io_out_T_12; // @[GrayCoder.scala 19:18]
  assign io_out = io_encode ? _io_out_T_1 : _io_out_T_13; // @[GrayCoder.scala 14:20 15:12 17:12]
endmodule
