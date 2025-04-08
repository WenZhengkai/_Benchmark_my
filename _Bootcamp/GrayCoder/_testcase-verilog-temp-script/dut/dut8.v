module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output reg [63:0] io_out,
  input         io_encode
);

  // Internal signal to store intermediate values during decoding
  reg [63:0] decoded_value;
  integer i;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      io_out <= 64'b0;
    end
    else if (io_encode) begin
      // Encoding: binary to Gray code
      io_out <= io_in ^ (io_in >> 1);
    end
    else begin
      // Decoding: Gray code to binary
      decoded_value = io_in;
      io_out = io_in; // Initialize with input value for first iteration

      // Iteratively decode Gray code to binary
      for (i = 1; i < 64; i = i + 1) begin
        decoded_value = decoded_value ^ (io_out >> i);
        io_out = decoded_value;
      end
    end
  end

endmodule
