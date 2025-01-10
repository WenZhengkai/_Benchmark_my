module serial2parallel (
    input wire clk,
    input wire rst_n,
    input wire din_serial,
    input wire din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

    reg [2:0] cnt;  // 3-bit counter to count up to 7, sufficient for counting 0 to 7

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 3'd0;
            dout_parallel <= 8'd0;
            dout_valid <= 1'b0;
        end else if (din_valid) begin
            dout_parallel <= {dout_parallel[6:0], din_serial}; // Shift left and insert the new serial input.
            if (cnt == 3'd7) begin
                dout_valid <= 1'b1;  // 8-bits received, set output valid
                cnt <= 3'd0;         // Reset counter
            end else begin
                dout_valid <= 1'b0;  // Data not yet complete
                cnt <= cnt + 1'b1;   // Increment the counter
            end
        end else begin
            dout_valid <= 1'b0;      // If din_valid is low, dout_valid remains low
        end
    end

endmodule
