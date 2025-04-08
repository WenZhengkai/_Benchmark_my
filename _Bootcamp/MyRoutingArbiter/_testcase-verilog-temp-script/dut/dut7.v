module dut (
  input        clock,
  input        reset,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input  [7:0] io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [7:0] io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input  [7:0] io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input  [7:0] io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);

  // Intermediate signals
  wire [3:0] valid_vector;
  reg [1:0] selected_channel;
  wire [7:0] selected_bits;

  // Capture valid signals of all input channels in a vector
  assign valid_vector = {io_in_3_valid, io_in_2_valid, io_in_1_valid, io_in_0_valid};

  // Output Validity
  assign io_out_valid = |valid_vector;

  // Priority Mux logic to select the first valid input channel
  always @(*) begin
    if (io_in_0_valid)
      selected_channel = 2'd0;
    else if (io_in_1_valid)
      selected_channel = 2'd1;
    else if (io_in_2_valid)
      selected_channel = 2'd2;
    else if (io_in_3_valid)
      selected_channel = 2'd3;
    else
      selected_channel = 2'd0;  // Default case, ideally should not hit when no valid input present
  end

  // Data Routing based on the selected channel
  assign selected_bits = (selected_channel == 2'd0) ? io_in_0_bits :
                         (selected_channel == 2'd1) ? io_in_1_bits :
                         (selected_channel == 2'd2) ? io_in_2_bits :
                         (selected_channel == 2'd3) ? io_in_3_bits : 8'b0;

  assign io_out_bits = selected_bits;

  // Input Readiness
  assign io_in_0_ready = (selected_channel == 2'd0) && io_out_ready;
  assign io_in_1_ready = (selected_channel == 2'd1) && io_out_ready;
  assign io_in_2_ready = (selected_channel == 2'd2) && io_out_ready;
  assign io_in_3_ready = (selected_channel == 2'd3) && io_out_ready;

endmodule
