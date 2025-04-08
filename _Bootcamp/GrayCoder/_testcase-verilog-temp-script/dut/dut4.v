module dut (
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output [63:0] io_out,
    input         io_encode
);
    reg [63:0] result;
    integer i;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            result <= 64'b0;
        end else if (io_encode) begin
            // Encoding: Binary to Gray code
            result <= io_in ^ (io_in >> 1);
        end else begin
            // Decoding: Gray code to Binary
            result <= io_in;
            for (i = 1; i < 64; i = i + 1) begin
                result[i] <= result[i-1] ^ io_in[i];
            end
        end
    end

    assign io_out = result;
endmodule
