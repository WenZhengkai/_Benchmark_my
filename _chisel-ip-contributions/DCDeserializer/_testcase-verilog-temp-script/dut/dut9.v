module dut(
    input wire        clock,
    input wire        reset,
    output reg        io_dataIn_ready,
    input wire        io_dataIn_valid,
    input wire [4:0]  io_dataIn_bits,
    input wire        io_dataOut_ready,
    output reg        io_dataOut_valid,
    output reg [7:0]  io_dataOut_bits
);

  // Internal parameters
  localparam INTEGER_WIDTH = 8;  // Total width of the output data
  localparam SERIAL_WIDTH = 5;   // Width of each incoming serialized segment
  localparam CYCLES = (INTEGER_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;  // Min cycles required

  // Internal registers
  reg [$clog2(CYCLES)-1:0] cycleCount;
  reg [INTEGER_WIDTH-1:0] dataSelect;
  reg dataValid;

  // Cycle calculation and deserialization process
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      dataSelect <= 0;
      dataValid <= 0;
      io_dataOut_valid <= 0;
      io_dataIn_ready <= 1;  // ready to accept data when reset
    end else begin
      // Handle incoming data
      if (io_dataIn_ready && io_dataIn_valid) begin
        // Position bits in the correct spot within dataSelect
        dataSelect <= (dataSelect >> SERIAL_WIDTH) | (io_dataIn_bits << (INTEGER_WIDTH - SERIAL_WIDTH));

        if (cycleCount == CYCLES - 1) begin
          // Once full data is received
          cycleCount <= 0;
          dataValid <= 1;
          io_dataOut_valid <= 1;
        end else begin
          cycleCount <= cycleCount + 1;
        end
      end

      // Handle outgoing data
      if (io_dataOut_ready && io_dataOut_valid) begin
        dataValid <= 0;
        io_dataOut_valid <= 0;
        io_dataIn_ready <= 1;  // ready to accept more data after sending output
      end else if (!io_dataOut_valid && !dataValid) begin
        io_dataIn_ready <= 1; // continue accepting more data if not yet valid
      end else begin
        io_dataIn_ready <= 0; // do not accept more data while data is valid 
      end
    end
  end

  // Assign output bits
  always @(*) begin
    io_dataOut_bits = dataSelect;
  end

endmodule
