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

    // Internal signal to hold the selected channel index
    reg [1:0] selected_channel;
    wire any_valid;
    
    // Output validity logic
    assign any_valid = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;
    assign io_out_valid = any_valid;

    // Priority Mux to select the first valid input based on priority
    always @(*) begin
        if (io_in_0_valid) begin
            selected_channel = 2'b00;
        end else if (io_in_1_valid) begin
            selected_channel = 2'b01;
        end else if (io_in_2_valid) begin
            selected_channel = 2'b10;
        end else if (io_in_3_valid) begin
            selected_channel = 2'b11;
        end else begin
            selected_channel = 2'b00;  // Default to channel 0 if none are valid
        end
    end

    // Data Routing
    always @(*) begin
        case (selected_channel)
            2'b00: io_out_bits = io_in_0_bits;
            2'b01: io_out_bits = io_in_1_bits;
            2'b10: io_out_bits = io_in_2_bits;
            2'b11: io_out_bits = io_in_3_bits;
            default: io_out_bits = 8'b00000000;  // Default data
        endcase
    end

    // Input Readiness
    assign io_in_0_ready = (selected_channel == 2'b00) && io_out_ready;
    assign io_in_1_ready = (selected_channel == 2'b01) && io_out_ready;
    assign io_in_2_ready = (selected_channel == 2'b10) && io_out_ready;
    assign io_in_3_ready = (selected_channel == 2'b11) && io_out_ready;

endmodule
