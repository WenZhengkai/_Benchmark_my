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
  reg [4:0] mul_en_out_reg; // @[dut.scala 28:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[dut.scala 35:26]
  reg [7:0] mul_b_reg; // @[dut.scala 36:26]
  wire [7:0] pp8 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [7:0] pp8_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [8:0] _temp_1_T = {pp8_1, 1'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_2 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [9:0] _temp_2_T = {pp8_2, 2'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_3 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [10:0] _temp_3_T = {pp8_3, 3'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_4 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [11:0] _temp_4_T = {pp8_4, 4'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_5 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [12:0] _temp_5_T = {pp8_5, 5'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_6 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [13:0] _temp_6_T = {pp8_6, 6'h0}; // @[dut.scala 50:28]
  wire [7:0] pp8_7 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 49:19]
  wire [14:0] _temp_7_T = {pp8_7, 7'h0}; // @[dut.scala 50:28]
  reg [15:0] sum_0; // @[dut.scala 57:20]
  reg [15:0] sum_1; // @[dut.scala 57:20]
  reg [15:0] sum_2; // @[dut.scala 57:20]
  reg [15:0] sum_3; // @[dut.scala 57:20]
  wire [15:0] temp_0 = {{8'd0}, pp8}; // @[dut.scala 47:18 50:13]
  wire [15:0] temp_1 = {{7'd0}, _temp_1_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] _sum_0_T_1 = temp_0 + temp_1; // @[dut.scala 61:21]
  wire [15:0] temp_2 = {{6'd0}, _temp_2_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] temp_3 = {{5'd0}, _temp_3_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] _sum_1_T_1 = temp_2 + temp_3; // @[dut.scala 62:21]
  wire [15:0] temp_4 = {{4'd0}, _temp_4_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] temp_5 = {{3'd0}, _temp_5_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] _sum_2_T_1 = temp_4 + temp_5; // @[dut.scala 63:21]
  wire [15:0] temp_6 = {{2'd0}, _temp_6_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] temp_7 = {{1'd0}, _temp_7_T}; // @[dut.scala 47:18 50:13]
  wire [15:0] _sum_3_T_1 = temp_6 + temp_7; // @[dut.scala 64:21]
  reg [15:0] mul_out_reg; // @[dut.scala 69:28]
  wire [15:0] _mul_out_reg_T_1 = sum_0 + sum_1; // @[dut.scala 70:26]
  wire [15:0] _mul_out_reg_T_3 = sum_2 + sum_3; // @[dut.scala 70:46]
  wire [15:0] _mul_out_reg_T_5 = _mul_out_reg_T_1 + _mul_out_reg_T_3; // @[dut.scala 70:36]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 30:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 75:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 28:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 28:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 29:18]
    end
    if (reset) begin // @[dut.scala 35:26]
      mul_a_reg <= 8'h0; // @[dut.scala 35:26]
    end else if (io_mul_en_in) begin // @[dut.scala 38:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 39:15]
    end
    if (reset) begin // @[dut.scala 36:26]
      mul_b_reg <= 8'h0; // @[dut.scala 36:26]
    end else if (io_mul_en_in) begin // @[dut.scala 38:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 40:15]
    end
    if (reset) begin // @[dut.scala 57:20]
      sum_0 <= 16'h0; // @[dut.scala 57:20]
    end else begin
      sum_0 <= _sum_0_T_1; // @[dut.scala 61:10]
    end
    if (reset) begin // @[dut.scala 57:20]
      sum_1 <= 16'h0; // @[dut.scala 57:20]
    end else begin
      sum_1 <= _sum_1_T_1; // @[dut.scala 62:10]
    end
    if (reset) begin // @[dut.scala 57:20]
      sum_2 <= 16'h0; // @[dut.scala 57:20]
    end else begin
      sum_2 <= _sum_2_T_1; // @[dut.scala 63:10]
    end
    if (reset) begin // @[dut.scala 57:20]
      sum_3 <= 16'h0; // @[dut.scala 57:20]
    end else begin
      sum_3 <= _sum_3_T_1; // @[dut.scala 64:10]
    end
    if (reset) begin // @[dut.scala 69:28]
      mul_out_reg <= 16'h0; // @[dut.scala 69:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_5; // @[dut.scala 70:15]
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
  mul_out_reg = _RAND_7[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
