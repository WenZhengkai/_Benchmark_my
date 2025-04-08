module dut(
    input              clock,
    input              reset,
    output reg         io_dataIn_ready,
    input              io_dataIn_valid,
    input      [4:0]   io_dataIn_bits,
    input              io_dataOut_ready,
    output reg         io_dataOut_valid,
    output reg [7:0]   io_dataOut_bits
);

  // Constants
  localparam SERIAL_WIDTH = 5;
  localparam PARALLEL_WIDTH = 8;
  localparam CYCLES = (PARALLEL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;

  // Register for cycle count and storing incoming serial data
  reg [$clog2(CYCLES):0] cycleCount;
  reg [PARALLEL_WIDTH-1:0] dataSelect;

  // Initialize registers
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount       <= 0;
      io_dataIn_ready  <= 1;
      io_dataOut_valid <= 0;
      io_dataOut_bits  <= 0;
      dataSelect       <= 0;
    end else begin
      if (io_dataIn_ready && io_dataIn_valid) begin
        // Store incoming data into appropriate position in dataSelect
        dataSelect <= {dataSelect[PARALLEL_WIDTH-SERIAL_WIDTH-1:0], io_dataIn_bits};
        
        if (cycleCount == CYCLES - 1) begin
          // Final cycle: complete deserialization
          io_dataOut_valid <= 1;
          io_dataOut_bits  <= dataSelect[PARALLEL_WIDTH-SERIAL_WIDTH-1:0];
          cycleCount <= 0;  // Reset cycle count for next transaction
        end else begin
          // Continue accumulating data
          cycleCount <= cycleCount + 1;
        end
      end

      // Manage data valid signal
      if (io_dataOut_ready && io_dataOut_valid) begin
        io_dataOut_valid <= 0; // Clear data valid signal after data is fully deserialized and successfully output
        io_dataIn_ready <= 1;  // Accept new input data
      end else if (io_dataOut_valid) begin
        io_dataIn_ready <= 0;  // Halt input data while output is valid
      end
    end
  end

endmodule
