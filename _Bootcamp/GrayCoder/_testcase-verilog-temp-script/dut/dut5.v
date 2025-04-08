module dut (
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output reg [63:0] io_out,
  input         io_encode
);
  
  // Internal register to hold intermediate binary calculation
  reg [63:0] binary_temp;
  
  // Internal logic for encoding and decoding
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      io_out <= 64'b0;
    end else begin
      if (io_encode) begin
        // Encoding: Binary to Gray
        io_out <= io_in ^ (io_in >> 1);
      end else begin
        // Decoding: Gray to Binary
        // Start with the most significant bit which is identical for binary
        binary_temp = io_in;
        binary_temp = binary_temp ^ (binary_temp >> 1); 
        binary_temp = binary_temp ^ (binary_temp >> 2); 
        binary_temp = binary_temp ^ (binary_temp >> 4); 
        binary_temp = binary_temp ^ (binary_temp >> 8); 
        binary_temp = binary_temp ^ (binary_temp >> 16); 
        binary_temp = binary_temp ^ (binary_temp >> 32);
        io_out <= binary_temp;
      end
    end
  end

endmodule
