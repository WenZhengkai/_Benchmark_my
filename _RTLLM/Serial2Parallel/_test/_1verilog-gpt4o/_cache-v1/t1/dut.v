module serial2parallel (
    input wire clk,
    input wire rst_n,
    input wire din_serial,
    input wire din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

    reg [2:0] cnt; // 3-bit counter to keep track of the number of received bits
    reg [7:0] shift_reg; // 8-bit shift register to store the serial data

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 3'b0;
            shift_reg <= 8'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end else if (din_valid) begin
            // Shift in the new bit received
            shift_reg <= {shift_reg[6:0], din_serial};

            if (cnt == 3'b111) begin
                // We have received 8 bits
                dout_parallel <= {shift_reg[6:0], din_serial}; // Capture current 8 bits
                dout_valid <= 1'b1;
                cnt <= 3'b0; // Reset counter
            end else begin
                cnt <= cnt + 1'b1;
                dout_valid <= 1'b0;
            end
        end else begin
            // No valid data being received
            dout_valid <= 1'b0;
        end
    end

endmodule
