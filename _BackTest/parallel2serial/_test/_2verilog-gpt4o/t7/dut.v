module dut (
    input wire clk,           // Clock signal
    input wire rst_n,         // Active-low reset
    input wire [3:0] d,       // 4-bit parallel data input
    output reg valid_out,     // Valid signal to indicate availability of serial output
    output reg dout           // Serial output
);

    // Internal data and counter registers
    reg [3:0] data;           // Data register to hold the parallel input data
    reg [1:0] cnt;            // 2-bit counter (0 to 3)

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: clear all registers
            data <= 4'b0;
            cnt <= 2'b0;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'b11) begin
                // When the counter reaches 3 (last bit outputted)
                data <= d;           // Load new parallel input
                cnt <= 2'b0;         // Reset counter
                valid_out <= 1'b1;   // Indicate valid output is available
                dout <= d[3];        // Output MSB of the new parallel data
            end else begin
                // Normal operation: shift the current data
                cnt <= cnt + 1;      // Increment counter
                valid_out <= 1'b0;   // Clear valid_out
                dout <= data[3];     // Output MSB of the current data register
                data <= {data[2:0], 1'b0}; // Shift data left by 1 bit
            end
        end
    end

endmodule
