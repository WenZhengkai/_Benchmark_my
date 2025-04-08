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
    output reg   io_out_valid,
    output reg [7:0] io_out_bits
);

reg [1:0] selected_channel;

always @(*) begin
    // By default, no output is valid
    io_out_valid = 0;
    io_out_bits = 8'b0;

    // Default ready signals
    io_in_0_ready = 0;
    io_in_1_ready = 0;
    io_in_2_ready = 0;
    io_in_3_ready = 0;

    // Priority selection based on valid inputs
    if (io_in_0_valid) begin
        selected_channel = 2'd0;
        io_out_valid = 1;
        io_out_bits = io_in_0_bits;
        io_in_0_ready = io_out_ready;
    end else if (io_in_1_valid) begin
        selected_channel = 2'd1;
        io_out_valid = 1;
        io_out_bits = io_in_1_bits;
        io_in_1_ready = io_out_ready;
    end else if (io_in_2_valid) begin
        selected_channel = 2'd2;
        io_out_valid = 1;
        io_out_bits = io_in_2_bits;
        io_in_2_ready = io_out_ready;
    end else if (io_in_3_valid) begin
        selected_channel = 2'd3;
        io_out_valid = 1;
        io_out_bits = io_in_3_bits;
        io_in_3_ready = io_out_ready;
    end
end

endmodule
