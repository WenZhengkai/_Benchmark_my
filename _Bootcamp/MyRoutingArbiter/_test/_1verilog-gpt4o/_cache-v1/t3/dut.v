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
    
    // Intermediate signals for priority selection
    reg [1:0] selected_channel;
    
    // Output Validity: At least one of the input channels should be valid
    assign io_out_valid = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;

    // Priority Selection using PriorityMux
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
            selected_channel = 2'b00; // Default case, should not happen when io_out_valid is high
        end
    end

    // Data Routing: Route the data from the selected input to the output
    assign io_out_bits = (selected_channel == 2'b00) ? io_in_0_bits :
                         (selected_channel == 2'b01) ? io_in_1_bits :
                         (selected_channel == 2'b10) ? io_in_2_bits :
                         io_in_3_bits;

    // Input Readiness: Only the selected channel can be marked as ready
    assign io_in_0_ready = io_out_ready && (selected_channel == 2'b00);
    assign io_in_1_ready = io_out_ready && (selected_channel == 2'b01);
    assign io_in_2_ready = io_out_ready && (selected_channel == 2'b10);
    assign io_in_3_ready = io_out_ready && (selected_channel == 2'b11);

endmodule
