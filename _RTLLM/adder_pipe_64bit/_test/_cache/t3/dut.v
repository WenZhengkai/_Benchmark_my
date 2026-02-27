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
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [95:0] _RAND_25;
`endif // RANDOMIZE_REG_INIT
  reg  reg_en_1; // @[dut.scala 17:25]
  reg  reg_en_2; // @[dut.scala 18:25]
  reg  reg_en_3; // @[dut.scala 19:25]
  reg  reg_en_4; // @[dut.scala 20:25]
  wire [15:0] adda_parts_0 = io_adda[15:0]; // @[dut.scala 36:29]
  wire [15:0] addb_parts_0 = io_addb[15:0]; // @[dut.scala 37:29]
  wire [15:0] adda_parts_1 = io_adda[31:16]; // @[dut.scala 36:29]
  wire [15:0] addb_parts_1 = io_addb[31:16]; // @[dut.scala 37:29]
  wire [15:0] adda_parts_2 = io_adda[47:32]; // @[dut.scala 36:29]
  wire [15:0] addb_parts_2 = io_addb[47:32]; // @[dut.scala 37:29]
  wire [15:0] adda_parts_3 = io_adda[63:48]; // @[dut.scala 36:29]
  wire [15:0] addb_parts_3 = io_addb[63:48]; // @[dut.scala 37:29]
  wire [16:0] temp_sum_stage1 = adda_parts_0 + addb_parts_0; // @[dut.scala 43:39]
  wire [15:0] sum_stage1 = temp_sum_stage1[15:0]; // @[dut.scala 44:32]
  wire  carry_stage1 = temp_sum_stage1[16]; // @[dut.scala 45:34]
  reg [15:0] reg_sum_stage1; // @[dut.scala 48:31]
  reg  reg_carry_stage1; // @[dut.scala 49:33]
  reg [15:0] reg_adda_parts_1_0; // @[dut.scala 50:33]
  reg [15:0] reg_adda_parts_1_1; // @[dut.scala 50:33]
  reg [15:0] reg_adda_parts_1_2; // @[dut.scala 50:33]
  reg [15:0] reg_addb_parts_1_0; // @[dut.scala 51:33]
  reg [15:0] reg_addb_parts_1_1; // @[dut.scala 51:33]
  reg [15:0] reg_addb_parts_1_2; // @[dut.scala 51:33]
  wire [16:0] _temp_sum_stage2_T = reg_adda_parts_1_0 + reg_addb_parts_1_0; // @[dut.scala 65:45]
  wire [16:0] _GEN_22 = {{16'd0}, reg_carry_stage1}; // @[dut.scala 65:68]
  wire [16:0] temp_sum_stage2 = _temp_sum_stage2_T + _GEN_22; // @[dut.scala 65:68]
  wire [15:0] sum_stage2 = temp_sum_stage2[15:0]; // @[dut.scala 66:32]
  wire  carry_stage2 = temp_sum_stage2[16]; // @[dut.scala 67:34]
  reg [15:0] reg_sum_stage1_2; // @[dut.scala 70:33]
  reg [15:0] reg_sum_stage2; // @[dut.scala 71:31]
  reg  reg_carry_stage2; // @[dut.scala 72:33]
  reg [15:0] reg_adda_parts_2_0; // @[dut.scala 73:33]
  reg [15:0] reg_adda_parts_2_1; // @[dut.scala 73:33]
  reg [15:0] reg_addb_parts_2_0; // @[dut.scala 74:33]
  reg [15:0] reg_addb_parts_2_1; // @[dut.scala 74:33]
  wire [16:0] _temp_sum_stage3_T = reg_adda_parts_2_0 + reg_addb_parts_2_0; // @[dut.scala 89:45]
  wire [16:0] _GEN_23 = {{16'd0}, reg_carry_stage2}; // @[dut.scala 89:68]
  wire [16:0] temp_sum_stage3 = _temp_sum_stage3_T + _GEN_23; // @[dut.scala 89:68]
  wire [15:0] sum_stage3 = temp_sum_stage3[15:0]; // @[dut.scala 90:32]
  wire  carry_stage3 = temp_sum_stage3[16]; // @[dut.scala 91:34]
  reg [15:0] reg_sum_stage1_3; // @[dut.scala 94:33]
  reg [15:0] reg_sum_stage2_3; // @[dut.scala 95:33]
  reg [15:0] reg_sum_stage3; // @[dut.scala 96:31]
  reg  reg_carry_stage3; // @[dut.scala 97:33]
  reg [15:0] reg_adda_parts_3; // @[dut.scala 98:33]
  reg [15:0] reg_addb_parts_3; // @[dut.scala 99:33]
  wire [16:0] _temp_sum_stage4_T = reg_adda_parts_3 + reg_addb_parts_3; // @[dut.scala 113:42]
  wire [16:0] _GEN_24 = {{16'd0}, reg_carry_stage3}; // @[dut.scala 113:62]
  wire [16:0] temp_sum_stage4 = _temp_sum_stage4_T + _GEN_24; // @[dut.scala 113:62]
  wire [15:0] sum_stage4 = temp_sum_stage4[15:0]; // @[dut.scala 114:32]
  wire  carry_stage4 = temp_sum_stage4[16]; // @[dut.scala 115:34]
  reg [64:0] reg_result; // @[dut.scala 118:27]
  wire [64:0] _reg_result_T = {carry_stage4,sum_stage4,reg_sum_stage3,reg_sum_stage2_3,reg_sum_stage1_3}; // @[Cat.scala 33:92]
  assign io_result = reg_result; // @[dut.scala 125:13]
  assign io_o_en = reg_en_4; // @[dut.scala 29:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:25]
      reg_en_1 <= 1'h0; // @[dut.scala 17:25]
    end else begin
      reg_en_1 <= io_i_en; // @[dut.scala 23:12]
    end
    if (reset) begin // @[dut.scala 18:25]
      reg_en_2 <= 1'h0; // @[dut.scala 18:25]
    end else begin
      reg_en_2 <= reg_en_1; // @[dut.scala 24:12]
    end
    if (reset) begin // @[dut.scala 19:25]
      reg_en_3 <= 1'h0; // @[dut.scala 19:25]
    end else begin
      reg_en_3 <= reg_en_2; // @[dut.scala 25:12]
    end
    if (reset) begin // @[dut.scala 20:25]
      reg_en_4 <= 1'h0; // @[dut.scala 20:25]
    end else begin
      reg_en_4 <= reg_en_3; // @[dut.scala 26:12]
    end
    if (reset) begin // @[dut.scala 48:31]
      reg_sum_stage1 <= 16'h0; // @[dut.scala 48:31]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_sum_stage1 <= sum_stage1; // @[dut.scala 54:20]
    end
    if (reset) begin // @[dut.scala 49:33]
      reg_carry_stage1 <= 1'h0; // @[dut.scala 49:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_carry_stage1 <= carry_stage1; // @[dut.scala 55:22]
    end
    if (reset) begin // @[dut.scala 50:33]
      reg_adda_parts_1_0 <= 16'h0; // @[dut.scala 50:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_adda_parts_1_0 <= adda_parts_1; // @[dut.scala 57:27]
    end
    if (reset) begin // @[dut.scala 50:33]
      reg_adda_parts_1_1 <= 16'h0; // @[dut.scala 50:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_adda_parts_1_1 <= adda_parts_2; // @[dut.scala 57:27]
    end
    if (reset) begin // @[dut.scala 50:33]
      reg_adda_parts_1_2 <= 16'h0; // @[dut.scala 50:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_adda_parts_1_2 <= adda_parts_3; // @[dut.scala 57:27]
    end
    if (reset) begin // @[dut.scala 51:33]
      reg_addb_parts_1_0 <= 16'h0; // @[dut.scala 51:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_addb_parts_1_0 <= addb_parts_1; // @[dut.scala 58:27]
    end
    if (reset) begin // @[dut.scala 51:33]
      reg_addb_parts_1_1 <= 16'h0; // @[dut.scala 51:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_addb_parts_1_1 <= addb_parts_2; // @[dut.scala 58:27]
    end
    if (reset) begin // @[dut.scala 51:33]
      reg_addb_parts_1_2 <= 16'h0; // @[dut.scala 51:33]
    end else if (io_i_en) begin // @[dut.scala 53:18]
      reg_addb_parts_1_2 <= addb_parts_3; // @[dut.scala 58:27]
    end
    if (reset) begin // @[dut.scala 70:33]
      reg_sum_stage1_2 <= 16'h0; // @[dut.scala 70:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_sum_stage1_2 <= reg_sum_stage1; // @[dut.scala 77:22]
    end
    if (reset) begin // @[dut.scala 71:31]
      reg_sum_stage2 <= 16'h0; // @[dut.scala 71:31]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_sum_stage2 <= sum_stage2; // @[dut.scala 78:20]
    end
    if (reset) begin // @[dut.scala 72:33]
      reg_carry_stage2 <= 1'h0; // @[dut.scala 72:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_carry_stage2 <= carry_stage2; // @[dut.scala 79:22]
    end
    if (reset) begin // @[dut.scala 73:33]
      reg_adda_parts_2_0 <= 16'h0; // @[dut.scala 73:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_adda_parts_2_0 <= reg_adda_parts_1_1; // @[dut.scala 81:27]
    end
    if (reset) begin // @[dut.scala 73:33]
      reg_adda_parts_2_1 <= 16'h0; // @[dut.scala 73:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_adda_parts_2_1 <= reg_adda_parts_1_2; // @[dut.scala 81:27]
    end
    if (reset) begin // @[dut.scala 74:33]
      reg_addb_parts_2_0 <= 16'h0; // @[dut.scala 74:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_addb_parts_2_0 <= reg_addb_parts_1_1; // @[dut.scala 82:27]
    end
    if (reset) begin // @[dut.scala 74:33]
      reg_addb_parts_2_1 <= 16'h0; // @[dut.scala 74:33]
    end else if (reg_en_1) begin // @[dut.scala 76:19]
      reg_addb_parts_2_1 <= reg_addb_parts_1_2; // @[dut.scala 82:27]
    end
    if (reset) begin // @[dut.scala 94:33]
      reg_sum_stage1_3 <= 16'h0; // @[dut.scala 94:33]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_sum_stage1_3 <= reg_sum_stage1_2; // @[dut.scala 102:22]
    end
    if (reset) begin // @[dut.scala 95:33]
      reg_sum_stage2_3 <= 16'h0; // @[dut.scala 95:33]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_sum_stage2_3 <= reg_sum_stage2; // @[dut.scala 103:22]
    end
    if (reset) begin // @[dut.scala 96:31]
      reg_sum_stage3 <= 16'h0; // @[dut.scala 96:31]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_sum_stage3 <= sum_stage3; // @[dut.scala 104:20]
    end
    if (reset) begin // @[dut.scala 97:33]
      reg_carry_stage3 <= 1'h0; // @[dut.scala 97:33]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_carry_stage3 <= carry_stage3; // @[dut.scala 105:22]
    end
    if (reset) begin // @[dut.scala 98:33]
      reg_adda_parts_3 <= 16'h0; // @[dut.scala 98:33]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_adda_parts_3 <= reg_adda_parts_2_1; // @[dut.scala 106:22]
    end
    if (reset) begin // @[dut.scala 99:33]
      reg_addb_parts_3 <= 16'h0; // @[dut.scala 99:33]
    end else if (reg_en_2) begin // @[dut.scala 101:19]
      reg_addb_parts_3 <= reg_addb_parts_2_1; // @[dut.scala 107:22]
    end
    if (reset) begin // @[dut.scala 118:27]
      reg_result <= 65'h0; // @[dut.scala 118:27]
    end else if (reg_en_3) begin // @[dut.scala 120:19]
      reg_result <= _reg_result_T; // @[dut.scala 121:16]
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
  reg_en_1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_en_2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_en_3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_en_4 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_sum_stage1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  reg_carry_stage1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  reg_adda_parts_1_0 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  reg_adda_parts_1_1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  reg_adda_parts_1_2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  reg_addb_parts_1_0 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  reg_addb_parts_1_1 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  reg_addb_parts_1_2 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  reg_sum_stage1_2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  reg_sum_stage2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  reg_carry_stage2 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  reg_adda_parts_2_0 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  reg_adda_parts_2_1 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  reg_addb_parts_2_0 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  reg_addb_parts_2_1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  reg_sum_stage1_3 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  reg_sum_stage2_3 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  reg_sum_stage3 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  reg_carry_stage3 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  reg_adda_parts_3 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  reg_addb_parts_3 = _RAND_24[15:0];
  _RAND_25 = {3{`RANDOM}};
  reg_result = _RAND_25[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
