module dut (
    input               clk,
    input               rst_n,
    input       [7:0]   data_in,
    input               valid_in,
    output reg          valid_out,
    output reg  [9:0]   data_out
);

    reg [1:0]   count;          // Counter to track number of received inputs (0-3)
    reg [9:0]   accumulator;    // Accumulator for the sum (needs 10 bits to hold 4*255 max)
    reg         process_flag;   // Flag to indicate we're in a processing sequence

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            count        <= 2'b00;
            accumulator  <= 10'b0;
            data_out     <= 10'b0;
            valid_out    <= 1'b0;
            process_flag <= 1'b0;
        end
        else begin
            // Default assignment for valid_out (pulse for one cycle)
            valid_out <= 1'b0;

            if (valid_in) begin
                if (!process_flag) begin
                    // First valid data in a new sequence
                    process_flag <= 1'b1;
                    count       <= 2'b01;
                    accumulator <= {2'b00, data_in};  // Zero-extend to 10 bits
                end
                else begin
                    // Subsequent data in current sequence
                    count <= count + 1;
                    accumulator <= accumulator + data_in;

                    if (count == 2'b11) begin
                        // Fourth data received - output result
                        data_out  <= accumulator + data_in;
                        valid_out <= 1'b1;
                        
                        // Reset for next sequence
                        count        <= 2'b00;
                        accumulator  <= 10'b0;
                        process_flag <= 1'b0;
                    end
                end
            end
        end
    end

endmodule