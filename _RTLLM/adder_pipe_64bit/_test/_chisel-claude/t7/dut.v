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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  reg  en_reg; // @[dut.scala 17:23]
  reg  en_reg2; // @[dut.scala 18:24]
  reg  en_reg3; // @[dut.scala 19:24]
  reg  en_reg4; // @[dut.scala 20:24]
  wire [15:0] adda_segments_0 = io_adda[15:0]; // @[dut.scala 36:32]
  wire [15:0] addb_segments_0 = io_addb[15:0]; // @[dut.scala 37:32]
  wire [15:0] adda_segments_1 = io_adda[31:16]; // @[dut.scala 36:32]
  wire [15:0] addb_segments_1 = io_addb[31:16]; // @[dut.scala 37:32]
  wire [15:0] adda_segments_2 = io_adda[47:32]; // @[dut.scala 36:32]
  wire [15:0] addb_segments_2 = io_addb[47:32]; // @[dut.scala 37:32]
  wire [15:0] adda_segments_3 = io_adda[63:48]; // @[dut.scala 36:32]
  wire [15:0] addb_segments_3 = io_addb[63:48]; // @[dut.scala 37:32]
  reg [15:0] sum1; // @[dut.scala 41:21]
  reg  carry1; // @[dut.scala 42:23]
  wire [16:0] temp_sum = adda_segments_0 + addb_segments_0; // @[dut.scala 45:37]
  reg [15:0] sum2; // @[dut.scala 51:21]
  reg  carry2; // @[dut.scala 52:23]
  reg [15:0] sum1_reg; // @[dut.scala 53:25]
  wire [16:0] _temp_sum_T = adda_segments_1 + addb_segments_1; // @[dut.scala 56:37]
  wire [16:0] _GEN_14 = {{16'd0}, carry1}; // @[dut.scala 56:57]
  wire [16:0] temp_sum_1 = _temp_sum_T + _GEN_14; // @[dut.scala 56:57]
  reg [15:0] sum3; // @[dut.scala 63:21]
  reg  carry3; // @[dut.scala 64:23]
  reg [15:0] sum2_reg; // @[dut.scala 65:25]
  reg [15:0] sum1_reg2; // @[dut.scala 66:26]
  wire [16:0] _temp_sum_T_2 = adda_segments_2 + addb_segments_2; // @[dut.scala 69:37]
  wire [16:0] _GEN_15 = {{16'd0}, carry2}; // @[dut.scala 69:57]
  wire [16:0] temp_sum_2 = _temp_sum_T_2 + _GEN_15; // @[dut.scala 69:57]
  reg [15:0] sum4; // @[dut.scala 77:21]
  reg  carry4; // @[dut.scala 78:23]
  reg [15:0] sum3_reg; // @[dut.scala 79:25]
  reg [15:0] sum2_reg2; // @[dut.scala 80:26]
  reg [15:0] sum1_reg3; // @[dut.scala 81:26]
  wire [16:0] _temp_sum_T_4 = adda_segments_3 + addb_segments_3; // @[dut.scala 84:37]
  wire [16:0] _GEN_16 = {{16'd0}, carry3}; // @[dut.scala 84:57]
  wire [16:0] temp_sum_3 = _temp_sum_T_4 + _GEN_16; // @[dut.scala 84:57]
  wire [31:0] io_result_lo = {sum2_reg2,sum1_reg3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry4,sum4,sum3_reg}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_reg4; // @[dut.scala 29:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:23]
      en_reg <= 1'h0; // @[dut.scala 17:23]
    end else begin
      en_reg <= io_i_en; // @[dut.scala 23:10]
    end
    if (reset) begin // @[dut.scala 18:24]
      en_reg2 <= 1'h0; // @[dut.scala 18:24]
    end else begin
      en_reg2 <= en_reg; // @[dut.scala 24:11]
    end
    if (reset) begin // @[dut.scala 19:24]
      en_reg3 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg3 <= en_reg2; // @[dut.scala 25:11]
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg4 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg4 <= en_reg3; // @[dut.scala 26:11]
    end
    if (reset) begin // @[dut.scala 41:21]
      sum1 <= 16'h0; // @[dut.scala 41:21]
    end else if (io_i_en) begin // @[dut.scala 44:18]
      sum1 <= temp_sum[15:0]; // @[dut.scala 46:10]
    end
    if (reset) begin // @[dut.scala 42:23]
      carry1 <= 1'h0; // @[dut.scala 42:23]
    end else if (io_i_en) begin // @[dut.scala 44:18]
      carry1 <= temp_sum[16]; // @[dut.scala 47:12]
    end
    if (reset) begin // @[dut.scala 51:21]
      sum2 <= 16'h0; // @[dut.scala 51:21]
    end else if (en_reg) begin // @[dut.scala 55:17]
      sum2 <= temp_sum_1[15:0]; // @[dut.scala 57:10]
    end
    if (reset) begin // @[dut.scala 52:23]
      carry2 <= 1'h0; // @[dut.scala 52:23]
    end else if (en_reg) begin // @[dut.scala 55:17]
      carry2 <= temp_sum_1[16]; // @[dut.scala 58:12]
    end
    if (reset) begin // @[dut.scala 53:25]
      sum1_reg <= 16'h0; // @[dut.scala 53:25]
    end else if (en_reg) begin // @[dut.scala 55:17]
      sum1_reg <= sum1; // @[dut.scala 59:14]
    end
    if (reset) begin // @[dut.scala 63:21]
      sum3 <= 16'h0; // @[dut.scala 63:21]
    end else if (en_reg2) begin // @[dut.scala 68:18]
      sum3 <= temp_sum_2[15:0]; // @[dut.scala 70:10]
    end
    if (reset) begin // @[dut.scala 64:23]
      carry3 <= 1'h0; // @[dut.scala 64:23]
    end else if (en_reg2) begin // @[dut.scala 68:18]
      carry3 <= temp_sum_2[16]; // @[dut.scala 71:12]
    end
    if (reset) begin // @[dut.scala 65:25]
      sum2_reg <= 16'h0; // @[dut.scala 65:25]
    end else if (en_reg2) begin // @[dut.scala 68:18]
      sum2_reg <= sum2; // @[dut.scala 72:14]
    end
    if (reset) begin // @[dut.scala 66:26]
      sum1_reg2 <= 16'h0; // @[dut.scala 66:26]
    end else if (en_reg2) begin // @[dut.scala 68:18]
      sum1_reg2 <= sum1_reg; // @[dut.scala 73:15]
    end
    if (reset) begin // @[dut.scala 77:21]
      sum4 <= 16'h0; // @[dut.scala 77:21]
    end else if (en_reg3) begin // @[dut.scala 83:18]
      sum4 <= temp_sum_3[15:0]; // @[dut.scala 85:10]
    end
    if (reset) begin // @[dut.scala 78:23]
      carry4 <= 1'h0; // @[dut.scala 78:23]
    end else if (en_reg3) begin // @[dut.scala 83:18]
      carry4 <= temp_sum_3[16]; // @[dut.scala 86:12]
    end
    if (reset) begin // @[dut.scala 79:25]
      sum3_reg <= 16'h0; // @[dut.scala 79:25]
    end else if (en_reg3) begin // @[dut.scala 83:18]
      sum3_reg <= sum3; // @[dut.scala 87:14]
    end
    if (reset) begin // @[dut.scala 80:26]
      sum2_reg2 <= 16'h0; // @[dut.scala 80:26]
    end else if (en_reg3) begin // @[dut.scala 83:18]
      sum2_reg2 <= sum2_reg; // @[dut.scala 88:15]
    end
    if (reset) begin // @[dut.scala 81:26]
      sum1_reg3 <= 16'h0; // @[dut.scala 81:26]
    end else if (en_reg3) begin // @[dut.scala 83:18]
      sum1_reg3 <= sum1_reg2; // @[dut.scala 89:15]
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
  en_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en_reg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en_reg3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_reg4 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sum1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  carry1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sum2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carry2 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sum1_reg = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  carry3 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sum2_reg = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum1_reg2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum4 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  carry4 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sum3_reg = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  sum2_reg2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sum1_reg3 = _RAND_17[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
