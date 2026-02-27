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
`endif // RANDOMIZE_REG_INIT
  reg  en_reg1; // @[dut.scala 17:24]
  reg  en_reg2; // @[dut.scala 18:24]
  reg  en_reg3; // @[dut.scala 19:24]
  reg  en_reg4; // @[dut.scala 20:24]
  reg [15:0] adda_reg1; // @[dut.scala 23:26]
  reg [15:0] addb_reg1; // @[dut.scala 24:26]
  reg  carry_reg1; // @[dut.scala 25:27]
  reg [15:0] adda_reg2; // @[dut.scala 28:26]
  reg [15:0] addb_reg2; // @[dut.scala 29:26]
  reg  carry_reg2; // @[dut.scala 30:27]
  reg [15:0] sum_reg1; // @[dut.scala 31:25]
  reg [15:0] adda_reg3; // @[dut.scala 34:26]
  reg [15:0] addb_reg3; // @[dut.scala 35:26]
  reg  carry_reg3; // @[dut.scala 36:27]
  reg [15:0] sum_reg2; // @[dut.scala 37:25]
  reg [15:0] adda_reg4; // @[dut.scala 40:26]
  reg [15:0] addb_reg4; // @[dut.scala 41:26]
  reg [15:0] sum_reg3; // @[dut.scala 42:25]
  reg [15:0] sum_reg4; // @[dut.scala 45:25]
  reg  final_carry; // @[dut.scala 46:28]
  wire [16:0] sum1 = adda_reg1 + addb_reg1; // @[dut.scala 64:24]
  wire [16:0] _sum2_T = adda_reg2 + addb_reg2; // @[dut.scala 76:24]
  wire [16:0] _GEN_20 = {{16'd0}, carry_reg2}; // @[dut.scala 76:37]
  wire [16:0] sum2 = _sum2_T + _GEN_20; // @[dut.scala 76:37]
  wire [16:0] _sum3_T = adda_reg3 + addb_reg3; // @[dut.scala 88:24]
  wire [16:0] _GEN_21 = {{16'd0}, carry_reg3}; // @[dut.scala 88:37]
  wire [16:0] sum3 = _sum3_T + _GEN_21; // @[dut.scala 88:37]
  wire [16:0] _sum4_T = adda_reg4 + addb_reg4; // @[dut.scala 100:24]
  wire [16:0] _GEN_22 = {{16'd0}, carry_reg1}; // @[dut.scala 100:37]
  wire [16:0] sum4 = _sum4_T + _GEN_22; // @[dut.scala 100:37]
  wire [31:0] io_result_lo = {sum_reg2,sum_reg1}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {final_carry,sum_reg4,sum_reg3}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_reg4; // @[dut.scala 118:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:24]
      en_reg1 <= 1'h0; // @[dut.scala 17:24]
    end else begin
      en_reg1 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 18:24]
      en_reg2 <= 1'h0; // @[dut.scala 18:24]
    end else begin
      en_reg2 <= en_reg1;
    end
    if (reset) begin // @[dut.scala 19:24]
      en_reg3 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg3 <= en_reg2;
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg4 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg4 <= en_reg3;
    end
    if (reset) begin // @[dut.scala 23:26]
      adda_reg1 <= 16'h0; // @[dut.scala 23:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      adda_reg1 <= io_adda[15:0]; // @[dut.scala 50:15]
    end
    if (reset) begin // @[dut.scala 24:26]
      addb_reg1 <= 16'h0; // @[dut.scala 24:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      addb_reg1 <= io_addb[15:0]; // @[dut.scala 51:15]
    end
    if (reset) begin // @[dut.scala 25:27]
      carry_reg1 <= 1'h0; // @[dut.scala 25:27]
    end else if (en_reg3) begin // @[dut.scala 91:18]
      carry_reg1 <= sum3[16]; // @[dut.scala 93:16]
    end
    if (reset) begin // @[dut.scala 28:26]
      adda_reg2 <= 16'h0; // @[dut.scala 28:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      adda_reg2 <= io_adda[31:16]; // @[dut.scala 52:15]
    end
    if (reset) begin // @[dut.scala 29:26]
      addb_reg2 <= 16'h0; // @[dut.scala 29:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      addb_reg2 <= io_addb[31:16]; // @[dut.scala 53:15]
    end
    if (reset) begin // @[dut.scala 30:27]
      carry_reg2 <= 1'h0; // @[dut.scala 30:27]
    end else if (en_reg1) begin // @[dut.scala 67:18]
      carry_reg2 <= sum1[16]; // @[dut.scala 69:16]
    end
    if (reset) begin // @[dut.scala 31:25]
      sum_reg1 <= 16'h0; // @[dut.scala 31:25]
    end else if (en_reg1) begin // @[dut.scala 67:18]
      sum_reg1 <= sum1[15:0]; // @[dut.scala 68:14]
    end
    if (reset) begin // @[dut.scala 34:26]
      adda_reg3 <= 16'h0; // @[dut.scala 34:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      adda_reg3 <= io_adda[47:32]; // @[dut.scala 54:15]
    end
    if (reset) begin // @[dut.scala 35:26]
      addb_reg3 <= 16'h0; // @[dut.scala 35:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      addb_reg3 <= io_addb[47:32]; // @[dut.scala 55:15]
    end
    if (reset) begin // @[dut.scala 36:27]
      carry_reg3 <= 1'h0; // @[dut.scala 36:27]
    end else if (en_reg2) begin // @[dut.scala 79:18]
      carry_reg3 <= sum2[16]; // @[dut.scala 81:16]
    end
    if (reset) begin // @[dut.scala 37:25]
      sum_reg2 <= 16'h0; // @[dut.scala 37:25]
    end else if (en_reg2) begin // @[dut.scala 79:18]
      sum_reg2 <= sum2[15:0]; // @[dut.scala 80:14]
    end
    if (reset) begin // @[dut.scala 40:26]
      adda_reg4 <= 16'h0; // @[dut.scala 40:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      adda_reg4 <= io_adda[63:48]; // @[dut.scala 56:15]
    end
    if (reset) begin // @[dut.scala 41:26]
      addb_reg4 <= 16'h0; // @[dut.scala 41:26]
    end else if (io_i_en) begin // @[dut.scala 49:18]
      addb_reg4 <= io_addb[63:48]; // @[dut.scala 57:15]
    end
    if (reset) begin // @[dut.scala 42:25]
      sum_reg3 <= 16'h0; // @[dut.scala 42:25]
    end else if (en_reg3) begin // @[dut.scala 91:18]
      sum_reg3 <= sum3[15:0]; // @[dut.scala 92:14]
    end
    if (reset) begin // @[dut.scala 45:25]
      sum_reg4 <= 16'h0; // @[dut.scala 45:25]
    end else if (en_reg4) begin // @[dut.scala 103:18]
      sum_reg4 <= sum4[15:0]; // @[dut.scala 104:14]
    end
    if (reset) begin // @[dut.scala 46:28]
      final_carry <= 1'h0; // @[dut.scala 46:28]
    end else if (en_reg4) begin // @[dut.scala 103:18]
      final_carry <= sum4[16]; // @[dut.scala 105:17]
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
  en_reg1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en_reg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en_reg3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_reg4 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  adda_reg1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  addb_reg1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  carry_reg1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  adda_reg2 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  addb_reg2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carry_reg2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum_reg1 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  adda_reg3 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  addb_reg3 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carry_reg3 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum_reg2 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  adda_reg4 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  addb_reg4 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sum_reg3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum_reg4 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  final_carry = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
