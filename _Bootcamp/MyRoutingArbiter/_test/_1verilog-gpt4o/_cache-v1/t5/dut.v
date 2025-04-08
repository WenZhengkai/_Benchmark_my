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
    output reg   io_out_valid,
    output reg [7:0] io_out_bits
);

    reg [1:0] selected_channel;
    wire any_valid;

    // Determine if any input is valid
    assign any_valid = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;

    // Priority Mux
    always @(*) begin
        selected_channel = 2'b00; // Default to channel 0
        if (io_in_0_valid) begin
            selected_channel = 2'b00;
        end else if (io_in_1_valid) begin
            selected_channel = 2'b01;
        end else if (io_in_2_valid) begin
            selected_channel = 2'b10;
        end else if (io_in_3_valid) begin
            selected_channel = 2'b11;
        end
    end

    // Output Logic
    always @(*) begin
        io_out_valid = any_valid && io_out_ready;
        case (selected_channel)
            2'b00: io_out_bits = io_in_0_bits;
            2'b01: io_out_bits = io_in_1_bits;
            2'b10: io_out_bits = io_in_2_bits;
            2'b11: io_out_bits = io_in_3_bits;
            default: io_out_bits = 8'b0;
        endcase
    end

    // Input Readiness Logic
    assign io_in_0_ready = (selected_channel == 2'b00) && io_out_ready;
    assign io_in_1_ready = (selected_channel == 2'b01) && io_out_ready;
    assign io_in_2_ready = (selected_channel == 2'b10) && io_out_ready;
    assign io_in_3_ready = (selected_channel == 2'b11) && io_out_ready;

endmodule
