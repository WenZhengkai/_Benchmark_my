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
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] stage1_sum; // @[dut.scala 14:27]
  reg [16:0] stage2_sum; // @[dut.scala 15:27]
  reg [16:0] stage3_sum; // @[dut.scala 16:27]
  reg [16:0] stage4_sum; // @[dut.scala 17:27]
  reg  stage1_en; // @[dut.scala 20:26]
  reg  stage2_en; // @[dut.scala 21:26]
  reg  stage3_en; // @[dut.scala 22:26]
  reg  stage4_en; // @[dut.scala 23:26]
  wire [16:0] sum1 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 27:31]
  wire [16:0] _sum2_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 33:32]
  wire [16:0] _GEN_4 = {{16'd0}, stage1_sum[16]}; // @[dut.scala 33:51]
  wire [16:0] sum2 = _sum2_T_2 + _GEN_4; // @[dut.scala 33:51]
  wire [16:0] _sum3_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 39:32]
  wire [16:0] _GEN_5 = {{16'd0}, stage2_sum[16]}; // @[dut.scala 39:51]
  wire [16:0] sum3 = _sum3_T_2 + _GEN_5; // @[dut.scala 39:51]
  wire [16:0] _sum4_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 45:32]
  wire [16:0] _GEN_6 = {{16'd0}, stage3_sum[16]}; // @[dut.scala 45:51]
  wire [16:0] sum4 = _sum4_T_2 + _GEN_6; // @[dut.scala 45:51]
  wire [31:0] io_result_lo = {stage2_sum[15:0],stage1_sum[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4_sum[16],stage4_sum[15:0],stage3_sum[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = stage4_en; // @[dut.scala 50:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:27]
      stage1_sum <= 17'h0; // @[dut.scala 14:27]
    end else if (io_i_en) begin // @[dut.scala 26:17]
      stage1_sum <= sum1; // @[dut.scala 28:16]
    end
    if (reset) begin // @[dut.scala 15:27]
      stage2_sum <= 17'h0; // @[dut.scala 15:27]
    end else if (stage1_en) begin // @[dut.scala 32:19]
      stage2_sum <= sum2; // @[dut.scala 34:16]
    end
    if (reset) begin // @[dut.scala 16:27]
      stage3_sum <= 17'h0; // @[dut.scala 16:27]
    end else if (stage2_en) begin // @[dut.scala 38:19]
      stage3_sum <= sum3; // @[dut.scala 40:16]
    end
    if (reset) begin // @[dut.scala 17:27]
      stage4_sum <= 17'h0; // @[dut.scala 17:27]
    end else if (stage3_en) begin // @[dut.scala 44:19]
      stage4_sum <= sum4; // @[dut.scala 46:16]
    end
    if (reset) begin // @[dut.scala 20:26]
      stage1_en <= 1'h0; // @[dut.scala 20:26]
    end else begin
      stage1_en <= io_i_en; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 21:26]
      stage2_en <= 1'h0; // @[dut.scala 21:26]
    end else begin
      stage2_en <= stage1_en; // @[dut.scala 21:26]
    end
    if (reset) begin // @[dut.scala 22:26]
      stage3_en <= 1'h0; // @[dut.scala 22:26]
    end else begin
      stage3_en <= stage2_en; // @[dut.scala 22:26]
    end
    if (reset) begin // @[dut.scala 23:26]
      stage4_en <= 1'h0; // @[dut.scala 23:26]
    end else begin
      stage4_en <= stage3_en; // @[dut.scala 23:26]
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
  stage1_sum = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  stage2_sum = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  stage3_sum = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  stage4_sum = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  stage1_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage2_en = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage3_en = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  stage4_en = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
