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
  reg  mul_en_out_reg_0; // @[dut.scala 17:31]
  reg  mul_en_out_reg_1; // @[dut.scala 17:31]
  reg  mul_en_out_reg_2; // @[dut.scala 17:31]
  reg  mul_en_out_reg_3; // @[dut.scala 17:31]
  reg  mul_en_out_reg_4; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[dut.scala 29:26]
  reg [7:0] mul_b_reg; // @[dut.scala 30:26]
  wire [7:0] _pp_0_T_1 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [8:0] _pp_0_T_2 = {{1'd0}, _pp_0_T_1}; // @[dut.scala 41:48]
  wire [7:0] _pp_1_T_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [8:0] _pp_1_T_2 = {_pp_1_T_1, 1'h0}; // @[dut.scala 41:48]
  wire [7:0] _pp_2_T_1 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [9:0] _GEN_9 = {_pp_2_T_1, 2'h0}; // @[dut.scala 41:48]
  wire [10:0] _pp_2_T_2 = {{1'd0}, _GEN_9}; // @[dut.scala 41:48]
  wire [7:0] _pp_3_T_1 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [10:0] _pp_3_T_2 = {_pp_3_T_1, 3'h0}; // @[dut.scala 41:48]
  wire [7:0] _pp_4_T_1 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [11:0] _GEN_10 = {_pp_4_T_1, 4'h0}; // @[dut.scala 41:48]
  wire [14:0] _pp_4_T_2 = {{3'd0}, _GEN_10}; // @[dut.scala 41:48]
  wire [7:0] _pp_5_T_1 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [12:0] _GEN_11 = {_pp_5_T_1, 5'h0}; // @[dut.scala 41:48]
  wire [14:0] _pp_5_T_2 = {{2'd0}, _GEN_11}; // @[dut.scala 41:48]
  wire [7:0] _pp_6_T_1 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [13:0] _GEN_12 = {_pp_6_T_1, 6'h0}; // @[dut.scala 41:48]
  wire [14:0] _pp_6_T_2 = {{1'd0}, _GEN_12}; // @[dut.scala 41:48]
  wire [7:0] _pp_7_T_1 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 41:17]
  wire [14:0] _pp_7_T_2 = {_pp_7_T_1, 7'h0}; // @[dut.scala 41:48]
  reg [15:0] sum1_reg_0; // @[dut.scala 45:25]
  reg [15:0] sum1_reg_1; // @[dut.scala 45:25]
  reg [15:0] sum1_reg_2; // @[dut.scala 45:25]
  reg [15:0] sum1_reg_3; // @[dut.scala 45:25]
  wire [7:0] pp_0 = _pp_0_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [7:0] pp_1 = _pp_1_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [8:0] _sum1_reg_0_T = pp_0 + pp_1; // @[dut.scala 47:26]
  wire [7:0] pp_2 = _pp_2_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [7:0] pp_3 = _pp_3_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [8:0] _sum1_reg_1_T = pp_2 + pp_3; // @[dut.scala 48:26]
  wire [7:0] pp_4 = _pp_4_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [7:0] pp_5 = _pp_5_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [8:0] _sum1_reg_2_T = pp_4 + pp_5; // @[dut.scala 49:26]
  wire [7:0] pp_6 = _pp_6_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [7:0] pp_7 = _pp_7_T_2[7:0]; // @[dut.scala 39:16 41:11]
  wire [8:0] _sum1_reg_3_T = pp_6 + pp_7; // @[dut.scala 50:26]
  reg [15:0] sum2_reg_0; // @[dut.scala 54:25]
  reg [15:0] sum2_reg_1; // @[dut.scala 54:25]
  wire [16:0] _sum2_reg_0_T = sum1_reg_0 + sum1_reg_1; // @[dut.scala 56:32]
  wire [16:0] _sum2_reg_1_T = sum1_reg_2 + sum1_reg_3; // @[dut.scala 57:32]
  wire [16:0] _GEN_6 = mul_en_out_reg_1 ? _sum2_reg_0_T : {{1'd0}, sum2_reg_0}; // @[dut.scala 55:28 56:17 54:25]
  wire [16:0] _GEN_7 = mul_en_out_reg_1 ? _sum2_reg_1_T : {{1'd0}, sum2_reg_1}; // @[dut.scala 55:28 57:17 54:25]
  reg [15:0] mul_out_reg; // @[dut.scala 61:28]
  wire [16:0] _mul_out_reg_T = sum2_reg_0 + sum2_reg_1; // @[dut.scala 63:32]
  wire [16:0] _GEN_8 = mul_en_out_reg_2 ? _mul_out_reg_T : {{1'd0}, mul_out_reg}; // @[dut.scala 62:28 63:17 61:28]
  wire [16:0] _GEN_13 = reset ? 17'h0 : _GEN_6; // @[dut.scala 54:{25,25}]
  wire [16:0] _GEN_14 = reset ? 17'h0 : _GEN_7; // @[dut.scala 54:{25,25}]
  wire [16:0] _GEN_15 = reset ? 17'h0 : _GEN_8; // @[dut.scala 61:{28,28}]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 26:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 67:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 20:21]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 29:26]
      mul_a_reg <= 8'h0; // @[dut.scala 29:26]
    end else if (io_mul_en_in) begin // @[dut.scala 33:23]
      mul_a_reg <= io_mul_a; // @[dut.scala 34:15]
    end
    if (reset) begin // @[dut.scala 30:26]
      mul_b_reg <= 8'h0; // @[dut.scala 30:26]
    end else if (io_mul_en_in) begin // @[dut.scala 33:23]
      mul_b_reg <= io_mul_b; // @[dut.scala 35:15]
    end
    if (reset) begin // @[dut.scala 45:25]
      sum1_reg_0 <= 16'h0; // @[dut.scala 45:25]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 46:28]
      sum1_reg_0 <= {{7'd0}, _sum1_reg_0_T}; // @[dut.scala 47:17]
    end
    if (reset) begin // @[dut.scala 45:25]
      sum1_reg_1 <= 16'h0; // @[dut.scala 45:25]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 46:28]
      sum1_reg_1 <= {{7'd0}, _sum1_reg_1_T}; // @[dut.scala 48:17]
    end
    if (reset) begin // @[dut.scala 45:25]
      sum1_reg_2 <= 16'h0; // @[dut.scala 45:25]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 46:28]
      sum1_reg_2 <= {{7'd0}, _sum1_reg_2_T}; // @[dut.scala 49:17]
    end
    if (reset) begin // @[dut.scala 45:25]
      sum1_reg_3 <= 16'h0; // @[dut.scala 45:25]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 46:28]
      sum1_reg_3 <= {{7'd0}, _sum1_reg_3_T}; // @[dut.scala 50:17]
    end
    sum2_reg_0 <= _GEN_13[15:0]; // @[dut.scala 54:{25,25}]
    sum2_reg_1 <= _GEN_14[15:0]; // @[dut.scala 54:{25,25}]
    mul_out_reg <= _GEN_15[15:0]; // @[dut.scala 61:{28,28}]
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
  sum1_reg_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum1_reg_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum1_reg_2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum1_reg_3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum2_reg_0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum2_reg_1 = _RAND_12[15:0];
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
