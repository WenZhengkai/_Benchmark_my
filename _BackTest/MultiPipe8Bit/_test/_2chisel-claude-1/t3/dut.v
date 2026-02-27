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
  reg  mul_en_out_reg_0; // @[dut.scala 14:31]
  reg  mul_en_out_reg_1; // @[dut.scala 14:31]
  reg  mul_en_out_reg_2; // @[dut.scala 14:31]
  reg  mul_en_out_reg_3; // @[dut.scala 14:31]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 21:19]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 21:44]
  wire [8:0] _temp_1_T_2 = mul_b_reg[1] ? _temp_1_T_1 : 9'h0; // @[dut.scala 21:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 21:44]
  wire [9:0] _temp_2_T_2 = mul_b_reg[2] ? _temp_2_T_1 : 10'h0; // @[dut.scala 21:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 21:44]
  wire [10:0] _temp_3_T_2 = mul_b_reg[3] ? _temp_3_T_1 : 11'h0; // @[dut.scala 21:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 21:44]
  wire [11:0] _temp_4_T_2 = mul_b_reg[4] ? _temp_4_T_1 : 12'h0; // @[dut.scala 21:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 21:44]
  wire [12:0] _temp_5_T_2 = mul_b_reg[5] ? _temp_5_T_1 : 13'h0; // @[dut.scala 21:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 21:44]
  wire [13:0] _temp_6_T_2 = mul_b_reg[6] ? _temp_6_T_1 : 14'h0; // @[dut.scala 21:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 21:44]
  wire [14:0] _temp_7_T_2 = mul_b_reg[7] ? _temp_7_T_1 : 15'h0; // @[dut.scala 21:19]
  reg [15:0] sum_0; // @[dut.scala 25:20]
  reg [15:0] sum_1; // @[dut.scala 25:20]
  reg [15:0] sum_2; // @[dut.scala 25:20]
  reg [15:0] sum_3; // @[dut.scala 25:20]
  wire [7:0] temp_1 = _temp_1_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [8:0] _sum_0_T = temp_0 + temp_1; // @[dut.scala 26:21]
  wire [7:0] temp_2 = _temp_2_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [7:0] temp_3 = _temp_3_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [8:0] _sum_1_T = temp_2 + temp_3; // @[dut.scala 27:21]
  wire [7:0] temp_4 = _temp_4_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [7:0] temp_5 = _temp_5_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [8:0] _sum_2_T = temp_4 + temp_5; // @[dut.scala 28:21]
  wire [7:0] temp_6 = _temp_6_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [7:0] temp_7 = _temp_7_T_2[7:0]; // @[dut.scala 19:18 21:13]
  wire [8:0] _sum_3_T = temp_6 + temp_7; // @[dut.scala 29:21]
  reg [15:0] mul_out_reg; // @[dut.scala 32:28]
  wire [16:0] _mul_out_reg_T = sum_0 + sum_1; // @[dut.scala 33:31]
  wire [16:0] _GEN_11 = {{1'd0}, sum_2}; // @[dut.scala 33:31]
  wire [17:0] _mul_out_reg_T_1 = _mul_out_reg_T + _GEN_11; // @[dut.scala 33:31]
  wire [17:0] _GEN_12 = {{2'd0}, sum_3}; // @[dut.scala 33:31]
  wire [18:0] _mul_out_reg_T_2 = _mul_out_reg_T_1 + _GEN_12; // @[dut.scala 33:31]
  wire [8:0] _GEN_6 = ~reset ? 9'h0 : _sum_0_T; // @[dut.scala 26:10 46:24 48:19]
  wire [8:0] _GEN_7 = ~reset ? 9'h0 : _sum_1_T; // @[dut.scala 27:10 46:24 48:19]
  wire [8:0] _GEN_8 = ~reset ? 9'h0 : _sum_2_T; // @[dut.scala 28:10 46:24 48:19]
  wire [8:0] _GEN_9 = ~reset ? 9'h0 : _sum_3_T; // @[dut.scala 29:10 46:24 48:19]
  wire [18:0] _GEN_10 = ~reset ? 19'h0 : _mul_out_reg_T_2; // @[dut.scala 33:15 46:24 49:17]
  wire [18:0] _GEN_13 = reset ? 19'h0 : _GEN_10; // @[dut.scala 32:{28,28}]
  assign io_mul_en_out = mul_en_out_reg_3; // @[dut.scala 42:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 43:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 14:31]
    end else if (~reset) begin // @[dut.scala 46:24]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 47:30]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 36:21]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 14:31]
    end else if (~reset) begin // @[dut.scala 46:24]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 47:30]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 38:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 14:31]
    end else if (~reset) begin // @[dut.scala 46:24]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 47:30]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 38:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 14:31]
    end else if (~reset) begin // @[dut.scala 46:24]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 47:30]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 38:23]
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
    if (reset) begin // @[dut.scala 25:20]
      sum_0 <= 16'h0; // @[dut.scala 25:20]
    end else begin
      sum_0 <= {{7'd0}, _GEN_6};
    end
    if (reset) begin // @[dut.scala 25:20]
      sum_1 <= 16'h0; // @[dut.scala 25:20]
    end else begin
      sum_1 <= {{7'd0}, _GEN_7};
    end
    if (reset) begin // @[dut.scala 25:20]
      sum_2 <= 16'h0; // @[dut.scala 25:20]
    end else begin
      sum_2 <= {{7'd0}, _GEN_8};
    end
    if (reset) begin // @[dut.scala 25:20]
      sum_3 <= 16'h0; // @[dut.scala 25:20]
    end else begin
      sum_3 <= {{7'd0}, _GEN_9};
    end
    mul_out_reg <= _GEN_13[15:0]; // @[dut.scala 32:{28,28}]
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
  mul_a_reg = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  mul_b_reg = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  sum_0 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum_1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum_2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum_3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  mul_out_reg = _RAND_10[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
