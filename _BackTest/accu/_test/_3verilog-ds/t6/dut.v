module dut (
    input               clk,
    input               rst_n,
    input       [7:0]   data_in,
    input               valid_in,
    output reg          valid_out,
    output reg  [9:0]   data_out
);

    reg [1:0]   counter;        // Counts from 0 to 3 (4 cycles)
    reg [9:0]   accumulator;    // Accumulator for the sum (needs 10 bits for 4*255 max)

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            counter     <= 2'b00;
            accumulator <= 10'b0;
            data_out    <= 10'b0;
            valid_out   <= 1'b0;
        end
        else begin
            // Default assignment for valid_out (only pulses for one cycle)
            valid_out <= 1'b0;
            
            if (valid_in) begin
                if (counter == 2'b11) begin
                    // On 4th valid input, output the sum and reset
                    data_out  <= accumulator + data_in;
                    valid_out <= 1'b1;
                    counter  <= 2'b00;
                    accumulator <= 10'b0;
                end
                else begin
                    // Accumulate and increment counter
                    accumulator <= accumulator + data_in;
                    counter <= counter + 1'b1;
                end
            end
        end
    end

endmodule