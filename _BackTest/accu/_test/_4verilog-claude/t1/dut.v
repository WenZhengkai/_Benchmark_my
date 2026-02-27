module dut (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

    // Internal registers
    reg [9:0] accumulator;
    reg [1:0] count;

    // Main logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset condition
            accumulator <= 10'b0;
            count <= 2'b0;
            valid_out <= 1'b0;
            data_out <= 10'b0;
        end else begin
            // Default state
            valid_out <= 1'b0;

            if (valid_in) begin
                // Accumulate input data
                accumulator <= accumulator + data_in;
                count <= count + 1'b1;

                // Check if we've received 4 inputs
                if (count == 2'b11) begin
                    // Output the accumulated result
                    data_out <= accumulator + data_in;
                    valid_out <= 1'b1;
                    
                    // Reset for next accumulation
                    accumulator <= 10'b0;
                    count <= 2'b0;
                end
            end
        end
    end

endmodule