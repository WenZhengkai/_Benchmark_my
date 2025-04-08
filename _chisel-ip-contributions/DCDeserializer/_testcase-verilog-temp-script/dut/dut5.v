module dut (
    input        clock,
    input        reset,
    output       io_dataIn_ready,
    input        io_dataIn_valid,
    input  [4:0] io_dataIn_bits,
    input        io_dataOut_ready,
    output       io_dataOut_valid,
    output [7:0] io_dataOut_bits
);

  // Parameters
  localparam SERIAL_WIDTH = 5;
  localparam PARALLEL_WIDTH = 8;
  localparam CYCLES = (PARALLEL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;  // Ceiling of division PARALLEL_WIDTH / SERIAL_WIDTH

  // Internal Registers
  reg [$clog2(CYCLES):0] cycleCount;  // Track current cycle
  reg [PARALLEL_WIDTH-1:0] dataSelect;  // Collect serialized bits
  reg dataValid;

  // Ready/Valid Logic
  assign io_dataIn_ready = !dataValid && io_dataOut_ready;  // Ready to accept when output is ready (and currently not holding valid data)
  assign io_dataOut_valid = dataValid;  // Output is valid based on accumulated data

  // Combine dataSelect to form full 8-bit output
  assign io_dataOut_bits = dataSelect;

  // Process on each clock cycle
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      dataSelect <= 0;
      dataValid <= 0;
    end else begin
      if (io_dataIn_valid && io_dataIn_ready) begin
        // Accept data and add to dataSelect
        dataSelect <= (dataSelect << SERIAL_WIDTH) | io_dataIn_bits;

        cycleCount <= cycleCount + 1;
        if (cycleCount == CYCLES - 1) begin
          dataValid <= 1;  // All bits collected, data is now valid
          cycleCount <= 0;  // Reset counter for next sequence
        end
      end

      // If data is sent out successfully, clear dataValid
      if (io_dataOut_valid && io_dataOut_ready) begin
        dataValid <= 0;
      end
    end
  end

endmodule
