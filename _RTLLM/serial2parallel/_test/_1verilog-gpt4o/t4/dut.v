module serial2parallel (
    input wire clk,
    input wire rst_n,
    input wire din_serial,
    input wire din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

    // 4-bit counter to track the number of received bits
    reg [3:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the module
            cnt <= 4'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end else begin
            if (din_valid) begin
                // Shift in the serial data into the parallel register
                dout_parallel <= {dout_parallel[6:0], din_serial};
                cnt <= cnt + 1;
                
                if (cnt == 4'b0111) begin
                    // 8 bits have been received, set the valid output high
                    dout_valid <= 1'b1;
                end else begin
                    // Output is not valid yet
                    dout_valid <= 1'b0;
                end
            end else begin
                // If input is not valid, ensure the output remains invalid
                dout_valid <= 1'b0;
            end
        end
    end

endmodule
