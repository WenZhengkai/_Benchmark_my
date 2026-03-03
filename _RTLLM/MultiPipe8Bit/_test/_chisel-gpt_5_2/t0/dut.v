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
  reg [4:0] mul_en_out_reg; // @[dut.scala 34:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] a16; // @[dut.scala 41:26]
  reg [7:0] mul_b_reg; // @[dut.scala 42:26]
  wire [15:0] temp_0 = mul_b_reg[0] ? {{8'd0}, a16} : 16'h0; // @[dut.scala 56:19]
  wire [8:0] pp_1 = {a16, 1'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_1 = mul_b_reg[1] ? {{7'd0}, pp_1} : 16'h0; // @[dut.scala 56:19]
  wire [9:0] pp_2 = {a16, 2'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_2 = mul_b_reg[2] ? {{6'd0}, pp_2} : 16'h0; // @[dut.scala 56:19]
  wire [10:0] pp_3 = {a16, 3'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_3 = mul_b_reg[3] ? {{5'd0}, pp_3} : 16'h0; // @[dut.scala 56:19]
  wire [11:0] pp_4 = {a16, 4'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_4 = mul_b_reg[4] ? {{4'd0}, pp_4} : 16'h0; // @[dut.scala 56:19]
  wire [12:0] pp_5 = {a16, 5'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_5 = mul_b_reg[5] ? {{3'd0}, pp_5} : 16'h0; // @[dut.scala 56:19]
  wire [13:0] pp_6 = {a16, 6'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_6 = mul_b_reg[6] ? {{2'd0}, pp_6} : 16'h0; // @[dut.scala 56:19]
  wire [14:0] pp_7 = {a16, 7'h0}; // @[dut.scala 55:19]
  wire [15:0] temp_7 = mul_b_reg[7] ? {{1'd0}, pp_7} : 16'h0; // @[dut.scala 56:19]
  reg [15:0] sum_0; // @[dut.scala 63:20]
  reg [15:0] sum_1; // @[dut.scala 63:20]
  reg [15:0] sum_2; // @[dut.scala 63:20]
  reg [15:0] sum_3; // @[dut.scala 63:20]
  wire [15:0] _sum_0_T_1 = temp_0 + temp_1; // @[dut.scala 66:21]
  wire [15:0] _sum_1_T_1 = temp_2 + temp_3; // @[dut.scala 67:21]
  wire [15:0] _sum_2_T_1 = temp_4 + temp_5; // @[dut.scala 68:21]
  wire [15:0] _sum_3_T_1 = temp_6 + temp_7; // @[dut.scala 69:21]
  reg [15:0] mul_out_reg; // @[dut.scala 74:28]
  wire [15:0] _mul_out_reg_T_1 = sum_0 + sum_1; // @[dut.scala 75:26]
  wire [15:0] _mul_out_reg_T_3 = sum_2 + sum_3; // @[dut.scala 75:46]
  wire [15:0] _mul_out_reg_T_5 = _mul_out_reg_T_1 + _mul_out_reg_T_3; // @[dut.scala 75:36]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 36:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 80:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 34:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 34:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 35:18]
    end
    if (reset) begin // @[dut.scala 41:26]
      a16 <= 8'h0; // @[dut.scala 41:26]
    end else if (io_mul_en_in) begin // @[dut.scala 43:22]
      a16 <= io_mul_a; // @[dut.scala 44:15]
    end
    if (reset) begin // @[dut.scala 42:26]
      mul_b_reg <= 8'h0; // @[dut.scala 42:26]
    end else if (io_mul_en_in) begin // @[dut.scala 43:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 45:15]
    end
    if (reset) begin // @[dut.scala 63:20]
      sum_0 <= 16'h0; // @[dut.scala 63:20]
    end else begin
      sum_0 <= _sum_0_T_1; // @[dut.scala 66:10]
    end
    if (reset) begin // @[dut.scala 63:20]
      sum_1 <= 16'h0; // @[dut.scala 63:20]
    end else begin
      sum_1 <= _sum_1_T_1; // @[dut.scala 67:10]
    end
    if (reset) begin // @[dut.scala 63:20]
      sum_2 <= 16'h0; // @[dut.scala 63:20]
    end else begin
      sum_2 <= _sum_2_T_1; // @[dut.scala 68:10]
    end
    if (reset) begin // @[dut.scala 63:20]
      sum_3 <= 16'h0; // @[dut.scala 63:20]
    end else begin
      sum_3 <= _sum_3_T_1; // @[dut.scala 69:10]
    end
    if (reset) begin // @[dut.scala 74:28]
      mul_out_reg <= 16'h0; // @[dut.scala 74:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_5; // @[dut.scala 75:15]
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
  a16 = _RAND_1[7:0];
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
