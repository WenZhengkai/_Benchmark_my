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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 15:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire [4:0] _mul_en_out_reg_T_3 = {mul_en_out_reg[3:0],1'h0}; // @[Cat.scala 33:92]
  wire  mul_en_out = mul_en_out_reg[4]; // @[dut.scala 23:34]
  reg [7:0] mul_a_reg; // @[dut.scala 27:26]
  reg [7:0] mul_b_reg; // @[dut.scala 28:26]
  wire [15:0] _partial_products_0_T_2 = mul_b_reg[0] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] _GEN_8 = {{8'd0}, mul_a_reg}; // @[dut.scala 39:45]
  wire [15:0] partial_products_0 = _GEN_8 & _partial_products_0_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_1_T_2 = mul_b_reg[1] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_1 = _GEN_8 & _partial_products_1_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_2_T_2 = mul_b_reg[2] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_2 = _GEN_8 & _partial_products_2_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_3_T_2 = mul_b_reg[3] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_3 = _GEN_8 & _partial_products_3_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_4_T_2 = mul_b_reg[4] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_4 = _GEN_8 & _partial_products_4_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_5_T_2 = mul_b_reg[5] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_5 = _GEN_8 & _partial_products_5_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_6_T_2 = mul_b_reg[6] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_6 = _GEN_8 & _partial_products_6_T_2; // @[dut.scala 39:45]
  wire [15:0] _partial_products_7_T_2 = mul_b_reg[7] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [15:0] partial_products_7 = _GEN_8 & _partial_products_7_T_2; // @[dut.scala 39:45]
  reg [15:0] sum1; // @[dut.scala 43:21]
  reg [15:0] sum2; // @[dut.scala 44:21]
  reg [15:0] sum3; // @[dut.scala 45:21]
  wire [16:0] _sum1_T = {partial_products_1, 1'h0}; // @[dut.scala 48:56]
  wire [16:0] _GEN_16 = {{1'd0}, partial_products_0}; // @[dut.scala 48:33]
  wire [16:0] _sum1_T_2 = _GEN_16 + _sum1_T; // @[dut.scala 48:33]
  wire [17:0] _sum2_T = {partial_products_2, 2'h0}; // @[dut.scala 49:34]
  wire [18:0] _sum2_T_1 = {partial_products_3, 3'h0}; // @[dut.scala 49:63]
  wire [18:0] _GEN_17 = {{1'd0}, _sum2_T}; // @[dut.scala 49:40]
  wire [18:0] _sum2_T_3 = _GEN_17 + _sum2_T_1; // @[dut.scala 49:40]
  wire [19:0] _sum3_T = {partial_products_4, 4'h0}; // @[dut.scala 50:34]
  wire [20:0] _sum3_T_1 = {partial_products_5, 5'h0}; // @[dut.scala 50:63]
  wire [20:0] _GEN_18 = {{1'd0}, _sum3_T}; // @[dut.scala 50:40]
  wire [20:0] _sum3_T_3 = _GEN_18 + _sum3_T_1; // @[dut.scala 50:40]
  wire [21:0] _sum3_T_4 = {partial_products_6, 6'h0}; // @[dut.scala 51:34]
  wire [21:0] _GEN_19 = {{1'd0}, _sum3_T_3}; // @[dut.scala 50:69]
  wire [21:0] _sum3_T_6 = _GEN_19 + _sum3_T_4; // @[dut.scala 50:69]
  wire [22:0] _sum3_T_7 = {partial_products_7, 7'h0}; // @[dut.scala 51:63]
  wire [22:0] _GEN_20 = {{1'd0}, _sum3_T_6}; // @[dut.scala 51:40]
  wire [22:0] _sum3_T_9 = _GEN_20 + _sum3_T_7; // @[dut.scala 51:40]
  wire [16:0] _GEN_3 = io_mul_en_in ? _sum1_T_2 : {{1'd0}, sum1}; // @[dut.scala 47:22 48:10 43:21]
  wire [18:0] _GEN_4 = io_mul_en_in ? _sum2_T_3 : {{3'd0}, sum2}; // @[dut.scala 47:22 49:10 44:21]
  wire [22:0] _GEN_5 = io_mul_en_in ? _sum3_T_9 : {{7'd0}, sum3}; // @[dut.scala 47:22 50:10 45:21]
  reg [15:0] mul_out_reg; // @[dut.scala 55:28]
  wire [15:0] _mul_out_reg_T_1 = sum1 + sum2; // @[dut.scala 57:25]
  wire [15:0] _mul_out_reg_T_3 = _mul_out_reg_T_1 + sum3; // @[dut.scala 57:32]
  wire [16:0] _GEN_21 = reset ? 17'h0 : _GEN_3; // @[dut.scala 43:{21,21}]
  wire [18:0] _GEN_22 = reset ? 19'h0 : _GEN_4; // @[dut.scala 44:{21,21}]
  wire [22:0] _GEN_23 = reset ? 23'h0 : _GEN_5; // @[dut.scala 45:{21,21}]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 23:34]
  assign io_mul_out = mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 61:20 62:16 64:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 15:31]
    end else if (io_mul_en_in) begin // @[dut.scala 16:22]
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 17:20]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_3; // @[dut.scala 19:20]
    end
    if (reset) begin // @[dut.scala 27:26]
      mul_a_reg <= 8'h0; // @[dut.scala 27:26]
    end else if (io_mul_en_in) begin // @[dut.scala 30:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 31:15]
    end
    if (reset) begin // @[dut.scala 28:26]
      mul_b_reg <= 8'h0; // @[dut.scala 28:26]
    end else if (io_mul_en_in) begin // @[dut.scala 30:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 32:15]
    end
    sum1 <= _GEN_21[15:0]; // @[dut.scala 43:{21,21}]
    sum2 <= _GEN_22[15:0]; // @[dut.scala 44:{21,21}]
    sum3 <= _GEN_23[15:0]; // @[dut.scala 45:{21,21}]
    if (reset) begin // @[dut.scala 55:28]
      mul_out_reg <= 16'h0; // @[dut.scala 55:28]
    end else if (io_mul_en_in) begin // @[dut.scala 56:22]
      mul_out_reg <= _mul_out_reg_T_3; // @[dut.scala 57:17]
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
  mul_en_out_reg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  sum1 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum2 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum3 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  mul_out_reg = _RAND_6[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
