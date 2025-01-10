// ```verilog
module asyn_fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)(
    input wclk,
    input rclk,
    input wrstn,
    input rrstn,
    input winc,
    input rinc,
    input [WIDTH-1:0] wdata,
    output reg wfull,
    output reg rempty,
    output reg [WIDTH-1:0] rdata
);

  // RAM module instantiation
  reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];
  reg [$clog2(DEPTH):0] wptr, rptr;
  reg [$clog2(DEPTH):0] wptr_gray, rptr_gray;
  reg [$clog2(DEPTH):0] waddr, raddr;
  reg [$clog2(DEPTH):0] sync_rptr_rclk, sync_wptr_wclk;
  
  always @(posedge wclk or negedge wrstn) begin
    if (!wrstn)
      {wptr, wptr_gray} <= 0;
    else if (winc && !wfull) begin
      RAM_MEM[waddr] <= wdata;
      wptr <= wptr + 1;
      wptr_gray <= (wptr + 1) ^ ((wptr + 1) >> 1);
    end
  end

  always @(posedge rclk or negedge rrstn) begin
    if (!rrstn)
      {rptr, rptr_gray} <= 0;
    else if (rinc && !rempty) begin
      rdata <= RAM_MEM[raddr];
      rptr <= rptr + 1;
      rptr_gray <= (rptr + 1) ^ ((rptr + 1) >> 1);
    end
  end

  // Synchronizing write pointer to read clock domain
  reg [$clog2(DEPTH):0] sync_wptr_rclk1, sync_wptr_rclk2;
  always @(posedge rclk or negedge rrstn) begin
    if (!rrstn)
      {sync_wptr_rclk1, sync_wptr_rclk2} <= 0;
    else begin
      sync_wptr_rclk1 <= wptr_gray;
      sync_wptr_rclk2 <= sync_wptr_rclk1;
    end
  end

  // Synchronizing read pointer to write clock domain
  reg [$clog2(DEPTH):0] sync_rptr_wclk1, sync_rptr_wclk2;
  always @(posedge wclk or negedge wrstn) begin
    if (!wrstn)
      {sync_rptr_wclk1, sync_rptr_wclk2} <= 0;
    else begin
      sync_rptr_wclk1 <= rptr_gray;
      sync_rptr_wclk2 <= sync_rptr_wclk1;
    end
  end

  wire [$clog2(DEPTH)-1:0] waddr_gray = wptr_gray[$clog2(DEPTH)-1:0];
  wire [$clog2(DEPTH)-1:0] raddr_gray = rptr_gray[$clog2(DEPTH)-1:0];

  // Full and Empty conditions
  always @(posedge wclk or negedge wrstn) begin
    if (!wrstn)
      wfull <= 0;
    else
      wfull <= (wptr_gray == {~sync_rptr_wclk2[$clog2(DEPTH):$clog2(DEPTH)-1],
                              sync_rptr_wclk2[$clog2(DEPTH)-2:0]});
  end

  always @(posedge rclk or negedge rrstn) begin
    if (!rrstn)
      rempty <= 1;
    else
      rempty <= (rptr_gray == sync_wptr_rclk2);
  end

  assign waddr = wptr[$clog2(DEPTH)-1:0];
  assign raddr = rptr[$clog2(DEPTH)-1:0];

endmodule
// ```