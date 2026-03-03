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
  reg  mul_en_out_reg_0; // @[dut.scala 14:31]
  reg  mul_en_out_reg_1; // @[dut.scala 14:31]
  reg  mul_en_out_reg_2; // @[dut.scala 14:31]
  reg  mul_en_out_reg_3; // @[dut.scala 14:31]
  reg  mul_en_out_reg_4; // @[dut.scala 14:31]
  reg [7:0] mul_a_reg; // @[dut.scala 26:26]
  reg [7:0] mul_b_reg; // @[dut.scala 27:26]
  wire [15:0] _temp_0_T_1 = {8'h0,mul_a_reg}; // @[Cat.scala 33:92]
  wire [15:0] temp_0 = mul_b_reg[0] ? _temp_0_T_1 : 16'h0; // @[dut.scala 38:19]
  wire [16:0] _temp_1_T_2 = {_temp_0_T_1, 1'h0}; // @[dut.scala 38:59]
  wire [16:0] _temp_1_T_3 = mul_b_reg[1] ? _temp_1_T_2 : 17'h0; // @[dut.scala 38:19]
  wire [17:0] _temp_2_T_2 = {_temp_0_T_1, 2'h0}; // @[dut.scala 38:59]
  wire [17:0] _temp_2_T_3 = mul_b_reg[2] ? _temp_2_T_2 : 18'h0; // @[dut.scala 38:19]
  wire [18:0] _temp_3_T_2 = {_temp_0_T_1, 3'h0}; // @[dut.scala 38:59]
  wire [18:0] _temp_3_T_3 = mul_b_reg[3] ? _temp_3_T_2 : 19'h0; // @[dut.scala 38:19]
  wire [19:0] _temp_4_T_2 = {_temp_0_T_1, 4'h0}; // @[dut.scala 38:59]
  wire [19:0] _temp_4_T_3 = mul_b_reg[4] ? _temp_4_T_2 : 20'h0; // @[dut.scala 38:19]
  wire [20:0] _temp_5_T_2 = {_temp_0_T_1, 5'h0}; // @[dut.scala 38:59]
  wire [20:0] _temp_5_T_3 = mul_b_reg[5] ? _temp_5_T_2 : 21'h0; // @[dut.scala 38:19]
  wire [21:0] _temp_6_T_2 = {_temp_0_T_1, 6'h0}; // @[dut.scala 38:59]
  wire [21:0] _temp_6_T_3 = mul_b_reg[6] ? _temp_6_T_2 : 22'h0; // @[dut.scala 38:19]
  wire [22:0] _temp_7_T_2 = {_temp_0_T_1, 7'h0}; // @[dut.scala 38:59]
  wire [22:0] _temp_7_T_3 = mul_b_reg[7] ? _temp_7_T_2 : 23'h0; // @[dut.scala 38:19]
  reg [15:0] sum1_reg; // @[dut.scala 43:25]
  wire [15:0] temp_1 = _temp_1_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] _sum1_reg_T_1 = temp_0 + temp_1; // @[dut.scala 44:23]
  reg [15:0] sum2_reg; // @[dut.scala 47:25]
  wire [15:0] temp_2 = _temp_2_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] temp_3 = _temp_3_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] _sum2_reg_T_1 = temp_2 + temp_3; // @[dut.scala 48:23]
  reg [15:0] sum3_reg; // @[dut.scala 51:25]
  wire [15:0] temp_4 = _temp_4_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] temp_5 = _temp_5_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] _sum3_reg_T_1 = temp_4 + temp_5; // @[dut.scala 52:23]
  reg [15:0] sum4_reg; // @[dut.scala 55:25]
  wire [15:0] temp_6 = _temp_6_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] temp_7 = _temp_7_T_3[15:0]; // @[dut.scala 35:18 38:13]
  wire [15:0] _sum4_reg_T_1 = temp_6 + temp_7; // @[dut.scala 56:23]
  reg [15:0] sum12_reg; // @[dut.scala 59:26]
  wire [15:0] _sum12_reg_T_1 = sum1_reg + sum2_reg; // @[dut.scala 60:25]
  reg [15:0] sum34_reg; // @[dut.scala 62:26]
  wire [15:0] _sum34_reg_T_1 = sum3_reg + sum4_reg; // @[dut.scala 63:25]
  reg [15:0] sum_all_reg; // @[dut.scala 66:28]
  wire [15:0] _sum_all_reg_T_1 = sum12_reg + sum34_reg; // @[dut.scala 67:28]
  reg [15:0] mul_out_reg; // @[dut.scala 70:28]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 23:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 74:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 17:21]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 26:26]
      mul_a_reg <= 8'h0; // @[dut.scala 26:26]
    end else if (io_mul_en_in) begin // @[dut.scala 29:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 30:15]
    end
    if (reset) begin // @[dut.scala 27:26]
      mul_b_reg <= 8'h0; // @[dut.scala 27:26]
    end else if (io_mul_en_in) begin // @[dut.scala 29:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 31:15]
    end
    if (reset) begin // @[dut.scala 43:25]
      sum1_reg <= 16'h0; // @[dut.scala 43:25]
    end else begin
      sum1_reg <= _sum1_reg_T_1; // @[dut.scala 44:12]
    end
    if (reset) begin // @[dut.scala 47:25]
      sum2_reg <= 16'h0; // @[dut.scala 47:25]
    end else begin
      sum2_reg <= _sum2_reg_T_1; // @[dut.scala 48:12]
    end
    if (reset) begin // @[dut.scala 51:25]
      sum3_reg <= 16'h0; // @[dut.scala 51:25]
    end else begin
      sum3_reg <= _sum3_reg_T_1; // @[dut.scala 52:12]
    end
    if (reset) begin // @[dut.scala 55:25]
      sum4_reg <= 16'h0; // @[dut.scala 55:25]
    end else begin
      sum4_reg <= _sum4_reg_T_1; // @[dut.scala 56:12]
    end
    if (reset) begin // @[dut.scala 59:26]
      sum12_reg <= 16'h0; // @[dut.scala 59:26]
    end else begin
      sum12_reg <= _sum12_reg_T_1; // @[dut.scala 60:13]
    end
    if (reset) begin // @[dut.scala 62:26]
      sum34_reg <= 16'h0; // @[dut.scala 62:26]
    end else begin
      sum34_reg <= _sum34_reg_T_1; // @[dut.scala 63:13]
    end
    if (reset) begin // @[dut.scala 66:28]
      sum_all_reg <= 16'h0; // @[dut.scala 66:28]
    end else begin
      sum_all_reg <= _sum_all_reg_T_1; // @[dut.scala 67:15]
    end
    if (reset) begin // @[dut.scala 70:28]
      mul_out_reg <= 16'h0; // @[dut.scala 70:28]
    end else begin
      mul_out_reg <= sum_all_reg; // @[dut.scala 71:15]
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
  sum1_reg = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum2_reg = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum3_reg = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum4_reg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum12_reg = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum34_reg = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum_all_reg = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  mul_out_reg = _RAND_14[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
