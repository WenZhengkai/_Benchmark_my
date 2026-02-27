module dut(
    input         clock,
    input         reset,
    input  [63:0] io_in,
    output reg [63:0] io_out,
    input         io_encode
);

    reg [63:0] decoded_result;  // Register to store decoded value internally
    integer i;                  // For the loop in sequential decoding

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            io_out <= 64'd0;  // Reset output
        end else begin
            if (io_encode) begin
                // Encoding Mode: Binary to Gray Code
                io_out <= io_in ^ (io_in >> 1);
            end else begin
                // Decoding Mode: Gray Code to Binary
                decoded_result = io_in;  // Initialize with input Gray code
                for (i = 1; i < 64; i = i + 1) begin
                    decoded_result = decoded_result ^ (decoded_result >> i);
                end
                io_out <= decoded_result;
            end
        end
    end

endmodule
