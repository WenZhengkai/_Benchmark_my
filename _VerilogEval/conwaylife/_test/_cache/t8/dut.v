module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal register to hold the next state
  reg [255:0] next_q;

  // Combinational logic to compute the next state
  always @(*) begin
    integer i, j;
    integer row, col;
    integer alive_neighbors;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Calculate the number of alive neighbors
        alive_neighbors = 0;

        // Check all 8 neighbors, wrapping around the grid
        for (row = i - 1; row <= i + 1; row = row + 1) begin
          for (col = j - 1; col <= j + 1; col = col + 1) begin
            if (row == i && col == j) continue; // Skip the current cell
            // Wrap around the grid using modulo 16
            if (q[((row + 16) % 16) * 16 + ((col + 16) % 16)] == 1)
              alive_neighbors = alive_neighbors + 1;
          end
        end

        // Determine the next state based on the rules
        case (alive_neighbors)
          0, 1: next_q[i * 16 + j] = 0; // Rule 1
          2:    next_q[i * 16 + j] = q[i * 16 + j]; // Rule 2
          3:    next_q[i * 16 + j] = 1; // Rule 3
          default: next_q[i * 16 + j] = 0; // Rule 4
        endcase
      end
    end
  end

  // Sequential logic to update the state on the clock edge
  always @(posedge clk) begin
    if (load)
      q <= data; // Load initial state
    else
      q <= next_q; // Update to the next state
  end

endmodule
