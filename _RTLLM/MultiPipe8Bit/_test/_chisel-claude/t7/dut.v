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
  reg [7:0] mul_a_reg; // @[dut.scala 31:26]
  reg [7:0] mul_b_reg; // @[dut.scala 32:26]
  wire [7:0] _partial_products_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 42:31]
  wire [8:0] _partial_products_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 42:57]
  wire [8:0] _partial_products_1_T_2 = mul_b_reg[1] ? _partial_products_1_T_1 : 9'h0; // @[dut.scala 42:31]
  wire [9:0] _partial_products_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 42:57]
  wire [9:0] _partial_products_2_T_2 = mul_b_reg[2] ? _partial_products_2_T_1 : 10'h0; // @[dut.scala 42:31]
  wire [10:0] _partial_products_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 42:57]
  wire [10:0] _partial_products_3_T_2 = mul_b_reg[3] ? _partial_products_3_T_1 : 11'h0; // @[dut.scala 42:31]
  wire [11:0] _partial_products_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 42:57]
  wire [11:0] _partial_products_4_T_2 = mul_b_reg[4] ? _partial_products_4_T_1 : 12'h0; // @[dut.scala 42:31]
  wire [12:0] _partial_products_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 42:57]
  wire [12:0] _partial_products_5_T_2 = mul_b_reg[5] ? _partial_products_5_T_1 : 13'h0; // @[dut.scala 42:31]
  wire [13:0] _partial_products_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 42:57]
  wire [13:0] _partial_products_6_T_2 = mul_b_reg[6] ? _partial_products_6_T_1 : 14'h0; // @[dut.scala 42:31]
  wire [14:0] _partial_products_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 42:57]
  wire [14:0] _partial_products_7_T_2 = mul_b_reg[7] ? _partial_products_7_T_1 : 15'h0; // @[dut.scala 42:31]
  reg [15:0] sum1_0; // @[dut.scala 46:21]
  reg [15:0] sum1_1; // @[dut.scala 46:21]
  reg [15:0] sum1_2; // @[dut.scala 46:21]
  reg [15:0] sum1_3; // @[dut.scala 46:21]
  wire [15:0] partial_products_0 = {{8'd0}, _partial_products_0_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] partial_products_1 = {{7'd0}, _partial_products_1_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] _sum1_0_T_1 = partial_products_0 + partial_products_1; // @[dut.scala 47:34]
  wire [15:0] partial_products_2 = {{6'd0}, _partial_products_2_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] partial_products_3 = {{5'd0}, _partial_products_3_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] _sum1_1_T_1 = partial_products_2 + partial_products_3; // @[dut.scala 48:34]
  wire [15:0] partial_products_4 = {{4'd0}, _partial_products_4_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] partial_products_5 = {{3'd0}, _partial_products_5_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] _sum1_2_T_1 = partial_products_4 + partial_products_5; // @[dut.scala 49:34]
  wire [15:0] partial_products_6 = {{2'd0}, _partial_products_6_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] partial_products_7 = {{1'd0}, _partial_products_7_T_2}; // @[dut.scala 40:30 42:25]
  wire [15:0] _sum1_3_T_1 = partial_products_6 + partial_products_7; // @[dut.scala 50:34]
  reg [15:0] sum2_0; // @[dut.scala 53:21]
  reg [15:0] sum2_1; // @[dut.scala 53:21]
  wire [15:0] _sum2_0_T_1 = sum1_0 + sum1_1; // @[dut.scala 54:22]
  wire [15:0] _sum2_1_T_1 = sum1_2 + sum1_3; // @[dut.scala 55:22]
  reg [15:0] mul_out_reg; // @[dut.scala 58:28]
  wire [15:0] _mul_out_reg_T_1 = sum2_0 + sum2_1; // @[dut.scala 59:26]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 28:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 62:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 22:21]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 24:27]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 24:27]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 24:27]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 24:27]
    end
    if (reset) begin // @[dut.scala 31:26]
      mul_a_reg <= 8'h0; // @[dut.scala 31:26]
    end else if (io_mul_en_in) begin // @[dut.scala 34:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 35:15]
    end
    if (reset) begin // @[dut.scala 32:26]
      mul_b_reg <= 8'h0; // @[dut.scala 32:26]
    end else if (io_mul_en_in) begin // @[dut.scala 34:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 36:15]
    end
    if (reset) begin // @[dut.scala 46:21]
      sum1_0 <= 16'h0; // @[dut.scala 46:21]
    end else begin
      sum1_0 <= _sum1_0_T_1; // @[dut.scala 47:11]
    end
    if (reset) begin // @[dut.scala 46:21]
      sum1_1 <= 16'h0; // @[dut.scala 46:21]
    end else begin
      sum1_1 <= _sum1_1_T_1; // @[dut.scala 48:11]
    end
    if (reset) begin // @[dut.scala 46:21]
      sum1_2 <= 16'h0; // @[dut.scala 46:21]
    end else begin
      sum1_2 <= _sum1_2_T_1; // @[dut.scala 49:11]
    end
    if (reset) begin // @[dut.scala 46:21]
      sum1_3 <= 16'h0; // @[dut.scala 46:21]
    end else begin
      sum1_3 <= _sum1_3_T_1; // @[dut.scala 50:11]
    end
    if (reset) begin // @[dut.scala 53:21]
      sum2_0 <= 16'h0; // @[dut.scala 53:21]
    end else begin
      sum2_0 <= _sum2_0_T_1; // @[dut.scala 54:11]
    end
    if (reset) begin // @[dut.scala 53:21]
      sum2_1 <= 16'h0; // @[dut.scala 53:21]
    end else begin
      sum2_1 <= _sum2_1_T_1; // @[dut.scala 55:11]
    end
    if (reset) begin // @[dut.scala 58:28]
      mul_out_reg <= 16'h0; // @[dut.scala 58:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 59:15]
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
  sum1_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum1_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum1_2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum1_3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum2_0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum2_1 = _RAND_12[15:0];
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
