module dut(
  input         clock,
  input         reset,
  input         io_clk,
  input         io_rst_n,
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
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] mul_en_out_reg; // @[dut.scala 16:32]
  reg [7:0] mul_a_reg; // @[dut.scala 17:32]
  reg [7:0] mul_b_reg; // @[dut.scala 18:32]
  reg [15:0] partialProducts_0; // @[dut.scala 19:29]
  reg [15:0] partialProducts_1; // @[dut.scala 19:29]
  reg [15:0] partialProducts_2; // @[dut.scala 19:29]
  reg [15:0] partialProducts_3; // @[dut.scala 19:29]
  reg [15:0] partialProducts_4; // @[dut.scala 19:29]
  reg [15:0] partialProducts_5; // @[dut.scala 19:29]
  reg [15:0] partialProducts_6; // @[dut.scala 19:29]
  reg [15:0] partialProducts_7; // @[dut.scala 19:29]
  reg [15:0] sum_0; // @[dut.scala 20:29]
  reg [15:0] sum_1; // @[dut.scala 20:29]
  reg [15:0] sum_2; // @[dut.scala 20:29]
  reg [15:0] sum_3; // @[dut.scala 20:29]
  reg [15:0] sum_4; // @[dut.scala 20:29]
  reg [15:0] sum_5; // @[dut.scala 20:29]
  reg [15:0] sum_6; // @[dut.scala 20:29]
  reg [15:0] sum_7; // @[dut.scala 20:29]
  reg [15:0] mul_out_reg; // @[dut.scala 21:33]
  wire [1:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire [7:0] _partialProducts_0_T_2 = mul_b_reg[0] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_0_T_3 = mul_a_reg & _partialProducts_0_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_1_T_2 = mul_b_reg[1] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_1_T_3 = mul_a_reg & _partialProducts_1_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_2_T_2 = mul_b_reg[2] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_2_T_3 = mul_a_reg & _partialProducts_2_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_3_T_2 = mul_b_reg[3] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_3_T_3 = mul_a_reg & _partialProducts_3_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_4_T_2 = mul_b_reg[4] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_4_T_3 = mul_a_reg & _partialProducts_4_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_5_T_2 = mul_b_reg[5] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_5_T_3 = mul_a_reg & _partialProducts_5_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_6_T_2 = mul_b_reg[6] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_6_T_3 = mul_a_reg & _partialProducts_6_T_2; // @[dut.scala 44:41]
  wire [7:0] _partialProducts_7_T_2 = mul_b_reg[7] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _partialProducts_7_T_3 = mul_a_reg & _partialProducts_7_T_2; // @[dut.scala 44:41]
  wire [16:0] _sum_1_T = {partialProducts_1, 1'h0}; // @[dut.scala 49:38]
  wire [17:0] _sum_2_T = {partialProducts_2, 2'h0}; // @[dut.scala 49:38]
  wire [18:0] _sum_3_T = {partialProducts_3, 3'h0}; // @[dut.scala 49:38]
  wire [19:0] _sum_4_T = {partialProducts_4, 4'h0}; // @[dut.scala 49:38]
  wire [20:0] _sum_5_T = {partialProducts_5, 5'h0}; // @[dut.scala 49:38]
  wire [21:0] _sum_6_T = {partialProducts_6, 6'h0}; // @[dut.scala 49:38]
  wire [22:0] _sum_7_T = {partialProducts_7, 7'h0}; // @[dut.scala 49:38]
  wire [15:0] _mul_out_reg_T_1 = sum_0 + sum_1; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_3 = _mul_out_reg_T_1 + sum_2; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_5 = _mul_out_reg_T_3 + sum_3; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_7 = _mul_out_reg_T_5 + sum_4; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_9 = _mul_out_reg_T_7 + sum_5; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_11 = _mul_out_reg_T_9 + sum_6; // @[dut.scala 53:35]
  wire [15:0] _mul_out_reg_T_13 = _mul_out_reg_T_11 + sum_7; // @[dut.scala 53:35]
  wire [16:0] _GEN_11 = io_mul_en_in ? _sum_1_T : {{1'd0}, sum_1}; // @[dut.scala 37:24 49:16 20:29]
  wire [17:0] _GEN_12 = io_mul_en_in ? _sum_2_T : {{2'd0}, sum_2}; // @[dut.scala 37:24 49:16 20:29]
  wire [18:0] _GEN_13 = io_mul_en_in ? _sum_3_T : {{3'd0}, sum_3}; // @[dut.scala 37:24 49:16 20:29]
  wire [19:0] _GEN_14 = io_mul_en_in ? _sum_4_T : {{4'd0}, sum_4}; // @[dut.scala 37:24 49:16 20:29]
  wire [20:0] _GEN_15 = io_mul_en_in ? _sum_5_T : {{5'd0}, sum_5}; // @[dut.scala 37:24 49:16 20:29]
  wire [21:0] _GEN_16 = io_mul_en_in ? _sum_6_T : {{6'd0}, sum_6}; // @[dut.scala 37:24 49:16 20:29]
  wire [22:0] _GEN_17 = io_mul_en_in ? _sum_7_T : {{7'd0}, sum_7}; // @[dut.scala 37:24 49:16 20:29]
  wire [16:0] _GEN_26 = ~io_rst_n ? 17'h0 : _GEN_11; // @[dut.scala 24:20 31:14]
  wire [17:0] _GEN_28 = ~io_rst_n ? 18'h0 : _GEN_12; // @[dut.scala 24:20 31:14]
  wire [18:0] _GEN_30 = ~io_rst_n ? 19'h0 : _GEN_13; // @[dut.scala 24:20 31:14]
  wire [19:0] _GEN_32 = ~io_rst_n ? 20'h0 : _GEN_14; // @[dut.scala 24:20 31:14]
  wire [20:0] _GEN_34 = ~io_rst_n ? 21'h0 : _GEN_15; // @[dut.scala 24:20 31:14]
  wire [21:0] _GEN_36 = ~io_rst_n ? 22'h0 : _GEN_16; // @[dut.scala 24:20 31:14]
  wire [22:0] _GEN_38 = ~io_rst_n ? 23'h0 : _GEN_17; // @[dut.scala 24:20 31:14]
  assign io_mul_en_out = mul_en_out_reg[1]; // @[dut.scala 58:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 59:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:32]
      mul_en_out_reg <= 2'h0; // @[dut.scala 16:32]
    end else if (~io_rst_n) begin // @[dut.scala 24:20]
      mul_en_out_reg <= 2'h0; // @[dut.scala 25:20]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 35:20]
    end
    if (reset) begin // @[dut.scala 17:32]
      mul_a_reg <= 8'h0; // @[dut.scala 17:32]
    end else if (~io_rst_n) begin // @[dut.scala 24:20]
      mul_a_reg <= 8'h0; // @[dut.scala 26:20]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      mul_a_reg <= io_mul_a; // @[dut.scala 39:17]
    end
    if (reset) begin // @[dut.scala 18:32]
      mul_b_reg <= 8'h0; // @[dut.scala 18:32]
    end else if (~io_rst_n) begin // @[dut.scala 24:20]
      mul_b_reg <= 8'h0; // @[dut.scala 27:20]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      mul_b_reg <= io_mul_b; // @[dut.scala 40:17]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_0 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_0 <= {{8'd0}, _partialProducts_0_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_1 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_1 <= {{8'd0}, _partialProducts_1_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_2 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_2 <= {{8'd0}, _partialProducts_2_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_3 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_3 <= {{8'd0}, _partialProducts_3_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_4 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_4 <= {{8'd0}, _partialProducts_4_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_5 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_5 <= {{8'd0}, _partialProducts_5_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_6 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_6 <= {{8'd0}, _partialProducts_6_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      partialProducts_7 <= 16'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      partialProducts_7 <= {{8'd0}, _partialProducts_7_T_3}; // @[dut.scala 44:28]
    end
    if (~io_rst_n) begin // @[dut.scala 24:20]
      sum_0 <= 16'h0; // @[dut.scala 31:14]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      sum_0 <= partialProducts_0; // @[dut.scala 49:16]
    end
    sum_1 <= _GEN_26[15:0];
    sum_2 <= _GEN_28[15:0];
    sum_3 <= _GEN_30[15:0];
    sum_4 <= _GEN_32[15:0];
    sum_5 <= _GEN_34[15:0];
    sum_6 <= _GEN_36[15:0];
    sum_7 <= _GEN_38[15:0];
    if (reset) begin // @[dut.scala 21:33]
      mul_out_reg <= 16'h0; // @[dut.scala 21:33]
    end else if (~io_rst_n) begin // @[dut.scala 24:20]
      mul_out_reg <= 16'h0; // @[dut.scala 28:20]
    end else if (io_mul_en_in) begin // @[dut.scala 37:24]
      mul_out_reg <= _mul_out_reg_T_13; // @[dut.scala 53:19]
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
  partialProducts_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  partialProducts_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partialProducts_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partialProducts_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  partialProducts_4 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  partialProducts_5 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  partialProducts_6 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  partialProducts_7 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum_0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum_1 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum_2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  sum_3 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum_4 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  sum_5 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sum_6 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum_7 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  mul_out_reg = _RAND_19[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
