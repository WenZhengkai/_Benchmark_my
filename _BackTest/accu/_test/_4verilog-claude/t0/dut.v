module dut (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

    reg [1:0] count;
    reg [9:0] accumulator;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 2'b00;
            accumulator <= 10'b0;
            valid_out <= 1'b0;
            data_out <= 10'b0;
        end else begin
            if (valid_in) begin
                if (count == 2'b11) begin
                    // Fourth valid input received
                    accumulator <= accumulator + data_in;
                    data_out <= accumulator + data_in;
                    valid_out <= 1'b1;
                    count <= 2'b00;
                    accumulator <= 10'b0;
                end else begin
                    // Accumulate input and increment count
                    accumulator <= accumulator + data_in;
                    count <= count + 1'b1;
                    valid_out <= 1'b0;
                end
            end else begin
                valid_out <= 1'b0;
            end
        end
    end

endmodule