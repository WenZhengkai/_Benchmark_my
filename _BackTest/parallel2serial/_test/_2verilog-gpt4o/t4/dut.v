module dut (
    input wire clk,         // Clock signal
    input wire rst_n,       // Reset signal (active low)
    input wire [3:0] d,     // 4-bit parallel input
    output reg valid_out,   // Valid signal indicating availability of serial output
    output reg dout         // Serial output
);

    // Internal registers
    reg [3:0] data;  // Register to hold the data being serialized
    reg [1:0] cnt;   // 2-bit counter to track the serialization progress (0 to 3)

    // Always block for sequential logic (synchronous operations)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: initialize registers
            data <= 4'b0;
            cnt <= 2'b0;
            dout <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            if (cnt == 3) begin
                // When counter reaches 3 (last bit of current data),
                // load new parallel input into 'data', reset counter, and set valid_out to 1
                data <= d;
                cnt <= 0;
                dout <= d[3]; // Output MSB of the new data
                valid_out <= 1'b1;
            end else begin
                // Serialization in progress
                dout <= data[3];           // Output MSB of 'data'
                data <= {data[2:0], 1'b0}; // Shift 'data' left (shift in 0)
                cnt <= cnt + 1;           // Increment counter
                valid_out <= 1'b0;        // Clear valid signal
            end
        end
    end

endmodule
