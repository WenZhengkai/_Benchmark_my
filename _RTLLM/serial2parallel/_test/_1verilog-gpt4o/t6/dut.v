module serial2parallel (
    input wire clk,                // Clock signal
    input wire rst_n,              // Active low reset
    input wire din_serial,         // Serial input data
    input wire din_valid,          // Validity signal for input data
    
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg dout_valid           // Validity signal for the output data
);

    reg [2:0] cnt;                  // 3-bit counter to count up to 8
    reg [7:0] shift_reg;            // Shift register to store serial input data

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: clear the counter and registers
            cnt <= 3'b0;
            shift_reg <= 8'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end else if (din_valid) begin
            // When input is valid, shift the data into the register
            shift_reg <= {shift_reg[6:0], din_serial};
            cnt <= cnt + 1;

            if (cnt == 3'b111) begin
                // We've received 8 bits, set the output valid
                dout_parallel <= {shift_reg[6:0], din_serial};
                dout_valid <= 1'b1;
                cnt <= 3'b0;  // Reset the counter
            end else begin
                dout_valid <= 1'b0;
            end
        end else begin
            // If din_valid is low, output data is not valid
            dout_valid <= 1'b0;
        end
    end

endmodule
