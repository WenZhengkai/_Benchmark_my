module dut (
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output reg [63:0] io_out,
    input         io_encode
);

    reg [63:0] intermediate;

    // Calculate log2Ceil of the bit width, which is 64 for io_in and io_out
    localparam integer WIDTH = 64;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            io_out <= 64'b0;
        end else begin
            if (io_encode) begin
                // Encoding Mode: Binary to Gray Code
                io_out <= io_in ^ (io_in >> 1);
            end else begin
                // Decoding Mode: Gray Code to Binary
                intermediate = io_in;
                for (integer i = 1; i < WIDTH; i = i + 1) begin
                    intermediate = intermediate ^ (intermediate >> i);
                end
                io_out <= intermediate;
            end
        end
    end

endmodule
