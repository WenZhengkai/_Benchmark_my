module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  i_en_reg; // @[dut.scala 14:26]
  reg [63:0] adda_reg; // @[dut.scala 15:26]
  reg [63:0] addb_reg; // @[dut.scala 16:26]
  wire [16:0] stage0_sum = adda_reg[15:0] + addb_reg[15:0]; // @[dut.scala 29:36]
  wire [15:0] sum0 = stage0_sum[15:0]; // @[dut.scala 30:21]
  wire  carry0 = stage0_sum[16]; // @[dut.scala 31:23]
  wire [16:0] _stage1_sum_T_2 = adda_reg[31:16] + addb_reg[31:16]; // @[dut.scala 34:38]
  wire [16:0] _GEN_0 = {{16'd0}, carry0}; // @[dut.scala 34:59]
  wire [16:0] stage1_sum = _stage1_sum_T_2 + _GEN_0; // @[dut.scala 34:59]
  wire [15:0] sum1 = stage1_sum[15:0]; // @[dut.scala 35:21]
  wire  carry1 = stage1_sum[16]; // @[dut.scala 36:23]
  wire [16:0] _stage2_sum_T_2 = adda_reg[47:32] + addb_reg[47:32]; // @[dut.scala 39:38]
  wire [16:0] _GEN_1 = {{16'd0}, carry1}; // @[dut.scala 39:59]
  wire [16:0] stage2_sum = _stage2_sum_T_2 + _GEN_1; // @[dut.scala 39:59]
  wire [15:0] sum2 = stage2_sum[15:0]; // @[dut.scala 40:21]
  wire  carry2 = stage2_sum[16]; // @[dut.scala 41:23]
  wire [16:0] _stage3_sum_T_2 = adda_reg[63:48] + addb_reg[63:48]; // @[dut.scala 44:38]
  wire [16:0] _GEN_2 = {{16'd0}, carry2}; // @[dut.scala 44:59]
  wire [16:0] stage3_sum = _stage3_sum_T_2 + _GEN_2; // @[dut.scala 44:59]
  wire [15:0] sum3 = stage3_sum[15:0]; // @[dut.scala 45:21]
  wire  carry_out = stage3_sum[16]; // @[dut.scala 46:29]
  reg  o_en_reg; // @[dut.scala 49:25]
  wire [31:0] io_result_lo = {sum1,sum0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry_out,sum3,sum2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = o_en_reg; // @[dut.scala 53:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      i_en_reg <= 1'h0; // @[dut.scala 14:26]
    end else begin
      i_en_reg <= io_i_en; // @[dut.scala 14:26]
    end
    adda_reg <= io_adda; // @[dut.scala 15:26]
    addb_reg <= io_addb; // @[dut.scala 16:26]
    if (reset) begin // @[dut.scala 49:25]
      o_en_reg <= 1'h0; // @[dut.scala 49:25]
    end else begin
      o_en_reg <= i_en_reg; // @[dut.scala 49:25]
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
  i_en_reg = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  adda_reg = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  addb_reg = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  o_en_reg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
