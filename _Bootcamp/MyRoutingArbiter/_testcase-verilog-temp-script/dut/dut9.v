module dut(
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

  // Internal wires
  wire [3:0] request_valid;
  wire [1:0] selected_channel;
  wire       selected_valid;
  reg  [7:0] output_data;

  // Assign valid signals from input channels
  assign request_valid[0] = io_in_0_valid;
  assign request_valid[1] = io_in_1_valid;
  assign request_valid[2] = io_in_2_valid;
  assign request_valid[3] = io_in_3_valid;

  // Determine if any input is valid
  assign io_out_valid = |request_valid;

  // Logic to determine the selected channel based on priority
  always @(*) begin
    if (request_valid[0]) begin
      selected_channel = 2'b00;
      selected_valid = io_in_0_valid;
      output_data = io_in_0_bits;
    end else if (request_valid[1]) begin
      selected_channel = 2'b01;
      selected_valid = io_in_1_valid;
      output_data = io_in_1_bits;
    end else if (request_valid[2]) begin
      selected_channel = 2'b10;
      selected_valid = io_in_2_valid;
      output_data = io_in_2_bits;
    end else begin
      selected_channel = 2'b11;
      selected_valid = io_in_3_valid;
      output_data = io_in_3_bits;
    end
  end

  // Assign bits output
  assign io_out_bits = output_data;

  // Determine which input channel is ready to proceed
  assign io_in_0_ready = (selected_channel == 2'b00) && io_out_ready;
  assign io_in_1_ready = (selected_channel == 2'b01) && io_out_ready;
  assign io_in_2_ready = (selected_channel == 2'b10) && io_out_ready;
  assign io_in_3_ready = (selected_channel == 2'b11) && io_out_ready;

endmodule
