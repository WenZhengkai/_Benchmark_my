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
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
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
`endif // RANDOMIZE_REG_INIT
  reg [63:0] adda_reg0; // @[dut.scala 14:26]
  reg [63:0] addb_reg0; // @[dut.scala 15:26]
  reg [63:0] adda_reg1; // @[dut.scala 17:26]
  reg [63:0] addb_reg1; // @[dut.scala 18:26]
  reg [63:0] adda_reg2; // @[dut.scala 20:26]
  reg [63:0] addb_reg2; // @[dut.scala 21:26]
  reg  i_en_reg0; // @[dut.scala 24:26]
  reg  i_en_reg1; // @[dut.scala 25:26]
  reg  i_en_reg2; // @[dut.scala 26:26]
  reg  i_en_reg3; // @[dut.scala 27:26]
  wire [16:0] temp0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 32:30]
  wire  carry0 = temp0[16]; // @[dut.scala 34:18]
  reg [15:0] sum0_reg; // @[dut.scala 36:25]
  reg  carry0_reg; // @[dut.scala 37:27]
  wire [16:0] _temp1_T_2 = adda_reg0[31:16] + addb_reg0[31:16]; // @[dut.scala 42:33]
  wire [16:0] _GEN_0 = {{16'd0}, carry0_reg}; // @[dut.scala 42:54]
  wire [17:0] temp1 = _temp1_T_2 + _GEN_0; // @[dut.scala 42:54]
  wire  carry1 = temp1[16]; // @[dut.scala 44:18]
  wire [16:0] sum1 = temp1[16:0]; // @[dut.scala 40:18 43:8]
  reg [15:0] sum1_reg; // @[dut.scala 46:25]
  reg  carry1_reg; // @[dut.scala 47:27]
  reg [15:0] sum0_reg1; // @[dut.scala 48:26]
  wire [16:0] _temp2_T_2 = adda_reg1[47:32] + addb_reg1[47:32]; // @[dut.scala 53:33]
  wire [16:0] _GEN_1 = {{16'd0}, carry1_reg}; // @[dut.scala 53:54]
  wire [17:0] temp2 = _temp2_T_2 + _GEN_1; // @[dut.scala 53:54]
  wire  carry2 = temp2[16]; // @[dut.scala 55:18]
  wire [16:0] sum2 = temp2[16:0]; // @[dut.scala 51:18 54:8]
  reg [15:0] sum2_reg; // @[dut.scala 57:25]
  reg  carry2_reg; // @[dut.scala 58:27]
  reg [15:0] sum1_reg1; // @[dut.scala 59:26]
  reg [15:0] sum0_reg2; // @[dut.scala 60:26]
  wire [16:0] _temp3_T_2 = adda_reg2[63:48] + addb_reg2[63:48]; // @[dut.scala 64:33]
  wire [16:0] _GEN_2 = {{16'd0}, carry2_reg}; // @[dut.scala 64:54]
  wire [17:0] temp3 = _temp3_T_2 + _GEN_2; // @[dut.scala 64:54]
  reg [16:0] sum3_reg; // @[dut.scala 67:25]
  reg [15:0] sum2_reg1; // @[dut.scala 68:26]
  reg [15:0] sum1_reg2; // @[dut.scala 69:26]
  reg [15:0] sum0_reg3; // @[dut.scala 70:26]
  wire [31:0] io_result_lo = {sum1_reg2,sum0_reg3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sum3_reg,sum2_reg1}; // @[Cat.scala 33:92]
  wire [16:0] sum3 = temp3[16:0]; // @[dut.scala 63:18 65:8]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg3; // @[dut.scala 76:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      adda_reg0 <= 64'h0; // @[dut.scala 14:26]
    end else begin
      adda_reg0 <= io_adda; // @[dut.scala 14:26]
    end
    if (reset) begin // @[dut.scala 15:26]
      addb_reg0 <= 64'h0; // @[dut.scala 15:26]
    end else begin
      addb_reg0 <= io_addb; // @[dut.scala 15:26]
    end
    if (reset) begin // @[dut.scala 17:26]
      adda_reg1 <= 64'h0; // @[dut.scala 17:26]
    end else begin
      adda_reg1 <= adda_reg0; // @[dut.scala 17:26]
    end
    if (reset) begin // @[dut.scala 18:26]
      addb_reg1 <= 64'h0; // @[dut.scala 18:26]
    end else begin
      addb_reg1 <= addb_reg0; // @[dut.scala 18:26]
    end
    if (reset) begin // @[dut.scala 20:26]
      adda_reg2 <= 64'h0; // @[dut.scala 20:26]
    end else begin
      adda_reg2 <= adda_reg1; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 21:26]
      addb_reg2 <= 64'h0; // @[dut.scala 21:26]
    end else begin
      addb_reg2 <= addb_reg1; // @[dut.scala 21:26]
    end
    if (reset) begin // @[dut.scala 24:26]
      i_en_reg0 <= 1'h0; // @[dut.scala 24:26]
    end else begin
      i_en_reg0 <= io_i_en; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      i_en_reg1 <= 1'h0; // @[dut.scala 25:26]
    end else begin
      i_en_reg1 <= i_en_reg0; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      i_en_reg2 <= 1'h0; // @[dut.scala 26:26]
    end else begin
      i_en_reg2 <= i_en_reg1; // @[dut.scala 26:26]
    end
    if (reset) begin // @[dut.scala 27:26]
      i_en_reg3 <= 1'h0; // @[dut.scala 27:26]
    end else begin
      i_en_reg3 <= i_en_reg2; // @[dut.scala 27:26]
    end
    if (reset) begin // @[dut.scala 36:25]
      sum0_reg <= 16'h0; // @[dut.scala 36:25]
    end else begin
      sum0_reg <= temp0[15:0]; // @[dut.scala 36:25]
    end
    if (reset) begin // @[dut.scala 37:27]
      carry0_reg <= 1'h0; // @[dut.scala 37:27]
    end else begin
      carry0_reg <= carry0; // @[dut.scala 37:27]
    end
    if (reset) begin // @[dut.scala 46:25]
      sum1_reg <= 16'h0; // @[dut.scala 46:25]
    end else begin
      sum1_reg <= sum1[15:0]; // @[dut.scala 46:25]
    end
    if (reset) begin // @[dut.scala 47:27]
      carry1_reg <= 1'h0; // @[dut.scala 47:27]
    end else begin
      carry1_reg <= carry1; // @[dut.scala 47:27]
    end
    if (reset) begin // @[dut.scala 48:26]
      sum0_reg1 <= 16'h0; // @[dut.scala 48:26]
    end else begin
      sum0_reg1 <= sum0_reg; // @[dut.scala 48:26]
    end
    if (reset) begin // @[dut.scala 57:25]
      sum2_reg <= 16'h0; // @[dut.scala 57:25]
    end else begin
      sum2_reg <= sum2[15:0]; // @[dut.scala 57:25]
    end
    if (reset) begin // @[dut.scala 58:27]
      carry2_reg <= 1'h0; // @[dut.scala 58:27]
    end else begin
      carry2_reg <= carry2; // @[dut.scala 58:27]
    end
    if (reset) begin // @[dut.scala 59:26]
      sum1_reg1 <= 16'h0; // @[dut.scala 59:26]
    end else begin
      sum1_reg1 <= sum1_reg; // @[dut.scala 59:26]
    end
    if (reset) begin // @[dut.scala 60:26]
      sum0_reg2 <= 16'h0; // @[dut.scala 60:26]
    end else begin
      sum0_reg2 <= sum0_reg1; // @[dut.scala 60:26]
    end
    if (reset) begin // @[dut.scala 67:25]
      sum3_reg <= 17'h0; // @[dut.scala 67:25]
    end else begin
      sum3_reg <= sum3; // @[dut.scala 67:25]
    end
    if (reset) begin // @[dut.scala 68:26]
      sum2_reg1 <= 16'h0; // @[dut.scala 68:26]
    end else begin
      sum2_reg1 <= sum2_reg; // @[dut.scala 68:26]
    end
    if (reset) begin // @[dut.scala 69:26]
      sum1_reg2 <= 16'h0; // @[dut.scala 69:26]
    end else begin
      sum1_reg2 <= sum1_reg1; // @[dut.scala 69:26]
    end
    if (reset) begin // @[dut.scala 70:26]
      sum0_reg3 <= 16'h0; // @[dut.scala 70:26]
    end else begin
      sum0_reg3 <= sum0_reg2; // @[dut.scala 70:26]
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
  _RAND_0 = {2{`RANDOM}};
  adda_reg0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addb_reg0 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  adda_reg1 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  addb_reg1 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  adda_reg2 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg2 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  i_en_reg0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  i_en_reg1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  i_en_reg2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  i_en_reg3 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum0_reg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry0_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sum1_reg = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carry1_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum0_reg1 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum2_reg = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  carry2_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sum1_reg1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum0_reg2 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sum3_reg = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  sum2_reg1 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  sum1_reg2 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  sum0_reg3 = _RAND_22[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
