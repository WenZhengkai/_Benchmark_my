module dut (
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output [63:0] io_out,
    input         io_encode
);

    // Internal registers
    reg [63:0]    decoded_value;
    integer       i;

    // Combinational logic for encoding and initial decoded_value assignment
    always @(*) begin
        if (io_encode) begin
            // Encoding Mode: Binary to Gray code
            io_out = io_in ^ (io_in >> 1);
            decoded_value = 64'd0;
        end else begin
            // Decoding Mode: Gray code to Binary
            decoded_value = io_in;
            for (i = 1; i < 64; i = i + 1) begin
                decoded_value[i] = io_in[i] ^ decoded_value[i - 1];
            end
            io_out = decoded_value;
        end
    end

    // Ensure io_out holds the correct value in each clock cycle
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            decoded_value <= 64'd0;
        end else if (!io_encode) begin
            io_out <= decoded_value;
        end
    end

endmodule
