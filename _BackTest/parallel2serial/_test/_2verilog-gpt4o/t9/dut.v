module dut (
    input  wire       clk,      // Clock signal
    input  wire       rst_n,    // Active-low reset signal
    input  wire [3:0] d,        // 4-bit parallel data input
    output reg        valid_out, // Valid signal indicating the availability of serial output
    output reg        dout      // Serial output
);

    // Registers to hold the state
    reg [3:0] data;   // Holds the current parallel input data for shifting
    reg [1:0] cnt;    // 2-bit counter for tracking the bit being output

    // The always block to describe the synchronous logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            data      <= 4'b0000;
            cnt       <= 2'd0;
            valid_out <= 1'b0;
            dout      <= 1'b0;
        end else begin
            if (cnt == 2'd3) begin
                // If the counter is 3, output the last bit in the current clock cycle
                dout      <= data[3]; // Output the MSB of the current data
                valid_out <= 1'b1;    // Set valid_out to 1 to indicate valid output
                data      <= d;       // Load new parallel data input
                cnt       <= 2'd0;    // Reset the counter
            end else begin
                // Otherwise, shift the data and output the next bit
                dout      <= data[3];   // Output the MSB of the current data
                data      <= {data[2:0], 1'b0}; // Shift data to the left by 1 bit
                cnt       <= cnt + 1;  // Increment the counter
                valid_out <= 1'b0;     // Reset valid_out as output is still work in progress
            end
        end
    end
endmodule
