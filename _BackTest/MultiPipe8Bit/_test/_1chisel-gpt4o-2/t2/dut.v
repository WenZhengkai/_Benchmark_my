module dut(
  input         clock,
  input         reset,
  input         io_mul_en_in,
  input  [7:0]  io_mul_a,
  input  [7:0]  io_mul_b,
  output        io_mul_en_out,
  output [15:0] io_mul_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg; // @[dut.scala 14:31]
  reg [7:0] mul_a_reg; // @[dut.scala 15:31]
  reg [7:0] mul_b_reg; // @[dut.scala 16:31]
  reg [15:0] mul_out_reg; // @[dut.scala 21:28]
  wire [7:0] _partial_products_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 34:31]
  wire [8:0] _partial_products_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 34:56]
  wire [8:0] _partial_products_1_T_2 = mul_b_reg[1] ? _partial_products_1_T_1 : 9'h0; // @[dut.scala 34:31]
  wire [9:0] _partial_products_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 34:56]
  wire [9:0] _partial_products_2_T_2 = mul_b_reg[2] ? _partial_products_2_T_1 : 10'h0; // @[dut.scala 34:31]
  wire [10:0] _partial_products_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 34:56]
  wire [10:0] _partial_products_3_T_2 = mul_b_reg[3] ? _partial_products_3_T_1 : 11'h0; // @[dut.scala 34:31]
  wire [11:0] _partial_products_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 34:56]
  wire [11:0] _partial_products_4_T_2 = mul_b_reg[4] ? _partial_products_4_T_1 : 12'h0; // @[dut.scala 34:31]
  wire [12:0] _partial_products_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 34:56]
  wire [12:0] _partial_products_5_T_2 = mul_b_reg[5] ? _partial_products_5_T_1 : 13'h0; // @[dut.scala 34:31]
  wire [13:0] _partial_products_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 34:56]
  wire [13:0] _partial_products_6_T_2 = mul_b_reg[6] ? _partial_products_6_T_1 : 14'h0; // @[dut.scala 34:31]
  wire [14:0] _partial_products_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 34:56]
  wire [14:0] _partial_products_7_T_2 = mul_b_reg[7] ? _partial_products_7_T_1 : 15'h0; // @[dut.scala 34:31]
  wire [15:0] partial_products_0 = {{8'd0}, _partial_products_0_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] partial_products_1 = {{7'd0}, _partial_products_1_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] sum_stage1_0 = partial_products_0 + partial_products_1; // @[dut.scala 39:40]
  wire [15:0] partial_products_2 = {{6'd0}, _partial_products_2_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] partial_products_3 = {{5'd0}, _partial_products_3_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] sum_stage1_1 = partial_products_2 + partial_products_3; // @[dut.scala 40:40]
  wire [15:0] partial_products_4 = {{4'd0}, _partial_products_4_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] partial_products_5 = {{3'd0}, _partial_products_5_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] sum_stage1_2 = partial_products_4 + partial_products_5; // @[dut.scala 41:40]
  wire [15:0] partial_products_6 = {{2'd0}, _partial_products_6_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] partial_products_7 = {{1'd0}, _partial_products_7_T_2}; // @[dut.scala 18:30 34:25]
  wire [15:0] sum_stage1_3 = partial_products_6 + partial_products_7; // @[dut.scala 42:40]
  wire [15:0] sum_stage2_0 = sum_stage1_0 + sum_stage1_1; // @[dut.scala 45:34]
  wire [15:0] sum_stage2_1 = sum_stage1_2 + sum_stage1_3; // @[dut.scala 46:34]
  wire [15:0] final_sum = sum_stage2_0 + sum_stage2_1; // @[dut.scala 49:33]
  assign io_mul_en_out = mul_en_out_reg; // @[dut.scala 57:17]
  assign io_mul_out = mul_en_out_reg ? mul_out_reg : 16'h0; // @[dut.scala 58:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= io_mul_en_in;
    end
    if (reset) begin // @[dut.scala 15:31]
      mul_a_reg <= 8'h0; // @[dut.scala 15:31]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 26:15]
    end
    if (reset) begin // @[dut.scala 16:31]
      mul_b_reg <= 8'h0; // @[dut.scala 16:31]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 27:15]
    end
    if (reset) begin // @[dut.scala 21:28]
      mul_out_reg <= 16'h0; // @[dut.scala 21:28]
    end else if (mul_en_out_reg) begin // @[dut.scala 52:24]
      mul_out_reg <= final_sum; // @[dut.scala 53:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mul_en_out_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  mul_out_reg = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
