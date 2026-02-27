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
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg_0; // @[dut.scala 19:31]
  reg  mul_en_out_reg_1; // @[dut.scala 19:31]
  reg  mul_en_out_reg_2; // @[dut.scala 19:31]
  reg  mul_en_out_reg_3; // @[dut.scala 19:31]
  reg  mul_en_out_reg_4; // @[dut.scala 19:31]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [15:0] _partial_products_0_T_1 = {{8'd0}, mul_a_reg}; // @[dut.scala 38:50]
  wire [15:0] partial_products_0 = mul_b_reg[0] ? _partial_products_0_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [8:0] _partial_products_1_T = {mul_a_reg, 1'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_1_T_1 = {{7'd0}, _partial_products_1_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_1 = mul_b_reg[1] ? _partial_products_1_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [9:0] _partial_products_2_T = {mul_a_reg, 2'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_2_T_1 = {{6'd0}, _partial_products_2_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_2 = mul_b_reg[2] ? _partial_products_2_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [10:0] _partial_products_3_T = {mul_a_reg, 3'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_3_T_1 = {{5'd0}, _partial_products_3_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_3 = mul_b_reg[3] ? _partial_products_3_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [11:0] _partial_products_4_T = {mul_a_reg, 4'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_4_T_1 = {{4'd0}, _partial_products_4_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_4 = mul_b_reg[4] ? _partial_products_4_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [12:0] _partial_products_5_T = {mul_a_reg, 5'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_5_T_1 = {{3'd0}, _partial_products_5_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_5 = mul_b_reg[5] ? _partial_products_5_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [13:0] _partial_products_6_T = {mul_a_reg, 6'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_6_T_1 = {{2'd0}, _partial_products_6_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_6 = mul_b_reg[6] ? _partial_products_6_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  wire [14:0] _partial_products_7_T = {mul_a_reg, 7'h0}; // @[dut.scala 38:41]
  wire [15:0] _partial_products_7_T_1 = {{1'd0}, _partial_products_7_T}; // @[dut.scala 38:50]
  wire [15:0] partial_products_7 = mul_b_reg[7] ? _partial_products_7_T_1 : 16'h0; // @[dut.scala 37:25 38:27 40:27]
  reg [15:0] sum_level1_0; // @[dut.scala 45:23]
  reg [15:0] sum_level1_1; // @[dut.scala 45:23]
  reg [15:0] sum_level1_2; // @[dut.scala 45:23]
  reg [15:0] sum_level1_3; // @[dut.scala 45:23]
  reg [15:0] sum_level2_0; // @[dut.scala 52:23]
  reg [15:0] sum_level2_1; // @[dut.scala 52:23]
  wire [15:0] _mul_out_reg_T_1 = sum_level2_0 + sum_level2_1; // @[dut.scala 57:43]
  reg [15:0] mul_out_reg; // @[dut.scala 57:28]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 28:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 60:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 22:21]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 24:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 24:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 24:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 24:23]
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
    sum_level1_0 <= partial_products_0 + partial_products_1; // @[dut.scala 46:40]
    sum_level1_1 <= partial_products_2 + partial_products_3; // @[dut.scala 47:40]
    sum_level1_2 <= partial_products_4 + partial_products_5; // @[dut.scala 48:40]
    sum_level1_3 <= partial_products_6 + partial_products_7; // @[dut.scala 49:40]
    sum_level2_0 <= sum_level1_0 + sum_level1_1; // @[dut.scala 53:34]
    sum_level2_1 <= sum_level1_2 + sum_level1_3; // @[dut.scala 54:34]
    if (reset) begin // @[dut.scala 57:28]
      mul_out_reg <= 16'h0; // @[dut.scala 57:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 57:28]
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
  mul_en_out_reg_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_en_out_reg_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mul_en_out_reg_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mul_en_out_reg_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mul_en_out_reg_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mul_a_reg = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  mul_b_reg = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  sum_level1_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum_level1_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum_level1_2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum_level1_3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum_level2_0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum_level2_1 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  mul_out_reg = _RAND_13[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
