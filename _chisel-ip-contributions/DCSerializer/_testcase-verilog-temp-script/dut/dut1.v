module dut(
    input        clock,
    input        reset,
    output       io_dataIn_ready,
    input        io_dataIn_valid,
    input  [7:0] io_dataIn_bits,
    input        io_dataOut_ready,
    output       io_dataOut_valid,
    output [4:0] io_dataOut_bits
);

  // Parameters
  localparam integer WIDTH = 5;  // Output word width
  localparam integer DATA_WIDTH = 8; // Input data width

  // Internal state
  reg [7:0]  data;   // Assuming io_dataIn_bits are serialized from this buffer
  reg [3:0]  cycleCount; // Support for up to 16 cycles (can be adjusted as necessary)
  reg        dataValid;  // Internal flag to indicate valid data
  
  wire [3:0] cycles; // Number of cycles needed for serialization

  // Calculate required cycles, taking ceiling into account
  assign cycles = (DATA_WIDTH % WIDTH != 0) ? (DATA_WIDTH / WIDTH + 1) : (DATA_WIDTH / WIDTH);

  // Cycle counter logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      dataValid <= 0;
    end else if (io_dataOut_valid && io_dataOut_ready) begin
      if (cycleCount == (cycles - 1)) begin
        cycleCount <= 0;
        dataValid <= 0;
      end else begin
        cycleCount <= cycleCount + 1;
      end
    end else if (io_dataIn_valid && io_dataIn_ready) begin
      cycleCount <= 0;
      dataValid <= 1;
      data <= io_dataIn_bits;
    end
  end

  // Handshaking logic for input readiness
  assign io_dataIn_ready = (cycleCount == (cycles - 1)) && io_dataOut_ready;

  // Output valid flag
  assign io_dataOut_valid = dataValid;

  // Output data selection logic based on the current cycle
  assign io_dataOut_bits = (data >> (cycleCount * WIDTH)) & ((1 << WIDTH) - 1);

endmodule
