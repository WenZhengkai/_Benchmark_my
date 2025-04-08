module dut(
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

  // Data register
  reg [7:0] pData;
  
  // Valid register
  reg [4:0] pValid;

  // Ready vector
  wire [4:0] pReady = {io_p_4_ready, io_p_3_ready, io_p_2_ready, io_p_1_ready, io_p_0_ready};

  // Next accept logic
  wire nxtAccept = (pValid == 5'b0) | ((pValid & pReady) == pValid);

  // Handle next state of pData and pValid
  always @(posedge clock) begin
    if (io_c_valid & nxtAccept) begin
      pData <= io_c_bits;  // Update data on new valid input
    end
    if (reset) begin
      pValid <= 5'b0;
    end
    else if (nxtAccept) begin
      pValid <= io_dst & {5{io_c_valid}};  // Update valid according to dst and current valid input
    end else begin
      pValid <= pValid & ~pReady;  // Retain only valid bits where not ready
    end
  end

  // Ready signal for input
  assign io_c_ready = nxtAccept;

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
