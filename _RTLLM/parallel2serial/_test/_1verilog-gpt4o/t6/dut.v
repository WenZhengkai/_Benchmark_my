module parallel2serial (
    input wire clk,       // Clock signal
    input wire rst_n,     // Active-low reset signal
    input wire [3:0] d,   // 4-bit parallel data input
    output reg valid_out, // Valid output signal
    output reg dout       // Serial data output
);

// Internal registers
reg [3:0] data; // Data register to hold input data
reg [1:0] cnt;  // Counter register to track which bit to output

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset
        cnt <= 2'b00;
        data <= 4'b0000;
        dout <= 1'b0;
        valid_out <= 1'b0;
    end else begin
        if (cnt == 2'b00) begin
            // Load new data and prepare to start shifting
            data <= d;
            dout <= d[3];
            valid_out <= 1'b1; // Output is valid on the first cycle
            cnt <= cnt + 1;
        end else if (cnt < 2'b11) begin
            // Continue shifting data
            data <= {data[2:0], 1'b0}; // Shift left by 1 bit
            dout <= data[3]; // Output MSB
            valid_out <= 1'b1; // Output is valid
            cnt <= cnt + 1;
        end else begin
            // Reset counter for next cycle
            data <= {data[2:0], 1'b0}; // Shift left by 1 bit
            dout <= data[3]; // Output last bit
            valid_out <= 1'b1; // Output is valid
            cnt <= 2'b00;
        end
    end
end

endmodule
