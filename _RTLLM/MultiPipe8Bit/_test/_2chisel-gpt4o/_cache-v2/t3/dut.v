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
  reg [4:0] mul_en_pipeline; // @[dut.scala 19:32]
  reg [7:0] mul_a_reg; // @[dut.scala 20:22]
  reg [7:0] mul_b_reg; // @[dut.scala 21:22]
  reg [15:0] partial_sums_0; // @[dut.scala 25:25]
  reg [15:0] partial_sums_1; // @[dut.scala 25:25]
  reg [15:0] partial_sums_2; // @[dut.scala 25:25]
  reg [15:0] partial_sums_3; // @[dut.scala 25:25]
  reg [15:0] mul_out_reg; // @[dut.scala 28:28]
  wire [4:0] _mul_en_pipeline_T_1 = {mul_en_pipeline[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  wire [15:0] partial_products_0 = mul_b_reg[0] ? {{8'd0}, mul_a_reg} : 16'h0; // @[dut.scala 41:31]
  wire [8:0] _partial_products_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_1 = mul_b_reg[1] ? {{7'd0}, _partial_products_1_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [9:0] _partial_products_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_2 = mul_b_reg[2] ? {{6'd0}, _partial_products_2_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [10:0] _partial_products_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_3 = mul_b_reg[3] ? {{5'd0}, _partial_products_3_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [11:0] _partial_products_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_4 = mul_b_reg[4] ? {{4'd0}, _partial_products_4_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [12:0] _partial_products_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_5 = mul_b_reg[5] ? {{3'd0}, _partial_products_5_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [13:0] _partial_products_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_6 = mul_b_reg[6] ? {{2'd0}, _partial_products_6_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [14:0] _partial_products_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 41:56]
  wire [15:0] partial_products_7 = mul_b_reg[7] ? {{1'd0}, _partial_products_7_T_1} : 16'h0; // @[dut.scala 41:31]
  wire [15:0] _mul_out_reg_T_1 = partial_sums_0 + partial_sums_1; // @[dut.scala 51:34]
  wire [15:0] _mul_out_reg_T_3 = _mul_out_reg_T_1 + partial_sums_2; // @[dut.scala 51:52]
  wire [15:0] _mul_out_reg_T_5 = _mul_out_reg_T_3 + partial_sums_3; // @[dut.scala 51:70]
  assign io_mul_en_out = mul_en_pipeline[4]; // @[dut.scala 55:35]
  assign io_mul_out = mul_en_pipeline[4] ? mul_out_reg : 16'h0; // @[dut.scala 54:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:32]
      mul_en_pipeline <= 5'h0; // @[dut.scala 19:32]
    end else begin
      mul_en_pipeline <= _mul_en_pipeline_T_1; // @[dut.scala 37:19]
    end
    if (io_mul_en_in) begin // @[dut.scala 31:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 32:15]
    end
    if (io_mul_en_in) begin // @[dut.scala 31:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 33:15]
    end
    partial_sums_0 <= partial_products_0 + partial_products_1; // @[dut.scala 45:42]
    partial_sums_1 <= partial_products_2 + partial_products_3; // @[dut.scala 46:42]
    partial_sums_2 <= partial_products_4 + partial_products_5; // @[dut.scala 47:42]
    partial_sums_3 <= partial_products_6 + partial_products_7; // @[dut.scala 48:42]
    if (reset) begin // @[dut.scala 28:28]
      mul_out_reg <= 16'h0; // @[dut.scala 28:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_5; // @[dut.scala 51:15]
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
  mul_en_pipeline = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  partial_sums_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  partial_sums_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partial_sums_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partial_sums_3 = _RAND_6[15:0];
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
