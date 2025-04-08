module dut (
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output [63:0] io_out,
    input         io_encode
);

    reg [63:0] gray;
    reg [63:0] binary;
    reg [5:0] i; // 6 bits needed for index up to 63

    always @(*) begin
        if (io_encode) begin
            // Encoding mode
            gray = io_in ^ (io_in >> 1);
            io_out = gray;
        end else begin
            // Decoding mode
            binary = io_in;
            for (i = 1; i < 64; i = i + 1) begin
                binary = binary ^ (binary >> i);
            end
            io_out = binary;
        end
    end

endmodule
