`timescale 1ns / 1ps

module testbench;

//parameter or localparam 
// No parameters or localparams in the given RTL

// Inputs
reg clock;
reg reset;
reg [4:0] io_dst;
reg io_c_valid;
reg [7:0] io_c_bits;
reg io_p_0_ready;
reg io_p_1_ready;
reg io_p_2_ready;
reg io_p_3_ready;
reg io_p_4_ready;

// Outputs or inout
  wire io_c_ready, io_c_ready_golden;
  wire io_p_0_valid, io_p_0_valid_golden;
  wire [7:0] io_p_0_bits, io_p_0_bits_golden;
  wire io_p_1_valid, io_p_1_valid_golden;
  wire [7:0] io_p_1_bits, io_p_1_bits_golden;
  wire io_p_2_valid, io_p_2_valid_golden;
  wire [7:0] io_p_2_bits, io_p_2_bits_golden;
  wire io_p_3_valid, io_p_3_valid_golden;
  wire [7:0] io_p_3_bits, io_p_3_bits_golden;
  wire io_p_4_valid, io_p_4_valid_golden;
  wire [7:0] io_p_4_bits, io_p_4_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} === ({io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden} ^ {io_c_ready, io_p_0_valid, io_p_0_bits, io_p_1_valid, io_p_1_bits, io_p_2_valid, io_p_2_bits, io_p_3_valid, io_p_3_bits, io_p_4_valid, io_p_4_bits} ^ {io_c_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden, io_p_2_valid_golden, io_p_2_bits_golden, io_p_3_valid_golden, io_p_3_bits_golden, io_p_4_valid_golden, io_p_4_bits_golden}));

// Instantiate the Unit Under Test (UUT)
DCMirror_UInt8_N5_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_dst(io_dst),
  .io_c_ready(io_c_ready_golden),
  .io_c_valid(io_c_valid),
  .io_c_bits(io_c_bits),
  .io_p_0_ready(io_p_0_ready),
  .io_p_0_valid(io_p_0_valid_golden),
  .io_p_0_bits(io_p_0_bits_golden),
  .io_p_1_ready(io_p_1_ready),
  .io_p_1_valid(io_p_1_valid_golden),
  .io_p_1_bits(io_p_1_bits_golden),
  .io_p_2_ready(io_p_2_ready),
  .io_p_2_valid(io_p_2_valid_golden),
  .io_p_2_bits(io_p_2_bits_golden),
  .io_p_3_ready(io_p_3_ready),
  .io_p_3_valid(io_p_3_valid_golden),
  .io_p_3_bits(io_p_3_bits_golden),
  .io_p_4_ready(io_p_4_ready),
  .io_p_4_valid(io_p_4_valid_golden),
  .io_p_4_bits(io_p_4_bits_golden)
);


dut uut (
  .clock(clock),
  .reset(reset),
  .io_dst(io_dst),
  .io_c_ready(io_c_ready),
  .io_c_valid(io_c_valid),
  .io_c_bits(io_c_bits),
  .io_p_0_ready(io_p_0_ready),
  .io_p_0_valid(io_p_0_valid),
  .io_p_0_bits(io_p_0_bits),
  .io_p_1_ready(io_p_1_ready),
  .io_p_1_valid(io_p_1_valid),
  .io_p_1_bits(io_p_1_bits),
  .io_p_2_ready(io_p_2_ready),
  .io_p_2_valid(io_p_2_valid),
  .io_p_2_bits(io_p_2_bits),
  .io_p_3_ready(io_p_3_ready),
  .io_p_3_valid(io_p_3_valid),
  .io_p_3_bits(io_p_3_bits),
  .io_p_4_ready(io_p_4_ready),
  .io_p_4_valid(io_p_4_valid),
  .io_p_4_bits(io_p_4_bits)
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
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, then to one, then back to zero
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #100;
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hFF;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #100;
    io_dst = 5'b0;
    io_c_valid = 0;
    io_c_bits = 8'b0;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #100;

    // Test Case 1: Basic Data Routing
    io_dst = 5'b10101;
    io_c_valid = 1;
    io_c_bits = 8'hAA;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hAA + i;
        #10;
    end

    // Test Case 2: Channel Not Ready
    io_dst = 5'b10101;
    io_c_valid = 1;
    io_c_bits = 8'hBB;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 0; // Channel 2 not ready
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hBB + i;
        #10;
    end

    // Test Case 3: Dynamic Update of Destination Mask
    io_dst = 5'b01110;
    io_c_valid = 1;
    io_c_bits = 8'hCC;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hCC + i;
        #10;
    end

    // Test Case 4: Reset Functionality
    reset = 1;
    #20;
    reset = 0;
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hDD;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hDD + i;
        #10;
    end

    // Test Case 5: All Channels Busy
    io_dst = 5'b11111;
    io_c_valid = 1;
    io_c_bits = 8'hEE;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    #10;
    for (integer i = 0; i < 100; i++) begin
        io_c_bits = 8'hEE + i;
        #10;
    end

    // Test Case 6: Sequential Data Processing
    for (integer j = 0; j < 5; j++) begin
        io_dst = 5'b11111 >> j;
        io_c_valid = 1;
        io_c_bits = 8'hFF;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        io_p_2_ready = 1;
        io_p_3_ready = 1;
        io_p_4_ready = 1;
        #10;
        for (integer i = 0; i < 100; i++) begin
            io_c_bits = 8'hFF + i;
            #10;
        end
    end

    // Final Reset Event
    reset = 1;
    #20;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    
    $finish;
end

endmodule

module DCMirror_UInt8_N5_golden(
  input        clock,
  input        reset,
  input  [4:0] io_dst,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] pData; // @[golden.scala 23:18]
  reg [4:0] pValid; // @[golden.scala 24:23]
  wire [4:0] pReady = {io_p_4_ready,io_p_3_ready,io_p_2_ready,io_p_1_ready,io_p_0_ready}; // @[Cat.scala 33:92]
  wire [4:0] _nxtAccept_T_2 = pValid & pReady; // @[golden.scala 26:69]
  wire  nxtAccept = pValid == 5'h0 | pValid != 5'h0 & _nxtAccept_T_2 == pValid; // @[golden.scala 26:36]
  wire [4:0] _pValid_T_1 = io_c_valid ? 5'h1f : 5'h0; // @[Bitwise.scala 77:12]
  wire [4:0] _pValid_T_2 = _pValid_T_1 & io_dst; // @[golden.scala 29:35]
  wire [4:0] _pValid_T_3 = ~pReady; // @[golden.scala 32:24]
  wire [4:0] _pValid_T_4 = pValid & _pValid_T_3; // @[golden.scala 32:22]
  assign io_c_ready = pValid == 5'h0 | pValid != 5'h0 & _nxtAccept_T_2 == pValid; // @[golden.scala 26:36]
  assign io_p_0_valid = pValid[0]; // @[golden.scala 38:28]
  assign io_p_0_bits = pData; // @[golden.scala 37:18]
  assign io_p_1_valid = pValid[1]; // @[golden.scala 38:28]
  assign io_p_1_bits = pData; // @[golden.scala 37:18]
  assign io_p_2_valid = pValid[2]; // @[golden.scala 38:28]
  assign io_p_2_bits = pData; // @[golden.scala 37:18]
  assign io_p_3_valid = pValid[3]; // @[golden.scala 38:28]
  assign io_p_3_bits = pData; // @[golden.scala 37:18]
  assign io_p_4_valid = pValid[4]; // @[golden.scala 38:28]
  assign io_p_4_bits = pData; // @[golden.scala 37:18]
  always @(posedge clock) begin
    if (nxtAccept) begin // @[golden.scala 28:19]
      pData <= io_c_bits; // @[golden.scala 30:11]
    end
    if (reset) begin // @[golden.scala 24:23]
      pValid <= 5'h0; // @[golden.scala 24:23]
    end else if (nxtAccept) begin // @[golden.scala 28:19]
      pValid <= _pValid_T_2; // @[golden.scala 29:12]
    end else begin
      pValid <= _pValid_T_4; // @[golden.scala 32:12]
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
  pData = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  pValid = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
