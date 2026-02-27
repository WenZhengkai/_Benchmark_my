module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q;

  // Combinational logic to compute the next state
  always @(*) begin
    integer i, j;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Get the current cell state
        reg current_state = q[i * 16 + j];

        // Count the number of alive neighbors
        integer neighbor_count = 0;
        integer x, y;

        for (x = -1; x <= 1; x = x + 1) begin
          for (y = -1; y <= 1; y = y + 1) begin
            if (x == 0 && y == 0) continue; // Skip the current cell

            // Calculate toroidal neighbor coordinates
            integer neighbor_x = (i + x + 16) % 16;
            integer neighbor_y = (j + y + 16) % 16;

            // Check if the neighbor is alive
            if (q[neighbor_x * 16 + neighbor_y]) begin
              neighbor_count = neighbor_count + 1;
            end
          end
        end

        // Determine the next state based on the rules
        case (neighbor_count)
          0, 1: next_q[i * 16 + j] = 1'b0; // Rule (1)
          2: next_q[i * 16 + j] = current_state; // Rule (2)
          3: next_q[i * 16 + j] = 1'b1; // Rule (3)
          default: next_q[i * 16 + j] = 1'b0; // Rule (4)
        endcase
      end
    end
  end

  // Sequential logic to update the state
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q <= next_q; // Update to the next state
    end
  end

endmodule
