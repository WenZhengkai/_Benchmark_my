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

  reg [7:0] pData;     // Register to hold the data payload
  reg [4:0] pValid;    // Valid register for each output

  wire [4:0] pReady;   // Combined ready signals from outputs
  wire nxtAccept;      // Signal indicating when new data can be accepted

  // Concatenate ready signals from each output
  assign pReady = {io_p_4_ready, io_p_3_ready, io_p_2_ready, io_p_1_ready, io_p_0_ready};

  // Determine when to accept new data
  assign nxtAccept = (pValid == 5'b00000) | ((pValid & pReady) == pValid);

  // Control logic for data and valid registers
  always @(posedge clock) begin
    if (reset) begin
      pValid <= 5'b0;
    end else begin
      if (nxtAccept && io_c_valid) begin
        pData <= io_c_bits;  // Update data payload
        pValid <= io_dst & {5{io_c_valid}};  // Set valid bits according to dst and c_valid
      end else begin
        // Retain valid bits for outputs that aren't ready
        pValid <= pValid & ~pReady;
      end
    end
  end

  // Assign output valid signals
  assign io_p_0_valid = pValid[0];
  assign io_p_1_valid = pValid[1];
  assign io_p_2_valid = pValid[2];
  assign io_p_3_valid = pValid[3];
  assign io_p_4_valid = pValid[4];

  // Assign output data signals
  assign io_p_0_bits = pData;
  assign io_p_1_bits = pData;
  assign io_p_2_bits = pData;
  assign io_p_3_bits = pData;
  assign io_p_4_bits = pData;

  // Assign input ready signal
  assign io_c_ready = nxtAccept;

endmodule
