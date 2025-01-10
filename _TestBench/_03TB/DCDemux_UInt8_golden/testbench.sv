`timescale 1ns / 1ps

module testbench;

  // parameter or localparam

  // Inputs
  reg clock;
  reg reset;
  reg [2:0] io_sel;
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
  DCDemux_UInt8_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_sel(io_sel),
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

  DCDemux_UInt8_golden uut (
    .clock(clock),
    .reset(reset),
    .io_sel(io_sel),
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
    io_sel = 0;
    io_c_valid = 0;
    io_c_bits = 8'h00;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;

    // Wait 100 ns for global reset to finish
    #100 reset = 1;
    #100 reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_c_valid = 1;
    io_c_bits = 8'hFF;
    io_p_0_ready = 1;
    io_p_1_ready = 1;
    io_p_2_ready = 1;
    io_p_3_ready = 1;
    io_p_4_ready = 1;

    // Basic Data Routing Test
    for (integer i = 0; i < 5; i = i + 1) begin
      io_sel = i;
      #10;
    end

    // Handling Invalid Input Data Test
    io_c_valid = 0;
    for (integer i = 0; i < 5; i = i + 1) begin
      io_sel = i;
      #10;
    end

    // Output Channel Not Ready Test
    io_c_valid = 1;
    io_p_0_ready = 0;
    io_p_1_ready = 0;
    io_p_2_ready = 0;
    io_p_3_ready = 0;
    io_p_4_ready = 0;
    for (integer i = 0; i < 5; i = i + 1) begin
      io_sel = i;
      #10;
    end

    // Data Integrity Test
    for (integer i = 0; i < 256; i = i + 1) begin
      io_c_bits = i;
      io_sel = i % 5;
      #10;
    end

    // System Clock Synchronization Test
    for (integer i = 0; i < 100; i = i + 1) begin
      io_sel = i % 5;
      io_c_valid = (i % 2 == 0);
      #10;
    end

    // Reset Event
    reset = 1;
    #20;
    reset = 0;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
  end

endmodule