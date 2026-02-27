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
  wire  _T_1 = 3'h0 == io_funct3; // @[dut.scala 91:23]
  wire [3:0] _GEN_0 = io_funct7 == 7'h20 ? 4'h1 : 4'h0; // @[dut.scala 93:{36,47} 94:33]
  wire  _T_3 = 3'h1 == io_funct3; // @[dut.scala 91:23]
  wire [3:0] _GEN_1 = 3'h7 == io_funct3 ? 4'h4 : 4'h0; // @[dut.scala 91:23 101:29 70:16]
  wire [3:0] _GEN_2 = 3'h6 == io_funct3 ? 4'h3 : _GEN_1; // @[dut.scala 91:23 100:29]
  wire [3:0] _GEN_3 = 3'h4 == io_funct3 ? 4'h2 : _GEN_2; // @[dut.scala 91:23 99:29]
  wire [3:0] _GEN_4 = 3'h3 == io_funct3 ? 4'h9 : _GEN_3; // @[dut.scala 91:23 98:30]
  wire [3:0] _GEN_5 = 3'h2 == io_funct3 ? 4'h8 : _GEN_4; // @[dut.scala 91:23 97:29]
  wire [3:0] _GEN_6 = 3'h1 == io_funct3 ? 4'h5 : _GEN_5; // @[dut.scala 91:23 96:29]
  wire [3:0] _GEN_7 = 3'h0 == io_funct3 ? _GEN_0 : _GEN_6; // @[dut.scala 91:23]
  wire [3:0] _GEN_11 = _T_3 ? 4'h5 : _GEN_3; // @[dut.scala 113:23 115:29]
  wire [3:0] _GEN_12 = _T_1 ? 4'h0 : _GEN_11; // @[dut.scala 113:23 114:29]
  wire  _T_15 = io_opcode == 7'h3; // @[dut.scala 125:23]
  wire  _T_16 = io_opcode == 7'h23; // @[dut.scala 131:24]
  wire  _T_17 = io_opcode == 7'h63; // @[dut.scala 140:23]
  wire [3:0] _GEN_13 = io_funct3 == 3'h0 ? 4'h8 : 4'h0; // @[dut.scala 142:{32,43} 70:16]
  wire  _T_20 = io_opcode == 7'h67; // @[dut.scala 147:24]
  wire  _T_21 = io_opcode == 7'h37; // @[dut.scala 157:23]
  wire  _T_22 = io_opcode == 7'h17; // @[dut.scala 162:24]
  wire  _GEN_15 = io_opcode == 7'h37 | _T_22; // @[dut.scala 157:35 158:16]
  wire  _GEN_17 = io_opcode == 7'h37 ? 1'h0 : _T_22; // @[dut.scala 157:35 78:16]
  wire  _GEN_19 = io_opcode == 7'h67 | _GEN_15; // @[dut.scala 147:37 150:17]
  wire  _GEN_20 = io_opcode == 7'h67 ? 1'h0 : _GEN_15; // @[dut.scala 147:37 80:16]
  wire  _GEN_21 = io_opcode == 7'h67 ? 1'h0 : _T_21; // @[dut.scala 147:37 81:16]
  wire  _GEN_22 = io_opcode == 7'h67 ? 1'h0 : _GEN_17; // @[dut.scala 147:37 78:16]
  wire  _GEN_23 = io_opcode == 7'h6f | _T_20; // @[dut.scala 143:36 144:15]
  wire  _GEN_24 = io_opcode == 7'h6f | _GEN_19; // @[dut.scala 143:36 145:17]
  wire  _GEN_25 = io_opcode == 7'h6f ? 1'h0 : _T_20; // @[dut.scala 143:36 77:16]
  wire  _GEN_26 = io_opcode == 7'h6f ? 1'h0 : _GEN_20; // @[dut.scala 143:36 80:16]
  wire  _GEN_27 = io_opcode == 7'h6f ? 1'h0 : _GEN_21; // @[dut.scala 143:36 81:16]
  wire  _GEN_28 = io_opcode == 7'h6f ? 1'h0 : _GEN_22; // @[dut.scala 143:36 78:16]
  wire [3:0] _GEN_30 = io_opcode == 7'h63 ? _GEN_13 : 4'h0; // @[dut.scala 140:38 70:16]
  wire  _GEN_31 = io_opcode == 7'h63 ? 1'h0 : _GEN_23; // @[dut.scala 140:38 79:16]
  wire  _GEN_32 = io_opcode == 7'h63 ? 1'h0 : _GEN_24; // @[dut.scala 140:38 75:16]
  wire  _GEN_33 = io_opcode == 7'h63 ? 1'h0 : _GEN_25; // @[dut.scala 140:38 77:16]
  wire  _GEN_34 = io_opcode == 7'h63 ? 1'h0 : _GEN_26; // @[dut.scala 140:38 80:16]
  wire  _GEN_35 = io_opcode == 7'h63 ? 1'h0 : _GEN_27; // @[dut.scala 140:38 81:16]
  wire  _GEN_36 = io_opcode == 7'h63 ? 1'h0 : _GEN_28; // @[dut.scala 140:38 78:16]
  wire [3:0] _GEN_37 = io_opcode == 7'h23 ? 4'h0 : _GEN_30; // @[dut.scala 131:38 132:14]
  wire  _GEN_38 = io_opcode == 7'h23 | _GEN_32; // @[dut.scala 131:38 133:15]
  wire  _GEN_40 = io_opcode == 7'h23 ? 1'h0 : _T_17; // @[dut.scala 131:38 72:16]
  wire  _GEN_41 = io_opcode == 7'h23 ? 1'h0 : _GEN_31; // @[dut.scala 131:38 79:16]
  wire  _GEN_42 = io_opcode == 7'h23 ? 1'h0 : _GEN_32; // @[dut.scala 131:38 75:16]
  wire  _GEN_43 = io_opcode == 7'h23 ? 1'h0 : _GEN_33; // @[dut.scala 131:38 77:16]
  wire  _GEN_44 = io_opcode == 7'h23 ? 1'h0 : _GEN_34; // @[dut.scala 131:38 80:16]
  wire  _GEN_45 = io_opcode == 7'h23 ? 1'h0 : _GEN_35; // @[dut.scala 131:38 81:16]
  wire  _GEN_46 = io_opcode == 7'h23 ? 1'h0 : _GEN_36; // @[dut.scala 131:38 78:16]
  wire [3:0] _GEN_47 = io_opcode == 7'h3 ? 4'h0 : _GEN_37; // @[dut.scala 125:36 126:14]
  wire  _GEN_48 = io_opcode == 7'h3 | _GEN_38; // @[dut.scala 125:36 127:15]
  wire  _GEN_50 = io_opcode == 7'h3 | _GEN_42; // @[dut.scala 125:36 129:17]
  wire [1:0] _GEN_51 = io_opcode == 7'h3 ? 2'h1 : 2'h0; // @[dut.scala 125:36 130:17 76:16]
  wire  _GEN_52 = io_opcode == 7'h3 ? 1'h0 : _T_16; // @[dut.scala 125:36 74:16]
  wire  _GEN_53 = io_opcode == 7'h3 ? 1'h0 : _GEN_40; // @[dut.scala 125:36 72:16]
  wire  _GEN_54 = io_opcode == 7'h3 ? 1'h0 : _GEN_41; // @[dut.scala 125:36 79:16]
  wire  _GEN_55 = io_opcode == 7'h3 ? 1'h0 : _GEN_43; // @[dut.scala 125:36 77:16]
  wire  _GEN_56 = io_opcode == 7'h3 ? 1'h0 : _GEN_44; // @[dut.scala 125:36 80:16]
  wire  _GEN_57 = io_opcode == 7'h3 ? 1'h0 : _GEN_45; // @[dut.scala 125:36 81:16]
  wire  _GEN_58 = io_opcode == 7'h3 ? 1'h0 : _GEN_46; // @[dut.scala 125:36 78:16]
  wire  _GEN_59 = io_opcode == 7'h13 | _GEN_48; // @[dut.scala 108:43 109:15]
  wire  _GEN_60 = io_opcode == 7'h13 | _GEN_50; // @[dut.scala 108:43 110:17]
  wire [1:0] _GEN_61 = io_opcode == 7'h13 ? 2'h2 : _GEN_51; // @[dut.scala 108:43 111:17]
  wire [3:0] _GEN_62 = io_opcode == 7'h13 ? _GEN_12 : _GEN_47; // @[dut.scala 108:43]
  wire  _GEN_63 = io_opcode == 7'h13 ? 1'h0 : _T_15; // @[dut.scala 108:43 73:16]
  wire  _GEN_64 = io_opcode == 7'h13 ? 1'h0 : _GEN_52; // @[dut.scala 108:43 74:16]
  wire  _GEN_65 = io_opcode == 7'h13 ? 1'h0 : _GEN_53; // @[dut.scala 108:43 72:16]
  wire  _GEN_66 = io_opcode == 7'h13 ? 1'h0 : _GEN_54; // @[dut.scala 108:43 79:16]
  wire  _GEN_67 = io_opcode == 7'h13 ? 1'h0 : _GEN_55; // @[dut.scala 108:43 77:16]
  wire  _GEN_68 = io_opcode == 7'h13 ? 1'h0 : _GEN_56; // @[dut.scala 108:43 80:16]
  wire  _GEN_69 = io_opcode == 7'h13 ? 1'h0 : _GEN_57; // @[dut.scala 108:43 81:16]
  wire  _GEN_70 = io_opcode == 7'h13 ? 1'h0 : _GEN_58; // @[dut.scala 108:43 78:16]
  assign io_aluop = io_opcode == 7'h33 ? _GEN_7 : _GEN_62; // @[dut.scala 86:32]
  assign io_immsrc = io_opcode == 7'h33 ? 1'h0 : _GEN_59; // @[dut.scala 86:32 87:15]
  assign io_isbranch = io_opcode == 7'h33 ? 1'h0 : _GEN_65; // @[dut.scala 72:16 86:32]
  assign io_memread = io_opcode == 7'h33 ? 1'h0 : _GEN_63; // @[dut.scala 73:16 86:32]
  assign io_memwrite = io_opcode == 7'h33 ? 1'h0 : _GEN_64; // @[dut.scala 74:16 86:32]
  assign io_regwrite = io_opcode == 7'h33 | _GEN_60; // @[dut.scala 86:32 88:17]
  assign io_memtoreg = io_opcode == 7'h33 ? 2'h2 : _GEN_61; // @[dut.scala 86:32 89:17]
  assign io_pcsel = io_opcode == 7'h33 ? 1'h0 : _GEN_67; // @[dut.scala 77:16 86:32]
  assign io_rdsel = io_opcode == 7'h33 ? 1'h0 : _GEN_70; // @[dut.scala 78:16 86:32]
  assign io_isjump = io_opcode == 7'h33 ? 1'h0 : _GEN_66; // @[dut.scala 79:16 86:32]
  assign io_isupper = io_opcode == 7'h33 ? 1'h0 : _GEN_68; // @[dut.scala 80:16 86:32]
  assign io_islui = io_opcode == 7'h33 ? 1'h0 : _GEN_69; // @[dut.scala 81:16 86:32]
endmodule
