module serial2parallel (
    input wire       clk,          // Clock signal
    input wire       rst_n,        // Active-low reset signal
    input wire       din_serial,   // Serial input data
    input wire       din_valid,    // Validity signal for input data
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg       dout_valid    // Validity signal for the output data
);

    // Internal 4-bit counter to count the number of received bits
    reg [3:0] cnt;
    
    // Internal shift register to hold the serial data as it comes in
    reg [7:0] shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            cnt <= 4'd0;
            dout_parallel <= 8'd0;
            shift_reg <= 8'd0;
            dout_valid <= 1'b0;
        end else begin
            if (din_valid) begin
                // Shift in the serial data and update the shift register
                shift_reg <= {shift_reg[6:0], din_serial};
                cnt <= cnt + 4'd1;
                
                // Check if 8 bits have been received
                if (cnt == 4'd7) begin
                    dout_parallel <= {shift_reg[6:0], din_serial};
                    dout_valid <= 1'b1;
                    cnt <= 4'd0; // Reset the counter
                end else begin
                    dout_valid <= 1'b0;
                end
            end
        end
    end

endmodule
