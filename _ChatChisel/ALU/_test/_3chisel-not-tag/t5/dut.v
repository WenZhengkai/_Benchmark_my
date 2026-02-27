module dut(
  input         clock,
  input         reset,
  input  [31:0] io_alu_in1,
  input  [31:0] io_alu_in2,
  input  [3:0]  io_aluop,
  output        io_zero,
  output [31:0] io_alu_result
);
  wire [31:0] _result_T_1 = io_alu_in1 + io_alu_in2; // @[dut.scala 23:42]
  wire [31:0] _result_T_3 = io_alu_in1 - io_alu_in2; // @[dut.scala 24:42]
  wire [31:0] _result_T_4 = io_alu_in1 ^ io_alu_in2; // @[dut.scala 27:42]
  wire [31:0] _result_T_5 = io_alu_in1 | io_alu_in2; // @[dut.scala 28:42]
  wire [31:0] _result_T_6 = io_alu_in1 & io_alu_in2; // @[dut.scala 29:42]
  wire [62:0] _GEN_10 = {{31'd0}, io_alu_in1}; // @[dut.scala 32:42]
  wire [62:0] _result_T_8 = _GEN_10 << io_alu_in2[4:0]; // @[dut.scala 32:42]
  wire [31:0] _result_T_10 = io_alu_in1 >> io_alu_in2[4:0]; // @[dut.scala 33:42]
  wire [31:0] _result_T_14 = $signed(io_alu_in1) >>> io_alu_in2[4:0]; // @[dut.scala 34:71]
  wire  _GEN_0 = 4'h9 == io_aluop & io_alu_in1 < io_alu_in2; // @[dut.scala 18:10 21:20 41:14]
  wire  _GEN_1 = 4'h8 == io_aluop ? $signed(io_alu_in1) < $signed(io_alu_in2) : _GEN_0; // @[dut.scala 21:20 38:14]
  wire [31:0] _GEN_2 = 4'h7 == io_aluop ? _result_T_14 : {{31'd0}, _GEN_1}; // @[dut.scala 21:20 34:28]
  wire [31:0] _GEN_3 = 4'h6 == io_aluop ? _result_T_10 : _GEN_2; // @[dut.scala 21:20 33:28]
  wire [62:0] _GEN_4 = 4'h5 == io_aluop ? _result_T_8 : {{31'd0}, _GEN_3}; // @[dut.scala 21:20 32:28]
  wire [62:0] _GEN_5 = 4'h4 == io_aluop ? {{31'd0}, _result_T_6} : _GEN_4; // @[dut.scala 21:20 29:28]
  wire [62:0] _GEN_6 = 4'h3 == io_aluop ? {{31'd0}, _result_T_5} : _GEN_5; // @[dut.scala 21:20 28:28]
  wire [62:0] _GEN_7 = 4'h2 == io_aluop ? {{31'd0}, _result_T_4} : _GEN_6; // @[dut.scala 21:20 27:28]
  wire [62:0] _GEN_8 = 4'h1 == io_aluop ? {{31'd0}, _result_T_3} : _GEN_7; // @[dut.scala 21:20 24:28]
  wire [62:0] _GEN_9 = 4'h0 == io_aluop ? {{31'd0}, _result_T_1} : _GEN_8; // @[dut.scala 21:20 23:28]
  assign io_zero = io_alu_in1 == io_alu_in2; // @[dut.scala 14:26]
  assign io_alu_result = _GEN_9[31:0]; // @[dut.scala 17:20]
endmodule
