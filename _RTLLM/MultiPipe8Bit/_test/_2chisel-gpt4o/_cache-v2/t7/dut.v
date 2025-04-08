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
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  reg [7:0] mul_a_reg; // @[dut.scala 15:26]
  reg [7:0] mul_b_reg; // @[dut.scala 16:26]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire [7:0] _partialProducts_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 30:30]
  wire [8:0] _partialProducts_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 30:55]
  wire [8:0] _partialProducts_1_T_2 = mul_b_reg[1] ? _partialProducts_1_T_1 : 9'h0; // @[dut.scala 30:30]
  wire [9:0] _partialProducts_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 30:55]
  wire [9:0] _partialProducts_2_T_2 = mul_b_reg[2] ? _partialProducts_2_T_1 : 10'h0; // @[dut.scala 30:30]
  wire [10:0] _partialProducts_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 30:55]
  wire [10:0] _partialProducts_3_T_2 = mul_b_reg[3] ? _partialProducts_3_T_1 : 11'h0; // @[dut.scala 30:30]
  wire [11:0] _partialProducts_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 30:55]
  wire [11:0] _partialProducts_4_T_2 = mul_b_reg[4] ? _partialProducts_4_T_1 : 12'h0; // @[dut.scala 30:30]
  wire [12:0] _partialProducts_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 30:55]
  wire [12:0] _partialProducts_5_T_2 = mul_b_reg[5] ? _partialProducts_5_T_1 : 13'h0; // @[dut.scala 30:30]
  wire [13:0] _partialProducts_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 30:55]
  wire [13:0] _partialProducts_6_T_2 = mul_b_reg[6] ? _partialProducts_6_T_1 : 14'h0; // @[dut.scala 30:30]
  wire [14:0] _partialProducts_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 30:55]
  wire [14:0] _partialProducts_7_T_2 = mul_b_reg[7] ? _partialProducts_7_T_1 : 15'h0; // @[dut.scala 30:30]
  reg [15:0] sumStages_0; // @[dut.scala 34:22]
  reg [15:0] sumStages_1; // @[dut.scala 34:22]
  reg [15:0] sumStages_2; // @[dut.scala 34:22]
  reg [15:0] sumStages_3; // @[dut.scala 34:22]
  wire [15:0] partialProducts_0 = {{8'd0}, _partialProducts_0_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_1 = {{7'd0}, _partialProducts_1_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_2 = {{6'd0}, _partialProducts_2_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_3 = {{5'd0}, _partialProducts_3_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] stage2Sum = sumStages_0 + sumStages_1; // @[dut.scala 43:32]
  wire [15:0] partialProducts_4 = {{4'd0}, _partialProducts_4_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_5 = {{3'd0}, _partialProducts_5_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_6 = {{2'd0}, _partialProducts_6_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] partialProducts_7 = {{1'd0}, _partialProducts_7_T_2}; // @[dut.scala 28:29 30:24]
  wire [15:0] stage3Sum = sumStages_2 + sumStages_3; // @[dut.scala 49:32]
  reg [15:0] mul_out_reg; // @[dut.scala 52:28]
  wire [15:0] _mul_out_reg_T_1 = stage2Sum + stage3Sum; // @[dut.scala 53:28]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 56:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 59:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 19:18]
    end
    if (reset) begin // @[dut.scala 15:26]
      mul_a_reg <= 8'h0; // @[dut.scala 15:26]
    end else if (io_mul_en_in) begin // @[dut.scala 22:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 23:15]
    end
    if (reset) begin // @[dut.scala 16:26]
      mul_b_reg <= 8'h0; // @[dut.scala 16:26]
    end else if (io_mul_en_in) begin // @[dut.scala 22:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 24:15]
    end
    sumStages_0 <= partialProducts_0 + partialProducts_1; // @[dut.scala 37:38]
    sumStages_1 <= partialProducts_2 + partialProducts_3; // @[dut.scala 40:38]
    sumStages_2 <= partialProducts_4 + partialProducts_5; // @[dut.scala 46:38]
    sumStages_3 <= partialProducts_6 + partialProducts_7; // @[dut.scala 47:38]
    if (reset) begin // @[dut.scala 52:28]
      mul_out_reg <= 16'h0; // @[dut.scala 52:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 53:15]
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
  sumStages_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sumStages_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sumStages_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sumStages_3 = _RAND_6[15:0];
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
