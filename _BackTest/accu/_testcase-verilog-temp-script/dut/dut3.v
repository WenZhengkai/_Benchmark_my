module dut (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

    // Internal registers
    reg [9:0] sum;
    reg [1:0] count;

    // Logic block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset everything
            data_out  <= 10'b0;
            valid_out <= 1'b0;
            sum       <= 10'b0;
            count     <= 2'b0;
        end else begin
            if (valid_in) begin
                // Add incoming data to the sum
                sum <= sum + data_in;
                // Increment valid input count
                count <= count + 1;

                // Check if 4 valid inputs have been accumulated
                if (count == 2'd3) begin
                    data_out  <= sum + data_in; // Final addition for the 4th input
                    valid_out <= 1'b1;
                    sum       <= 10'b0;        // Reset sum after output
                    count     <= 2'b0;         // Reset count after output
                end else begin
                    valid_out <= 1'b0;         // Output not ready yet
                end
            end else begin
                valid_out <= 1'b0;             // Output invalid if no valid input
            end
        end
    end

endmodule
