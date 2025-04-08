module dut(
    input        clock,
    input        reset,
    output reg   io_dataIn_ready,
    input        io_dataIn_valid,
    input  [7:0] io_dataIn_bits,
    input        io_dataOut_ready,
    output reg   io_dataOut_valid,
    output reg [4:0] io_dataOut_bits
);

  // Internal parameters and registers
  reg [3:0] cycleCount; // Assumes a maximum of 16 cycles
  reg [4:0] dataSelect[1:0]; // To accommodate two 5-bit slices of the 8-bit input
  integer cycles;

  initial begin
    cycleCount = 0;
    io_dataIn_ready = 0;
    io_dataOut_valid = 0;
    io_dataOut_bits = 0;
  end

  // Compute the number of cycles required
  always @(*) begin
    if (8 % 5 != 0) begin
      cycles = 8 / 5 + 1; // for 8-bit width converted to 5-bit slices
    end else begin
      cycles = 8 / 5;
    end
  end

  // Main sequential logic to handle data serialization process
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      io_dataIn_ready <= 0;
      io_dataOut_valid <= 0;
    end else begin
      // Check if the output can proceed with valid data
      if (io_dataOut_ready && io_dataOut_valid) begin
        cycleCount <= cycleCount + 1;
        io_dataOut_valid <= 0; // Assume transmission happens; data becomes invalid here
      end
      
      // Load data and reset cycle count when new transaction starts
      if (io_dataIn_valid && io_dataIn_ready) begin
        cycleCount <= 0;
        dataSelect[0] <= io_dataIn_bits[4:0];
        dataSelect[1] <= io_dataIn_bits[7:5];
        io_dataIn_ready <= 0; // Acknowledge the transaction
      end
      
      // Determine when to be ready again
      if (cycleCount == (cycles - 1)) begin
        io_dataIn_ready <= 1; // Ready for a new data transaction
      end

      // Handle data output and determine validity
      if (cycleCount < cycles) begin
        io_dataOut_bits <= dataSelect[cycleCount];
        io_dataOut_valid <= io_dataIn_valid;
      end else begin
        io_dataOut_valid <= 0;
      end
    end
  end

endmodule
