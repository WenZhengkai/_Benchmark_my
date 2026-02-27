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
    integer neighbor_count;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Count the number of alive neighbors
        neighbor_count = 0;

        // Check all 8 neighbors with wrap-around
        for (row = i - 1; row <= i + 1; row = row + 1) begin
          for (col = j - 1; col <= j + 1; col = col + 1) begin
            if (row == i && col == j) continue; // Skip the current cell
            if (q[((row + 16) % 16) * 16 + ((col + 16) % 16)] == 1) begin
              neighbor_count = neighbor_count + 1;
            end
          end
        end

        // Apply the rules to determine the next state
        case (neighbor_count)
          0, 1: next_q[i * 16 + j] = 0; // Rule (1)
          2: next_q[i * 16 + j] = q[i * 16 + j]; // Rule (2)
          3: next_q[i * 16 + j] = 1; // Rule (3)
          default: next_q[i * 16 + j] = 0; // Rule (4)
        endcase
      end
    end
  end

  // Sequential logic to update the state
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q <= next_q; // Update state
    end
  end

endmodule
