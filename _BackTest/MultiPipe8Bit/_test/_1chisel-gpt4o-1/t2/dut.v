module dut(
  input         clock,
  input         reset,
  input         io_clk,
  input         io_rst_n,
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
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg; // @[dut.scala 17:31]
  reg [7:0] mul_a_reg; // @[dut.scala 18:31]
  reg [7:0] mul_b_reg; // @[dut.scala 19:31]
  reg [15:0] mul_out_reg; // @[dut.scala 20:31]
  wire [15:0] _GEN_6 = ~io_rst_n ? 16'h0 : mul_out_reg; // @[dut.scala 23:19 27:20 20:31]
  wire [7:0] _partialProducts_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 42:30]
  wire [8:0] _partialProducts_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 42:55]
  wire [8:0] _partialProducts_1_T_2 = mul_b_reg[1] ? _partialProducts_1_T_1 : 9'h0; // @[dut.scala 42:30]
  wire [9:0] _partialProducts_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 42:55]
  wire [9:0] _partialProducts_2_T_2 = mul_b_reg[2] ? _partialProducts_2_T_1 : 10'h0; // @[dut.scala 42:30]
  wire [10:0] _partialProducts_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 42:55]
  wire [10:0] _partialProducts_3_T_2 = mul_b_reg[3] ? _partialProducts_3_T_1 : 11'h0; // @[dut.scala 42:30]
  wire [11:0] _partialProducts_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 42:55]
  wire [11:0] _partialProducts_4_T_2 = mul_b_reg[4] ? _partialProducts_4_T_1 : 12'h0; // @[dut.scala 42:30]
  wire [12:0] _partialProducts_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 42:55]
  wire [12:0] _partialProducts_5_T_2 = mul_b_reg[5] ? _partialProducts_5_T_1 : 13'h0; // @[dut.scala 42:30]
  wire [13:0] _partialProducts_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 42:55]
  wire [13:0] _partialProducts_6_T_2 = mul_b_reg[6] ? _partialProducts_6_T_1 : 14'h0; // @[dut.scala 42:30]
  wire [14:0] _partialProducts_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 42:55]
  wire [14:0] _partialProducts_7_T_2 = mul_b_reg[7] ? _partialProducts_7_T_1 : 15'h0; // @[dut.scala 42:30]
  wire [15:0] partialProducts_0 = {{8'd0}, _partialProducts_0_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] partialProducts_1 = {{7'd0}, _partialProducts_1_T_2}; // @[dut.scala 40:29 42:24]
  wire [16:0] _partialSum_T = partialProducts_0 + partialProducts_1; // @[dut.scala 46:45]
  wire [15:0] partialProducts_2 = {{6'd0}, _partialProducts_2_T_2}; // @[dut.scala 40:29 42:24]
  wire [16:0] _GEN_8 = {{1'd0}, partialProducts_2}; // @[dut.scala 46:45]
  wire [17:0] _partialSum_T_1 = _partialSum_T + _GEN_8; // @[dut.scala 46:45]
  wire [15:0] partialProducts_3 = {{5'd0}, _partialProducts_3_T_2}; // @[dut.scala 40:29 42:24]
  wire [17:0] _GEN_9 = {{2'd0}, partialProducts_3}; // @[dut.scala 46:45]
  wire [18:0] _partialSum_T_2 = _partialSum_T_1 + _GEN_9; // @[dut.scala 46:45]
  wire [15:0] partialProducts_4 = {{4'd0}, _partialProducts_4_T_2}; // @[dut.scala 40:29 42:24]
  wire [18:0] _GEN_10 = {{3'd0}, partialProducts_4}; // @[dut.scala 46:45]
  wire [19:0] _partialSum_T_3 = _partialSum_T_2 + _GEN_10; // @[dut.scala 46:45]
  wire [15:0] partialProducts_5 = {{3'd0}, _partialProducts_5_T_2}; // @[dut.scala 40:29 42:24]
  wire [19:0] _GEN_11 = {{4'd0}, partialProducts_5}; // @[dut.scala 46:45]
  wire [20:0] _partialSum_T_4 = _partialSum_T_3 + _GEN_11; // @[dut.scala 46:45]
  wire [15:0] partialProducts_6 = {{2'd0}, _partialProducts_6_T_2}; // @[dut.scala 40:29 42:24]
  wire [20:0] _GEN_12 = {{5'd0}, partialProducts_6}; // @[dut.scala 46:45]
  wire [21:0] _partialSum_T_5 = _partialSum_T_4 + _GEN_12; // @[dut.scala 46:45]
  wire [15:0] partialProducts_7 = {{1'd0}, _partialProducts_7_T_2}; // @[dut.scala 40:29 42:24]
  wire [21:0] _GEN_13 = {{6'd0}, partialProducts_7}; // @[dut.scala 46:45]
  wire [22:0] partialSum = _partialSum_T_5 + _GEN_13; // @[dut.scala 46:45]
  wire [22:0] _GEN_7 = io_mul_en_in ? partialSum : {{7'd0}, _GEN_6}; // @[dut.scala 49:22 50:17]
  wire [22:0] _GEN_14 = reset ? 23'h0 : _GEN_7; // @[dut.scala 20:{31,31}]
  assign io_mul_en_out = mul_en_out_reg; // @[dut.scala 54:17]
  assign io_mul_out = mul_out_reg; // @[dut.scala 55:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:31]
      mul_en_out_reg <= 1'h0; // @[dut.scala 17:31]
    end else if (~io_rst_n) begin // @[dut.scala 23:19]
      mul_en_out_reg <= 1'h0; // @[dut.scala 24:20]
    end else begin
      mul_en_out_reg <= io_mul_en_in;
    end
    if (reset) begin // @[dut.scala 18:31]
      mul_a_reg <= 8'h0; // @[dut.scala 18:31]
    end else if (~io_rst_n) begin // @[dut.scala 23:19]
      mul_a_reg <= 8'h0; // @[dut.scala 25:20]
    end else if (io_mul_en_in) begin // @[dut.scala 30:24]
      mul_a_reg <= io_mul_a; // @[dut.scala 32:22]
    end
    if (reset) begin // @[dut.scala 19:31]
      mul_b_reg <= 8'h0; // @[dut.scala 19:31]
    end else if (~io_rst_n) begin // @[dut.scala 23:19]
      mul_b_reg <= 8'h0; // @[dut.scala 26:20]
    end else if (io_mul_en_in) begin // @[dut.scala 30:24]
      mul_b_reg <= io_mul_b; // @[dut.scala 33:22]
    end
    mul_out_reg <= _GEN_14[15:0]; // @[dut.scala 20:{31,31}]
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
  mul_en_out_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  mul_out_reg = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
