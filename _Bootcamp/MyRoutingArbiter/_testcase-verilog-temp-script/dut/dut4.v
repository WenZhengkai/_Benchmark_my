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

    // Determine if any input is valid
    wire any_input_valid = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;

    // PriorityMux logic: select the first valid input channel
    reg [1:0] selected_channel;
    always @(*) begin
        if (io_in_0_valid)
            selected_channel = 2'b00;
        else if (io_in_1_valid)
            selected_channel = 2'b01;
        else if (io_in_2_valid)
            selected_channel = 2'b10;
        else if (io_in_3_valid)
            selected_channel = 2'b11;
        else
            selected_channel = 2'b00;  // Default selection if none are valid, won't be used
    end

    // Output Validity
    assign io_out_valid = any_input_valid;

    // Data Routing
    assign io_out_bits = (selected_channel == 2'b00) ? io_in_0_bits :
                         (selected_channel == 2'b01) ? io_in_1_bits :
                         (selected_channel == 2'b10) ? io_in_2_bits :
                         (selected_channel == 2'b11) ? io_in_3_bits :
                         8'b0;  // Default value, shouldn't occur

    // Input Readiness
    assign io_in_0_ready = io_out_ready && (selected_channel == 2'b00);
    assign io_in_1_ready = io_out_ready && (selected_channel == 2'b01);
    assign io_in_2_ready = io_out_ready && (selected_channel == 2'b10);
    assign io_in_3_ready = io_out_ready && (selected_channel == 2'b11);

endmodule
