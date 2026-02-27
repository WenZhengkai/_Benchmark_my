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
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [95:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg  en_reg1; // @[dut.scala 17:24]
  reg  en_reg2; // @[dut.scala 18:24]
  reg  en_reg3; // @[dut.scala 19:24]
  reg  en_reg4; // @[dut.scala 20:24]
  reg [63:0] adda_reg; // @[dut.scala 23:25]
  reg [63:0] addb_reg; // @[dut.scala 24:25]
  reg [15:0] sum1; // @[dut.scala 27:21]
  reg [15:0] sum2; // @[dut.scala 28:21]
  reg [15:0] sum3; // @[dut.scala 29:21]
  reg  carry1; // @[dut.scala 32:23]
  reg  carry2; // @[dut.scala 33:23]
  reg  carry3; // @[dut.scala 34:23]
  reg  carry4; // @[dut.scala 35:23]
  reg [64:0] result_reg; // @[dut.scala 38:27]
  wire [15:0] adda_chunks_0 = adda_reg[15:0]; // @[dut.scala 57:31]
  wire [15:0] addb_chunks_0 = addb_reg[15:0]; // @[dut.scala 58:31]
  wire [15:0] adda_chunks_1 = adda_reg[31:16]; // @[dut.scala 57:31]
  wire [15:0] addb_chunks_1 = addb_reg[31:16]; // @[dut.scala 58:31]
  wire [15:0] adda_chunks_2 = adda_reg[47:32]; // @[dut.scala 57:31]
  wire [15:0] addb_chunks_2 = addb_reg[47:32]; // @[dut.scala 58:31]
  wire [15:0] adda_chunks_3 = adda_reg[63:48]; // @[dut.scala 57:31]
  wire [15:0] addb_chunks_3 = addb_reg[63:48]; // @[dut.scala 58:31]
  wire [16:0] temp = adda_chunks_0 + addb_chunks_0; // @[dut.scala 63:31]
  wire [16:0] _temp_T = adda_chunks_1 + addb_chunks_1; // @[dut.scala 70:31]
  wire [16:0] _GEN_10 = {{16'd0}, carry1}; // @[dut.scala 70:49]
  wire [16:0] temp_1 = _temp_T + _GEN_10; // @[dut.scala 70:49]
  wire [16:0] _temp_T_2 = adda_chunks_2 + addb_chunks_2; // @[dut.scala 77:31]
  wire [16:0] _GEN_11 = {{16'd0}, carry2}; // @[dut.scala 77:49]
  wire [16:0] temp_2 = _temp_T_2 + _GEN_11; // @[dut.scala 77:49]
  wire [16:0] _temp_T_4 = adda_chunks_3 + addb_chunks_3; // @[dut.scala 84:31]
  wire [16:0] _GEN_12 = {{16'd0}, carry3}; // @[dut.scala 84:49]
  wire [16:0] temp_3 = _temp_T_4 + _GEN_12; // @[dut.scala 84:49]
  wire [15:0] high_sum = temp_3[15:0]; // @[dut.scala 85:24]
  wire [64:0] _result_reg_T = {carry4,high_sum,sum3,sum2,sum1}; // @[Cat.scala 33:92]
  assign io_result = result_reg; // @[dut.scala 93:13]
  assign io_o_en = en_reg4; // @[dut.scala 94:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:24]
      en_reg1 <= 1'h0; // @[dut.scala 17:24]
    end else begin
      en_reg1 <= io_i_en; // @[dut.scala 47:11]
    end
    if (reset) begin // @[dut.scala 18:24]
      en_reg2 <= 1'h0; // @[dut.scala 18:24]
    end else begin
      en_reg2 <= en_reg1; // @[dut.scala 48:11]
    end
    if (reset) begin // @[dut.scala 19:24]
      en_reg3 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg3 <= en_reg2; // @[dut.scala 49:11]
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg4 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg4 <= en_reg3; // @[dut.scala 50:11]
    end
    if (reset) begin // @[dut.scala 23:25]
      adda_reg <= 64'h0; // @[dut.scala 23:25]
    end else if (io_i_en) begin // @[dut.scala 41:17]
      adda_reg <= io_adda; // @[dut.scala 42:14]
    end
    if (reset) begin // @[dut.scala 24:25]
      addb_reg <= 64'h0; // @[dut.scala 24:25]
    end else if (io_i_en) begin // @[dut.scala 41:17]
      addb_reg <= io_addb; // @[dut.scala 43:14]
    end
    if (reset) begin // @[dut.scala 27:21]
      sum1 <= 16'h0; // @[dut.scala 27:21]
    end else if (en_reg1) begin // @[dut.scala 62:17]
      sum1 <= temp[15:0]; // @[dut.scala 64:10]
    end
    if (reset) begin // @[dut.scala 28:21]
      sum2 <= 16'h0; // @[dut.scala 28:21]
    end else if (en_reg2) begin // @[dut.scala 69:17]
      sum2 <= temp_1[15:0]; // @[dut.scala 71:10]
    end
    if (reset) begin // @[dut.scala 29:21]
      sum3 <= 16'h0; // @[dut.scala 29:21]
    end else if (en_reg3) begin // @[dut.scala 76:17]
      sum3 <= temp_2[15:0]; // @[dut.scala 78:10]
    end
    if (reset) begin // @[dut.scala 32:23]
      carry1 <= 1'h0; // @[dut.scala 32:23]
    end else if (en_reg1) begin // @[dut.scala 62:17]
      carry1 <= temp[16]; // @[dut.scala 65:12]
    end
    if (reset) begin // @[dut.scala 33:23]
      carry2 <= 1'h0; // @[dut.scala 33:23]
    end else if (en_reg2) begin // @[dut.scala 69:17]
      carry2 <= temp_1[16]; // @[dut.scala 72:12]
    end
    if (reset) begin // @[dut.scala 34:23]
      carry3 <= 1'h0; // @[dut.scala 34:23]
    end else if (en_reg3) begin // @[dut.scala 76:17]
      carry3 <= temp_2[16]; // @[dut.scala 79:12]
    end
    if (reset) begin // @[dut.scala 35:23]
      carry4 <= 1'h0; // @[dut.scala 35:23]
    end else if (en_reg4) begin // @[dut.scala 83:17]
      carry4 <= temp_3[16]; // @[dut.scala 86:12]
    end
    if (reset) begin // @[dut.scala 38:27]
      result_reg <= 65'h0; // @[dut.scala 38:27]
    end else if (en_reg4) begin // @[dut.scala 83:17]
      result_reg <= _result_reg_T; // @[dut.scala 89:16]
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
  _RAND_4 = {2{`RANDOM}};
  adda_reg = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  sum1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum2 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum3 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carry1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  carry2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  carry3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  carry4 = _RAND_12[0:0];
  _RAND_13 = {3{`RANDOM}};
  result_reg = _RAND_13[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
