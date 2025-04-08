module serial2parallel (
    input clk,                  // Clock signal
    input rst_n,                // Active low reset signal
    input din_serial,           // Serial input data
    input din_valid,            // Validity signal for input data
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg dout_valid       // Validity signal for the output data
);

    reg [2:0] cnt;              // 3-bit counter to count up to 8 (0 to 7)

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the counter and output registers
            cnt <= 3'b000;
            dout_parallel <= 8'b00000000;
            dout_valid <= 1'b0;
        end else begin
            if (din_valid) begin
                // Shift in the serial data
                dout_parallel <= {dout_parallel[6:0], din_serial};
                
                // Increment the counter
                if (cnt == 3'b111) begin
                    // All 8 bits received
                    dout_valid <= 1'b1;  // Set valid flag
                    cnt <= 3'b000;       // Reset counter for next byte
                end else begin
                    // Increment counter if less than 7
                    cnt <= cnt + 1;
                    dout_valid <= 1'b0; // Reset the valid signal
                end
            end else begin
                // No valid serial data; ensure valid output is false
                dout_valid <= 1'b0;
            end
        end
    end
endmodule
