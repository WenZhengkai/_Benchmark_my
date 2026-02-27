module dut (
    input wire clk,        // Clock signal
    input wire rst_n,      // Active-low reset signal
    input wire [3:0] d,    // 4-bit parallel data input
    output reg valid_out,  // Valid signal indicating the availability of serial output
    output reg dout        // Serial output
);

    // Internal registers
    reg [3:0] shift_reg;   // Shift register to hold input data
    reg [1:0] cnt;         // 2-bit counter to track the current bit being output

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the internal registers
            shift_reg <= 4'b0;
            cnt <= 2'b0;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'b00) begin
                // Load the input data into the shift register when the counter is at 0
                shift_reg <= d;
                dout <= d[3];       // Output the most significant bit first
                valid_out <= 1'b1;  // Indicate valid output
                cnt <= cnt + 1'b1;  // Increment the counter
            end else if (cnt < 2'b11) begin
                // Output the next bits sequentially
                dout <= shift_reg[3];         // Output the MSB of shift_reg
                shift_reg <= {shift_reg[2:0], 1'b0};  // Shift the register left
                valid_out <= 1'b1;           // Indicate valid output
                cnt <= cnt + 1'b1;           // Increment the counter
            end else begin
                // When counter reaches 3, reset to 0 for the next input
                dout <= shift_reg[3];        // Output the last bit
                shift_reg <= {shift_reg[2:0], 1'b0};  // Shift the register left
                valid_out <= 1'b1;           // Indicate valid output
                cnt <= 2'b00;                // Reset counter
            end
        end
    end

endmodule
