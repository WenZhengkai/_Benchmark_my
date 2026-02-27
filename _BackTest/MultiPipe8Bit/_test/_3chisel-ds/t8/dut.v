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
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] mul_en_out_reg; // @[dut.scala 17:31]
  wire [1:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  reg  stage1_en; // @[dut.scala 28:26]
  wire [8:0] _partial_products_0_T_1 = {1'h0,mul_a_reg}; // @[Cat.scala 33:92]
  wire [8:0] partial_products_0 = mul_b_reg[0] ? _partial_products_0_T_1 : 9'h0; // @[dut.scala 33:31]
  wire [9:0] _partial_products_1_T_2 = {_partial_products_0_T_1, 1'h0}; // @[dut.scala 33:71]
  wire [9:0] _partial_products_1_T_3 = mul_b_reg[1] ? _partial_products_1_T_2 : 10'h0; // @[dut.scala 33:31]
  wire [10:0] _partial_products_2_T_2 = {_partial_products_0_T_1, 2'h0}; // @[dut.scala 33:71]
  wire [10:0] _partial_products_2_T_3 = mul_b_reg[2] ? _partial_products_2_T_2 : 11'h0; // @[dut.scala 33:31]
  wire [11:0] _partial_products_3_T_2 = {_partial_products_0_T_1, 3'h0}; // @[dut.scala 33:71]
  wire [11:0] _partial_products_3_T_3 = mul_b_reg[3] ? _partial_products_3_T_2 : 12'h0; // @[dut.scala 33:31]
  wire [12:0] _partial_products_4_T_2 = {_partial_products_0_T_1, 4'h0}; // @[dut.scala 33:71]
  wire [12:0] _partial_products_4_T_3 = mul_b_reg[4] ? _partial_products_4_T_2 : 13'h0; // @[dut.scala 33:31]
  wire [13:0] _partial_products_5_T_2 = {_partial_products_0_T_1, 5'h0}; // @[dut.scala 33:71]
  wire [13:0] _partial_products_5_T_3 = mul_b_reg[5] ? _partial_products_5_T_2 : 14'h0; // @[dut.scala 33:31]
  wire [14:0] _partial_products_6_T_2 = {_partial_products_0_T_1, 6'h0}; // @[dut.scala 33:71]
  wire [14:0] _partial_products_6_T_3 = mul_b_reg[6] ? _partial_products_6_T_2 : 15'h0; // @[dut.scala 33:31]
  wire [15:0] _partial_products_7_T_2 = {_partial_products_0_T_1, 7'h0}; // @[dut.scala 33:71]
  wire [15:0] _partial_products_7_T_3 = mul_b_reg[7] ? _partial_products_7_T_2 : 16'h0; // @[dut.scala 33:31]
  reg  stage2_en; // @[dut.scala 35:26]
  wire [8:0] partial_products_1 = _partial_products_1_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] _sum0_T_1 = partial_products_0 + partial_products_1; // @[dut.scala 38:44]
  reg [9:0] sum0; // @[Reg.scala 35:20]
  wire [8:0] partial_products_2 = _partial_products_2_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] partial_products_3 = _partial_products_3_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] _sum1_T_1 = partial_products_2 + partial_products_3; // @[dut.scala 39:44]
  reg [9:0] sum1; // @[Reg.scala 35:20]
  wire [8:0] partial_products_4 = _partial_products_4_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] partial_products_5 = _partial_products_5_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] _sum2_T_1 = partial_products_4 + partial_products_5; // @[dut.scala 40:44]
  reg [9:0] sum2; // @[Reg.scala 35:20]
  wire [8:0] partial_products_6 = _partial_products_6_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] partial_products_7 = _partial_products_7_T_3[8:0]; // @[dut.scala 31:30 33:25]
  wire [8:0] _sum3_T_1 = partial_products_6 + partial_products_7; // @[dut.scala 41:44]
  reg [9:0] sum3; // @[Reg.scala 35:20]
  reg  stage3_en; // @[dut.scala 42:26]
  wire [9:0] _sum4_T_1 = sum0 + sum1; // @[dut.scala 45:29]
  reg [10:0] sum4; // @[Reg.scala 35:20]
  wire [9:0] _sum5_T_1 = sum2 + sum3; // @[dut.scala 46:29]
  reg [10:0] sum5; // @[Reg.scala 35:20]
  reg  stage4_en; // @[dut.scala 47:26]
  wire [10:0] _mul_out_reg_T_1 = sum4 + sum5; // @[dut.scala 50:36]
  reg [15:0] mul_out_reg; // @[Reg.scala 35:20]
  reg  stage5_en; // @[dut.scala 51:26]
  assign io_mul_en_out = mul_en_out_reg[1]; // @[dut.scala 23:34]
  assign io_mul_out = stage5_en ? mul_out_reg : 16'h0; // @[dut.scala 54:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg <= 2'h0; // @[dut.scala 17:31]
    end else if (reset) begin // @[dut.scala 18:30]
      mul_en_out_reg <= 2'h0; // @[dut.scala 19:20]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 21:20]
    end
    if (reset) begin // @[Reg.scala 35:20]
      mul_a_reg <= 8'h0; // @[Reg.scala 35:20]
    end else if (io_mul_en_in) begin // @[Reg.scala 36:18]
      mul_a_reg <= io_mul_a; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      mul_b_reg <= 8'h0; // @[Reg.scala 35:20]
    end else if (io_mul_en_in) begin // @[Reg.scala 36:18]
      mul_b_reg <= io_mul_b; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 28:26]
      stage1_en <= 1'h0; // @[dut.scala 28:26]
    end else begin
      stage1_en <= io_mul_en_in; // @[dut.scala 28:26]
    end
    if (reset) begin // @[dut.scala 35:26]
      stage2_en <= 1'h0; // @[dut.scala 35:26]
    end else begin
      stage2_en <= stage1_en; // @[dut.scala 35:26]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum0 <= 10'h0; // @[Reg.scala 35:20]
    end else if (stage1_en) begin // @[Reg.scala 36:18]
      sum0 <= {{1'd0}, _sum0_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum1 <= 10'h0; // @[Reg.scala 35:20]
    end else if (stage1_en) begin // @[Reg.scala 36:18]
      sum1 <= {{1'd0}, _sum1_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum2 <= 10'h0; // @[Reg.scala 35:20]
    end else if (stage1_en) begin // @[Reg.scala 36:18]
      sum2 <= {{1'd0}, _sum2_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum3 <= 10'h0; // @[Reg.scala 35:20]
    end else if (stage1_en) begin // @[Reg.scala 36:18]
      sum3 <= {{1'd0}, _sum3_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 42:26]
      stage3_en <= 1'h0; // @[dut.scala 42:26]
    end else begin
      stage3_en <= stage2_en; // @[dut.scala 42:26]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum4 <= 11'h0; // @[Reg.scala 35:20]
    end else if (stage2_en) begin // @[Reg.scala 36:18]
      sum4 <= {{1'd0}, _sum4_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      sum5 <= 11'h0; // @[Reg.scala 35:20]
    end else if (stage2_en) begin // @[Reg.scala 36:18]
      sum5 <= {{1'd0}, _sum5_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 47:26]
      stage4_en <= 1'h0; // @[dut.scala 47:26]
    end else begin
      stage4_en <= stage3_en; // @[dut.scala 47:26]
    end
    if (reset) begin // @[Reg.scala 35:20]
      mul_out_reg <= 16'h0; // @[Reg.scala 35:20]
    end else if (stage3_en) begin // @[Reg.scala 36:18]
      mul_out_reg <= {{5'd0}, _mul_out_reg_T_1}; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 51:26]
      stage5_en <= 1'h0; // @[dut.scala 51:26]
    end else begin
      stage5_en <= stage4_en; // @[dut.scala 51:26]
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
  mul_en_out_reg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  stage1_en = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stage2_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sum0 = _RAND_5[9:0];
  _RAND_6 = {1{`RANDOM}};
  sum1 = _RAND_6[9:0];
  _RAND_7 = {1{`RANDOM}};
  sum2 = _RAND_7[9:0];
  _RAND_8 = {1{`RANDOM}};
  sum3 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  stage3_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum4 = _RAND_10[10:0];
  _RAND_11 = {1{`RANDOM}};
  sum5 = _RAND_11[10:0];
  _RAND_12 = {1{`RANDOM}};
  stage4_en = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mul_out_reg = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  stage5_en = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
