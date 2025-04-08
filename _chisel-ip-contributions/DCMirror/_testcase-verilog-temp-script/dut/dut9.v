module dut (
    input         clock,
    input         reset,
    input  [4:0]  io_dst,
    output        io_c_ready,
    input         io_c_valid,
    input  [7:0]  io_c_bits,
    input         io_p_0_ready,
    output        io_p_0_valid,
    output [7:0]  io_p_0_bits,
    input         io_p_1_ready,
    output        io_p_1_valid,
    output [7:0]  io_p_1_bits,
    input         io_p_2_ready,
    output        io_p_2_valid,
    output [7:0]  io_p_2_bits,
    input         io_p_3_ready,
    output        io_p_3_valid,
    output [7:0]  io_p_3_bits,
    input         io_p_4_ready,
    output        io_p_4_valid,
    output [7:0]  io_p_4_bits
);

  reg [7:0] pData;
  reg [4:0] pValid;
  wire [4:0] pReady = {io_p_4_ready, io_p_3_ready, io_p_2_ready, io_p_1_ready, io_p_0_ready};

  wire nxtAccept = (pValid == 5'd0) || (pValid & pReady) == pValid;

  always @(posedge clock) begin
    if (reset) begin
      pValid <= 5'd0;
    end else if (nxtAccept && io_c_valid) begin
      pData <= io_c_bits;
      pValid <= io_dst & {5{io_c_valid}};
    end else begin
      pValid <= pValid & ~pReady;
    end
  end

  assign io_c_ready = nxtAccept;
  
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
