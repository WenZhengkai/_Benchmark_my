module serial2parallel (
    input wire clk,             // Clock signal
    input wire rst_n,           // Active-low reset signal
    input wire din_serial,      // Serial input data
    input wire din_valid,       // Validity signal for input data
    output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
    output reg dout_valid       // Validity signal for the output data
);

    reg [2:0] cnt;              // 3-bit counter to track the number of received bits
    reg [7:0] shift_reg;        // 8-bit shift register to store serial data

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers and counter on active low reset
            cnt <= 3'b0;
            shift_reg <= 8'b0;
            dout_parallel <= 8'b0;
            dout_valid <= 1'b0;
        end else begin
            dout_valid <= 1'b0; // Default dout_valid to 0
            
            if (din_valid) begin
                // Shift in the serial data
                shift_reg <= {shift_reg[6:0], din_serial};

                // Increment the counter
                cnt <= cnt + 3'b1;

                // Check if 8 bits have been collected
                if (cnt == 3'b111) begin
                    // Load the shift register data into dout_parallel
                    dout_parallel <= shift_reg;
                    dout_valid <= 1'b1; // Set output valid to 1
                    cnt <= 3'b0;        // Reset counter
                end
            end
        end
    end
endmodule
