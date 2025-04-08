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
  localparam integer DATA_WIDTH = 8;
  localparam integer SERIAL_WIDTH = 5;
  localparam integer CYCLE_COUNT = (DATA_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH; // ceiling division

  // Cycle count width using log2Ceil
  localparam integer CYCLE_COUNT_WIDTH = $clog2(CYCLE_COUNT);

  // Internal Registers
  reg [CYCLE_COUNT_WIDTH-1:0] cycleCount;
  reg [DATA_WIDTH-1:0] dataSelect;
  reg dataValid;

  // Assign output values
  assign io_dataOut_bits = dataSelect;
  assign io_dataOut_valid = dataValid;
  assign io_dataIn_ready = !dataValid || (io_dataOut_ready && dataValid);

  // Process
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      dataSelect <= 0;
      dataValid <= 0;
    end else begin
      // Handle data input
      if (io_dataIn_ready && io_dataIn_valid) begin
        // Store the incoming serial data segment into the correct position in dataSelect
        dataSelect <= (dataSelect << SERIAL_WIDTH) | io_dataIn_bits;
        cycleCount <= cycleCount + 1;

        // Check if we have reached the required number of cycles
        if (cycleCount == CYCLE_COUNT - 1) begin
          dataValid <= 1;
          cycleCount <= 0;
        end
      end

      // Handle data output
      if (io_dataOut_valid && io_dataOut_ready) begin
        // Data has been successfully output reset dataValid
        dataValid <= 0;
      end
    end
  end

endmodule
