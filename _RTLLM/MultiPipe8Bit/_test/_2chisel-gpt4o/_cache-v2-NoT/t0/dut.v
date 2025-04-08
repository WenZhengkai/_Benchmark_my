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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire  mul_en_out = mul_en_out_reg[4]; // @[dut.scala 16:34]
  reg [7:0] mul_a_reg; // @[dut.scala 20:26]
  reg [7:0] mul_b_reg; // @[dut.scala 21:26]
  wire [7:0] _temp_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 30:19]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 30:44]
  wire [8:0] _temp_1_T_2 = mul_b_reg[1] ? _temp_1_T_1 : 9'h0; // @[dut.scala 30:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 30:44]
  wire [9:0] _temp_2_T_2 = mul_b_reg[2] ? _temp_2_T_1 : 10'h0; // @[dut.scala 30:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 30:44]
  wire [10:0] _temp_3_T_2 = mul_b_reg[3] ? _temp_3_T_1 : 11'h0; // @[dut.scala 30:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 30:44]
  wire [11:0] _temp_4_T_2 = mul_b_reg[4] ? _temp_4_T_1 : 12'h0; // @[dut.scala 30:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 30:44]
  wire [12:0] _temp_5_T_2 = mul_b_reg[5] ? _temp_5_T_1 : 13'h0; // @[dut.scala 30:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 30:44]
  wire [13:0] _temp_6_T_2 = mul_b_reg[6] ? _temp_6_T_1 : 14'h0; // @[dut.scala 30:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 30:44]
  wire [14:0] _temp_7_T_2 = mul_b_reg[7] ? _temp_7_T_1 : 15'h0; // @[dut.scala 30:19]
  wire [15:0] temp_0 = {{8'd0}, _temp_0_T_2}; // @[dut.scala 28:18 30:13]
  wire [15:0] temp_1 = {{7'd0}, _temp_1_T_2}; // @[dut.scala 28:18 30:13]
  reg [15:0] sum1; // @[dut.scala 35:21]
  wire [15:0] temp_2 = {{6'd0}, _temp_2_T_2}; // @[dut.scala 28:18 30:13]
  wire [15:0] temp_3 = {{5'd0}, _temp_3_T_2}; // @[dut.scala 28:18 30:13]
  reg [15:0] sum2; // @[dut.scala 36:21]
  wire [15:0] temp_4 = {{4'd0}, _temp_4_T_2}; // @[dut.scala 28:18 30:13]
  wire [15:0] temp_5 = {{3'd0}, _temp_5_T_2}; // @[dut.scala 28:18 30:13]
  reg [15:0] sum3; // @[dut.scala 37:21]
  wire [15:0] temp_6 = {{2'd0}, _temp_6_T_2}; // @[dut.scala 28:18 30:13]
  wire [15:0] temp_7 = {{1'd0}, _temp_7_T_2}; // @[dut.scala 28:18 30:13]
  reg [15:0] sum4; // @[dut.scala 38:21]
  reg [15:0] sumA; // @[dut.scala 40:21]
  reg [15:0] sumB; // @[dut.scala 41:21]
  reg [15:0] mul_out_reg; // @[dut.scala 44:28]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 16:34]
  assign io_mul_out = mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 45:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 15:18]
    end
    if (reset) begin // @[dut.scala 20:26]
      mul_a_reg <= 8'h0; // @[dut.scala 20:26]
    end else if (io_mul_en_in) begin // @[dut.scala 22:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 23:15]
    end
    if (reset) begin // @[dut.scala 21:26]
      mul_b_reg <= 8'h0; // @[dut.scala 21:26]
    end else if (io_mul_en_in) begin // @[dut.scala 22:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 24:15]
    end
    sum1 <= temp_0 + temp_1; // @[dut.scala 35:30]
    sum2 <= temp_2 + temp_3; // @[dut.scala 36:30]
    sum3 <= temp_4 + temp_5; // @[dut.scala 37:30]
    sum4 <= temp_6 + temp_7; // @[dut.scala 38:30]
    sumA <= sum1 + sum2; // @[dut.scala 40:27]
    sumB <= sum3 + sum4; // @[dut.scala 41:27]
    mul_out_reg <= sumA + sumB; // @[dut.scala 44:34]
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
  sumA = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sumB = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  mul_out_reg = _RAND_9[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
