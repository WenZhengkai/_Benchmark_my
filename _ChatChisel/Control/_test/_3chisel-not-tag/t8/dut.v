module dut(
  input        clock,
  input        reset,
  input  [6:0] io_opcode,
  input  [6:0] io_funct7,
  input  [2:0] io_funct3,
  output [3:0] io_aluop,
  output       io_immsrc,
  output       io_isbranch,
  output       io_memread,
  output       io_memwrite,
  output       io_regwrite,
  output [1:0] io_memtoreg,
  output       io_pcsel,
  output       io_rdsel,
  output       io_isjump,
  output       io_isupper,
  output       io_islui
);
  wire  _T_1 = 3'h0 == io_funct3; // @[dut.scala 101:25]
  wire  _T_2 = io_funct7 == 7'h20; // @[dut.scala 103:26]
  wire [2:0] _GEN_1 = _T_2 ? 3'h7 : 3'h6; // @[dut.scala 113:{38,49} 114:35]
  wire [2:0] _GEN_2 = 3'h5 == io_funct3 ? _GEN_1 : 3'h0; // @[dut.scala 101:25 78:12]
  wire [2:0] _GEN_3 = 3'h1 == io_funct3 ? 3'h5 : _GEN_2; // @[dut.scala 101:25 111:32]
  wire [2:0] _GEN_4 = 3'h7 == io_funct3 ? 3'h4 : _GEN_3; // @[dut.scala 101:25 110:32]
  wire [2:0] _GEN_5 = 3'h6 == io_funct3 ? 3'h3 : _GEN_4; // @[dut.scala 101:25 109:32]
  wire [2:0] _GEN_6 = 3'h4 == io_funct3 ? 3'h2 : _GEN_5; // @[dut.scala 101:25 108:32]
  wire [3:0] _GEN_7 = 3'h3 == io_funct3 ? 4'h9 : {{1'd0}, _GEN_6}; // @[dut.scala 101:25 107:32]
  wire [3:0] _GEN_8 = 3'h2 == io_funct3 ? 4'h8 : _GEN_7; // @[dut.scala 101:25 106:32]
  wire [3:0] _GEN_9 = 3'h0 == io_funct3 ? {{3'd0}, _T_2} : _GEN_8; // @[dut.scala 101:25]
  wire [3:0] _GEN_18 = _T_1 ? 4'h0 : _GEN_8; // @[dut.scala 125:25 126:32]
  wire [3:0] _io_aluop_T_1 = io_funct3[2] ? 4'h9 : 4'h8; // @[dut.scala 159:22]
  wire  _GEN_20 = 7'h37 == io_opcode | 7'h17 == io_opcode; // @[dut.scala 179:18 94:21]
  wire  _GEN_22 = 7'h37 == io_opcode ? 1'h0 : 7'h17 == io_opcode; // @[dut.scala 86:12 94:21]
  wire  _GEN_24 = 7'h67 == io_opcode | _GEN_20; // @[dut.scala 173:19 94:21]
  wire  _GEN_25 = 7'h67 == io_opcode ? 1'h0 : _GEN_20; // @[dut.scala 88:14 94:21]
  wire  _GEN_26 = 7'h67 == io_opcode ? 1'h0 : 7'h37 == io_opcode; // @[dut.scala 89:12 94:21]
  wire  _GEN_27 = 7'h67 == io_opcode ? 1'h0 : _GEN_22; // @[dut.scala 86:12 94:21]
  wire  _GEN_28 = 7'h6f == io_opcode | 7'h67 == io_opcode; // @[dut.scala 164:17 94:21]
  wire  _GEN_29 = 7'h6f == io_opcode | _GEN_24; // @[dut.scala 165:19 94:21]
  wire  _GEN_30 = 7'h6f == io_opcode ? 1'h0 : 7'h67 == io_opcode; // @[dut.scala 85:12 94:21]
  wire  _GEN_31 = 7'h6f == io_opcode ? 1'h0 : _GEN_25; // @[dut.scala 88:14 94:21]
  wire  _GEN_32 = 7'h6f == io_opcode ? 1'h0 : _GEN_26; // @[dut.scala 89:12 94:21]
  wire  _GEN_33 = 7'h6f == io_opcode ? 1'h0 : _GEN_27; // @[dut.scala 86:12 94:21]
  wire [3:0] _GEN_35 = 7'h63 == io_opcode ? _io_aluop_T_1 : 4'h0; // @[dut.scala 159:16 78:12 94:21]
  wire  _GEN_36 = 7'h63 == io_opcode ? 1'h0 : _GEN_28; // @[dut.scala 87:13 94:21]
  wire  _GEN_37 = 7'h63 == io_opcode ? 1'h0 : _GEN_29; // @[dut.scala 83:15 94:21]
  wire  _GEN_38 = 7'h63 == io_opcode ? 1'h0 : _GEN_30; // @[dut.scala 85:12 94:21]
  wire  _GEN_39 = 7'h63 == io_opcode ? 1'h0 : _GEN_31; // @[dut.scala 88:14 94:21]
  wire  _GEN_40 = 7'h63 == io_opcode ? 1'h0 : _GEN_32; // @[dut.scala 89:12 94:21]
  wire  _GEN_41 = 7'h63 == io_opcode ? 1'h0 : _GEN_33; // @[dut.scala 86:12 94:21]
  wire [3:0] _GEN_42 = 7'h23 == io_opcode ? 4'h0 : _GEN_35; // @[dut.scala 151:16 94:21]
  wire  _GEN_43 = 7'h23 == io_opcode | _GEN_37; // @[dut.scala 152:17 94:21]
  wire  _GEN_45 = 7'h23 == io_opcode ? 1'h0 : 7'h63 == io_opcode; // @[dut.scala 80:15 94:21]
  wire  _GEN_46 = 7'h23 == io_opcode ? 1'h0 : _GEN_36; // @[dut.scala 87:13 94:21]
  wire  _GEN_47 = 7'h23 == io_opcode ? 1'h0 : _GEN_37; // @[dut.scala 83:15 94:21]
  wire  _GEN_48 = 7'h23 == io_opcode ? 1'h0 : _GEN_38; // @[dut.scala 85:12 94:21]
  wire  _GEN_49 = 7'h23 == io_opcode ? 1'h0 : _GEN_39; // @[dut.scala 88:14 94:21]
  wire  _GEN_50 = 7'h23 == io_opcode ? 1'h0 : _GEN_40; // @[dut.scala 89:12 94:21]
  wire  _GEN_51 = 7'h23 == io_opcode ? 1'h0 : _GEN_41; // @[dut.scala 86:12 94:21]
  wire [3:0] _GEN_52 = 7'h3 == io_opcode ? 4'h0 : _GEN_42; // @[dut.scala 142:16 94:21]
  wire  _GEN_53 = 7'h3 == io_opcode | _GEN_43; // @[dut.scala 143:17 94:21]
  wire  _GEN_55 = 7'h3 == io_opcode | _GEN_47; // @[dut.scala 145:19 94:21]
  wire  _GEN_56 = 7'h3 == io_opcode ? 1'h0 : 7'h23 == io_opcode; // @[dut.scala 82:15 94:21]
  wire  _GEN_57 = 7'h3 == io_opcode ? 1'h0 : _GEN_45; // @[dut.scala 80:15 94:21]
  wire  _GEN_58 = 7'h3 == io_opcode ? 1'h0 : _GEN_46; // @[dut.scala 87:13 94:21]
  wire  _GEN_59 = 7'h3 == io_opcode ? 1'h0 : _GEN_48; // @[dut.scala 85:12 94:21]
  wire  _GEN_60 = 7'h3 == io_opcode ? 1'h0 : _GEN_49; // @[dut.scala 88:14 94:21]
  wire  _GEN_61 = 7'h3 == io_opcode ? 1'h0 : _GEN_50; // @[dut.scala 89:12 94:21]
  wire  _GEN_62 = 7'h3 == io_opcode ? 1'h0 : _GEN_51; // @[dut.scala 86:12 94:21]
  wire  _GEN_63 = 7'h13 == io_opcode | _GEN_53; // @[dut.scala 121:17 94:21]
  wire  _GEN_64 = 7'h13 == io_opcode | _GEN_55; // @[dut.scala 122:19 94:21]
  wire [1:0] _GEN_65 = 7'h13 == io_opcode ? 2'h2 : {{1'd0}, 7'h3 == io_opcode}; // @[dut.scala 123:19 94:21]
  wire [3:0] _GEN_66 = 7'h13 == io_opcode ? _GEN_18 : _GEN_52; // @[dut.scala 94:21]
  wire  _GEN_67 = 7'h13 == io_opcode ? 1'h0 : 7'h3 == io_opcode; // @[dut.scala 81:14 94:21]
  wire  _GEN_68 = 7'h13 == io_opcode ? 1'h0 : _GEN_56; // @[dut.scala 82:15 94:21]
  wire  _GEN_69 = 7'h13 == io_opcode ? 1'h0 : _GEN_57; // @[dut.scala 80:15 94:21]
  wire  _GEN_70 = 7'h13 == io_opcode ? 1'h0 : _GEN_58; // @[dut.scala 87:13 94:21]
  wire  _GEN_71 = 7'h13 == io_opcode ? 1'h0 : _GEN_59; // @[dut.scala 85:12 94:21]
  wire  _GEN_72 = 7'h13 == io_opcode ? 1'h0 : _GEN_60; // @[dut.scala 88:14 94:21]
  wire  _GEN_73 = 7'h13 == io_opcode ? 1'h0 : _GEN_61; // @[dut.scala 89:12 94:21]
  wire  _GEN_74 = 7'h13 == io_opcode ? 1'h0 : _GEN_62; // @[dut.scala 86:12 94:21]
  assign io_aluop = 7'h33 == io_opcode ? _GEN_9 : _GEN_66; // @[dut.scala 94:21]
  assign io_immsrc = 7'h33 == io_opcode ? 1'h0 : _GEN_63; // @[dut.scala 94:21 97:17]
  assign io_isbranch = 7'h33 == io_opcode ? 1'h0 : _GEN_69; // @[dut.scala 80:15 94:21]
  assign io_memread = 7'h33 == io_opcode ? 1'h0 : _GEN_67; // @[dut.scala 81:14 94:21]
  assign io_memwrite = 7'h33 == io_opcode ? 1'h0 : _GEN_68; // @[dut.scala 82:15 94:21]
  assign io_regwrite = 7'h33 == io_opcode | _GEN_64; // @[dut.scala 94:21 98:19]
  assign io_memtoreg = 7'h33 == io_opcode ? 2'h2 : _GEN_65; // @[dut.scala 94:21 99:19]
  assign io_pcsel = 7'h33 == io_opcode ? 1'h0 : _GEN_71; // @[dut.scala 85:12 94:21]
  assign io_rdsel = 7'h33 == io_opcode ? 1'h0 : _GEN_74; // @[dut.scala 86:12 94:21]
  assign io_isjump = 7'h33 == io_opcode ? 1'h0 : _GEN_70; // @[dut.scala 87:13 94:21]
  assign io_isupper = 7'h33 == io_opcode ? 1'h0 : _GEN_72; // @[dut.scala 88:14 94:21]
  assign io_islui = 7'h33 == io_opcode ? 1'h0 : _GEN_73; // @[dut.scala 89:12 94:21]
endmodule
