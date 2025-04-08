module serial2parallel (
    input wire clk,
    input wire rst_n,
    input wire din_serial,
    input wire din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

    reg [2:0] cnt; // 3-bit counter, as it only needs to count up to 7
    reg [7:0] shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 3'd0;
            shift_reg <= 8'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end else begin
            if (din_valid) begin
                // Shift the current bits to the left and insert the new serial bit
                shift_reg <= {shift_reg[6:0], din_serial};
                cnt <= cnt + 1;

                if (cnt == 3'd7) begin
                    // When the counter reaches 7, load the shift register to the output
                    dout_parallel <= {shift_reg[6:0], din_serial};
                    dout_valid <= 1'b1;
                    cnt <= 3'd0; // Reset counter
                end else begin
                    dout_valid <= 1'b0;
                end
            end
        end
    end

endmodule
