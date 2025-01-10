
module parallel2serial (
    input wire clk,         // Clock signal
    input wire rst_n,       // Asynchronous active-low reset signal
    input wire [3:0] d,     // 4-bit parallel data input
    output reg valid_out,   // Serial data valid signal
    output reg dout         // Serial data output
);

    reg [3:0] data;         // Register to hold the parallel data
    reg [1:0] cnt;          // 2-bit counter to track the serial output position

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: reset all registers
            cnt <= 2'b0;
            valid_out <= 1'b0;
            data <= 4'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'b0) begin
                data <= d;  // Load new parallel data into the register
                dout <= d[3];  // Output the MSB of data
                valid_out <= 1'b1;  // Signal that valid data is available
                cnt <= cnt + 1'b1;  // Increment the counter
            end else if (cnt < 2'b11) begin
                dout <= data[3];  // Output the current MSB of data
                data <= {data[2:0], 1'b0};  // Shift data left
                valid_out <= 1'b1;  // Signal that valid data is available
                cnt <= cnt + 1'b1;  // Increment the counter
            end else begin
                dout <= data[3];  // Output the last bit of data
                valid_out <= 1'b1;  // Signal that valid data is available
                cnt <= 2'b0;  // Reset the counter for the next input
            end
        end
    end

endmodule
