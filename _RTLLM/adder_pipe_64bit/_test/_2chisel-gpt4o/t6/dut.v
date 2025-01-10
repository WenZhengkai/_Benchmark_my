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
  reg [95:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] stage1_out_sum; // @[dut.scala 14:31]
  reg [32:0] stage2_out_sum; // @[dut.scala 15:31]
  reg [48:0] stage3_out_sum; // @[dut.scala 16:31]
  reg [64:0] stage4_out_sum; // @[dut.scala 17:31]
  reg  stage1_en; // @[dut.scala 19:26]
  reg  stage2_en; // @[dut.scala 20:26]
  reg  stage3_en; // @[dut.scala 21:26]
  reg  stage4_en; // @[dut.scala 22:26]
  wire [16:0] stage1_sum = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 24:35]
  wire [16:0] _stage2_sum_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 25:36]
  wire [16:0] _GEN_4 = {{16'd0}, stage1_out_sum[16]}; // @[dut.scala 25:55]
  wire [16:0] stage2_sum = _stage2_sum_T_2 + _GEN_4; // @[dut.scala 25:55]
  wire [16:0] _stage3_sum_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 26:36]
  wire [16:0] _GEN_5 = {{16'd0}, stage2_out_sum[32]}; // @[dut.scala 26:55]
  wire [16:0] stage3_sum = _stage3_sum_T_2 + _GEN_5; // @[dut.scala 26:55]
  wire [16:0] _stage4_sum_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 27:36]
  wire [16:0] _GEN_6 = {{16'd0}, stage3_out_sum[48]}; // @[dut.scala 27:55]
  wire [16:0] stage4_sum = _stage4_sum_T_2 + _GEN_6; // @[dut.scala 27:55]
  wire [32:0] _stage2_out_sum_T_2 = {stage2_sum,stage1_out_sum[15:0]}; // @[Cat.scala 33:92]
  wire [48:0] _stage3_out_sum_T_2 = {stage3_sum,stage2_out_sum[31:0]}; // @[Cat.scala 33:92]
  wire [64:0] _stage4_out_sum_T_2 = {stage4_sum,stage3_out_sum[47:0]}; // @[Cat.scala 33:92]
  assign io_result = stage4_out_sum; // @[dut.scala 45:13]
  assign io_o_en = stage4_en; // @[dut.scala 46:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      stage1_out_sum <= 17'h0; // @[dut.scala 14:31]
    end else if (io_i_en) begin // @[dut.scala 29:17]
      stage1_out_sum <= stage1_sum; // @[dut.scala 30:20]
    end
    if (reset) begin // @[dut.scala 15:31]
      stage2_out_sum <= 33'h0; // @[dut.scala 15:31]
    end else if (stage1_en) begin // @[dut.scala 33:19]
      stage2_out_sum <= _stage2_out_sum_T_2; // @[dut.scala 34:20]
    end
    if (reset) begin // @[dut.scala 16:31]
      stage3_out_sum <= 49'h0; // @[dut.scala 16:31]
    end else if (stage2_en) begin // @[dut.scala 37:19]
      stage3_out_sum <= _stage3_out_sum_T_2; // @[dut.scala 38:20]
    end
    if (reset) begin // @[dut.scala 17:31]
      stage4_out_sum <= 65'h0; // @[dut.scala 17:31]
    end else if (stage3_en) begin // @[dut.scala 41:19]
      stage4_out_sum <= _stage4_out_sum_T_2; // @[dut.scala 42:20]
    end
    if (reset) begin // @[dut.scala 19:26]
      stage1_en <= 1'h0; // @[dut.scala 19:26]
    end else begin
      stage1_en <= io_i_en; // @[dut.scala 19:26]
    end
    if (reset) begin // @[dut.scala 20:26]
      stage2_en <= 1'h0; // @[dut.scala 20:26]
    end else begin
      stage2_en <= stage1_en; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 21:26]
      stage3_en <= 1'h0; // @[dut.scala 21:26]
    end else begin
      stage3_en <= stage2_en; // @[dut.scala 21:26]
    end
    if (reset) begin // @[dut.scala 22:26]
      stage4_en <= 1'h0; // @[dut.scala 22:26]
    end else begin
      stage4_en <= stage3_en; // @[dut.scala 22:26]
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
  stage1_out_sum = _RAND_0[16:0];
  _RAND_1 = {2{`RANDOM}};
  stage2_out_sum = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  stage3_out_sum = _RAND_2[48:0];
  _RAND_3 = {3{`RANDOM}};
  stage4_out_sum = _RAND_3[64:0];
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
