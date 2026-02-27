module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal signal to hold the next state of the grid
  reg [255:0] next_q;

  // Function to calculate the number of alive neighbors for a given cell
  function [3:0] count_neighbors;
    input [7:0] row, col;
    reg [3:0] count;
    integer i, j;
    begin
      count = 0;
      for (i = -1; i <= 1; i = i + 1) begin
        for (j = -1; j <= 1; j = j + 1) begin
          if (i == 0 && j == 0) continue; // Skip the cell itself
          // Calculate wrapped indices using modulo 16
          if (q[((row + i + 16) % 16) * 16 + ((col + j + 16) % 16)]) begin
            count = count + 1;
          end
        end
      end
      count_neighbors = count;
    end
  endfunction

  // Update the grid state every clock cycle
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q <= next_q; // Update to the next state
    end
  end

  // Compute the next state of the grid
  integer row, col;
  always @(*) begin
    for (row = 0; row < 16; row = row + 1) begin
      for (col = 0; col < 16; col = col + 1) begin
        case (count_neighbors(row, col))
          0, 1: next_q[row * 16 + col] = 0; // Rule (1)
          2: next_q[row * 16 + col] = q[row * 16 + col]; // Rule (2)
          3: next_q[row * 16 + col] = 1; // Rule (3)
          default: next_q[row * 16 + col] = 0; // Rule (4)
        endcase
      end
    end
  end

endmodule
