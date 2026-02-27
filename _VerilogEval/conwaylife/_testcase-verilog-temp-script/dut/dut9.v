module dut (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal signal to hold the next state
  reg [255:0] next_q;

  // Combinational logic to compute the next state
  always @(*) begin
    integer i, j;
    integer row, col;
    integer neighbor_count;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Calculate the number of live neighbors for cell (i,j)
        neighbor_count = 0;

        // Check all 8 neighbors with wrap-around using modulo 16
        neighbor_count = neighbor_count + q[((i - 1 + 16) % 16) * 16 + ((j - 1 + 16) % 16)];
        neighbor_count = neighbor_count + q[((i - 1 + 16) % 16) * 16 + j];
        neighbor_count = neighbor_count + q[((i - 1 + 16) % 16) * 16 + ((j + 1) % 16)];
        neighbor_count = neighbor_count + q[i * 16 + ((j - 1 + 16) % 16)];
        neighbor_count = neighbor_count + q[i * 16 + ((j + 1) % 16)];
        neighbor_count = neighbor_count + q[((i + 1) % 16) * 16 + ((j - 1 + 16) % 16)];
        neighbor_count = neighbor_count + q[((i + 1) % 16) * 16 + j];
        neighbor_count = neighbor_count + q[((i + 1) % 16) * 16 + ((j + 1) % 16)];

        // Determine the next state based on the rules
        case (neighbor_count)
          0, 1: next_q[i * 16 + j] = 0; // Rule (1): 0-1 neighbor
          2: next_q[i * 16 + j] = q[i * 16 + j]; // Rule (2): 2 neighbors
          3: next_q[i * 16 + j] = 1; // Rule (3): 3 neighbors
          default: next_q[i * 16 + j] = 0; // Rule (4): 4+ neighbors
        endcase
      end
    end
  end

  // Sequential logic to update the state on the clock edge
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q <= next_q; // Update to the next state
    end
  end

endmodule
