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
  reg  mul_en_out_reg_0; // @[dut.scala 19:31]
  reg  mul_en_out_reg_1; // @[dut.scala 19:31]
  reg  mul_en_out_reg_2; // @[dut.scala 19:31]
  reg  mul_en_out_reg_3; // @[dut.scala 19:31]
  reg  mul_en_out_reg_4; // @[dut.scala 19:31]
  reg [7:0] mul_a_reg; // @[dut.scala 22:26]
  reg [7:0] mul_b_reg; // @[dut.scala 23:26]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_2 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_3 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_4 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_5 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_6 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  wire [7:0] temp_7 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 40:19]
  reg [9:0] sum1; // @[dut.scala 44:21]
  reg [9:0] sum2; // @[dut.scala 45:21]
  reg [9:0] sum3; // @[dut.scala 46:21]
  reg [9:0] sum4; // @[dut.scala 47:21]
  wire [8:0] _sum1_T = {temp_1, 1'h0}; // @[dut.scala 49:30]
  wire [8:0] _GEN_2 = {{1'd0}, temp_0}; // @[dut.scala 49:19]
  wire [8:0] _sum1_T_2 = _GEN_2 + _sum1_T; // @[dut.scala 49:19]
  wire [9:0] _sum2_T = {temp_2, 2'h0}; // @[dut.scala 50:20]
  wire [10:0] _sum2_T_1 = {temp_3, 3'h0}; // @[dut.scala 50:37]
  wire [10:0] _GEN_3 = {{1'd0}, _sum2_T}; // @[dut.scala 50:26]
  wire [10:0] _sum2_T_3 = _GEN_3 + _sum2_T_1; // @[dut.scala 50:26]
  wire [11:0] _sum3_T = {temp_4, 4'h0}; // @[dut.scala 51:20]
  wire [12:0] _sum3_T_1 = {temp_5, 5'h0}; // @[dut.scala 51:37]
  wire [12:0] _GEN_4 = {{1'd0}, _sum3_T}; // @[dut.scala 51:26]
  wire [12:0] _sum3_T_3 = _GEN_4 + _sum3_T_1; // @[dut.scala 51:26]
  wire [13:0] _sum4_T = {temp_6, 6'h0}; // @[dut.scala 52:20]
  wire [14:0] _sum4_T_1 = {temp_7, 7'h0}; // @[dut.scala 52:37]
  wire [14:0] _GEN_5 = {{1'd0}, _sum4_T}; // @[dut.scala 52:26]
  wire [14:0] _sum4_T_3 = _GEN_5 + _sum4_T_1; // @[dut.scala 52:26]
  reg [11:0] sum_a; // @[dut.scala 55:22]
  reg [11:0] sum_b; // @[dut.scala 56:22]
  wire [9:0] _sum_a_T_1 = sum1 + sum2; // @[dut.scala 58:17]
  wire [9:0] _sum_b_T_1 = sum3 + sum4; // @[dut.scala 59:17]
  reg [15:0] mul_out_reg; // @[dut.scala 62:28]
  wire [11:0] _mul_out_reg_T_1 = sum_a + sum_b; // @[dut.scala 63:24]
  wire [10:0] _GEN_6 = reset ? 11'h0 : _sum2_T_3; // @[dut.scala 45:{21,21} 50:8]
  wire [12:0] _GEN_7 = reset ? 13'h0 : _sum3_T_3; // @[dut.scala 46:{21,21} 51:8]
  wire [14:0] _GEN_8 = reset ? 15'h0 : _sum4_T_3; // @[dut.scala 47:{21,21} 52:8]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 66:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 67:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 32:21]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 34:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 34:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 34:23]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 34:23]
    end
    if (reset) begin // @[dut.scala 22:26]
      mul_a_reg <= 8'h0; // @[dut.scala 22:26]
    end else if (io_mul_en_in) begin // @[dut.scala 26:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 27:15]
    end
    if (reset) begin // @[dut.scala 23:26]
      mul_b_reg <= 8'h0; // @[dut.scala 23:26]
    end else if (io_mul_en_in) begin // @[dut.scala 26:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 28:15]
    end
    if (reset) begin // @[dut.scala 44:21]
      sum1 <= 10'h0; // @[dut.scala 44:21]
    end else begin
      sum1 <= {{1'd0}, _sum1_T_2}; // @[dut.scala 49:8]
    end
    sum2 <= _GEN_6[9:0]; // @[dut.scala 45:{21,21} 50:8]
    sum3 <= _GEN_7[9:0]; // @[dut.scala 46:{21,21} 51:8]
    sum4 <= _GEN_8[9:0]; // @[dut.scala 47:{21,21} 52:8]
    if (reset) begin // @[dut.scala 55:22]
      sum_a <= 12'h0; // @[dut.scala 55:22]
    end else begin
      sum_a <= {{2'd0}, _sum_a_T_1}; // @[dut.scala 58:9]
    end
    if (reset) begin // @[dut.scala 56:22]
      sum_b <= 12'h0; // @[dut.scala 56:22]
    end else begin
      sum_b <= {{2'd0}, _sum_b_T_1}; // @[dut.scala 59:9]
    end
    if (reset) begin // @[dut.scala 62:28]
      mul_out_reg <= 16'h0; // @[dut.scala 62:28]
    end else begin
      mul_out_reg <= {{4'd0}, _mul_out_reg_T_1}; // @[dut.scala 63:15]
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
  sum1 = _RAND_7[9:0];
  _RAND_8 = {1{`RANDOM}};
  sum2 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  sum3 = _RAND_9[9:0];
  _RAND_10 = {1{`RANDOM}};
  sum4 = _RAND_10[9:0];
  _RAND_11 = {1{`RANDOM}};
  sum_a = _RAND_11[11:0];
  _RAND_12 = {1{`RANDOM}};
  sum_b = _RAND_12[11:0];
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
