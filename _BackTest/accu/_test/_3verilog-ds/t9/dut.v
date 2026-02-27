module dut (
    input               clk,
    input               rst_n,
    input       [7:0]   data_in,
    input               valid_in,
    output reg          valid_out,
    output reg  [9:0]    data_out
);

    reg [1:0]   counter;        // Counter to track number of received inputs (0-3)
    reg [9:0]   accumulator;    // Accumulator for the sum (needs 10 bits for 4x 8-bit max)
    reg         processing;     // Flag to indicate we're in a processing sequence

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            counter     <= 2'b00;
            accumulator <= 10'b0;
            data_out    <= 10'b0;
            valid_out   <= 1'b0;
            processing  <= 1'b0;
        end
        else begin
            // Default value for valid_out (pulse for one cycle only)
            valid_out <= 1'b0;
            
            if (valid_in) begin
                // When we get valid input
                processing <= 1'b1;
                
                if (counter == 2'b11) begin
                    // On 4th input (counter = 3)
                    accumulator <= accumulator + data_in;
                    data_out    <= accumulator + data_in;
                    valid_out   <= 1'b1;
                    counter     <= 2'b00;
                    accumulator <= 10'b0;
                end
                else begin
                    // For 1st-3rd inputs
                    accumulator <= accumulator + data_in;
                    counter     <= counter + 1;
                end
            end
            else if (!valid_in && processing && counter != 0) begin
                // If we lose valid_in mid-sequence, reset (optional behavior)
                counter     <= 2'b00;
                accumulator <= 10'b0;
                processing  <= 1'b0;
            end
        end
    end

endmodule