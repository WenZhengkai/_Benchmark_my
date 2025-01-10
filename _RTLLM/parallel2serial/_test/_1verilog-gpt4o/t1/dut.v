module parallel2serial (
    input wire clk,         // Clock signal
    input wire rst_n,       // Active low reset signal
    input wire [3:0] d,     // 4-bit parallel data input
    output reg valid_out,   // Valid signal indicating availability of serial output
    output reg dout         // Serial output
);

    reg [3:0] data;         // Internal register to hold the current data being serialized
    reg [1:0] cnt;          // 2-bit counter to track the bit position

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset
            cnt <= 2'b00;
            data <= 4'b0000;
            dout <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            if (cnt == 2'b11) begin
                // Load new data and reset counter when 4th bit is reached
                data <= d;
                cnt <= 2'b00;
                dout <= d[3]; // Output the MSB of the new data
                valid_out <= 1'b1;
            end else begin
                // Shift data and increment counter for bits 0-2
                dout <= data[3]; // Output current MSB of data
                data <= {data[2:0], 1'b0}; // Shift left by 1, fill LSB with 0
                cnt <= cnt + 2'b01;
                valid_out <= 1'b0;
            end
        end
    end

endmodule
