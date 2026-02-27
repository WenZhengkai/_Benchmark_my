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
  reg  mul_en_out_reg_0; // @[dut.scala 17:31]
  reg  mul_en_out_reg_1; // @[dut.scala 17:31]
  reg  mul_en_out_reg_2; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[dut.scala 20:26]
  reg [7:0] mul_b_reg; // @[dut.scala 21:26]
  reg [15:0] sum_0; // @[dut.scala 27:16]
  reg [15:0] sum_1; // @[dut.scala 27:16]
  reg [15:0] mul_out_reg; // @[dut.scala 28:28]
  wire [7:0] _temp_0_T_1 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [7:0] _temp_1_T_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [8:0] temp_1 = {_temp_1_T_1, 1'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_2_T_1 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [9:0] _temp_2_T_2 = {_temp_2_T_1, 2'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_3_T_1 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [10:0] _temp_3_T_2 = {_temp_3_T_1, 3'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_4_T_1 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [11:0] _temp_4_T_2 = {_temp_4_T_1, 4'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_5_T_1 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [12:0] _temp_5_T_2 = {_temp_5_T_1, 5'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_6_T_1 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [13:0] _temp_6_T_2 = {_temp_6_T_1, 6'h0}; // @[dut.scala 45:50]
  wire [7:0] _temp_7_T_1 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 45:19]
  wire [14:0] _temp_7_T_2 = {_temp_7_T_1, 7'h0}; // @[dut.scala 45:50]
  wire [8:0] temp_0 = {{1'd0}, _temp_0_T_1}; // @[dut.scala 24:18 45:13]
  wire [9:0] _sum_0_T = temp_0 + temp_1; // @[dut.scala 50:23]
  wire [8:0] temp_2 = _temp_2_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [9:0] _GEN_5 = {{1'd0}, temp_2}; // @[dut.scala 50:34]
  wire [10:0] _sum_0_T_1 = _sum_0_T + _GEN_5; // @[dut.scala 50:34]
  wire [8:0] temp_3 = _temp_3_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [10:0] _GEN_6 = {{2'd0}, temp_3}; // @[dut.scala 50:45]
  wire [11:0] _sum_0_T_2 = _sum_0_T_1 + _GEN_6; // @[dut.scala 50:45]
  wire [8:0] temp_4 = _temp_4_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [8:0] temp_5 = _temp_5_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [9:0] _sum_1_T = temp_4 + temp_5; // @[dut.scala 51:23]
  wire [8:0] temp_6 = _temp_6_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [9:0] _GEN_7 = {{1'd0}, temp_6}; // @[dut.scala 51:34]
  wire [10:0] _sum_1_T_1 = _sum_1_T + _GEN_7; // @[dut.scala 51:34]
  wire [8:0] temp_7 = _temp_7_T_2[8:0]; // @[dut.scala 24:18 45:13]
  wire [10:0] _GEN_8 = {{2'd0}, temp_7}; // @[dut.scala 51:45]
  wire [11:0] _sum_1_T_2 = _sum_1_T_1 + _GEN_8; // @[dut.scala 51:45]
  wire [11:0] _GEN_2 = mul_en_out_reg_0 ? _sum_0_T_2 : 12'h0; // @[dut.scala 49:27 50:12 53:12]
  wire [11:0] _GEN_3 = mul_en_out_reg_0 ? _sum_1_T_2 : 12'h0; // @[dut.scala 49:27 51:12 54:12]
  wire [16:0] _mul_out_reg_T = sum_0 + sum_1; // @[dut.scala 59:27]
  wire [16:0] _GEN_4 = mul_en_out_reg_1 ? _mul_out_reg_T : 17'h0; // @[dut.scala 58:27 59:17 61:17]
  wire [16:0] _GEN_9 = reset ? 17'h0 : _GEN_4; // @[dut.scala 28:{28,28}]
  assign io_mul_en_out = mul_en_out_reg_2; // @[dut.scala 35:17]
  assign io_mul_out = mul_en_out_reg_2 ? mul_out_reg : 16'h0; // @[dut.scala 65:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 31:21]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 33:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 33:23]
    end
    if (reset) begin // @[dut.scala 20:26]
      mul_a_reg <= 8'h0; // @[dut.scala 20:26]
    end else if (io_mul_en_in) begin // @[dut.scala 38:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 39:15]
    end
    if (reset) begin // @[dut.scala 21:26]
      mul_b_reg <= 8'h0; // @[dut.scala 21:26]
    end else if (io_mul_en_in) begin // @[dut.scala 38:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 40:15]
    end
    sum_0 <= {{4'd0}, _GEN_2};
    sum_1 <= {{4'd0}, _GEN_3};
    mul_out_reg <= _GEN_9[15:0]; // @[dut.scala 28:{28,28}]
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
  mul_a_reg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  mul_b_reg = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  sum_0 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum_1 = _RAND_6[15:0];
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
