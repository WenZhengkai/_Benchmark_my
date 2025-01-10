`timescale 1ns / 1ps

module testbench;

//parameter or localparam 


// Inputs
reg clock;
reg reset;
reg [1:0] io_sel_0;
reg [1:0] io_sel_1;
reg io_c_0_valid;
reg [7:0] io_c_0_bits;
reg io_c_1_valid;
reg [7:0] io_c_1_bits;
reg io_p_0_ready;
reg io_p_1_ready;

// Outputs or inout
wire io_c_0_ready, io_c_0_ready_golden;
wire io_c_1_ready, io_c_1_ready_golden;
wire io_p_0_valid, io_p_0_valid_golden;
wire [7:0] io_p_0_bits, io_p_0_bits_golden;
wire io_p_1_valid, io_p_1_valid_golden;
wire [7:0] io_p_1_bits, io_p_1_bits_golden;


integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden} === ({io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden} ^ {io_c_0_ready, io_c_1_ready, io_p_0_valid, io_p_0_bits, io_p_1_valid, io_p_1_bits} ^ {io_c_0_ready_golden, io_c_1_ready_golden, io_p_0_valid_golden, io_p_0_bits_golden, io_p_1_valid_golden, io_p_1_bits_golden}));

// Instantiate the Unit Under Test (UUT)
DcMcCrossbarUInt8_M2N2_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_c_0_ready(io_c_0_ready_golden),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready_golden),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid_golden),
    .io_p_0_bits(io_p_0_bits_golden),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid_golden),
    .io_p_1_bits(io_p_1_bits_golden)
);


dut uut (
    .clock(clock),
    .reset(reset),
    .io_sel_0(io_sel_0),
    .io_sel_1(io_sel_1),
    .io_c_0_ready(io_c_0_ready),
    .io_c_0_valid(io_c_0_valid),
    .io_c_0_bits(io_c_0_bits),
    .io_c_1_ready(io_c_1_ready),
    .io_c_1_valid(io_c_1_valid),
    .io_c_1_bits(io_c_1_bits),
    .io_p_0_ready(io_p_0_ready),
    .io_p_0_valid(io_p_0_valid),
    .io_p_0_bits(io_p_0_bits),
    .io_p_1_ready(io_p_1_ready),
    .io_p_1_valid(io_p_1_valid),
    .io_p_1_bits(io_p_1_bits)
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
    io_sel_0 = 2'b00;
    io_sel_1 = 2'b00;
    io_c_0_valid = 0;
    io_c_0_bits = 8'h00;
    io_c_1_valid = 0;
    io_c_1_bits = 8'h00;
    io_p_0_ready = 0;
    io_p_1_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, and finally set all inputs back to zero
    io_sel_0 = 2'b00; io_sel_1 = 2'b00; io_c_0_valid = 0; io_c_0_bits = 8'h00; io_c_1_valid = 0; io_c_1_bits = 8'h00; io_p_0_ready = 0; io_p_1_ready = 0;
    #100;
    io_sel_0 = 2'b11; io_sel_1 = 2'b11; io_c_0_valid = 1; io_c_0_bits = 8'hFF; io_c_1_valid = 1; io_c_1_bits = 8'hFF; io_p_0_ready = 1; io_p_1_ready = 1;
    #100;
    io_sel_0 = 2'b00; io_sel_1 = 2'b00; io_c_0_valid = 0; io_c_0_bits = 8'h00; io_c_1_valid = 0; io_c_1_bits = 8'h00; io_p_0_ready = 0; io_p_1_ready = 0;
    #100;

    // Test Case 1: Dynamic Data Routing
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = i % 2;
        io_sel_1 = (i + 1) % 2;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = i;
        io_c_1_bits = 100 - i;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        #10;
    end

    // Test Case 2: Flow Control Management with Backpressure
    io_sel_0 = 2'b01;
    io_sel_1 = 2'b10;
    io_c_0_valid = 1;
    io_c_1_valid = 1;
    io_c_0_bits = 8'hAA;
    io_c_1_bits = 8'h55;
    io_p_0_ready = 0; // Simulate backpressure
    io_p_1_ready = 1;
    #100;

    // Test Case 3: Arbitration and Fairness
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = 2'b01;
        io_sel_1 = 2'b01;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = i;
        io_c_1_bits = 100 - i;
        io_p_0_ready = (i % 2 == 0);
        io_p_1_ready = (i % 2 == 1);
        #10;
    end

    // Test Case 4: Reset and Initialization
    reset = 1;
    #20;
    reset = 0;
    #100;

    // Test Case 5: Clock Synchronized Operations
    for (integer i = 0; i < 100; i = i + 1) begin
        io_sel_0 = i % 4;
        io_sel_1 = (i + 1) % 4;
        io_c_0_valid = 1;
        io_c_1_valid = 1;
        io_c_0_bits = 8'hFF >> i;
        io_c_1_bits = 8'hFF << i;
        io_p_0_ready = 1;
        io_p_1_ready = 1;
        #10;
    end

    // Toggle reset signal to simulate a reset event
    reset = 1;
    #20;
    reset = 0;
    #100;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    // Be sure to save the following code in the final generated testbench.sv
    $finish;
end

endmodule
module DCMirror_UInt8_N2_golden(
  input        clock,
  input        reset,
  input  [1:0] io_dst,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] pData; // @[DCMirror.scala 23:18]
  reg [1:0] pValid; // @[DCMirror.scala 24:23]
  wire [1:0] pReady = {io_p_1_ready,io_p_0_ready}; // @[Cat.scala 33:92]
  wire [1:0] _nxtAccept_T_2 = pValid & pReady; // @[DCMirror.scala 26:69]
  wire  nxtAccept = pValid == 2'h0 | pValid != 2'h0 & _nxtAccept_T_2 == pValid; // @[DCMirror.scala 26:36]
  wire [1:0] _pValid_T_1 = io_c_valid ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [1:0] _pValid_T_2 = _pValid_T_1 & io_dst; // @[DCMirror.scala 29:35]
  wire [1:0] _pValid_T_3 = ~pReady; // @[DCMirror.scala 32:24]
  wire [1:0] _pValid_T_4 = pValid & _pValid_T_3; // @[DCMirror.scala 32:22]
  assign io_c_ready = pValid == 2'h0 | pValid != 2'h0 & _nxtAccept_T_2 == pValid; // @[DCMirror.scala 26:36]
  assign io_p_0_valid = pValid[0]; // @[DCMirror.scala 38:28]
  assign io_p_0_bits = pData; // @[DCMirror.scala 37:18]
  assign io_p_1_valid = pValid[1]; // @[DCMirror.scala 38:28]
  assign io_p_1_bits = pData; // @[DCMirror.scala 37:18]
  always @(posedge clock) begin
    if (nxtAccept) begin // @[DCMirror.scala 28:19]
      pData <= io_c_bits; // @[DCMirror.scala 30:11]
    end
    if (reset) begin // @[DCMirror.scala 24:23]
      pValid <= 2'h0; // @[DCMirror.scala 24:23]
    end else if (nxtAccept) begin // @[DCMirror.scala 28:19]
      pValid <= _pValid_T_2; // @[DCMirror.scala 29:12]
    end else begin
      pValid <= _pValid_T_4; // @[DCMirror.scala 32:12]
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
  pValid = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCArbiter_UInt8_golden(
  input        clock,
  input        reset,
  output       io_c_0_ready,
  input        io_c_0_valid,
  input  [7:0] io_c_0_bits,
  output       io_c_1_ready,
  input        io_c_1_valid,
  input  [7:0] io_c_1_bits,
  input        io_p_ready,
  output       io_p_valid,
  output [7:0] io_p_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] justGranted; // @[DCArbiter.scala 25:28]
  wire [1:0] ioCValid = {io_c_1_valid,io_c_0_valid}; // @[Cat.scala 33:92]
  wire [1:0] _toBeGranted_mskReq_T_1 = justGranted - 2'h1; // @[DCArbiter.scala 41:38]
  wire [1:0] _toBeGranted_mskReq_T_2 = _toBeGranted_mskReq_T_1 | justGranted; // @[DCArbiter.scala 41:45]
  wire [1:0] _toBeGranted_mskReq_T_3 = ~_toBeGranted_mskReq_T_2; // @[DCArbiter.scala 41:25]
  wire [1:0] toBeGranted_mskReq = ioCValid & _toBeGranted_mskReq_T_3; // @[DCArbiter.scala 41:23]
  wire  _toBeGranted_T = toBeGranted_mskReq != 2'h0; // @[DCArbiter.scala 46:19]
  wire [1:0] _toBeGranted_tmpGrant_T = ~toBeGranted_mskReq; // @[DCArbiter.scala 42:27]
  wire [1:0] _toBeGranted_tmpGrant_T_2 = _toBeGranted_tmpGrant_T + 2'h1; // @[DCArbiter.scala 42:35]
  wire [1:0] toBeGranted_tmpGrant = toBeGranted_mskReq & _toBeGranted_tmpGrant_T_2; // @[DCArbiter.scala 42:24]
  wire [1:0] _toBeGranted_tmpGrant2_T = ~ioCValid; // @[DCArbiter.scala 43:29]
  wire [1:0] _toBeGranted_tmpGrant2_T_2 = _toBeGranted_tmpGrant2_T + 2'h1; // @[DCArbiter.scala 43:38]
  wire [1:0] toBeGranted_tmpGrant2 = ioCValid & _toBeGranted_tmpGrant2_T_2; // @[DCArbiter.scala 43:26]
  wire [1:0] _GEN_0 = toBeGranted_mskReq != 2'h0 ? toBeGranted_tmpGrant : toBeGranted_tmpGrant2; // @[DCArbiter.scala 46:28 47:12 49:12]
  wire [1:0] _toBeGranted_rv_T_2 = {toBeGranted_tmpGrant[0],toBeGranted_tmpGrant[1]}; // @[Cat.scala 33:92]
  wire [1:0] _toBeGranted_rv_T_5 = {toBeGranted_tmpGrant2[0],toBeGranted_tmpGrant2[1]}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_1 = _toBeGranted_T ? _toBeGranted_rv_T_2 : _toBeGranted_rv_T_5; // @[DCArbiter.scala 52:28 53:12 55:12]
  wire [1:0] _GEN_2 = ioCValid != 2'h0 ? _GEN_1 : justGranted; // @[DCArbiter.scala 51:33 58:10]
  wire [1:0] toBeGranted_rv = io_p_ready ? _GEN_0 : _GEN_2; // @[DCArbiter.scala 45:22]
  assign io_c_0_ready = toBeGranted_rv[0] & io_p_ready; // @[DCArbiter.scala 31:37]
  assign io_c_1_ready = toBeGranted_rv[1] & io_p_ready; // @[DCArbiter.scala 31:37]
  assign io_p_valid = |ioCValid; // @[DCArbiter.scala 65:26]
  assign io_p_bits = toBeGranted_rv[1] ? io_c_1_bits : io_c_0_bits; // @[DCArbiter.scala 100:17 99:26]
  always @(posedge clock) begin
    if (reset) begin // @[DCArbiter.scala 25:28]
      justGranted <= 2'h1; // @[DCArbiter.scala 25:28]
    end else if (toBeGranted_rv != 2'h0) begin // @[DCArbiter.scala 93:29]
      if (io_p_ready) begin // @[DCArbiter.scala 45:22]
        if (toBeGranted_mskReq != 2'h0) begin // @[DCArbiter.scala 46:28]
          justGranted <= toBeGranted_tmpGrant; // @[DCArbiter.scala 47:12]
        end else begin
          justGranted <= toBeGranted_tmpGrant2; // @[DCArbiter.scala 49:12]
        end
      end else if (ioCValid != 2'h0) begin // @[DCArbiter.scala 51:33]
        justGranted <= _GEN_1;
      end
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
  justGranted = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DcMcCrossbarUInt8_M2N2_golden(
  input        clock,
  input        reset,
  input  [1:0] io_sel_0,
  input  [1:0] io_sel_1,
  output       io_c_0_ready,
  input        io_c_0_valid,
  input  [7:0] io_c_0_bits,
  output       io_c_1_ready,
  input        io_c_1_valid,
  input  [7:0] io_c_1_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits
);
  wire  demuxList_0_clock; // @[golden.scala 19:59]
  wire  demuxList_0_reset; // @[golden.scala 19:59]
  wire [1:0] demuxList_0_io_dst; // @[golden.scala 19:59]
  wire  demuxList_0_io_c_ready; // @[golden.scala 19:59]
  wire  demuxList_0_io_c_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_0_io_c_bits; // @[golden.scala 19:59]
  wire  demuxList_0_io_p_0_ready; // @[golden.scala 19:59]
  wire  demuxList_0_io_p_0_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_0_io_p_0_bits; // @[golden.scala 19:59]
  wire  demuxList_0_io_p_1_ready; // @[golden.scala 19:59]
  wire  demuxList_0_io_p_1_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_0_io_p_1_bits; // @[golden.scala 19:59]
  wire  demuxList_1_clock; // @[golden.scala 19:59]
  wire  demuxList_1_reset; // @[golden.scala 19:59]
  wire [1:0] demuxList_1_io_dst; // @[golden.scala 19:59]
  wire  demuxList_1_io_c_ready; // @[golden.scala 19:59]
  wire  demuxList_1_io_c_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_1_io_c_bits; // @[golden.scala 19:59]
  wire  demuxList_1_io_p_0_ready; // @[golden.scala 19:59]
  wire  demuxList_1_io_p_0_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_1_io_p_0_bits; // @[golden.scala 19:59]
  wire  demuxList_1_io_p_1_ready; // @[golden.scala 19:59]
  wire  demuxList_1_io_p_1_valid; // @[golden.scala 19:59]
  wire [7:0] demuxList_1_io_p_1_bits; // @[golden.scala 19:59]
  wire  arbList_0_clock; // @[golden.scala 20:58]
  wire  arbList_0_reset; // @[golden.scala 20:58]
  wire  arbList_0_io_c_0_ready; // @[golden.scala 20:58]
  wire  arbList_0_io_c_0_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_0_io_c_0_bits; // @[golden.scala 20:58]
  wire  arbList_0_io_c_1_ready; // @[golden.scala 20:58]
  wire  arbList_0_io_c_1_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_0_io_c_1_bits; // @[golden.scala 20:58]
  wire  arbList_0_io_p_ready; // @[golden.scala 20:58]
  wire  arbList_0_io_p_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_0_io_p_bits; // @[golden.scala 20:58]
  wire  arbList_1_clock; // @[golden.scala 20:58]
  wire  arbList_1_reset; // @[golden.scala 20:58]
  wire  arbList_1_io_c_0_ready; // @[golden.scala 20:58]
  wire  arbList_1_io_c_0_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_1_io_c_0_bits; // @[golden.scala 20:58]
  wire  arbList_1_io_c_1_ready; // @[golden.scala 20:58]
  wire  arbList_1_io_c_1_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_1_io_c_1_bits; // @[golden.scala 20:58]
  wire  arbList_1_io_p_ready; // @[golden.scala 20:58]
  wire  arbList_1_io_p_valid; // @[golden.scala 20:58]
  wire [7:0] arbList_1_io_p_bits; // @[golden.scala 20:58]
  DCMirror_UInt8_N2_golden demuxList_0 ( // @[golden.scala 19:59]
    .clock(demuxList_0_clock),
    .reset(demuxList_0_reset),
    .io_dst(demuxList_0_io_dst),
    .io_c_ready(demuxList_0_io_c_ready),
    .io_c_valid(demuxList_0_io_c_valid),
    .io_c_bits(demuxList_0_io_c_bits),
    .io_p_0_ready(demuxList_0_io_p_0_ready),
    .io_p_0_valid(demuxList_0_io_p_0_valid),
    .io_p_0_bits(demuxList_0_io_p_0_bits),
    .io_p_1_ready(demuxList_0_io_p_1_ready),
    .io_p_1_valid(demuxList_0_io_p_1_valid),
    .io_p_1_bits(demuxList_0_io_p_1_bits)
  );
  DCMirror_UInt8_N2_golden demuxList_1 ( // @[golden.scala 19:59]
    .clock(demuxList_1_clock),
    .reset(demuxList_1_reset),
    .io_dst(demuxList_1_io_dst),
    .io_c_ready(demuxList_1_io_c_ready),
    .io_c_valid(demuxList_1_io_c_valid),
    .io_c_bits(demuxList_1_io_c_bits),
    .io_p_0_ready(demuxList_1_io_p_0_ready),
    .io_p_0_valid(demuxList_1_io_p_0_valid),
    .io_p_0_bits(demuxList_1_io_p_0_bits),
    .io_p_1_ready(demuxList_1_io_p_1_ready),
    .io_p_1_valid(demuxList_1_io_p_1_valid),
    .io_p_1_bits(demuxList_1_io_p_1_bits)
  );
  DCArbiter_UInt8_golden arbList_0 ( // @[golden.scala 20:58]
    .clock(arbList_0_clock),
    .reset(arbList_0_reset),
    .io_c_0_ready(arbList_0_io_c_0_ready),
    .io_c_0_valid(arbList_0_io_c_0_valid),
    .io_c_0_bits(arbList_0_io_c_0_bits),
    .io_c_1_ready(arbList_0_io_c_1_ready),
    .io_c_1_valid(arbList_0_io_c_1_valid),
    .io_c_1_bits(arbList_0_io_c_1_bits),
    .io_p_ready(arbList_0_io_p_ready),
    .io_p_valid(arbList_0_io_p_valid),
    .io_p_bits(arbList_0_io_p_bits)
  );
  DCArbiter_UInt8_golden arbList_1 ( // @[golden.scala 20:58]
    .clock(arbList_1_clock),
    .reset(arbList_1_reset),
    .io_c_0_ready(arbList_1_io_c_0_ready),
    .io_c_0_valid(arbList_1_io_c_0_valid),
    .io_c_0_bits(arbList_1_io_c_0_bits),
    .io_c_1_ready(arbList_1_io_c_1_ready),
    .io_c_1_valid(arbList_1_io_c_1_valid),
    .io_c_1_bits(arbList_1_io_c_1_bits),
    .io_p_ready(arbList_1_io_p_ready),
    .io_p_valid(arbList_1_io_p_valid),
    .io_p_bits(arbList_1_io_p_bits)
  );
  assign io_c_0_ready = demuxList_0_io_c_ready; // @[golden.scala 22:25]
  assign io_c_1_ready = demuxList_1_io_c_ready; // @[golden.scala 22:25]
  assign io_p_0_valid = arbList_0_io_p_valid; // @[golden.scala 30:23]
  assign io_p_0_bits = arbList_0_io_p_bits; // @[golden.scala 30:23]
  assign io_p_1_valid = arbList_1_io_p_valid; // @[golden.scala 30:23]
  assign io_p_1_bits = arbList_1_io_p_bits; // @[golden.scala 30:23]
  assign demuxList_0_clock = clock;
  assign demuxList_0_reset = reset;
  assign demuxList_0_io_dst = io_sel_0; // @[golden.scala 23:27]
  assign demuxList_0_io_c_valid = io_c_0_valid; // @[golden.scala 22:25]
  assign demuxList_0_io_c_bits = io_c_0_bits; // @[golden.scala 22:25]
  assign demuxList_0_io_p_0_ready = arbList_0_io_c_0_ready; // @[golden.scala 26:30]
  assign demuxList_0_io_p_1_ready = arbList_1_io_c_0_ready; // @[golden.scala 26:30]
  assign demuxList_1_clock = clock;
  assign demuxList_1_reset = reset;
  assign demuxList_1_io_dst = io_sel_1; // @[golden.scala 23:27]
  assign demuxList_1_io_c_valid = io_c_1_valid; // @[golden.scala 22:25]
  assign demuxList_1_io_c_bits = io_c_1_bits; // @[golden.scala 22:25]
  assign demuxList_1_io_p_0_ready = arbList_0_io_c_1_ready; // @[golden.scala 26:30]
  assign demuxList_1_io_p_1_ready = arbList_1_io_c_1_ready; // @[golden.scala 26:30]
  assign arbList_0_clock = clock;
  assign arbList_0_reset = reset;
  assign arbList_0_io_c_0_valid = demuxList_0_io_p_0_valid; // @[golden.scala 26:30]
  assign arbList_0_io_c_0_bits = demuxList_0_io_p_0_bits; // @[golden.scala 26:30]
  assign arbList_0_io_c_1_valid = demuxList_1_io_p_0_valid; // @[golden.scala 26:30]
  assign arbList_0_io_c_1_bits = demuxList_1_io_p_0_bits; // @[golden.scala 26:30]
  assign arbList_0_io_p_ready = io_p_0_ready; // @[golden.scala 30:23]
  assign arbList_1_clock = clock;
  assign arbList_1_reset = reset;
  assign arbList_1_io_c_0_valid = demuxList_0_io_p_1_valid; // @[golden.scala 26:30]
  assign arbList_1_io_c_0_bits = demuxList_0_io_p_1_bits; // @[golden.scala 26:30]
  assign arbList_1_io_c_1_valid = demuxList_1_io_p_1_valid; // @[golden.scala 26:30]
  assign arbList_1_io_c_1_bits = demuxList_1_io_p_1_bits; // @[golden.scala 26:30]
  assign arbList_1_io_p_ready = io_p_1_ready; // @[golden.scala 30:23]
endmodule
