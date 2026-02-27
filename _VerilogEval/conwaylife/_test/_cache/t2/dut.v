module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal signal to hold the next state
  reg [255:0] next_q;

  // Clocked process to update the state
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load the initial state
    end else begin
      q <= next_q; // Update to the next state
    end
  end

  // Combinational logic to compute the next state
  always @(*) begin
    integer i, j;
    integer row, col;
    integer count;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Count the number of live neighbors
        count = 0;

        // Check all 8 neighbors with wrap-around
        for (row = i - 1; row <= i + 1; row = row + 1) begin
          for (col = j - 1; col <= j + 1; col = col + 1) begin
            if (row == i && col == j) continue; // Skip the cell itself

            // Handle wrap-around for rows and columns
            integer wrapped_row = (row + 16) % 16;
            integer wrapped_col = (col + 16) % 16;

            // Check if the neighbor is alive
            if (q[wrapped_row * 16 + wrapped_col]) begin
              count = count + 1;
            end
          end
        end

        // Apply the rules to determine the next state
        if (count <= 1) begin
          next_q[i * 16 + j] = 0; // Rule (1)
        end else if (count == 2) begin
          next_q[i * 16 + j] = q[i * 16 + j]; // Rule (2)
        end else if (count == 3) begin
          next_q[i * 16 + j] = 1; // Rule (3)
        end else begin
          next_q[i * 16 + j] = 0; // Rule (4)
        end
      end
    end
  end

endmodule
