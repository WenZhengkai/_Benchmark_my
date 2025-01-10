module serial2parallel (
    input wire clk,           // Clock signal
    input wire rst_n,         // Asynchronous reset signal (active low)
    input wire din_serial,    // Serial input data
    input wire din_valid,     // Validity signal for input data
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg dout_valid     // Validity signal for the output data
);

    reg [2:0] cnt;            // 3-bit counter to keep track of received bits
    reg [7:0] shift_reg;      // 8-bit shift register to store incoming bits

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 3'd0;
            shift_reg <= 8'd0;
            dout_parallel <= 8'd0;
            dout_valid <= 1'b0;
        end else begin
            // If the input data is valid
            if (din_valid) begin
                // Shift in the new data bit (MSB first)
                shift_reg <= {shift_reg[6:0], din_serial};
                cnt <= cnt + 3'd1;

                // Check if we have received 8 bits
                if (cnt == 3'd7) begin
                    dout_parallel <= {shift_reg[7:0], din_serial};
                    dout_valid <= 1'b1;
                end else begin
                    dout_valid <= 1'b0;
                end
            end else begin
                // If data is not valid, keep the count and outputs stable
                dout_valid <= 1'b0;
            end
        end
    end

endmodule
