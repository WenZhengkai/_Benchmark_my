module dut(
  input         clock,
  input         reset,
  output        io_dataIn_ready,
  input         io_dataIn_valid,
  input  [7:0]  io_dataIn_bits,
  input         io_dataOut_ready,
  output reg    io_dataOut_valid,
  output reg [4:0] io_dataOut_bits
);

  // Cycle counter register
  reg [2:0] cycleCount; // 3 bits to count up to 7 for cycles
  wire [2:0] cycles; // Total number of cycles required

  // Compute number of cycles needed to serialize 8-bit input into 5-bit output
  assign cycles = (8 % 5 != 0) ? (8 / 5) + 1 : (8 / 5);

  // Data Select Vector - store a split version of the input
  reg [4:0] dataSelect [0:1];

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 3'b0;
      io_dataOut_valid <= 1'b0;
    end else begin
      // Check if it's the last cycle and output is ready to accept data
      if (io_dataOut_valid && io_dataOut_ready) begin
        if (cycleCount == cycles - 1) begin
          cycleCount <= 3'b0;
        end else begin
          cycleCount <= cycleCount + 1'b1;
        end
        io_dataOut_valid <= (cycleCount < cycles);
      end

      // Handle data selection based on current cycle
      if (io_dataIn_valid) begin
        // Load the data into dataSelect vector
        dataSelect[0] <= io_dataIn_bits[4:0];
        dataSelect[1] <= io_dataIn_bits[7:5]; // Remaining bits

        // Set the output bitstream
        io_dataOut_bits <= dataSelect[cycleCount];

        // Set valid signal
        io_dataOut_valid <= 1'b1;
      end
    end
  end

  // Handshake logic for input readiness
  assign io_dataIn_ready = (cycleCount == cycles - 1) && io_dataOut_ready;

endmodule
