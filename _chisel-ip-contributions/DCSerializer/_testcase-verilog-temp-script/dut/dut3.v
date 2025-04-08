module dut(
    input             clock,
    input             reset,
    output            io_dataIn_ready,
    input             io_dataIn_valid,
    input   [7:0]     io_dataIn_bits,
    input             io_dataOut_ready,
    output            io_dataOut_valid,
    output  [4:0]     io_dataOut_bits
);

  reg [1:0] cycleCount_reg, cycleCount_next; // Assuming it needs 2 cycles for 8 bits
  reg [7:0] data_reg;

  wire [4:0] dataSelect[1:0];
  assign dataSelect[0] = data_reg[4:0]; // lower 5 bits
  assign dataSelect[1] = data_reg[7:5]; // higher 3 bits (padded with zeros)

  // Calculate number of cycles
  localparam integer cycles = 2; // For 8-bit data and 5-bit output, ceil(8/5) = 2

  // Handshake Outputs
  assign io_dataIn_ready = (cycleCount_reg == cycles - 1) && io_dataOut_ready;
  assign io_dataOut_valid = io_dataIn_valid;

  // Output data based on cycle count
  assign io_dataOut_bits = dataSelect[cycleCount_reg];

  // Cycle counter logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount_reg <= 0;
      data_reg <= 0;
    end else begin
      cycleCount_reg <= cycleCount_next;

      // Latch input data when input handshake conditions are met
      if (io_dataIn_ready && io_dataIn_valid) begin
        data_reg <= io_dataIn_bits;
      end
    end
  end

  always @(*) begin
    if (io_dataOut_valid && io_dataOut_ready) begin
      if (cycleCount_reg == cycles - 1) begin
        cycleCount_next = 0; // Reset cycle count after last cycle
      end else begin
        cycleCount_next = cycleCount_reg + 1;
      end
    end else begin
      cycleCount_next = cycleCount_reg;
    end
  end

endmodule
