module dut (
    input wire clk,         // Clock signal
    input wire rst_n,       // Active low reset signal
    input wire [3:0] d,     // 4-bit parallel data input
    output reg valid_out,   // Valid signal indicating the availability of output
    output reg dout         // Serial bit output
);

    // Internal registers
    reg [3:0] data;         // Data register to hold the 4-bit input d
    reg [1:0] cnt;          // 2-bit counter for tracking the bit position (0-3)

    // Sequential logic: Processed on the rising edge of the clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: Initialize all signals and registers to 0 on reset
            data <= 4'b0;
            cnt <= 2'b0;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'd0) begin
                // Load new data from input `d` when the counter is 0
                data <= d;
                dout <= d[3];   // Output the most significant bit (MSB)
                valid_out <= 1'b1; // Indicate valid output
                cnt <= cnt + 1'b1; // Increment the counter
            end else if (cnt < 2'd3) begin
                // For subsequent bits (remaining bits except LSB)
                dout <= data[3];   // Output the next MSB of the shift stack
              data	You missed increment counter <<= dout ;
警告：dut2.v格式异常
