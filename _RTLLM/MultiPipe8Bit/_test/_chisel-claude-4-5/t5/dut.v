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
  reg [7:0] mul_a_reg; // @[dut.scala 21:26]
  reg [7:0] mul_b_reg; // @[dut.scala 22:26]
  wire [15:0] _temp_0_T_1 = {8'h0,mul_a_reg}; // @[Cat.scala 33:92]
  wire [15:0] temp_0 = mul_b_reg[0] ? _temp_0_T_1 : 16'h0; // @[dut.scala 34:19]
  wire [16:0] _temp_1_T_2 = {_temp_0_T_1, 1'h0}; // @[dut.scala 35:45]
  wire [16:0] _temp_1_T_3 = mul_b_reg[1] ? _temp_1_T_2 : 17'h0; // @[dut.scala 34:19]
  wire [17:0] _temp_2_T_2 = {_temp_0_T_1, 2'h0}; // @[dut.scala 35:45]
  wire [17:0] _temp_2_T_3 = mul_b_reg[2] ? _temp_2_T_2 : 18'h0; // @[dut.scala 34:19]
  wire [18:0] _temp_3_T_2 = {_temp_0_T_1, 3'h0}; // @[dut.scala 35:45]
  wire [18:0] _temp_3_T_3 = mul_b_reg[3] ? _temp_3_T_2 : 19'h0; // @[dut.scala 34:19]
  wire [19:0] _temp_4_T_2 = {_temp_0_T_1, 4'h0}; // @[dut.scala 35:45]
  wire [19:0] _temp_4_T_3 = mul_b_reg[4] ? _temp_4_T_2 : 20'h0; // @[dut.scala 34:19]
  wire [20:0] _temp_5_T_2 = {_temp_0_T_1, 5'h0}; // @[dut.scala 35:45]
  wire [20:0] _temp_5_T_3 = mul_b_reg[5] ? _temp_5_T_2 : 21'h0; // @[dut.scala 34:19]
  wire [21:0] _temp_6_T_2 = {_temp_0_T_1, 6'h0}; // @[dut.scala 35:45]
  wire [21:0] _temp_6_T_3 = mul_b_reg[6] ? _temp_6_T_2 : 22'h0; // @[dut.scala 34:19]
  wire [22:0] _temp_7_T_2 = {_temp_0_T_1, 7'h0}; // @[dut.scala 35:45]
  wire [22:0] _temp_7_T_3 = mul_b_reg[7] ? _temp_7_T_2 : 23'h0; // @[dut.scala 34:19]
  reg [15:0] sum0; // @[dut.scala 40:21]
  reg [15:0] sum1; // @[dut.scala 41:21]
  wire [15:0] temp_1 = _temp_1_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] _sum0_T_1 = temp_0 + temp_1; // @[dut.scala 43:19]
  wire [15:0] temp_2 = _temp_2_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] temp_3 = _temp_3_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] _sum1_T_1 = temp_2 + temp_3; // @[dut.scala 44:19]
  reg [15:0] sum2; // @[dut.scala 47:21]
  reg [15:0] sum3; // @[dut.scala 48:21]
  wire [15:0] temp_4 = _temp_4_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] temp_5 = _temp_5_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] _sum2_T_1 = temp_4 + temp_5; // @[dut.scala 50:19]
  wire [15:0] temp_6 = _temp_6_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] temp_7 = _temp_7_T_3[15:0]; // @[dut.scala 31:18 34:13]
  wire [15:0] _sum3_T_1 = temp_6 + temp_7; // @[dut.scala 51:19]
  reg [15:0] sum01; // @[dut.scala 54:22]
  reg [15:0] sum23; // @[dut.scala 55:22]
  wire [15:0] _sum01_T_1 = sum0 + sum1; // @[dut.scala 57:17]
  wire [15:0] _sum23_T_1 = sum2 + sum3; // @[dut.scala 58:17]
  reg [15:0] mul_out_reg; // @[dut.scala 61:28]
  wire [15:0] _mul_out_reg_T_1 = sum01 + sum23; // @[dut.scala 62:24]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 18:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 65:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 15:18]
    end
    if (reset) begin // @[dut.scala 21:26]
      mul_a_reg <= 8'h0; // @[dut.scala 21:26]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 25:15]
    end
    if (reset) begin // @[dut.scala 22:26]
      mul_b_reg <= 8'h0; // @[dut.scala 22:26]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 26:15]
    end
    if (reset) begin // @[dut.scala 40:21]
      sum0 <= 16'h0; // @[dut.scala 40:21]
    end else begin
      sum0 <= _sum0_T_1; // @[dut.scala 43:8]
    end
    if (reset) begin // @[dut.scala 41:21]
      sum1 <= 16'h0; // @[dut.scala 41:21]
    end else begin
      sum1 <= _sum1_T_1; // @[dut.scala 44:8]
    end
    if (reset) begin // @[dut.scala 47:21]
      sum2 <= 16'h0; // @[dut.scala 47:21]
    end else begin
      sum2 <= _sum2_T_1; // @[dut.scala 50:8]
    end
    if (reset) begin // @[dut.scala 48:21]
      sum3 <= 16'h0; // @[dut.scala 48:21]
    end else begin
      sum3 <= _sum3_T_1; // @[dut.scala 51:8]
    end
    if (reset) begin // @[dut.scala 54:22]
      sum01 <= 16'h0; // @[dut.scala 54:22]
    end else begin
      sum01 <= _sum01_T_1; // @[dut.scala 57:9]
    end
    if (reset) begin // @[dut.scala 55:22]
      sum23 <= 16'h0; // @[dut.scala 55:22]
    end else begin
      sum23 <= _sum23_T_1; // @[dut.scala 58:9]
    end
    if (reset) begin // @[dut.scala 61:28]
      mul_out_reg <= 16'h0; // @[dut.scala 61:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 62:15]
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
  sum0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum01 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum23 = _RAND_8[15:0];
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
