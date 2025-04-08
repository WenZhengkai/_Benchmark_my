module dut(
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output reg [63:0] io_out,
  input         io_encode
);

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      io_out <= 64'b0;
    end else begin
      if (io_encode) begin
        // Encoding Mode: Binary to Gray Code
        io_out <= io_in ^ (io_in >> 1);
      end else begin
        // Decoding Mode: Gray Code to Binary
        integer i;
        reg [63:0] bin;
        bin = io_in;
        
        // Decode by iterative XOR
        for (i = 1; i < 64; i = i + 1) begin
          bin = bin ^ (bin >> i);
        end

        io_out <= bin;
      end
    end
  end

endmodule
