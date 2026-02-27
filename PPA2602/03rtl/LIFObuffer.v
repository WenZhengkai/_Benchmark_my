module dut(
  input        clock,
  input        reset,
  input  [3:0] io_dataIn,
  input        io_RW,
  input        io_EN,
  output       io_EMPTY,
  output       io_FULL,
  output [3:0] io_dataOut
);

  localparam integer STACK_DEPTH = 4;
  localparam integer PTR_W = 3; // log2Ceil(4+1)=3

  reg [3:0] stackMem [0:STACK_DEPTH-1];
  reg [PTR_W-1:0] stackPtr;   // initialized to 4
  reg empty;
  reg full;

  integer i;

  // Combinational outputs (matches the Chisel "io.dataOut := stackMem(stackPtr)" at end)
  assign io_EMPTY   = empty;
  assign io_FULL    = full;
  assign io_dataOut = stackMem[stackPtr]; // Note: stackPtr can be 4 on reset -> out of range (same issue as Chisel)

  always @(posedge clock) begin
    if (reset) begin
      for (i = 0; i < STACK_DEPTH; i = i + 1)
        stackMem[i] <= 4'h0;

      stackPtr <= STACK_DEPTH[PTR_W-1:0]; // 4
      empty    <= 1'b1;
      full     <= 1'b0;
    end else begin
      if (io_EN) begin
        if (!io_RW && !full) begin
          // push
          stackPtr <= stackPtr - 1'b1;
          stackMem[stackPtr] <= io_dataIn; // uses old stackPtr (as in the Chisel)
          empty    <= 1'b0;
          full     <= (stackPtr == 3'd1);
        end else if (io_RW && !empty) begin
          // pop
          stackMem[stackPtr] <= 4'h0;
          stackPtr <= stackPtr + 1'b1;
          full     <= 1'b0;
          empty    <= (stackPtr == (STACK_DEPTH-1)); // ==3
        end
      end
    end
  end

endmodule