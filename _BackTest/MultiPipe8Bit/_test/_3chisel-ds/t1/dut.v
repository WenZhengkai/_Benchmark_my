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
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [7:0] _partial_products_0_T_1 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [7:0] _partial_products_1_T_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [8:0] partial_products_1 = {_partial_products_1_T_1, 1'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_2_T_1 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [9:0] _partial_products_2_T_2 = {_partial_products_2_T_1, 2'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_3_T_1 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [10:0] _partial_products_3_T_2 = {_partial_products_3_T_1, 3'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_4_T_1 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [11:0] _partial_products_4_T_2 = {_partial_products_4_T_1, 4'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_5_T_1 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [12:0] _partial_products_5_T_2 = {_partial_products_5_T_1, 5'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_6_T_1 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [13:0] _partial_products_6_T_2 = {_partial_products_6_T_1, 6'h0}; // @[dut.scala 26:62]
  wire [7:0] _partial_products_7_T_1 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 26:31]
  wire [14:0] _partial_products_7_T_2 = {_partial_products_7_T_1, 7'h0}; // @[dut.scala 26:62]
  wire [8:0] partial_products_0 = {{1'd0}, _partial_products_0_T_1}; // @[dut.scala 24:30 26:25]
  reg [9:0] sum_stage1_0; // @[dut.scala 30:29]
  wire [8:0] partial_products_2 = _partial_products_2_T_2[8:0]; // @[dut.scala 24:30 26:25]
  wire [8:0] partial_products_3 = _partial_products_3_T_2[8:0]; // @[dut.scala 24:30 26:25]
  reg [9:0] sum_stage1_1; // @[dut.scala 31:29]
  wire [8:0] partial_products_4 = _partial_products_4_T_2[8:0]; // @[dut.scala 24:30 26:25]
  wire [8:0] partial_products_5 = _partial_products_5_T_2[8:0]; // @[dut.scala 24:30 26:25]
  reg [9:0] sum_stage1_2; // @[dut.scala 32:29]
  wire [8:0] partial_products_6 = _partial_products_6_T_2[8:0]; // @[dut.scala 24:30 26:25]
  wire [8:0] partial_products_7 = _partial_products_7_T_2[8:0]; // @[dut.scala 24:30 26:25]
  reg [9:0] sum_stage1_3; // @[dut.scala 33:29]
  reg [10:0] sum_stage2_0; // @[dut.scala 36:29]
  reg [10:0] sum_stage2_1; // @[dut.scala 37:29]
  reg [11:0] mul_out_reg; // @[dut.scala 40:28]
  wire [11:0] _io_mul_out_T = io_mul_en_out ? mul_out_reg : 12'h0; // @[dut.scala 54:23]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 53:17]
  assign io_mul_out = {{4'd0}, _io_mul_out_T}; // @[dut.scala 54:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else if (reset | ~io_mul_en_in) begin // @[dut.scala 43:39]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 44:30]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 46:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else if (reset | ~io_mul_en_in) begin // @[dut.scala 43:39]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 44:30]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 48:25]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else if (reset | ~io_mul_en_in) begin // @[dut.scala 43:39]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 44:30]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 48:25]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 17:31]
    end else if (reset | ~io_mul_en_in) begin // @[dut.scala 43:39]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 44:30]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 48:25]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 17:31]
    end else if (reset | ~io_mul_en_in) begin // @[dut.scala 43:39]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 44:30]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 48:25]
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
    sum_stage1_0 <= partial_products_0 + partial_products_1; // @[dut.scala 30:50]
    sum_stage1_1 <= partial_products_2 + partial_products_3; // @[dut.scala 31:50]
    sum_stage1_2 <= partial_products_4 + partial_products_5; // @[dut.scala 32:50]
    sum_stage1_3 <= partial_products_6 + partial_products_7; // @[dut.scala 33:50]
    sum_stage2_0 <= sum_stage1_0 + sum_stage1_1; // @[dut.scala 36:43]
    sum_stage2_1 <= sum_stage1_2 + sum_stage1_3; // @[dut.scala 37:43]
    mul_out_reg <= sum_stage2_0 + sum_stage2_1; // @[dut.scala 40:42]
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
  sum_stage1_0 = _RAND_7[9:0];
  _RAND_8 = {1{`RANDOM}};
  sum_stage1_1 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  sum_stage1_2 = _RAND_9[9:0];
  _RAND_10 = {1{`RANDOM}};
  sum_stage1_3 = _RAND_10[9:0];
  _RAND_11 = {1{`RANDOM}};
  sum_stage2_0 = _RAND_11[10:0];
  _RAND_12 = {1{`RANDOM}};
  sum_stage2_1 = _RAND_12[10:0];
  _RAND_13 = {1{`RANDOM}};
  mul_out_reg = _RAND_13[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
