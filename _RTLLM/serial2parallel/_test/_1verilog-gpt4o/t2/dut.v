module serial2parallel (
    input wire clk,            // Clock signal
    input wire rst_n,          // Active low reset signal
    input wire din_serial,     // Serial input data
    input wire din_valid,      // Validity signal for input data
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg dout_valid      // Validity signal for the output data
);

    // Internal 3-bit counter to count the number of received serial bits
    reg [2:0] cnt;
    // Internal shift register to store the incoming serial bits
    reg [7:0] shift_reg;

    // Sequential logic operating on the rising edge of the clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers and outputs on active low reset
            cnt <= 3'b0;
            shift_reg <= 8'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end
        else begin
            if (din_valid) begin
                // Shift the serial input into the shift register
                shift_reg <= {shift_reg[6:0], din_serial};
                
                // Increment the counter after a valid serial input
                cnt <= cnt + 1;
                
                // Check if we have received 8 bits
                if (cnt == 3'b111) begin
                    // Load the shift register content into the parallel output
                    dout_parallel <= {shift_reg[6:0], din_serial};
                    dout_valid <= 1'b1; // Indicate that output is valid
                    
                    // Reset the counter
                    cnt <= 3'b0;
                end
                else begin
                    dout_valid <= 1'b0; // Output is not valid yet
                end
            end
        end
    end

endmodule
