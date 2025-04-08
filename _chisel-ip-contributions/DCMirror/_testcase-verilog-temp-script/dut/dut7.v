module dut (
  input        clock,
  input        reset,
  input  [4:0] io_dst,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);

  reg [7:0] pData;      // Data register
  reg [4:0] pValid;     // Valid register

  wire [4:0] pReady;    // Ready vector
  wire nxtAccept;       // Next accept signal

  // Combine ready signals from all output channels
  assign pReady = {io_p_4_ready, io_p_3_ready, io_p_2_ready, io_p_1_ready, io_p_0_ready};

  // Calculate next accept logic
  assign nxtAccept = (pValid == 5'b00000) || (pValid & pReady) == pValid;

  // io_c_ready indicates when the module is ready to accept new data
  assign io_c_ready = nxtAccept;

  // Handle data storage and validity based on nxtAccept and incoming valid data
  always @(posedge clock) begin
    if (!reset) begin
      if (nxtAccept) begin
        pData <= io_c_bits;
        if (io_c_valid) begin
          pValid <= io_dst; // Set pValid based on dst only if incoming data is valid
        end
      end else begin
        pValid <= pValid & ~pReady; // Clear valid bits for channels that are ready
      end
    end
  end

  // Output assignments
  assign io_p_0_valid = pValid[0];
  assign io_p_0_bits = pData;
  assign io_p_1_valid = pValid[1];
  assign io_p_1_bits = pData;
  assign io_p_2_valid = pValid[2];
  assign io_p_2_bits = pData;
  assign io_p_3_valid = pValid[3];
  assign io_p_3_bits = pData;
  assign io_p_4_valid = pValid[4];
  assign io_p_4_bits = pData;

endmodule
