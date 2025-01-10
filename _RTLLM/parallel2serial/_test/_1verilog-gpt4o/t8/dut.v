module parallel2serial(
    input wire clk,            // Clock signal
    input wire rst_n,          // Active low reset signal
    input wire [3:0] d,        // 4-bit parallel data input
    output reg valid_out,      // Valid signal for serial output availability
    output reg dout            // Serial data output
);

    // Internal signals
    reg [3:0] data;            // Data register to hold parallel input
    reg [1:0] cnt;             // 2-bit counter to track bit position

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: reset counters and valid output
            cnt <= 2'd0;
            data <= 4'd0;
            dout <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            if (cnt == 2'd0) begin
                // Load new data and set valid output
                data <= d;
                dout <= d[3]; // Output the most significant bit
                valid_out <= 1'b1;
            end else begin
                // Shift data and output the next bit
                dout <= data[3];
                valid_out <= 1'b1;
            end

            // Shift the data register
            data <= {data[2:0], 1'b0};

            // Update the counter
            if (cnt == 2'd3) begin
                cnt <= 2'd0;  // Reset the counter after 4 bits
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule
