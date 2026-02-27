module dut (
    input wire clk,        // Clock signal
    input wire rst_n,      // Reset signal (active low)
    input wire [3:0] d,    // 4-bit parallel data input
    output reg valid_out,  // Valid signal indicating availability of serial output
    output reg dout        // Serial output
);

    // Internal registers
    reg [3:0] data;        // Register to hold the parallel input data
    reg [1:0] cnt;         // Counter register (2 bits for counting 0 to 3)

    // Sequential logic: Main control
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            data <= 4'b0;
            dout <= 1'b0;
            valid_out <= 1'b0;
            cnt <= 2'b0;
        end else begin
            // Normal operation
            if (cnt == 2'b11) begin
                // On the last cycle of the current serial output
                data <= d;          // Load new parallel data
                dout <= d[3];       // Output the MSB of the new data
                valid_out <= 1'b1;  // Assert valid signal
                cnt <= 2'b00;       // Reset counter
            end else begin
                // During intermediate cycles
                dout <= data[2];     // Shift the next bit to dout
                data <= {data[2:0], 1'b0}; // Shift data left, insert 0
                valid_out <= 1'b0;   // Deassert valid signal
                cnt <= cnt + 1;      // Increment counter
            end
        end
    end

endmodule
