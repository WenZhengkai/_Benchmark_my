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
    reg [1:0] selected_channel;
    reg [7:0] selected_data;
    reg out_valid_int;

    // Determine output validity
    always @(*) begin
        out_valid_int = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;
    end

    // Determine the selected channel and route data
    always @(*) begin
        if (io_in_0_valid) begin
            selected_channel = 2'b00;
            selected_data    = io_in_0_bits;
        end else if (io_in_1_valid) begin
            selected_channel = 2'b01;
            selected_data    = io_in_1_bits;
        end else if (io_in_2_valid) begin
            selected_channel = 2'b10;
            selected_data    = io_in_2_bits;
        end else if (io_in_3_valid) begin
            selected_channel = 2'b11;
            selected_data    = io_in_3_bits;
        end else begin
            selected_channel = 2'bxx;
            selected_data    = 8'bxxxx_xxxx;
        end
    end

    // Output assignments
    assign io_out_valid = out_valid_int;
    assign io_out_bits  = selected_data;

    // Input readiness logic
    assign io_in_0_ready = (selected_channel == 2'b00) && io_out_ready;
    assign io_in_1_ready = (selected_channel == 2'b01) && io_out_ready;
    assign io_in_2_ready = (selected_channel == 2'b10) && io_out_ready;
    assign io_in_3_ready = (selected_channel == 2'b11) && io_out_ready;

endmodule
