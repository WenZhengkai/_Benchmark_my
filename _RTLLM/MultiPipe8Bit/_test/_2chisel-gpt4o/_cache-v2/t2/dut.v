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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  wire [15:0] temp_0 = io_mul_b[0] ? {{8'd0}, io_mul_a} : 16'h0; // @[dut.scala 21:19]
  wire [8:0] _temp_1_T_1 = {io_mul_a, 1'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_1 = io_mul_b[1] ? {{7'd0}, _temp_1_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [9:0] _temp_2_T_1 = {io_mul_a, 2'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_2 = io_mul_b[2] ? {{6'd0}, _temp_2_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [10:0] _temp_3_T_1 = {io_mul_a, 3'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_3 = io_mul_b[3] ? {{5'd0}, _temp_3_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [11:0] _temp_4_T_1 = {io_mul_a, 4'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_4 = io_mul_b[4] ? {{4'd0}, _temp_4_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [12:0] _temp_5_T_1 = {io_mul_a, 5'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_5 = io_mul_b[5] ? {{3'd0}, _temp_5_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [13:0] _temp_6_T_1 = {io_mul_a, 6'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_6 = io_mul_b[6] ? {{2'd0}, _temp_6_T_1} : 16'h0; // @[dut.scala 21:19]
  wire [14:0] _temp_7_T_1 = {io_mul_a, 7'h0}; // @[dut.scala 21:42]
  wire [15:0] temp_7 = io_mul_b[7] ? {{1'd0}, _temp_7_T_1} : 16'h0; // @[dut.scala 21:19]
  reg [15:0] sum1; // @[dut.scala 25:21]
  reg [15:0] sum2; // @[dut.scala 26:21]
  reg [15:0] sum3; // @[dut.scala 27:21]
  reg [15:0] sum4; // @[dut.scala 28:21]
  wire [15:0] _sum1_T_1 = temp_0 + temp_1; // @[dut.scala 31:19]
  wire [15:0] _sum2_T_1 = temp_2 + temp_3; // @[dut.scala 32:19]
  reg [15:0] partial_sum1; // @[dut.scala 35:29]
  wire [15:0] _partial_sum1_T_1 = sum1 + sum2; // @[dut.scala 37:24]
  wire [15:0] _sum3_T_1 = temp_4 + temp_5; // @[dut.scala 39:19]
  wire [15:0] _sum4_T_1 = temp_6 + temp_7; // @[dut.scala 40:19]
  reg [15:0] final_sum; // @[dut.scala 43:26]
  wire [15:0] _final_sum_T_1 = sum3 + sum4; // @[dut.scala 44:37]
  wire [15:0] _final_sum_T_3 = partial_sum1 + _final_sum_T_1; // @[dut.scala 44:29]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire [4:0] _mul_en_out_reg_T_3 = {mul_en_out_reg[3:0],1'h0}; // @[Cat.scala 33:92]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 56:34]
  assign io_mul_out = io_mul_en_out ? final_sum : 16'h0; // @[dut.scala 57:23]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else if (io_mul_en_in) begin // @[dut.scala 47:22]
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 48:20]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_3; // @[dut.scala 52:20]
    end
    if (reset) begin // @[dut.scala 25:21]
      sum1 <= 16'h0; // @[dut.scala 25:21]
    end else begin
      sum1 <= _sum1_T_1; // @[dut.scala 31:8]
    end
    if (reset) begin // @[dut.scala 26:21]
      sum2 <= 16'h0; // @[dut.scala 26:21]
    end else begin
      sum2 <= _sum2_T_1; // @[dut.scala 32:8]
    end
    if (reset) begin // @[dut.scala 27:21]
      sum3 <= 16'h0; // @[dut.scala 27:21]
    end else begin
      sum3 <= _sum3_T_1; // @[dut.scala 39:8]
    end
    if (reset) begin // @[dut.scala 28:21]
      sum4 <= 16'h0; // @[dut.scala 28:21]
    end else begin
      sum4 <= _sum4_T_1; // @[dut.scala 40:8]
    end
    if (reset) begin // @[dut.scala 35:29]
      partial_sum1 <= 16'h0; // @[dut.scala 35:29]
    end else begin
      partial_sum1 <= _partial_sum1_T_1; // @[dut.scala 37:16]
    end
    if (reset) begin // @[dut.scala 43:26]
      final_sum <= 16'h0; // @[dut.scala 43:26]
    end else begin
      final_sum <= _final_sum_T_3; // @[dut.scala 44:13]
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
  sum1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  sum2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  sum3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partial_sum1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  final_sum = _RAND_6[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
