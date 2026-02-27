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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 19:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_2 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_3 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_4 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_5 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_6 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  wire [7:0] temp_7 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 34:19]
  reg [15:0] sum_1; // @[dut.scala 38:22]
  wire [8:0] _sum_1_T = {temp_1, 1'h0}; // @[dut.scala 41:23]
  wire [8:0] _GEN_5 = {{1'd0}, temp_0}; // @[dut.scala 40:22]
  wire [8:0] _sum_1_T_2 = _GEN_5 + _sum_1_T; // @[dut.scala 40:22]
  wire [9:0] _sum_1_T_3 = {temp_2, 2'h0}; // @[dut.scala 42:23]
  wire [9:0] _GEN_6 = {{1'd0}, _sum_1_T_2}; // @[dut.scala 41:29]
  wire [9:0] _sum_1_T_5 = _GEN_6 + _sum_1_T_3; // @[dut.scala 41:29]
  wire [10:0] _sum_1_T_6 = {temp_3, 3'h0}; // @[dut.scala 43:23]
  wire [10:0] _GEN_7 = {{1'd0}, _sum_1_T_5}; // @[dut.scala 42:29]
  wire [10:0] _sum_1_T_8 = _GEN_7 + _sum_1_T_6; // @[dut.scala 42:29]
  reg [15:0] sum_2; // @[dut.scala 47:22]
  wire [11:0] _sum_2_T = {temp_4, 4'h0}; // @[dut.scala 49:23]
  wire [12:0] _sum_2_T_1 = {temp_5, 5'h0}; // @[dut.scala 50:23]
  wire [12:0] _GEN_8 = {{1'd0}, _sum_2_T}; // @[dut.scala 49:29]
  wire [12:0] _sum_2_T_3 = _GEN_8 + _sum_2_T_1; // @[dut.scala 49:29]
  wire [13:0] _sum_2_T_4 = {temp_6, 6'h0}; // @[dut.scala 51:23]
  wire [13:0] _GEN_9 = {{1'd0}, _sum_2_T_3}; // @[dut.scala 50:29]
  wire [13:0] _sum_2_T_6 = _GEN_9 + _sum_2_T_4; // @[dut.scala 50:29]
  wire [14:0] _sum_2_T_7 = {temp_7, 7'h0}; // @[dut.scala 52:23]
  wire [14:0] _GEN_10 = {{1'd0}, _sum_2_T_6}; // @[dut.scala 51:29]
  wire [14:0] _sum_2_T_9 = _GEN_10 + _sum_2_T_7; // @[dut.scala 51:29]
  reg [15:0] mul_out_reg; // @[dut.scala 56:28]
  wire [15:0] _mul_out_reg_T_1 = sum_1 + sum_2; // @[dut.scala 58:26]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 25:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 62:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 19:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 22:18]
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
    if (reset) begin // @[dut.scala 38:22]
      sum_1 <= 16'h0; // @[dut.scala 38:22]
    end else if (mul_en_out_reg[0]) begin // @[dut.scala 39:27]
      sum_1 <= {{5'd0}, _sum_1_T_8}; // @[dut.scala 40:11]
    end
    if (reset) begin // @[dut.scala 47:22]
      sum_2 <= 16'h0; // @[dut.scala 47:22]
    end else if (mul_en_out_reg[1]) begin // @[dut.scala 48:27]
      sum_2 <= {{1'd0}, _sum_2_T_9}; // @[dut.scala 49:11]
    end
    if (reset) begin // @[dut.scala 56:28]
      mul_out_reg <= 16'h0; // @[dut.scala 56:28]
    end else if (mul_en_out_reg[2]) begin // @[dut.scala 57:27]
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 58:17]
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
  sum_1 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum_2 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  mul_out_reg = _RAND_5[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
