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
  reg  mul_en_out_reg_0; // @[dut.scala 17:31]
  reg  mul_en_out_reg_1; // @[dut.scala 17:31]
  reg  mul_en_out_reg_2; // @[dut.scala 17:31]
  reg  mul_en_out_reg_3; // @[dut.scala 17:31]
  reg  mul_en_out_reg_4; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [7:0] _temp_1_T_1 = mul_b_reg[1] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [8:0] _temp_1_T_2 = {_temp_1_T_1, 1'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_2_T_1 = mul_b_reg[2] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [9:0] _temp_2_T_2 = {_temp_2_T_1, 2'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_3_T_1 = mul_b_reg[3] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [10:0] _temp_3_T_2 = {_temp_3_T_1, 3'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_4_T_1 = mul_b_reg[4] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [11:0] _temp_4_T_2 = {_temp_4_T_1, 4'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_5_T_1 = mul_b_reg[5] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [12:0] _temp_5_T_2 = {_temp_5_T_1, 5'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_6_T_1 = mul_b_reg[6] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [13:0] _temp_6_T_2 = {_temp_6_T_1, 6'h0}; // @[dut.scala 35:50]
  wire [7:0] _temp_7_T_1 = mul_b_reg[7] ? mul_a_reg : 8'h0; // @[dut.scala 35:19]
  wire [14:0] _temp_7_T_2 = {_temp_7_T_1, 7'h0}; // @[dut.scala 35:50]
  wire [7:0] temp_1 = _temp_1_T_2[7:0]; // @[dut.scala 33:18 35:13]
  reg [7:0] sum1_0; // @[dut.scala 39:23]
  wire [7:0] temp_2 = _temp_2_T_2[7:0]; // @[dut.scala 33:18 35:13]
  wire [7:0] temp_3 = _temp_3_T_2[7:0]; // @[dut.scala 33:18 35:13]
  reg [7:0] sum1_1; // @[dut.scala 40:23]
  wire [7:0] temp_4 = _temp_4_T_2[7:0]; // @[dut.scala 33:18 35:13]
  wire [7:0] temp_5 = _temp_5_T_2[7:0]; // @[dut.scala 33:18 35:13]
  reg [7:0] sum1_2; // @[dut.scala 41:23]
  wire [7:0] temp_6 = _temp_6_T_2[7:0]; // @[dut.scala 33:18 35:13]
  wire [7:0] temp_7 = _temp_7_T_2[7:0]; // @[dut.scala 33:18 35:13]
  reg [7:0] sum1_3; // @[dut.scala 42:23]
  reg [7:0] sum2_0; // @[dut.scala 45:23]
  reg [7:0] sum2_1; // @[dut.scala 46:23]
  reg [7:0] mul_out_reg; // @[dut.scala 49:28]
  wire [7:0] _io_mul_out_T = io_mul_en_out ? mul_out_reg : 8'h0; // @[dut.scala 52:20]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 26:17]
  assign io_mul_out = {{8'd0}, _io_mul_out_T}; // @[dut.scala 52:14]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 20:21]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 22:23]
    end
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 17:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 22:23]
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
    sum1_0 <= temp_0 + temp_1; // @[dut.scala 39:32]
    sum1_1 <= temp_2 + temp_3; // @[dut.scala 40:32]
    sum1_2 <= temp_4 + temp_5; // @[dut.scala 41:32]
    sum1_3 <= temp_6 + temp_7; // @[dut.scala 42:32]
    sum2_0 <= sum1_0 + sum1_1; // @[dut.scala 45:31]
    sum2_1 <= sum1_2 + sum1_3; // @[dut.scala 46:31]
    mul_out_reg <= sum2_0 + sum2_1; // @[dut.scala 49:36]
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
  sum1_0 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  sum1_1 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  sum1_2 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  sum1_3 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  sum2_0 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  sum2_1 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  mul_out_reg = _RAND_13[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
