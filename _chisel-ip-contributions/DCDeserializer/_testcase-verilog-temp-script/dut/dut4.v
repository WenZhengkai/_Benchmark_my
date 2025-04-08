module dut (
    input         clock,
    input         reset,
    output        io_dataIn_ready,
    input         io_dataIn_valid,
    input  [4:0]  io_dataIn_bits,
    input         io_dataOut_ready,
    output        io_dataOut_valid,
    output [7:0]  io_dataOut_bits
);

  // Parameterize the serialized and parallel data widths
  parameter SERIAL_WIDTH = 5;
  parameter PARALLEL_WIDTH = 8;
  parameter CYCLE_NUM = (PARALLEL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;  // Ceiling division to determine cycle count
  
  // Calculation for log2Ceil. In practice, synthesis tools will usually handle this internally.
  function integer log2Ceil;
    input integer value;
    integer i;
    begin
      log2Ceil = 0;
      for (i = value - 1; i > 0; i = i >> 1) begin
        log2Ceil = log2Ceil + 1;
      end
    end
  endfunction
  
  // Internal registers
  reg [log2Ceil(CYCLE_NUM) - 1:0] cycleCount = 0;
  reg [PARALLEL_WIDTH - 1:0] dataSelect = 0;
  reg dataValid = 0;

  // Assigning the ready and valid signals
  assign io_dataIn_ready = io_dataOut_ready && !dataValid;
  assign io_dataOut_valid = dataValid;
  assign io_dataOut_bits = dataSelect;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cycleCount <= 0;
      dataSelect <= 0;
      dataValid <= 0;
    end else begin
      if (io_dataIn_ready && io_dataIn_valid) begin
        // Load the incoming data bits into the appropriate position within dataSelect
        // Shifting the previous data left and adding new bits
        dataSelect <= {io_dataIn_bits, dataSelect[PARALLEL_WIDTH-1:SERIAL_WIDTH]};
        
        // Increment the cycle count
        if (cycleCount == CYCLE_NUM - 1) begin
          cycleCount <= 0;
          dataValid <= 1;
        end else begin
          cycleCount <= cycleCount + 1;
        end
      end
      
      // When dataOut is consumed, reset dataValid flag
      if (io_dataOut_valid && io_dataOut_ready) begin
          dataValid <= 0;
      end
    end
  end
endmodule
