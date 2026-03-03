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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[dut.scala 19:26]
  reg [7:0] mul_b_reg; // @[dut.scala 20:26]
  wire [15:0] temp_0 = mul_b_reg[0] ? {{8'd0}, mul_a_reg} : 16'h0; // @[dut.scala 29:19]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_1 = mul_b_reg[1] ? {{7'd0}, _temp_1_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_2 = mul_b_reg[2] ? {{6'd0}, _temp_2_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_3 = mul_b_reg[3] ? {{5'd0}, _temp_3_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_4 = mul_b_reg[4] ? {{4'd0}, _temp_4_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_5 = mul_b_reg[5] ? {{3'd0}, _temp_5_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_6 = mul_b_reg[6] ? {{2'd0}, _temp_6_T_1} : 16'h0; // @[dut.scala 29:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 29:45]
  wire [15:0] temp_7 = mul_b_reg[7] ? {{1'd0}, _temp_7_T_1} : 16'h0; // @[dut.scala 29:19]
  reg [15:0] sum_0; // @[dut.scala 33:20]
  reg [15:0] sum_1; // @[dut.scala 33:20]
  reg [15:0] sum_2; // @[dut.scala 33:20]
  reg [15:0] sum_3; // @[dut.scala 33:20]
  wire [16:0] _sum_0_T = temp_0 + temp_1; // @[dut.scala 35:23]
  wire [16:0] _sum_1_T = temp_2 + temp_3; // @[dut.scala 36:23]
  wire [16:0] _sum_2_T = temp_4 + temp_5; // @[dut.scala 37:23]
  wire [16:0] _sum_3_T = temp_6 + temp_7; // @[dut.scala 38:23]
  wire [16:0] _GEN_2 = mul_en_out_reg[0] ? _sum_0_T : {{1'd0}, sum_0}; // @[dut.scala 34:27 35:12 33:20]
  wire [16:0] _GEN_3 = mul_en_out_reg[0] ? _sum_1_T : {{1'd0}, sum_1}; // @[dut.scala 34:27 36:12 33:20]
  wire [16:0] _GEN_4 = mul_en_out_reg[0] ? _sum_2_T : {{1'd0}, sum_2}; // @[dut.scala 34:27 37:12 33:20]
  wire [16:0] _GEN_5 = mul_en_out_reg[0] ? _sum_3_T : {{1'd0}, sum_3}; // @[dut.scala 34:27 38:12 33:20]
  reg [15:0] sum_l2_0; // @[dut.scala 41:23]
  reg [15:0] sum_l2_1; // @[dut.scala 41:23]
  wire [16:0] _sum_l2_0_T = sum_0 + sum_1; // @[dut.scala 43:25]
  wire [16:0] _sum_l2_1_T = sum_2 + sum_3; // @[dut.scala 44:25]
  wire [16:0] _GEN_6 = mul_en_out_reg[1] ? _sum_l2_0_T : {{1'd0}, sum_l2_0}; // @[dut.scala 42:27 43:15 41:23]
  wire [16:0] _GEN_7 = mul_en_out_reg[1] ? _sum_l2_1_T : {{1'd0}, sum_l2_1}; // @[dut.scala 42:27 44:15 41:23]
  reg [15:0] mul_out_reg; // @[dut.scala 48:28]
  wire [16:0] _mul_out_reg_T = sum_l2_0 + sum_l2_1; // @[dut.scala 50:30]
  wire [16:0] _GEN_8 = mul_en_out_reg[2] ? _mul_out_reg_T : {{1'd0}, mul_out_reg}; // @[dut.scala 49:27 50:17 48:28]
  reg [15:0] mul_out_pipe; // @[dut.scala 54:29]
  wire [16:0] _GEN_10 = reset ? 17'h0 : _GEN_2; // @[dut.scala 33:{20,20}]
  wire [16:0] _GEN_11 = reset ? 17'h0 : _GEN_3; // @[dut.scala 33:{20,20}]
  wire [16:0] _GEN_12 = reset ? 17'h0 : _GEN_4; // @[dut.scala 33:{20,20}]
  wire [16:0] _GEN_13 = reset ? 17'h0 : _GEN_5; // @[dut.scala 33:{20,20}]
  wire [16:0] _GEN_14 = reset ? 17'h0 : _GEN_6; // @[dut.scala 41:{23,23}]
  wire [16:0] _GEN_15 = reset ? 17'h0 : _GEN_7; // @[dut.scala 41:{23,23}]
  wire [16:0] _GEN_16 = reset ? 17'h0 : _GEN_8; // @[dut.scala 48:{28,28}]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 16:34]
  assign io_mul_out = io_mul_en_out ? mul_out_pipe : 16'h0; // @[dut.scala 60:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 15:18]
    end
    if (reset) begin // @[dut.scala 19:26]
      mul_a_reg <= 8'h0; // @[dut.scala 19:26]
    end else if (io_mul_en_in) begin // @[dut.scala 21:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 22:15]
    end
    if (reset) begin // @[dut.scala 20:26]
      mul_b_reg <= 8'h0; // @[dut.scala 20:26]
    end else if (io_mul_en_in) begin // @[dut.scala 21:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 23:15]
    end
    sum_0 <= _GEN_10[15:0]; // @[dut.scala 33:{20,20}]
    sum_1 <= _GEN_11[15:0]; // @[dut.scala 33:{20,20}]
    sum_2 <= _GEN_12[15:0]; // @[dut.scala 33:{20,20}]
    sum_3 <= _GEN_13[15:0]; // @[dut.scala 33:{20,20}]
    sum_l2_0 <= _GEN_14[15:0]; // @[dut.scala 41:{23,23}]
    sum_l2_1 <= _GEN_15[15:0]; // @[dut.scala 41:{23,23}]
    mul_out_reg <= _GEN_16[15:0]; // @[dut.scala 48:{28,28}]
    if (reset) begin // @[dut.scala 54:29]
      mul_out_pipe <= 16'h0; // @[dut.scala 54:29]
    end else if (mul_en_out_reg[3]) begin // @[dut.scala 55:27]
      mul_out_pipe <= mul_out_reg; // @[dut.scala 56:18]
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
  sum_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum_l2_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum_l2_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  mul_out_reg = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  mul_out_pipe = _RAND_10[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
