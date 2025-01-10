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
  reg  mul_en_reg; // @[dut.scala 15:27]
  reg [7:0] mul_a_reg; // @[dut.scala 16:22]
  reg [7:0] mul_b_reg; // @[dut.scala 17:22]
  reg [15:0] mul_out_reg; // @[dut.scala 20:28]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_1 = mul_b_reg[1] ? {{7'd0}, _temp_1_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_2 = mul_b_reg[2] ? {{6'd0}, _temp_2_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_3 = mul_b_reg[3] ? {{5'd0}, _temp_3_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_4 = mul_b_reg[4] ? {{4'd0}, _temp_4_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_5 = mul_b_reg[5] ? {{3'd0}, _temp_5_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_6 = mul_b_reg[6] ? {{2'd0}, _temp_6_T_1} : 16'h0; // @[dut.scala 34:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 34:44]
  wire [15:0] temp_7 = mul_b_reg[7] ? {{1'd0}, _temp_7_T_1} : 16'h0; // @[dut.scala 34:19]
  reg [15:0] partial_sum_reg_0; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_1; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_2; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_3; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_4; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_5; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_6; // @[dut.scala 38:28]
  reg [15:0] partial_sum_reg_7; // @[dut.scala 38:28]
  assign io_mul_en_out = mul_en_reg; // @[dut.scala 51:17]
  assign io_mul_out = mul_en_reg ? mul_out_reg : 16'h0; // @[dut.scala 52:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:27]
      mul_en_reg <= 1'h0; // @[dut.scala 15:27]
    end else begin
      mul_en_reg <= io_mul_en_in;
    end
    if (io_mul_en_in) begin // @[dut.scala 23:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 25:15]
    end
    if (io_mul_en_in) begin // @[dut.scala 23:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 26:15]
    end
    if (reset) begin // @[dut.scala 20:28]
      mul_out_reg <= 16'h0; // @[dut.scala 20:28]
    end else if (mul_en_reg) begin // @[dut.scala 46:20]
      mul_out_reg <= partial_sum_reg_7; // @[dut.scala 47:17]
    end
    if (mul_b_reg[0]) begin // @[dut.scala 34:19]
      partial_sum_reg_0 <= {{8'd0}, mul_a_reg};
    end else begin
      partial_sum_reg_0 <= 16'h0;
    end
    partial_sum_reg_1 <= partial_sum_reg_0 + temp_1; // @[dut.scala 42:50]
    partial_sum_reg_2 <= partial_sum_reg_1 + temp_2; // @[dut.scala 42:50]
    partial_sum_reg_3 <= partial_sum_reg_2 + temp_3; // @[dut.scala 42:50]
    partial_sum_reg_4 <= partial_sum_reg_3 + temp_4; // @[dut.scala 42:50]
    partial_sum_reg_5 <= partial_sum_reg_4 + temp_5; // @[dut.scala 42:50]
    partial_sum_reg_6 <= partial_sum_reg_5 + temp_6; // @[dut.scala 42:50]
    partial_sum_reg_7 <= partial_sum_reg_6 + temp_7; // @[dut.scala 42:50]
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
  mul_en_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  mul_out_reg = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  partial_sum_reg_0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partial_sum_reg_1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partial_sum_reg_2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  partial_sum_reg_3 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  partial_sum_reg_4 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  partial_sum_reg_5 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  partial_sum_reg_6 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  partial_sum_reg_7 = _RAND_11[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
