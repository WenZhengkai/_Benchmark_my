module parallel2serial (
    input wire clk,       // Clock signal
    input wire rst_n,     // Active-low reset signal
    input wire [3:0] d,   // 4-bit parallel data input
    output reg valid_out, // Output valid signal
    output reg dout       // Serial data output
);

    reg [3:0] data;       // Register to hold input data
    reg [1:0] cnt;        // 2-bit counter to track bit position

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset signal handling
            data <= 4'b0;
            cnt <= 2'b0;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'd3) begin
                // Load new data and start the next cycle
                data <= d;
                cnt <= 2'b0;
                dout <= d[3];   // Output MSB of new data
                valid_out <= 1'b1;
            end else begin
                // Continue outputting bits
                cnt <= cnt + 2'd1;
                dout <= data[3];  // Output current MSB of data
                valid_out <= 1'b1;
                data <= {data[2:0], 1'b0};  // Shift left, insert 0 (maintain data length)
            end
        end
    end
endmodule
