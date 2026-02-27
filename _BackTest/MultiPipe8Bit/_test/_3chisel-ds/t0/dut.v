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
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg_0; // @[dut.scala 17:31]
  reg  mul_en_out_reg_1; // @[dut.scala 17:31]
  reg  mul_en_out_reg_2; // @[dut.scala 17:31]
  reg  mul_en_out_reg_3; // @[dut.scala 17:31]
  reg  mul_en_out_reg_4; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[dut.scala 20:22]
  reg [7:0] mul_b_reg; // @[dut.scala 21:22]
  reg [9:0] sum_0; // @[dut.scala 27:16]
  reg [9:0] sum_1; // @[dut.scala 27:16]
  reg [9:0] sum_2; // @[dut.scala 27:16]
  reg [9:0] sum_3; // @[dut.scala 27:16]
  reg [15:0] mul_out_reg; // @[dut.scala 30:24]
  wire  temp_0_0 = mul_a_reg[0] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_1 = mul_a_reg[1] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_2 = mul_a_reg[2] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_3 = mul_a_reg[3] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_4 = mul_a_reg[4] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_5 = mul_a_reg[5] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_6 = mul_a_reg[6] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_0_7 = mul_a_reg[7] & mul_b_reg[0]; // @[dut.scala 52:34]
  wire  temp_1_0 = mul_a_reg[0] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_1 = mul_a_reg[1] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_2 = mul_a_reg[2] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_3 = mul_a_reg[3] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_4 = mul_a_reg[4] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_5 = mul_a_reg[5] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_6 = mul_a_reg[6] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_1_7 = mul_a_reg[7] & mul_b_reg[1]; // @[dut.scala 52:34]
  wire  temp_2_0 = mul_a_reg[0] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_1 = mul_a_reg[1] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_2 = mul_a_reg[2] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_3 = mul_a_reg[3] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_4 = mul_a_reg[4] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_5 = mul_a_reg[5] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_6 = mul_a_reg[6] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_2_7 = mul_a_reg[7] & mul_b_reg[2]; // @[dut.scala 52:34]
  wire  temp_3_0 = mul_a_reg[0] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_1 = mul_a_reg[1] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_2 = mul_a_reg[2] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_3 = mul_a_reg[3] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_4 = mul_a_reg[4] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_5 = mul_a_reg[5] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_6 = mul_a_reg[6] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_3_7 = mul_a_reg[7] & mul_b_reg[3]; // @[dut.scala 52:34]
  wire  temp_4_0 = mul_a_reg[0] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_1 = mul_a_reg[1] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_2 = mul_a_reg[2] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_3 = mul_a_reg[3] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_4 = mul_a_reg[4] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_5 = mul_a_reg[5] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_6 = mul_a_reg[6] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_4_7 = mul_a_reg[7] & mul_b_reg[4]; // @[dut.scala 52:34]
  wire  temp_5_0 = mul_a_reg[0] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_1 = mul_a_reg[1] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_2 = mul_a_reg[2] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_3 = mul_a_reg[3] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_4 = mul_a_reg[4] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_5 = mul_a_reg[5] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_6 = mul_a_reg[6] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_5_7 = mul_a_reg[7] & mul_b_reg[5]; // @[dut.scala 52:34]
  wire  temp_6_0 = mul_a_reg[0] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_1 = mul_a_reg[1] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_2 = mul_a_reg[2] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_3 = mul_a_reg[3] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_4 = mul_a_reg[4] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_5 = mul_a_reg[5] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_6 = mul_a_reg[6] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_6_7 = mul_a_reg[7] & mul_b_reg[6]; // @[dut.scala 52:34]
  wire  temp_7_0 = mul_a_reg[0] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_1 = mul_a_reg[1] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_2 = mul_a_reg[2] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_3 = mul_a_reg[3] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_4 = mul_a_reg[4] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_5 = mul_a_reg[5] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_6 = mul_a_reg[6] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire  temp_7_7 = mul_a_reg[7] & mul_b_reg[7]; // @[dut.scala 52:34]
  wire [9:0] _sum_stage1_0_T_1 = {2'h0,temp_0_7,temp_0_6,temp_0_5,temp_0_4,temp_0_3,temp_0_2,temp_0_1,temp_0_0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_0_T_3 = {1'h0,temp_1_7,temp_1_6,temp_1_5,temp_1_4,temp_1_3,temp_1_2,temp_1_1,temp_1_0,1'h0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_1_T_1 = {2'h0,temp_2_7,temp_2_6,temp_2_5,temp_2_4,temp_2_3,temp_2_2,temp_2_1,temp_2_0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_1_T_3 = {1'h0,temp_3_7,temp_3_6,temp_3_5,temp_3_4,temp_3_3,temp_3_2,temp_3_1,temp_3_0,1'h0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_2_T_1 = {2'h0,temp_4_7,temp_4_6,temp_4_5,temp_4_4,temp_4_3,temp_4_2,temp_4_1,temp_4_0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_2_T_3 = {1'h0,temp_5_7,temp_5_6,temp_5_5,temp_5_4,temp_5_3,temp_5_2,temp_5_1,temp_5_0,1'h0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_3_T_1 = {2'h0,temp_6_7,temp_6_6,temp_6_5,temp_6_4,temp_6_3,temp_6_2,temp_6_1,temp_6_0}; // @[Cat.scala 33:92]
  wire [9:0] _sum_stage1_3_T_3 = {1'h0,temp_7_7,temp_7_6,temp_7_5,temp_7_4,temp_7_3,temp_7_2,temp_7_1,temp_7_0,1'h0}; // @[Cat.scala 33:92]
  wire [11:0] _sum_stage2_0_T = {2'h0,sum_0}; // @[Cat.scala 33:92]
  wire [13:0] _sum_stage2_0_T_1 = {2'h0,sum_1,2'h0}; // @[Cat.scala 33:92]
  wire [13:0] _GEN_3 = {{2'd0}, _sum_stage2_0_T}; // @[dut.scala 80:42]
  wire [13:0] _sum_stage2_0_T_3 = _GEN_3 + _sum_stage2_0_T_1; // @[dut.scala 80:42]
  wire [11:0] _sum_stage2_1_T = {2'h0,sum_2}; // @[Cat.scala 33:92]
  wire [13:0] _sum_stage2_1_T_1 = {2'h0,sum_3,2'h0}; // @[Cat.scala 33:92]
  wire [13:0] _GEN_4 = {{2'd0}, _sum_stage2_1_T}; // @[dut.scala 83:42]
  wire [13:0] _sum_stage2_1_T_3 = _GEN_4 + _sum_stage2_1_T_1; // @[dut.scala 83:42]
  wire [11:0] sum_stage2_1 = _sum_stage2_1_T_3[11:0]; // @[dut.scala 78:24 83:17]
  wire [15:0] _final_sum_T = {sum_stage2_1, 4'h0}; // @[dut.scala 87:50]
  wire [11:0] sum_stage2_0 = _sum_stage2_0_T_3[11:0]; // @[dut.scala 78:24 80:17]
  wire [15:0] _GEN_5 = {{4'd0}, sum_stage2_0}; // @[dut.scala 87:33]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 93:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 94:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in;
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 40:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 40:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 40:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 40:23]
    end
    if (io_mul_en_in) begin // @[dut.scala 44:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 45:15]
    end
    if (io_mul_en_in) begin // @[dut.scala 44:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 46:15]
    end
    sum_0 <= _sum_stage1_0_T_1 + _sum_stage1_0_T_3; // @[dut.scala 59:50]
    sum_1 <= _sum_stage1_1_T_1 + _sum_stage1_1_T_3; // @[dut.scala 62:50]
    sum_2 <= _sum_stage1_2_T_1 + _sum_stage1_2_T_3; // @[dut.scala 65:50]
    sum_3 <= _sum_stage1_3_T_1 + _sum_stage1_3_T_3; // @[dut.scala 68:50]
    mul_out_reg <= _GEN_5 + _final_sum_T; // @[dut.scala 87:33]
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
  sum_0 = _RAND_7[9:0];
  _RAND_8 = {1{`RANDOM}};
  sum_1 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  sum_2 = _RAND_9[9:0];
  _RAND_10 = {1{`RANDOM}};
  sum_3 = _RAND_10[9:0];
  _RAND_11 = {1{`RANDOM}};
  mul_out_reg = _RAND_11[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
