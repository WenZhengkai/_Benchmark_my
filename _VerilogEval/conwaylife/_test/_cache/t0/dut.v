module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal signal to hold the next state
  reg [255:0] next_q;

  // Function to calculate the number of live neighbors for a given cell
  function [3:0] count_neighbors;
    input [3:0] row; // Row index (0 to 15)
    input [3:0] col; // Column index (0 to 15)
    reg [3:0] count;
    integer i, j;
    begin
      count = 0;
      for (i = -1; i <= 1; i = i + 1) begin
        for (j = -1; j <= 1; j = j + 1) begin
          if (i == 0 && j == 0) continue; // Skip the cell itself
          // Calculate wrapped-around indices
          if (row + i < 0) row = 15;
          else if (row + i > 15) row = 0;
          else row = row + i;
          if (col + j < 0) col = 15;
          else if (col + j > 15) col = 0;
          else col = col + j;
          // Check if the neighbor is alive
          if (q[{row, col}]) count = count + 1;
        end
      end
      count_neighbors = count;
    end
  endfunction

  // Logic to update the grid
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q <= next_q; // Update to the next state
    end
  end

  // Combinational logic to compute the next state
  always @(*) begin
    integer row, col;
    reg [3:0] neighbors;
    for (row = 0; row < 16; row = row + 1) begin
      for (col = 0; col < 16; col = col + 1) begin
        neighbors = count_neighbors(row, col);
        case (neighbors)
          0, 1: next_q[{row, col}] = 0; // Rule 1
          2: next_q[{row, col}] = q[{row, col}]; // Rule 2
          3: next_q[{row, col}] = 1; // Rule 3
          default: next_q[{row, col}] = 0; // Rule 4
        endcase
      end
    end
  end

endmodule
