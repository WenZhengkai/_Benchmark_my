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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 15:31]
  wire [5:0] _mul_en_out_reg_T = {mul_en_out_reg, 1'h0}; // @[dut.scala 17:38]
  wire [5:0] _GEN_4 = {{5'd0}, io_mul_en_in}; // @[dut.scala 17:43]
  wire [5:0] _mul_en_out_reg_T_1 = _mul_en_out_reg_T | _GEN_4; // @[dut.scala 17:43]
  wire [5:0] _GEN_0 = io_mul_en_in ? _mul_en_out_reg_T_1 : {{1'd0}, mul_en_out_reg}; // @[dut.scala 16:22 17:20 15:31]
  reg [7:0] mul_a_reg; // @[dut.scala 24:26]
  reg [7:0] mul_b_reg; // @[dut.scala 25:26]
  wire [7:0] _temp_0_T_2 = mul_b_reg[0] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_0_T_3 = mul_a_reg & _temp_0_T_2; // @[dut.scala 34:27]
  wire [7:0] _temp_1_T_2 = mul_b_reg[1] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_1_T_3 = mul_a_reg & _temp_1_T_2; // @[dut.scala 34:27]
  wire [8:0] _temp_1_T_4 = {_temp_1_T_3, 1'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_2_T_2 = mul_b_reg[2] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_2_T_3 = mul_a_reg & _temp_2_T_2; // @[dut.scala 34:27]
  wire [9:0] _temp_2_T_4 = {_temp_2_T_3, 2'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_3_T_2 = mul_b_reg[3] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_3_T_3 = mul_a_reg & _temp_3_T_2; // @[dut.scala 34:27]
  wire [10:0] _temp_3_T_4 = {_temp_3_T_3, 3'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_4_T_2 = mul_b_reg[4] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_4_T_3 = mul_a_reg & _temp_4_T_2; // @[dut.scala 34:27]
  wire [11:0] _temp_4_T_4 = {_temp_4_T_3, 4'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_5_T_2 = mul_b_reg[5] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_5_T_3 = mul_a_reg & _temp_5_T_2; // @[dut.scala 34:27]
  wire [12:0] _temp_5_T_4 = {_temp_5_T_3, 5'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_6_T_2 = mul_b_reg[6] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_6_T_3 = mul_a_reg & _temp_6_T_2; // @[dut.scala 34:27]
  wire [13:0] _temp_6_T_4 = {_temp_6_T_3, 6'h0}; // @[dut.scala 34:59]
  wire [7:0] _temp_7_T_2 = mul_b_reg[7] ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] _temp_7_T_3 = mul_a_reg & _temp_7_T_2; // @[dut.scala 34:27]
  wire [14:0] _temp_7_T_4 = {_temp_7_T_3, 7'h0}; // @[dut.scala 34:59]
  reg [15:0] sum1; // @[dut.scala 39:21]
  reg [15:0] sum2; // @[dut.scala 40:21]
  reg [15:0] sum3; // @[dut.scala 41:21]
  reg [15:0] sum4; // @[dut.scala 42:21]
  wire [15:0] temp_0 = {{8'd0}, _temp_0_T_3}; // @[dut.scala 32:18 34:13]
  wire [15:0] temp_1 = {{7'd0}, _temp_1_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] _sum1_T_1 = temp_0 + temp_1; // @[dut.scala 45:19]
  wire [15:0] temp_2 = {{6'd0}, _temp_2_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] temp_3 = {{5'd0}, _temp_3_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] _sum2_T_1 = temp_2 + temp_3; // @[dut.scala 46:19]
  wire [15:0] temp_4 = {{4'd0}, _temp_4_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] temp_5 = {{3'd0}, _temp_5_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] _sum3_T_1 = temp_4 + temp_5; // @[dut.scala 47:19]
  wire [15:0] temp_6 = {{2'd0}, _temp_6_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] temp_7 = {{1'd0}, _temp_7_T_4}; // @[dut.scala 32:18 34:13]
  wire [15:0] _sum4_T_1 = temp_6 + temp_7; // @[dut.scala 48:19]
  reg [15:0] mul_out_reg; // @[dut.scala 51:28]
  wire [15:0] _mul_out_reg_T_1 = sum1 + sum2; // @[dut.scala 52:23]
  wire [15:0] _mul_out_reg_T_3 = _mul_out_reg_T_1 + sum3; // @[dut.scala 52:30]
  wire [15:0] _mul_out_reg_T_5 = _mul_out_reg_T_3 + sum4; // @[dut.scala 52:37]
  wire [5:0] _GEN_5 = reset ? 6'h0 : _GEN_0; // @[dut.scala 15:{31,31}]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 21:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 55:23 56:16 58:16]
  always @(posedge clock) begin
    mul_en_out_reg <= _GEN_5[4:0]; // @[dut.scala 15:{31,31}]
    if (reset) begin // @[dut.scala 24:26]
      mul_a_reg <= 8'h0; // @[dut.scala 24:26]
    end else if (io_mul_en_in) begin // @[dut.scala 26:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 27:15]
    end
    if (reset) begin // @[dut.scala 25:26]
      mul_b_reg <= 8'h0; // @[dut.scala 25:26]
    end else if (io_mul_en_in) begin // @[dut.scala 26:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 28:15]
    end
    if (reset) begin // @[dut.scala 39:21]
      sum1 <= 16'h0; // @[dut.scala 39:21]
    end else begin
      sum1 <= _sum1_T_1; // @[dut.scala 45:8]
    end
    if (reset) begin // @[dut.scala 40:21]
      sum2 <= 16'h0; // @[dut.scala 40:21]
    end else begin
      sum2 <= _sum2_T_1; // @[dut.scala 46:8]
    end
    if (reset) begin // @[dut.scala 41:21]
      sum3 <= 16'h0; // @[dut.scala 41:21]
    end else begin
      sum3 <= _sum3_T_1; // @[dut.scala 47:8]
    end
    if (reset) begin // @[dut.scala 42:21]
      sum4 <= 16'h0; // @[dut.scala 42:21]
    end else begin
      sum4 <= _sum4_T_1; // @[dut.scala 48:8]
    end
    if (reset) begin // @[dut.scala 51:28]
      mul_out_reg <= 16'h0; // @[dut.scala 51:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_5; // @[dut.scala 52:15]
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
  sum1 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum2 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum3 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum4 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  mul_out_reg = _RAND_7[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
