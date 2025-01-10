module parallel2serial(
    input wire clk,      // Clock signal
    input wire rst_n,    // Asynchronous active low reset
    input wire [3:0] d,  // 4-bit parallel data input
    output reg valid_out,// Output valid signal
    output reg dout      // Serial data output
);

    reg [2:0] cnt;       // 3-bit counter for tracking output bits
    reg [3:0] data;      // Internal data register to hold input data

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            cnt <= 3'd0;
            data <= 4'd0;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 3'd0) begin
                // Load new data and output MSB on the first cycle
                data <= d;
                dout <= d[3]; // Output the MSB
                valid_out <= 1'b1;
            end else begin
                // Shift data and output the next bit
                data <= {data[2:0], 1'b0};
                dout <= data[2];
                valid_out <= 1'b1;
            end

            // Increment or reset counter
            if (cnt == 3'd3) begin
                cnt <= 3'd0; // Reset counter after 4 cycles
            end else begin
                cnt <= cnt + 1;
            end
        end
    end

endmodule
