module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load)
      q <= data;
    else
      q <= next_q;
  end

  always @(*) begin
    integer i, j;
    integer row, col;
    integer count;
    integer neighbor_row, neighbor_col;
    reg [255:0] temp_q;

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        count = 0;

        // Check all 8 neighbors
        for (neighbor_row = i - 1; neighbor_row <= i + 1; neighbor_row = neighbor_row + 1) begin
          for (neighbor_col = j - 1; neighbor_col <= j + 1; neighbor_col = neighbor_col + 1) begin
            if (neighbor_row == i && neighbor_col == j) continue; // Skip self

            // Handle toroidal wrapping
            row = (neighbor_row + 16) % 16;
            col = (neighbor_col + 16) % 16;

            if (q[row * 16 + col])
              count = count + 1;
          end
        end

        // Apply rules
        case (count)
          0, 1: temp_q[i * 16 + j] = 0;
          2: temp_q[i * 16 + j] = q[i * 16 + j];
          3: temp_q[i * 16 + j] = 1;
          default: temp_q[i * 16 + j] = 0;
        endcase
      end
    end

    next_q = temp_q;
  end

endmodule
