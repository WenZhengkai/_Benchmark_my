module dut(
  input         clock,
  input         reset,
  input         io_mul_en_in,
  input  [7:0]  io_mul_a,
  input  [7:0]  io_mul_b,
  output        io_mul_en_out,
  output [15:0] io_mul_out
);

  // 5-cycle enable pipeline
  reg [4:0] mul_en_out_reg;

  // input registers (capture only when enabled)
  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;

  // combinational partial products and sums
  wire [15:0] temp [0:7];
  wire [15:0] sum0, sum1, sum2, sum3;
  wire [15:0] mul_out_next;

  // final product register
  reg [15:0] mul_out_reg;

  // Enable pipeline and input capture
  always @(posedge clock) begin
    if (reset) begin
      mul_en_out_reg <= 5'b0;
      mul_a_reg      <= 8'b0;
      mul_b_reg      <= 8'b0;
      mul_out_reg    <= 16'b0;
    end else begin
      // input control
      if (io_mul_en_in) begin
        mul_a_reg <= io_mul_a;
        mul_b_reg <= io_mul_b;
      end

      // shift enable
      mul_en_out_reg[0] <= io_mul_en_in;
      mul_en_out_reg[4:1] <= mul_en_out_reg[3:0];

      // register final product every cycle (matches the Chisel behavior)
      mul_out_reg <= mul_out_next;
    end
  end

  // Partial Product Generation
  assign temp[0] = mul_b_reg[0] ? ({8'b0, mul_a_reg} << 0) : 16'b0;
  assign temp[1] = mul_b_reg[1] ? ({8'b0, mul_a_reg} << 1) : 16'b0;
  assign temp[2] = mul_b_reg[2] ? ({8'b0, mul_a_reg} << 2) : 16'b0;
  assign temp[3] = mul_b_reg[3] ? ({8'b0, mul_a_reg} << 3) : 16'b0;
  assign temp[4] = mul_b_reg[4] ? ({8'b0, mul_a_reg} << 4) : 16'b0;
  assign temp[5] = mul_b_reg[5] ? ({8'b0, mul_a_reg} << 5) : 16'b0;
  assign temp[6] = mul_b_reg[6] ? ({8'b0, mul_a_reg} << 6) : 16'b0;
  assign temp[7] = mul_b_reg[7] ? ({8'b0, mul_a_reg} << 7) : 16'b0;

  // Partial Sum Calculation
  assign sum0 = temp[0] + temp[1];
  assign sum1 = temp[2] + temp[3];
  assign sum2 = temp[4] + temp[5];
  assign sum3 = temp[6] + temp[7];

  // Final Product Calculation
  assign mul_out_next = sum0 + sum1 + sum2 + sum3;

  // Outputs
  assign io_mul_en_out = mul_en_out_reg[4];
  assign io_mul_out    = io_mul_en_out ? mul_out_reg : 16'b0;

endmodule