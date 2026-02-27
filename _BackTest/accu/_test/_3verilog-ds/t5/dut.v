module dut (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

    // Internal registers
    reg [7:0] data_buffer [0:3];  // Buffer to store 4 input data
    reg [1:0] count;              // Counter for received data (0-3)
    reg [9:0] sum;                // Accumulated sum
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            count <= 2'b00;
            valid_out <= 1'b0;
            data_out <= 10'b0;
            sum <= 10'b0;
            // Clear the buffer
            data_buffer[0] <= 8'b0;
            data_buffer[1] <= 8'b0;
            data_buffer[2] <= 8'b0;
            data_buffer[3] <= 8'b0;
        end
        else begin
            // Default value for valid_out (pulse for one cycle only)
            valid_out <= 1'b0;
            
            if (valid_in) begin
                // Store incoming data in buffer
                data_buffer[count] <= data_in;
                
                // Increment count (wraps around after 3)
                if (count == 2'b11) begin
                    count <= 2'b00;
                    
                    // Calculate sum when we have 4 data points
                    sum <= data_buffer[0] + data_buffer[1] + 
                           data_buffer[2] + data_buffer[3];
                    
                    // Output the sum and assert valid_out
                    data_out <= sum;
                    valid_out <= 1'b1;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
        end
    end

endmodule