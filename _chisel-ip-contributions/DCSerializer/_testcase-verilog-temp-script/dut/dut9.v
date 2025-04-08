module dut (
    input clock,
    input reset,
    output reg io_dataIn_ready,
    input io_dataIn_valid,
    input [7:0] io_dataIn_bits,
    input io_dataOut_ready,
    output reg io_dataOut_valid,
    output reg [4:0] io_dataOut_bits
);

  // Constants for data width
  parameter INPUT_WIDTH = 8;  // Width of input data
  parameter OUTPUT_WIDTH = 5; // Width of output data
  parameter NUM_CYCLES = (INPUT_WIDTH % OUTPUT_WIDTH != 0) ? 2 : 1; // Calculate cycles

  // Cycle counter to track serialization process
  reg [$clog2(NUM_CYCLES):0] cycleCount;

  // Intermediate storage for serialized data
  reg [OUTPUT_WIDTH-1:0] dataSelect [0:NUM_CYCLES-1];

  // Serialization logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      io_dataIn_ready <= 1'b1;
      io_dataOut_valid <= 1'b0;
    end else begin
      if (io_dataIn_ready && io_dataIn_valid) begin
        // Load input data in the data select
        dataSelect[0] <= io_dataIn_bits[4:0];
        if (NUM_CYCLES > 1) begin
          dataSelect[1] <= io_dataIn_bits[INPUT_WIDTH-1:5];
        end
        cycleCount <= 0;
        io_dataIn_ready <= 1'b0;
      end

      if (io_dataOut_ready && io_dataOut_valid) begin
        cycleCount <= cycleCount + 1;
      end

      if (cycleCount == (NUM_CYCLES - 1)) begin
        io_dataIn_ready <= 1'b1;
      end

      io_dataOut_bits <= dataSelect[cycleCount];
      io_dataOut_valid <= io_dataIn_valid && !io_dataIn_ready;
    end
  end

endmodule
