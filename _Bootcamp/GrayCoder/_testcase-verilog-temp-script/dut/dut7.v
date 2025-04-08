module dut (
    input wire         clock,
    input wire         reset,
    input wire [63:0]  io_in,
    output reg [63:0]  io_out,
    input wire         io_encode
);

  integer i;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      io_out <= 64'b0;
    end else begin
      if (io_encode) begin
        // Encoding mode: Binary to Gray code
        io_out <= io_in ^ (io_in >> 1);
      end else begin
        // Decoding mode: Gray code to Binary
        io_out[63] <= io_in[63]; // The most significant bit (MSB) remains the same
        for (i = 62; i >= 0; i = i - 1) begin
          io_out[i] <= io_out[i+1] ^ io_in[i]; // XOR with the bit higher than current
        end
      end
    end
  end

endmodule
