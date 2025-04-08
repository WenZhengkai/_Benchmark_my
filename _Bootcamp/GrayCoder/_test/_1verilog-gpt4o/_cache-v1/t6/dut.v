module dut (
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output reg [63:0] io_out,
    input         io_encode
);

    integer i;
    reg [63:0] temp;

    // Sequential logic triggered on the positive edge of the clock
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            io_out <= 64'b0;
        end else begin
            if (io_encode) begin
                // Encoding mode: Binary to Gray code
                io_out <= io_in ^ (io_in >> 1);
            end else begin
                // Decoding mode: Gray code to Binary
                // Gray to binary conversion requires iteration
                temp = io_in;
                io_out = temp;
                for (i = 1; i < 64; i = i + 1) begin
                    io_out = io_out ^ (temp >> i);
                end
            end
        end
    end

endmodule
