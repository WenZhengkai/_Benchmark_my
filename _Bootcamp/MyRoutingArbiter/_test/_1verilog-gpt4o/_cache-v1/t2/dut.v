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

    // Intermediate signals
    reg [1:0] selected_channel;  // To hold the selected channel index
    reg io_out_valid_reg;
    reg [7:0] io_out_bits_reg;

    // Combinational logic for arbitration and selection
    always @(*) begin
        if (io_in_0_valid) begin
            selected_channel = 2'b00;
            io_out_valid_reg = 1'b1;
            io_out_bits_reg = io_in_0_bits;
        end
        else if (io_in_1_valid) begin
            selected_channel = 2'b01;
            io_out_valid_reg = 1'b1;
            io_out_bits_reg = io_in_1_bits;
        end
        else if (io_in_2_valid) begin
            selected_channel = 2'b10;
            io_out_valid_reg = 1'b1;
            io_out_bits_reg = io_in_2_bits;
        end
        else if (io_in_3_valid) begin
            selected_channel = 2'b11;
            io_out_valid_reg = 1'b1;
            io_out_bits_reg = io_in_3_bits;
        end
        else begin
            selected_channel = 2'b00;
            io_out_valid_reg = 1'b0;
            io_out_bits_reg = 8'b0;
        end
    end

    // Assign output signals
    assign io_out_valid = io_out_valid_reg;
    assign io_out_bits = io_out_bits_reg;

    // Assign ready signals based on the channel selected and output readiness
    assign io_in_0_ready = (selected_channel == 2'b00) && io_out_ready;
    assign io_in_1_ready = (selected_channel == 2'b01) && io_out_ready;
    assign io_in_2_ready = (selected_channel == 2'b10) && io_out_ready;
    assign io_in_3_ready = (selected_channel == 2'b11) && io_out_ready;

endmodule
