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
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] mul_en_out_reg; // @[dut.scala 17:31]
  wire [2:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[1:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[dut.scala 26:22]
  reg [7:0] mul_b_reg; // @[dut.scala 27:22]
  wire [7:0] _partial_products_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 36:31]
  wire [8:0] _partial_products_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 36:56]
  wire [8:0] _partial_products_1_T_2 = mul_b_reg[1] ? _partial_products_1_T_1 : 9'h0; // @[dut.scala 36:31]
  wire [9:0] _partial_products_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 36:56]
  wire [9:0] _partial_products_2_T_2 = mul_b_reg[2] ? _partial_products_2_T_1 : 10'h0; // @[dut.scala 36:31]
  wire [10:0] _partial_products_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 36:56]
  wire [10:0] _partial_products_3_T_2 = mul_b_reg[3] ? _partial_products_3_T_1 : 11'h0; // @[dut.scala 36:31]
  wire [11:0] _partial_products_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 36:56]
  wire [11:0] _partial_products_4_T_2 = mul_b_reg[4] ? _partial_products_4_T_1 : 12'h0; // @[dut.scala 36:31]
  wire [12:0] _partial_products_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 36:56]
  wire [12:0] _partial_products_5_T_2 = mul_b_reg[5] ? _partial_products_5_T_1 : 13'h0; // @[dut.scala 36:31]
  wire [13:0] _partial_products_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 36:56]
  wire [13:0] _partial_products_6_T_2 = mul_b_reg[6] ? _partial_products_6_T_1 : 14'h0; // @[dut.scala 36:31]
  wire [14:0] _partial_products_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 36:56]
  wire [14:0] _partial_products_7_T_2 = mul_b_reg[7] ? _partial_products_7_T_1 : 15'h0; // @[dut.scala 36:31]
  reg [15:0] sum_stage1_reg_0; // @[dut.scala 40:27]
  reg [15:0] sum_stage1_reg_1; // @[dut.scala 40:27]
  reg [15:0] sum_stage1_reg_2; // @[dut.scala 40:27]
  reg [15:0] sum_stage1_reg_3; // @[dut.scala 40:27]
  wire [15:0] partial_products_0 = {{8'd0}, _partial_products_0_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] partial_products_1 = {{7'd0}, _partial_products_1_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] _sum_stage1_reg_0_T_1 = partial_products_0 + partial_products_1; // @[dut.scala 42:46]
  wire [15:0] partial_products_2 = {{6'd0}, _partial_products_2_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] partial_products_3 = {{5'd0}, _partial_products_3_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] _sum_stage1_reg_1_T_1 = partial_products_2 + partial_products_3; // @[dut.scala 43:46]
  wire [15:0] partial_products_4 = {{4'd0}, _partial_products_4_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] partial_products_5 = {{3'd0}, _partial_products_5_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] _sum_stage1_reg_2_T_1 = partial_products_4 + partial_products_5; // @[dut.scala 44:46]
  wire [15:0] partial_products_6 = {{2'd0}, _partial_products_6_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] partial_products_7 = {{1'd0}, _partial_products_7_T_2}; // @[dut.scala 34:30 36:25]
  wire [15:0] _sum_stage1_reg_3_T_1 = partial_products_6 + partial_products_7; // @[dut.scala 45:46]
  reg [15:0] sum_stage2_reg_0; // @[dut.scala 49:27]
  reg [15:0] sum_stage2_reg_1; // @[dut.scala 49:27]
  wire [15:0] _sum_stage2_reg_0_T_1 = sum_stage1_reg_0 + sum_stage1_reg_1; // @[dut.scala 51:44]
  wire [15:0] _sum_stage2_reg_1_T_1 = sum_stage1_reg_2 + sum_stage1_reg_3; // @[dut.scala 52:44]
  reg [15:0] mul_out_reg; // @[dut.scala 56:24]
  wire [15:0] _mul_out_reg_T_1 = sum_stage2_reg_0 + sum_stage2_reg_1; // @[dut.scala 58:38]
  assign io_mul_en_out = mul_en_out_reg[2]; // @[dut.scala 23:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 62:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg <= 3'h0; // @[dut.scala 17:31]
    end else if (reset) begin // @[dut.scala 18:22]
      mul_en_out_reg <= 3'h0; // @[dut.scala 19:20]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 21:20]
    end
    if (io_mul_en_in) begin // @[dut.scala 28:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 29:15]
    end
    if (io_mul_en_in) begin // @[dut.scala 28:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 30:15]
    end
    if (mul_en_out_reg[0]) begin // @[dut.scala 41:27]
      sum_stage1_reg_0 <= _sum_stage1_reg_0_T_1; // @[dut.scala 42:23]
    end
    if (mul_en_out_reg[0]) begin // @[dut.scala 41:27]
      sum_stage1_reg_1 <= _sum_stage1_reg_1_T_1; // @[dut.scala 43:23]
    end
    if (mul_en_out_reg[0]) begin // @[dut.scala 41:27]
      sum_stage1_reg_2 <= _sum_stage1_reg_2_T_1; // @[dut.scala 44:23]
    end
    if (mul_en_out_reg[0]) begin // @[dut.scala 41:27]
      sum_stage1_reg_3 <= _sum_stage1_reg_3_T_1; // @[dut.scala 45:23]
    end
    if (mul_en_out_reg[1]) begin // @[dut.scala 50:27]
      sum_stage2_reg_0 <= _sum_stage2_reg_0_T_1; // @[dut.scala 51:23]
    end
    if (mul_en_out_reg[1]) begin // @[dut.scala 50:27]
      sum_stage2_reg_1 <= _sum_stage2_reg_1_T_1; // @[dut.scala 52:23]
    end
    if (mul_en_out_reg[2]) begin // @[dut.scala 57:27]
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 58:17]
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
  mul_en_out_reg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  sum_stage1_reg_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum_stage1_reg_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum_stage1_reg_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum_stage1_reg_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum_stage2_reg_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum_stage2_reg_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  mul_out_reg = _RAND_9[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
