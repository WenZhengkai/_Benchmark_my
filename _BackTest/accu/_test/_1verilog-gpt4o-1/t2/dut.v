module dut (
    input         clk,         // Clock input
    input         rst_n,       // Active-low reset
    input  [7:0]  data_in,     // 8-bit input data
    input         valid_in,    // Input valid signal
    output        valid_out,   // Output valid signal
    output [9:0]  data_out     // 10-bit accumulated output data
);

    // Internal signals
    reg [9:0] acc;             // Accumulator to store the sum
    reg [1:0] cnt;             // Counter to count the number of valid inputs
    reg       valid_out_reg;   // Registered version of valid_out
    reg [9:0] data_out_reg;    // Registered version of data_out

    // Assign outputs to registered signals
    assign valid_out = valid_out_reg;
    assign data_out  = data_out_reg;

    // Sequential block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all internal values
            acc           <= 10'd0;
            cnt           <= 2'd0;
            valid_out_reg <= 1'b0;
            data_out_reg  <= 10'd0;
        end else begin
            if (valid_in) begin
                // Accumulate the input data
                acc <= acc + data_in;

                // Increment the counter
                cnt <= cnt + 1;

                // Check if we reached 4 valid inputs
                if (cnt == 2'd3) begin  // 4th input (0-based count)
                    data_out_reg  <= acc + data_in; // Calculate final accumulation
                    valid_out_reg <= 1'b1;         // Set valid_out signal for 1 cycle
                    acc           <= 10'd0;        // Reset accumulator
                    cnt           <= 2'd0;         // Reset counter
                end else begin
                    valid_out_reg <= 1'b0; // No valid output yet
                end
            end else begin
                valid_out_reg <= 1'b0; // No valid input, so no valid output
            end
        end
    end

endmodule
