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
  reg  mul_en_out_reg_0; // @[dut.scala 17:31]
  reg  mul_en_out_reg_1; // @[dut.scala 17:31]
  reg  mul_en_out_reg_2; // @[dut.scala 17:31]
  reg  mul_en_out_reg_3; // @[dut.scala 17:31]
  reg  mul_en_out_reg_4; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[dut.scala 20:22]
  reg [7:0] mul_b_reg; // @[dut.scala 21:22]
  reg [15:0] sum_0; // @[dut.scala 27:16]
  reg [15:0] sum_1; // @[dut.scala 27:16]
  reg [15:0] mul_out_reg; // @[dut.scala 30:24]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_2 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_3 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_4 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_5 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_6 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [7:0] temp_7 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 53:19]
  wire [8:0] _sum_stage1_0_T = {temp_1, 1'h0}; // @[dut.scala 57:42]
  wire [8:0] _GEN_11 = {{1'd0}, temp_0}; // @[dut.scala 57:30]
  wire [9:0] sum_stage1_0 = _GEN_11 + _sum_stage1_0_T; // @[dut.scala 57:30]
  wire [8:0] _sum_stage1_1_T = {temp_3, 1'h0}; // @[dut.scala 58:42]
  wire [8:0] _GEN_12 = {{1'd0}, temp_2}; // @[dut.scala 58:30]
  wire [9:0] sum_stage1_1 = _GEN_12 + _sum_stage1_1_T; // @[dut.scala 58:30]
  wire [8:0] _sum_stage1_2_T = {temp_5, 1'h0}; // @[dut.scala 59:42]
  wire [8:0] _GEN_13 = {{1'd0}, temp_4}; // @[dut.scala 59:30]
  wire [9:0] sum_stage1_2 = _GEN_13 + _sum_stage1_2_T; // @[dut.scala 59:30]
  wire [8:0] _sum_stage1_3_T = {temp_7, 1'h0}; // @[dut.scala 60:42]
  wire [8:0] _GEN_14 = {{1'd0}, temp_6}; // @[dut.scala 60:30]
  wire [9:0] sum_stage1_3 = _GEN_14 + _sum_stage1_3_T; // @[dut.scala 60:30]
  wire [11:0] _sum_0_T = {sum_stage1_1, 2'h0}; // @[dut.scala 64:45]
  wire [11:0] _GEN_15 = {{2'd0}, sum_stage1_0}; // @[dut.scala 64:28]
  wire [12:0] _sum_0_T_1 = _GEN_15 + _sum_0_T; // @[dut.scala 64:28]
  wire [11:0] _sum_1_T = {sum_stage1_3, 2'h0}; // @[dut.scala 65:45]
  wire [11:0] _GEN_16 = {{2'd0}, sum_stage1_2}; // @[dut.scala 65:28]
  wire [12:0] _sum_1_T_1 = _GEN_16 + _sum_1_T; // @[dut.scala 65:28]
  wire [12:0] _GEN_7 = mul_en_out_reg_1 ? _sum_0_T_1 : 13'h0; // @[dut.scala 63:27 64:12 67:12]
  wire [12:0] _GEN_8 = mul_en_out_reg_1 ? _sum_1_T_1 : 13'h0; // @[dut.scala 63:27 65:12 68:12]
  reg [15:0] sum_stage3; // @[dut.scala 72:23]
  wire [19:0] _sum_stage3_T = {sum_1, 4'h0}; // @[dut.scala 74:37]
  wire [19:0] _GEN_17 = {{4'd0}, sum_0}; // @[dut.scala 74:26]
  wire [20:0] _sum_stage3_T_1 = _GEN_17 + _sum_stage3_T; // @[dut.scala 74:26]
  wire [20:0] _GEN_9 = mul_en_out_reg_2 ? _sum_stage3_T_1 : 21'h0; // @[dut.scala 73:27 74:16 76:16]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 87:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 88:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in;
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0;
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1;
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2;
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3;
    end
    if (io_mul_en_in) begin // @[dut.scala 33:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 41:15]
    end
    if (io_mul_en_in) begin // @[dut.scala 33:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 42:15]
    end
    sum_0 <= {{3'd0}, _GEN_7};
    sum_1 <= {{3'd0}, _GEN_8};
    if (mul_en_out_reg_3) begin // @[dut.scala 80:27]
      mul_out_reg <= sum_stage3; // @[dut.scala 81:17]
    end else begin
      mul_out_reg <= 16'h0; // @[dut.scala 83:17]
    end
    sum_stage3 <= _GEN_9[15:0];
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
  sum_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  mul_out_reg = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum_stage3 = _RAND_10[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
