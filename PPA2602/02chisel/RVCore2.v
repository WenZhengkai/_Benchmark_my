module IFU_LLM(
  input         clock,
  input         reset,
  input  [31:0] io_inst,
  input         io_to_idu_ready,
  output [31:0] io_to_idu_bits_inst,
  output [31:0] io_to_idu_bits_pc,
  output [31:0] io_to_idu_bits_next_pc,
  output        io_to_idu_bits_isBranch,
  output [31:0] io_pc,
  input  [31:0] io_redirect_target,
  input         io_redirect_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcReg; // @[IFU.scala 86:22]
  wire [6:0] opcode = io_inst[6:0]; // @[IFU.scala 92:23]
  wire  isJal = opcode == 7'h6f; // @[IFU.scala 94:23]
  wire  isJalr = opcode == 7'h67; // @[IFU.scala 95:24]
  wire  isBranch = opcode == 7'h63; // @[IFU.scala 96:26]
  wire  isJump = isJal | isJalr | isBranch; // @[IFU.scala 97:32]
  wire [10:0] _jalOffset_T_2 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] jalOffset = {_jalOffset_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] jalTarget = pcReg + jalOffset; // @[IFU.scala 110:25]
  wire [31:0] predictPc = pcReg + 32'h4; // @[IFU.scala 113:20]
  wire  _next_pc_T = ~io_to_idu_ready; // @[IFU.scala 119:5]
  wire  _next_pc_T_1 = ~isJump; // @[IFU.scala 120:5]
  wire  _next_pc_T_2 = isJalr | isBranch; // @[IFU.scala 122:13]
  wire [31:0] _next_pc_T_3 = _next_pc_T_2 ? predictPc : pcReg; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_4 = isJal ? jalTarget : _next_pc_T_3; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_5 = _next_pc_T_1 ? predictPc : _next_pc_T_4; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_6 = _next_pc_T ? pcReg : _next_pc_T_5; // @[Mux.scala 101:16]
  assign io_to_idu_bits_inst = io_inst; // @[IFU.scala 132:23]
  assign io_to_idu_bits_pc = pcReg; // @[IFU.scala 133:23]
  assign io_to_idu_bits_next_pc = io_redirect_valid ? io_redirect_target : _next_pc_T_6; // @[Mux.scala 101:16]
  assign io_to_idu_bits_isBranch = isJal | isJalr | isBranch; // @[IFU.scala 97:32]
  assign io_pc = pcReg; // @[IFU.scala 89:9]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 86:22]
      pcReg <= 32'h80000000; // @[IFU.scala 86:22]
    end else if (io_redirect_valid) begin // @[Mux.scala 101:16]
      pcReg <= io_redirect_target;
    end else if (!(_next_pc_T)) begin // @[Mux.scala 101:16]
      if (_next_pc_T_1) begin // @[Mux.scala 101:16]
        pcReg <= predictPc;
      end else begin
        pcReg <= _next_pc_T_4;
      end
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
  pcReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDU_LLM(
  output        io_from_ifu_ready,
  input         io_from_ifu_valid,
  input  [31:0] io_from_ifu_bits_inst,
  input  [31:0] io_from_ifu_bits_pc,
  input  [31:0] io_from_ifu_bits_next_pc,
  input         io_from_ifu_bits_isBranch,
  input         io_to_isu_ready,
  output        io_to_isu_valid,
  output [31:0] io_to_isu_bits_cf_inst,
  output [31:0] io_to_isu_bits_cf_pc,
  output [31:0] io_to_isu_bits_cf_next_pc,
  output        io_to_isu_bits_cf_isBranch,
  output        io_to_isu_bits_ctrl_MemWrite,
  output [1:0]  io_to_isu_bits_ctrl_ResSrc,
  output [2:0]  io_to_isu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_isu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_isu_bits_ctrl_fuType,
  output [6:0]  io_to_isu_bits_ctrl_fuOpType,
  output [4:0]  io_to_isu_bits_ctrl_rs1,
  output [4:0]  io_to_isu_bits_ctrl_rs2,
  output        io_to_isu_bits_ctrl_rfWen,
  output [4:0]  io_to_isu_bits_ctrl_rd,
  output [31:0] io_to_isu_bits_data_imm
);
  wire  _io_from_ifu_ready_T_1 = io_to_isu_ready & io_to_isu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _T = io_from_ifu_bits_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _T_1 = 32'h13 == _T; // @[Lookup.scala 31:38]
  wire [31:0] _T_2 = io_from_ifu_bits_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _T_3 = 32'h1013 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_5 = 32'h2013 == _T; // @[Lookup.scala 31:38]
  wire  _T_7 = 32'h3013 == _T; // @[Lookup.scala 31:38]
  wire  _T_9 = 32'h4013 == _T; // @[Lookup.scala 31:38]
  wire  _T_11 = 32'h5013 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_13 = 32'h6013 == _T; // @[Lookup.scala 31:38]
  wire  _T_15 = 32'h7013 == _T; // @[Lookup.scala 31:38]
  wire  _T_17 = 32'h40005013 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_19 = 32'h33 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_21 = 32'h1033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_23 = 32'h2033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_25 = 32'h3033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_27 = 32'h4033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_29 = 32'h5033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_31 = 32'h6033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_33 = 32'h7033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_35 = 32'h40000033 == _T_2; // @[Lookup.scala 31:38]
  wire  _T_37 = 32'h40005033 == _T_2; // @[Lookup.scala 31:38]
  wire [31:0] _T_38 = io_from_ifu_bits_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _T_39 = 32'h17 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_41 = 32'h37 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_43 = 32'h6f == _T_38; // @[Lookup.scala 31:38]
  wire  _T_45 = 32'h67 == _T; // @[Lookup.scala 31:38]
  wire  _T_47 = 32'h63 == _T; // @[Lookup.scala 31:38]
  wire  _T_49 = 32'h1063 == _T; // @[Lookup.scala 31:38]
  wire  _T_51 = 32'h4063 == _T; // @[Lookup.scala 31:38]
  wire  _T_53 = 32'h5063 == _T; // @[Lookup.scala 31:38]
  wire  _T_55 = 32'h6063 == _T; // @[Lookup.scala 31:38]
  wire  _T_57 = 32'h7063 == _T; // @[Lookup.scala 31:38]
  wire  _T_59 = 32'h23 == _T; // @[Lookup.scala 31:38]
  wire  _T_61 = 32'h1023 == _T; // @[Lookup.scala 31:38]
  wire  _T_63 = 32'h2023 == _T; // @[Lookup.scala 31:38]
  wire  _T_65 = 32'h3 == _T; // @[Lookup.scala 31:38]
  wire  _T_67 = 32'h1003 == _T; // @[Lookup.scala 31:38]
  wire  _T_69 = 32'h2003 == _T; // @[Lookup.scala 31:38]
  wire  _T_71 = 32'h4003 == _T; // @[Lookup.scala 31:38]
  wire  _T_73 = 32'h5003 == _T; // @[Lookup.scala 31:38]
  wire  _T_75 = 32'h1073 == _T; // @[Lookup.scala 31:38]
  wire  _T_77 = 32'h2073 == _T; // @[Lookup.scala 31:38]
  wire  _T_79 = 32'h73 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire  _T_81 = 32'h100073 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire  _T_83 = 32'h30200073 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire [2:0] _T_84 = _T_83 ? 3'h5 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _T_85 = _T_81 ? 3'h4 : _T_84; // @[Lookup.scala 34:39]
  wire [2:0] _T_86 = _T_79 ? 3'h4 : _T_85; // @[Lookup.scala 34:39]
  wire [2:0] _T_87 = _T_77 ? 3'h4 : _T_86; // @[Lookup.scala 34:39]
  wire [2:0] _T_88 = _T_75 ? 3'h4 : _T_87; // @[Lookup.scala 34:39]
  wire [2:0] _T_89 = _T_73 ? 3'h4 : _T_88; // @[Lookup.scala 34:39]
  wire [2:0] _T_90 = _T_71 ? 3'h4 : _T_89; // @[Lookup.scala 34:39]
  wire [2:0] _T_91 = _T_69 ? 3'h4 : _T_90; // @[Lookup.scala 34:39]
  wire [2:0] _T_92 = _T_67 ? 3'h4 : _T_91; // @[Lookup.scala 34:39]
  wire [2:0] _T_93 = _T_65 ? 3'h4 : _T_92; // @[Lookup.scala 34:39]
  wire [2:0] _T_94 = _T_63 ? 3'h2 : _T_93; // @[Lookup.scala 34:39]
  wire [2:0] _T_95 = _T_61 ? 3'h2 : _T_94; // @[Lookup.scala 34:39]
  wire [2:0] _T_96 = _T_59 ? 3'h2 : _T_95; // @[Lookup.scala 34:39]
  wire [2:0] _T_97 = _T_57 ? 3'h1 : _T_96; // @[Lookup.scala 34:39]
  wire [2:0] _T_98 = _T_55 ? 3'h1 : _T_97; // @[Lookup.scala 34:39]
  wire [2:0] _T_99 = _T_53 ? 3'h1 : _T_98; // @[Lookup.scala 34:39]
  wire [2:0] _T_100 = _T_51 ? 3'h1 : _T_99; // @[Lookup.scala 34:39]
  wire [2:0] _T_101 = _T_49 ? 3'h1 : _T_100; // @[Lookup.scala 34:39]
  wire [2:0] _T_102 = _T_47 ? 3'h1 : _T_101; // @[Lookup.scala 34:39]
  wire [2:0] _T_103 = _T_45 ? 3'h4 : _T_102; // @[Lookup.scala 34:39]
  wire [2:0] _T_104 = _T_43 ? 3'h7 : _T_103; // @[Lookup.scala 34:39]
  wire [2:0] _T_105 = _T_41 ? 3'h6 : _T_104; // @[Lookup.scala 34:39]
  wire [2:0] _T_106 = _T_39 ? 3'h6 : _T_105; // @[Lookup.scala 34:39]
  wire [2:0] _T_107 = _T_37 ? 3'h5 : _T_106; // @[Lookup.scala 34:39]
  wire [2:0] _T_108 = _T_35 ? 3'h5 : _T_107; // @[Lookup.scala 34:39]
  wire [2:0] _T_109 = _T_33 ? 3'h5 : _T_108; // @[Lookup.scala 34:39]
  wire [2:0] _T_110 = _T_31 ? 3'h5 : _T_109; // @[Lookup.scala 34:39]
  wire [2:0] _T_111 = _T_29 ? 3'h5 : _T_110; // @[Lookup.scala 34:39]
  wire [2:0] _T_112 = _T_27 ? 3'h5 : _T_111; // @[Lookup.scala 34:39]
  wire [2:0] _T_113 = _T_25 ? 3'h5 : _T_112; // @[Lookup.scala 34:39]
  wire [2:0] _T_114 = _T_23 ? 3'h5 : _T_113; // @[Lookup.scala 34:39]
  wire [2:0] _T_115 = _T_21 ? 3'h5 : _T_114; // @[Lookup.scala 34:39]
  wire [2:0] _T_116 = _T_19 ? 3'h5 : _T_115; // @[Lookup.scala 34:39]
  wire [2:0] _T_117 = _T_17 ? 3'h4 : _T_116; // @[Lookup.scala 34:39]
  wire [2:0] _T_118 = _T_15 ? 3'h4 : _T_117; // @[Lookup.scala 34:39]
  wire [2:0] _T_119 = _T_13 ? 3'h4 : _T_118; // @[Lookup.scala 34:39]
  wire [2:0] _T_120 = _T_11 ? 3'h4 : _T_119; // @[Lookup.scala 34:39]
  wire [2:0] _T_121 = _T_9 ? 3'h4 : _T_120; // @[Lookup.scala 34:39]
  wire [2:0] _T_122 = _T_7 ? 3'h4 : _T_121; // @[Lookup.scala 34:39]
  wire [2:0] _T_123 = _T_5 ? 3'h4 : _T_122; // @[Lookup.scala 34:39]
  wire [2:0] _T_124 = _T_3 ? 3'h4 : _T_123; // @[Lookup.scala 34:39]
  wire [2:0] instType = _T_1 ? 3'h4 : _T_124; // @[Lookup.scala 34:39]
  wire [1:0] _T_125 = _T_83 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _T_126 = _T_81 ? 2'h3 : _T_125; // @[Lookup.scala 34:39]
  wire [1:0] _T_127 = _T_79 ? 2'h3 : _T_126; // @[Lookup.scala 34:39]
  wire [1:0] _T_128 = _T_77 ? 2'h3 : _T_127; // @[Lookup.scala 34:39]
  wire [1:0] _T_129 = _T_75 ? 2'h3 : _T_128; // @[Lookup.scala 34:39]
  wire [1:0] _T_130 = _T_73 ? 2'h1 : _T_129; // @[Lookup.scala 34:39]
  wire [1:0] _T_131 = _T_71 ? 2'h1 : _T_130; // @[Lookup.scala 34:39]
  wire [1:0] _T_132 = _T_69 ? 2'h1 : _T_131; // @[Lookup.scala 34:39]
  wire [1:0] _T_133 = _T_67 ? 2'h1 : _T_132; // @[Lookup.scala 34:39]
  wire [1:0] _T_134 = _T_65 ? 2'h1 : _T_133; // @[Lookup.scala 34:39]
  wire [1:0] _T_135 = _T_63 ? 2'h1 : _T_134; // @[Lookup.scala 34:39]
  wire [1:0] _T_136 = _T_61 ? 2'h1 : _T_135; // @[Lookup.scala 34:39]
  wire [1:0] _T_137 = _T_59 ? 2'h1 : _T_136; // @[Lookup.scala 34:39]
  wire [1:0] _T_138 = _T_57 ? 2'h0 : _T_137; // @[Lookup.scala 34:39]
  wire [1:0] _T_139 = _T_55 ? 2'h0 : _T_138; // @[Lookup.scala 34:39]
  wire [1:0] _T_140 = _T_53 ? 2'h0 : _T_139; // @[Lookup.scala 34:39]
  wire [1:0] _T_141 = _T_51 ? 2'h0 : _T_140; // @[Lookup.scala 34:39]
  wire [1:0] _T_142 = _T_49 ? 2'h0 : _T_141; // @[Lookup.scala 34:39]
  wire [1:0] _T_143 = _T_47 ? 2'h0 : _T_142; // @[Lookup.scala 34:39]
  wire [1:0] _T_144 = _T_45 ? 2'h0 : _T_143; // @[Lookup.scala 34:39]
  wire [1:0] _T_145 = _T_43 ? 2'h0 : _T_144; // @[Lookup.scala 34:39]
  wire [1:0] _T_146 = _T_41 ? 2'h0 : _T_145; // @[Lookup.scala 34:39]
  wire [1:0] _T_147 = _T_39 ? 2'h0 : _T_146; // @[Lookup.scala 34:39]
  wire [1:0] _T_148 = _T_37 ? 2'h0 : _T_147; // @[Lookup.scala 34:39]
  wire [1:0] _T_149 = _T_35 ? 2'h0 : _T_148; // @[Lookup.scala 34:39]
  wire [1:0] _T_150 = _T_33 ? 2'h0 : _T_149; // @[Lookup.scala 34:39]
  wire [1:0] _T_151 = _T_31 ? 2'h0 : _T_150; // @[Lookup.scala 34:39]
  wire [1:0] _T_152 = _T_29 ? 2'h0 : _T_151; // @[Lookup.scala 34:39]
  wire [1:0] _T_153 = _T_27 ? 2'h0 : _T_152; // @[Lookup.scala 34:39]
  wire [1:0] _T_154 = _T_25 ? 2'h0 : _T_153; // @[Lookup.scala 34:39]
  wire [1:0] _T_155 = _T_23 ? 2'h0 : _T_154; // @[Lookup.scala 34:39]
  wire [1:0] _T_156 = _T_21 ? 2'h0 : _T_155; // @[Lookup.scala 34:39]
  wire [1:0] _T_157 = _T_19 ? 2'h0 : _T_156; // @[Lookup.scala 34:39]
  wire [1:0] _T_158 = _T_17 ? 2'h0 : _T_157; // @[Lookup.scala 34:39]
  wire [1:0] _T_159 = _T_15 ? 2'h0 : _T_158; // @[Lookup.scala 34:39]
  wire [1:0] _T_160 = _T_13 ? 2'h0 : _T_159; // @[Lookup.scala 34:39]
  wire [1:0] _T_161 = _T_11 ? 2'h0 : _T_160; // @[Lookup.scala 34:39]
  wire [1:0] _T_162 = _T_9 ? 2'h0 : _T_161; // @[Lookup.scala 34:39]
  wire [1:0] _T_163 = _T_7 ? 2'h0 : _T_162; // @[Lookup.scala 34:39]
  wire [1:0] _T_164 = _T_5 ? 2'h0 : _T_163; // @[Lookup.scala 34:39]
  wire [1:0] _T_165 = _T_3 ? 2'h0 : _T_164; // @[Lookup.scala 34:39]
  wire [1:0] fuType = _T_1 ? 2'h0 : _T_165; // @[Lookup.scala 34:39]
  wire  _T_166 = _T_83 ? 1'h0 : 1'h1; // @[Lookup.scala 34:39]
  wire  _T_167 = _T_81 ? 1'h0 : _T_166; // @[Lookup.scala 34:39]
  wire  _T_168 = _T_79 ? 1'h0 : _T_167; // @[Lookup.scala 34:39]
  wire [1:0] _T_169 = _T_77 ? 2'h2 : {{1'd0}, _T_168}; // @[Lookup.scala 34:39]
  wire [1:0] _T_170 = _T_75 ? 2'h1 : _T_169; // @[Lookup.scala 34:39]
  wire [2:0] _T_171 = _T_73 ? 3'h5 : {{1'd0}, _T_170}; // @[Lookup.scala 34:39]
  wire [2:0] _T_172 = _T_71 ? 3'h4 : _T_171; // @[Lookup.scala 34:39]
  wire [2:0] _T_173 = _T_69 ? 3'h2 : _T_172; // @[Lookup.scala 34:39]
  wire [2:0] _T_174 = _T_67 ? 3'h1 : _T_173; // @[Lookup.scala 34:39]
  wire [2:0] _T_175 = _T_65 ? 3'h0 : _T_174; // @[Lookup.scala 34:39]
  wire [3:0] _T_176 = _T_63 ? 4'ha : {{1'd0}, _T_175}; // @[Lookup.scala 34:39]
  wire [3:0] _T_177 = _T_61 ? 4'h9 : _T_176; // @[Lookup.scala 34:39]
  wire [3:0] _T_178 = _T_59 ? 4'h8 : _T_177; // @[Lookup.scala 34:39]
  wire [4:0] _T_179 = _T_57 ? 5'h17 : {{1'd0}, _T_178}; // @[Lookup.scala 34:39]
  wire [4:0] _T_180 = _T_55 ? 5'h16 : _T_179; // @[Lookup.scala 34:39]
  wire [4:0] _T_181 = _T_53 ? 5'h15 : _T_180; // @[Lookup.scala 34:39]
  wire [4:0] _T_182 = _T_51 ? 5'h14 : _T_181; // @[Lookup.scala 34:39]
  wire [4:0] _T_183 = _T_49 ? 5'h11 : _T_182; // @[Lookup.scala 34:39]
  wire [4:0] _T_184 = _T_47 ? 5'h10 : _T_183; // @[Lookup.scala 34:39]
  wire [6:0] _T_185 = _T_45 ? 7'h40 : {{2'd0}, _T_184}; // @[Lookup.scala 34:39]
  wire [6:0] _T_186 = _T_43 ? 7'h40 : _T_185; // @[Lookup.scala 34:39]
  wire [6:0] _T_187 = _T_41 ? 7'h40 : _T_186; // @[Lookup.scala 34:39]
  wire [6:0] _T_188 = _T_39 ? 7'h40 : _T_187; // @[Lookup.scala 34:39]
  wire [6:0] _T_189 = _T_37 ? 7'hd : _T_188; // @[Lookup.scala 34:39]
  wire [6:0] _T_190 = _T_35 ? 7'h8 : _T_189; // @[Lookup.scala 34:39]
  wire [6:0] _T_191 = _T_33 ? 7'h7 : _T_190; // @[Lookup.scala 34:39]
  wire [6:0] _T_192 = _T_31 ? 7'h6 : _T_191; // @[Lookup.scala 34:39]
  wire [6:0] _T_193 = _T_29 ? 7'h5 : _T_192; // @[Lookup.scala 34:39]
  wire [6:0] _T_194 = _T_27 ? 7'h4 : _T_193; // @[Lookup.scala 34:39]
  wire [6:0] _T_195 = _T_25 ? 7'h3 : _T_194; // @[Lookup.scala 34:39]
  wire [6:0] _T_196 = _T_23 ? 7'h2 : _T_195; // @[Lookup.scala 34:39]
  wire [6:0] _T_197 = _T_21 ? 7'h1 : _T_196; // @[Lookup.scala 34:39]
  wire [6:0] _T_198 = _T_19 ? 7'h40 : _T_197; // @[Lookup.scala 34:39]
  wire [6:0] _T_199 = _T_17 ? 7'hd : _T_198; // @[Lookup.scala 34:39]
  wire [6:0] _T_200 = _T_15 ? 7'h7 : _T_199; // @[Lookup.scala 34:39]
  wire [6:0] _T_201 = _T_13 ? 7'h6 : _T_200; // @[Lookup.scala 34:39]
  wire [6:0] _T_202 = _T_11 ? 7'h5 : _T_201; // @[Lookup.scala 34:39]
  wire [6:0] _T_203 = _T_9 ? 7'h4 : _T_202; // @[Lookup.scala 34:39]
  wire [6:0] _T_204 = _T_7 ? 7'h3 : _T_203; // @[Lookup.scala 34:39]
  wire [6:0] _T_205 = _T_5 ? 7'h2 : _T_204; // @[Lookup.scala 34:39]
  wire [6:0] _T_206 = _T_3 ? 7'h1 : _T_205; // @[Lookup.scala 34:39]
  wire [2:0] _T_207 = _T_83 ? 3'h0 : 3'h4; // @[Lookup.scala 34:39]
  wire [2:0] _T_208 = _T_81 ? 3'h0 : _T_207; // @[Lookup.scala 34:39]
  wire [2:0] _T_209 = _T_79 ? 3'h0 : _T_208; // @[Lookup.scala 34:39]
  wire [2:0] _T_210 = _T_77 ? 3'h0 : _T_209; // @[Lookup.scala 34:39]
  wire [2:0] _T_211 = _T_75 ? 3'h0 : _T_210; // @[Lookup.scala 34:39]
  wire [2:0] _T_212 = _T_73 ? 3'h0 : _T_211; // @[Lookup.scala 34:39]
  wire [2:0] _T_213 = _T_71 ? 3'h0 : _T_212; // @[Lookup.scala 34:39]
  wire [2:0] _T_214 = _T_69 ? 3'h0 : _T_213; // @[Lookup.scala 34:39]
  wire [2:0] _T_215 = _T_67 ? 3'h0 : _T_214; // @[Lookup.scala 34:39]
  wire [2:0] _T_216 = _T_65 ? 3'h0 : _T_215; // @[Lookup.scala 34:39]
  wire [2:0] _T_217 = _T_63 ? 3'h0 : _T_216; // @[Lookup.scala 34:39]
  wire [2:0] _T_218 = _T_61 ? 3'h0 : _T_217; // @[Lookup.scala 34:39]
  wire [2:0] _T_219 = _T_59 ? 3'h0 : _T_218; // @[Lookup.scala 34:39]
  wire [2:0] _T_220 = _T_57 ? 3'h0 : _T_219; // @[Lookup.scala 34:39]
  wire [2:0] _T_221 = _T_55 ? 3'h0 : _T_220; // @[Lookup.scala 34:39]
  wire [2:0] _T_222 = _T_53 ? 3'h0 : _T_221; // @[Lookup.scala 34:39]
  wire [2:0] _T_223 = _T_51 ? 3'h0 : _T_222; // @[Lookup.scala 34:39]
  wire [2:0] _T_224 = _T_49 ? 3'h0 : _T_223; // @[Lookup.scala 34:39]
  wire [2:0] _T_225 = _T_47 ? 3'h0 : _T_224; // @[Lookup.scala 34:39]
  wire [2:0] _T_226 = _T_45 ? 3'h2 : _T_225; // @[Lookup.scala 34:39]
  wire [2:0] _T_227 = _T_43 ? 3'h2 : _T_226; // @[Lookup.scala 34:39]
  wire [2:0] _T_228 = _T_41 ? 3'h4 : _T_227; // @[Lookup.scala 34:39]
  wire [2:0] _T_229 = _T_39 ? 3'h2 : _T_228; // @[Lookup.scala 34:39]
  wire [2:0] _T_230 = _T_37 ? 3'h0 : _T_229; // @[Lookup.scala 34:39]
  wire [2:0] _T_231 = _T_35 ? 3'h0 : _T_230; // @[Lookup.scala 34:39]
  wire [2:0] _T_232 = _T_33 ? 3'h0 : _T_231; // @[Lookup.scala 34:39]
  wire [2:0] _T_233 = _T_31 ? 3'h0 : _T_232; // @[Lookup.scala 34:39]
  wire [2:0] _T_234 = _T_29 ? 3'h0 : _T_233; // @[Lookup.scala 34:39]
  wire [2:0] _T_235 = _T_27 ? 3'h0 : _T_234; // @[Lookup.scala 34:39]
  wire [2:0] _T_236 = _T_25 ? 3'h0 : _T_235; // @[Lookup.scala 34:39]
  wire [2:0] _T_237 = _T_23 ? 3'h0 : _T_236; // @[Lookup.scala 34:39]
  wire [2:0] _T_238 = _T_21 ? 3'h0 : _T_237; // @[Lookup.scala 34:39]
  wire [2:0] _T_239 = _T_19 ? 3'h0 : _T_238; // @[Lookup.scala 34:39]
  wire [2:0] _T_240 = _T_17 ? 3'h0 : _T_239; // @[Lookup.scala 34:39]
  wire [2:0] _T_241 = _T_15 ? 3'h0 : _T_240; // @[Lookup.scala 34:39]
  wire [2:0] _T_242 = _T_13 ? 3'h0 : _T_241; // @[Lookup.scala 34:39]
  wire [2:0] _T_243 = _T_11 ? 3'h0 : _T_242; // @[Lookup.scala 34:39]
  wire [2:0] _T_244 = _T_9 ? 3'h0 : _T_243; // @[Lookup.scala 34:39]
  wire [2:0] _T_245 = _T_7 ? 3'h0 : _T_244; // @[Lookup.scala 34:39]
  wire [2:0] _T_246 = _T_5 ? 3'h0 : _T_245; // @[Lookup.scala 34:39]
  wire [2:0] _T_247 = _T_3 ? 3'h0 : _T_246; // @[Lookup.scala 34:39]
  wire [2:0] _T_248 = _T_83 ? 3'h1 : 3'h4; // @[Lookup.scala 34:39]
  wire [2:0] _T_249 = _T_81 ? 3'h3 : _T_248; // @[Lookup.scala 34:39]
  wire [2:0] _T_250 = _T_79 ? 3'h3 : _T_249; // @[Lookup.scala 34:39]
  wire [2:0] _T_251 = _T_77 ? 3'h3 : _T_250; // @[Lookup.scala 34:39]
  wire [2:0] _T_252 = _T_75 ? 3'h3 : _T_251; // @[Lookup.scala 34:39]
  wire [2:0] _T_253 = _T_73 ? 3'h3 : _T_252; // @[Lookup.scala 34:39]
  wire [2:0] _T_254 = _T_71 ? 3'h3 : _T_253; // @[Lookup.scala 34:39]
  wire [2:0] _T_255 = _T_69 ? 3'h3 : _T_254; // @[Lookup.scala 34:39]
  wire [2:0] _T_256 = _T_67 ? 3'h3 : _T_255; // @[Lookup.scala 34:39]
  wire [2:0] _T_257 = _T_65 ? 3'h3 : _T_256; // @[Lookup.scala 34:39]
  wire [2:0] _T_258 = _T_63 ? 3'h3 : _T_257; // @[Lookup.scala 34:39]
  wire [2:0] _T_259 = _T_61 ? 3'h3 : _T_258; // @[Lookup.scala 34:39]
  wire [2:0] _T_260 = _T_59 ? 3'h3 : _T_259; // @[Lookup.scala 34:39]
  wire [2:0] _T_261 = _T_57 ? 3'h1 : _T_260; // @[Lookup.scala 34:39]
  wire [2:0] _T_262 = _T_55 ? 3'h1 : _T_261; // @[Lookup.scala 34:39]
  wire [2:0] _T_263 = _T_53 ? 3'h1 : _T_262; // @[Lookup.scala 34:39]
  wire [2:0] _T_264 = _T_51 ? 3'h1 : _T_263; // @[Lookup.scala 34:39]
  wire [2:0] _T_265 = _T_49 ? 3'h1 : _T_264; // @[Lookup.scala 34:39]
  wire [2:0] _T_266 = _T_47 ? 3'h1 : _T_265; // @[Lookup.scala 34:39]
  wire [2:0] _T_267 = _T_45 ? 3'h5 : _T_266; // @[Lookup.scala 34:39]
  wire [2:0] _T_268 = _T_43 ? 3'h5 : _T_267; // @[Lookup.scala 34:39]
  wire [2:0] _T_269 = _T_41 ? 3'h3 : _T_268; // @[Lookup.scala 34:39]
  wire [2:0] _T_270 = _T_39 ? 3'h3 : _T_269; // @[Lookup.scala 34:39]
  wire [2:0] _T_271 = _T_37 ? 3'h1 : _T_270; // @[Lookup.scala 34:39]
  wire [2:0] _T_272 = _T_35 ? 3'h1 : _T_271; // @[Lookup.scala 34:39]
  wire [2:0] _T_273 = _T_33 ? 3'h1 : _T_272; // @[Lookup.scala 34:39]
  wire [2:0] _T_274 = _T_31 ? 3'h1 : _T_273; // @[Lookup.scala 34:39]
  wire [2:0] _T_275 = _T_29 ? 3'h1 : _T_274; // @[Lookup.scala 34:39]
  wire [2:0] _T_276 = _T_27 ? 3'h1 : _T_275; // @[Lookup.scala 34:39]
  wire [2:0] _T_277 = _T_25 ? 3'h1 : _T_276; // @[Lookup.scala 34:39]
  wire [2:0] _T_278 = _T_23 ? 3'h1 : _T_277; // @[Lookup.scala 34:39]
  wire [2:0] _T_279 = _T_21 ? 3'h1 : _T_278; // @[Lookup.scala 34:39]
  wire [2:0] _T_280 = _T_19 ? 3'h1 : _T_279; // @[Lookup.scala 34:39]
  wire [2:0] _T_281 = _T_17 ? 3'h3 : _T_280; // @[Lookup.scala 34:39]
  wire [2:0] _T_282 = _T_15 ? 3'h3 : _T_281; // @[Lookup.scala 34:39]
  wire [2:0] _T_283 = _T_13 ? 3'h3 : _T_282; // @[Lookup.scala 34:39]
  wire [2:0] _T_284 = _T_11 ? 3'h3 : _T_283; // @[Lookup.scala 34:39]
  wire [2:0] _T_285 = _T_9 ? 3'h3 : _T_284; // @[Lookup.scala 34:39]
  wire [2:0] _T_286 = _T_7 ? 3'h3 : _T_285; // @[Lookup.scala 34:39]
  wire [2:0] _T_287 = _T_5 ? 3'h3 : _T_286; // @[Lookup.scala 34:39]
  wire [2:0] _T_288 = _T_3 ? 3'h3 : _T_287; // @[Lookup.scala 34:39]
  wire [4:0] ctrl_rd = io_from_ifu_bits_inst[11:7]; // @[IDU.scala 222:18]
  wire  ctrl_MemWrite = instType == 3'h2; // @[IDU.scala 223:30]
  wire  _ctrl_ResSrc_T_1 = io_from_ifu_bits_inst[6:0] == 7'h3; // @[IDU.scala 225:17]
  wire  _ctrl_ResSrc_T_3 = io_from_ifu_bits_inst[6:0] == 7'h73; // @[IDU.scala 226:17]
  wire [1:0] _ctrl_ResSrc_T_4 = _ctrl_ResSrc_T_3 ? 2'h2 : 2'h0; // @[Mux.scala 101:16]
  wire  _imm_T = instType == 3'h4; // @[IDU.scala 237:15]
  wire  imm_signBit = io_from_ifu_bits_inst[31]; // @[EXU.scala 8:20]
  wire [19:0] _imm_T_3 = imm_signBit ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _imm_T_4 = {_imm_T_3,io_from_ifu_bits_inst[31:20]}; // @[Cat.scala 33:92]
  wire  _imm_T_5 = instType == 3'h6; // @[IDU.scala 238:15]
  wire [31:0] _imm_T_8 = {io_from_ifu_bits_inst[31:12],12'h0}; // @[Cat.scala 33:92]
  wire  _imm_T_10 = instType == 3'h7; // @[IDU.scala 239:15]
  wire [20:0] _imm_T_15 = {io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[19:12],io_from_ifu_bits_inst[20],
    io_from_ifu_bits_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire  imm_signBit_2 = _imm_T_15[20]; // @[EXU.scala 8:20]
  wire [10:0] _imm_T_17 = imm_signBit_2 ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _imm_T_18 = {_imm_T_17,io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[19:12],io_from_ifu_bits_inst[20],
    io_from_ifu_bits_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [11:0] _imm_T_22 = {io_from_ifu_bits_inst[31:25],ctrl_rd}; // @[Cat.scala 33:92]
  wire  imm_signBit_3 = _imm_T_22[11]; // @[EXU.scala 8:20]
  wire [19:0] _imm_T_24 = imm_signBit_3 ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _imm_T_25 = {_imm_T_24,io_from_ifu_bits_inst[31:25],ctrl_rd}; // @[Cat.scala 33:92]
  wire  _imm_T_26 = instType == 3'h1; // @[IDU.scala 241:15]
  wire [12:0] _imm_T_31 = {io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[7],io_from_ifu_bits_inst[30:25],
    io_from_ifu_bits_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire  imm_signBit_4 = _imm_T_31[12]; // @[EXU.scala 8:20]
  wire [18:0] _imm_T_33 = imm_signBit_4 ? 19'h7ffff : 19'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _imm_T_34 = {_imm_T_33,io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[7],io_from_ifu_bits_inst[30:25],
    io_from_ifu_bits_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] _imm_T_35 = _imm_T_26 ? _imm_T_34 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _imm_T_36 = ctrl_MemWrite ? _imm_T_25 : _imm_T_35; // @[Mux.scala 101:16]
  wire [31:0] _imm_T_37 = _imm_T_10 ? _imm_T_18 : _imm_T_36; // @[Mux.scala 101:16]
  wire [31:0] _imm_T_38 = _imm_T_5 ? _imm_T_8 : _imm_T_37; // @[Mux.scala 101:16]
  assign io_from_ifu_ready = ~io_from_ifu_valid | _io_from_ifu_ready_T_1; // @[RVCore.scala 66:56]
  assign io_to_isu_valid = io_from_ifu_valid; // @[RVCore.scala 67:40]
  assign io_to_isu_bits_cf_inst = io_from_ifu_bits_inst; // @[IDU.scala 254:21]
  assign io_to_isu_bits_cf_pc = io_from_ifu_bits_pc; // @[IDU.scala 254:21]
  assign io_to_isu_bits_cf_next_pc = io_from_ifu_bits_next_pc; // @[IDU.scala 254:21]
  assign io_to_isu_bits_cf_isBranch = io_from_ifu_bits_isBranch; // @[IDU.scala 254:21]
  assign io_to_isu_bits_ctrl_MemWrite = instType == 3'h2; // @[IDU.scala 223:30]
  assign io_to_isu_bits_ctrl_ResSrc = _ctrl_ResSrc_T_1 ? 2'h1 : _ctrl_ResSrc_T_4; // @[Mux.scala 101:16]
  assign io_to_isu_bits_ctrl_fuSrc1Type = _T_1 ? 3'h0 : _T_247; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_fuSrc2Type = _T_1 ? 3'h3 : _T_288; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_fuType = {{1'd0}, fuType}; // @[IDU.scala 217:18 230:15]
  assign io_to_isu_bits_ctrl_fuOpType = _T_1 ? 7'h40 : _T_206; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_rs1 = io_from_ifu_bits_inst[19:15]; // @[IDU.scala 220:19]
  assign io_to_isu_bits_ctrl_rs2 = io_from_ifu_bits_inst[24:20]; // @[IDU.scala 221:19]
  assign io_to_isu_bits_ctrl_rfWen = instType[2]; // @[IDU.scala 15:54]
  assign io_to_isu_bits_ctrl_rd = io_from_ifu_bits_inst[11:7]; // @[IDU.scala 222:18]
  assign io_to_isu_bits_data_imm = _imm_T ? _imm_T_4 : _imm_T_38; // @[Mux.scala 101:16]
endmodule
module ISU_LLM(
  input         clock,
  input         reset,
  output        io_from_idu_ready,
  input         io_from_idu_valid,
  input  [31:0] io_from_idu_bits_cf_inst,
  input  [31:0] io_from_idu_bits_cf_pc,
  input  [31:0] io_from_idu_bits_cf_next_pc,
  input         io_from_idu_bits_cf_isBranch,
  input         io_from_idu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_idu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuType,
  input  [6:0]  io_from_idu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_idu_bits_ctrl_rs1,
  input  [4:0]  io_from_idu_bits_ctrl_rs2,
  input         io_from_idu_bits_ctrl_rfWen,
  input  [4:0]  io_from_idu_bits_ctrl_rd,
  input  [31:0] io_from_idu_bits_data_imm,
  input         io_to_exu_ready,
  output        io_to_exu_valid,
  output [31:0] io_to_exu_bits_cf_inst,
  output [31:0] io_to_exu_bits_cf_pc,
  output [31:0] io_to_exu_bits_cf_next_pc,
  output        io_to_exu_bits_cf_isBranch,
  output        io_to_exu_bits_ctrl_MemWrite,
  output [1:0]  io_to_exu_bits_ctrl_ResSrc,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
  output        io_to_exu_bits_ctrl_rfWen,
  output [4:0]  io_to_exu_bits_ctrl_rd,
  output [31:0] io_to_exu_bits_data_fuSrc1,
  output [31:0] io_to_exu_bits_data_fuSrc2,
  output [31:0] io_to_exu_bits_data_imm,
  output [31:0] io_to_exu_bits_data_rfSrc1,
  output [31:0] io_to_exu_bits_data_rfSrc2,
  input  [4:0]  io_wb_rd,
  input         io_wb_RegWrite,
  input  [31:0] io_from_reg_rfSrc1,
  input  [31:0] io_from_reg_rfSrc2
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] busy_1; // @[ISU.scala 23:23]
  reg [1:0] busy_2; // @[ISU.scala 23:23]
  reg [1:0] busy_3; // @[ISU.scala 23:23]
  reg [1:0] busy_4; // @[ISU.scala 23:23]
  reg [1:0] busy_5; // @[ISU.scala 23:23]
  reg [1:0] busy_6; // @[ISU.scala 23:23]
  reg [1:0] busy_7; // @[ISU.scala 23:23]
  reg [1:0] busy_8; // @[ISU.scala 23:23]
  reg [1:0] busy_9; // @[ISU.scala 23:23]
  reg [1:0] busy_10; // @[ISU.scala 23:23]
  reg [1:0] busy_11; // @[ISU.scala 23:23]
  reg [1:0] busy_12; // @[ISU.scala 23:23]
  reg [1:0] busy_13; // @[ISU.scala 23:23]
  reg [1:0] busy_14; // @[ISU.scala 23:23]
  reg [1:0] busy_15; // @[ISU.scala 23:23]
  wire [1:0] _GEN_1 = 4'h1 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_2 = 4'h2 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_2 : _GEN_1; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_3 = 4'h3 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_3 : _GEN_2; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_4 = 4'h4 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_4 : _GEN_3; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_5 = 4'h5 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_5 : _GEN_4; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_6 = 4'h6 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_6 : _GEN_5; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_7 = 4'h7 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_7 : _GEN_6; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_8 = 4'h8 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_8 : _GEN_7; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_9 = 4'h9 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_9 : _GEN_8; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_10 = 4'ha == io_from_idu_bits_ctrl_rs1[3:0] ? busy_10 : _GEN_9; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_11 = 4'hb == io_from_idu_bits_ctrl_rs1[3:0] ? busy_11 : _GEN_10; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_12 = 4'hc == io_from_idu_bits_ctrl_rs1[3:0] ? busy_12 : _GEN_11; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_13 = 4'hd == io_from_idu_bits_ctrl_rs1[3:0] ? busy_13 : _GEN_12; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_14 = 4'he == io_from_idu_bits_ctrl_rs1[3:0] ? busy_14 : _GEN_13; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_15 = 4'hf == io_from_idu_bits_ctrl_rs1[3:0] ? busy_15 : _GEN_14; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_1 = _GEN_15 != 2'h0; // @[ISU.scala 24:47]
  wire [1:0] _GEN_17 = 4'h1 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_18 = 4'h2 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_2 : _GEN_17; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_19 = 4'h3 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_3 : _GEN_18; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_20 = 4'h4 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_4 : _GEN_19; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_21 = 4'h5 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_5 : _GEN_20; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_22 = 4'h6 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_6 : _GEN_21; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_23 = 4'h7 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_7 : _GEN_22; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_24 = 4'h8 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_8 : _GEN_23; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_25 = 4'h9 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_9 : _GEN_24; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_26 = 4'ha == io_from_idu_bits_ctrl_rs2[3:0] ? busy_10 : _GEN_25; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_27 = 4'hb == io_from_idu_bits_ctrl_rs2[3:0] ? busy_11 : _GEN_26; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_28 = 4'hc == io_from_idu_bits_ctrl_rs2[3:0] ? busy_12 : _GEN_27; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_29 = 4'hd == io_from_idu_bits_ctrl_rs2[3:0] ? busy_13 : _GEN_28; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_30 = 4'he == io_from_idu_bits_ctrl_rs2[3:0] ? busy_14 : _GEN_29; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_31 = 4'hf == io_from_idu_bits_ctrl_rs2[3:0] ? busy_15 : _GEN_30; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_3 = _GEN_31 != 2'h0; // @[ISU.scala 24:47]
  wire  AnyInvalidCondition = _AnyInvalidCondition_T_1 | _AnyInvalidCondition_T_3; // @[ISU.scala 138:66]
  wire  _io_from_idu_ready_T_1 = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _fuSrc1_T_1 = 3'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_reg_rfSrc1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc1_T_3 = 3'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc : _fuSrc1_T_1; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_1 = 3'h1 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_reg_rfSrc2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_3 = 3'h3 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm : _fuSrc2_T_1; // @[Mux.scala 81:58]
  wire [46:0] _isFireSetMask_T_2 = 47'h1 << io_from_idu_bits_ctrl_rd; // @[ISU.scala 25:50]
  wire [15:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _io_from_idu_ready_T_1 ? _isFireSetMask_T_2[15:0] : 16'h0; // @[ISU.scala 159:26]
  wire [46:0] _wbuClearMask_T = 47'h1 << io_wb_rd; // @[ISU.scala 25:50]
  wire [15:0] wbuClearMask = io_wb_RegWrite ? _wbuClearMask_T[15:0] : 16'h0; // @[ISU.scala 160:25]
  wire [1:0] _busy_1_T_2 = busy_1 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_1_T_6 = busy_1 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_1_T_7 = busy_1 == 2'h0 ? 2'h0 : _busy_1_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_2_T_2 = busy_2 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_2_T_6 = busy_2 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_2_T_7 = busy_2 == 2'h0 ? 2'h0 : _busy_2_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_3_T_2 = busy_3 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_3_T_6 = busy_3 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_3_T_7 = busy_3 == 2'h0 ? 2'h0 : _busy_3_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_4_T_2 = busy_4 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_4_T_6 = busy_4 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_4_T_7 = busy_4 == 2'h0 ? 2'h0 : _busy_4_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_5_T_2 = busy_5 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_5_T_6 = busy_5 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_5_T_7 = busy_5 == 2'h0 ? 2'h0 : _busy_5_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_6_T_2 = busy_6 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_6_T_6 = busy_6 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_6_T_7 = busy_6 == 2'h0 ? 2'h0 : _busy_6_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_7_T_2 = busy_7 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_7_T_6 = busy_7 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_7_T_7 = busy_7 == 2'h0 ? 2'h0 : _busy_7_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_8_T_2 = busy_8 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_8_T_6 = busy_8 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_8_T_7 = busy_8 == 2'h0 ? 2'h0 : _busy_8_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_9_T_2 = busy_9 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_9_T_6 = busy_9 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_9_T_7 = busy_9 == 2'h0 ? 2'h0 : _busy_9_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_10_T_2 = busy_10 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_10_T_6 = busy_10 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_10_T_7 = busy_10 == 2'h0 ? 2'h0 : _busy_10_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_11_T_2 = busy_11 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_11_T_6 = busy_11 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_11_T_7 = busy_11 == 2'h0 ? 2'h0 : _busy_11_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_12_T_2 = busy_12 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_12_T_6 = busy_12 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_12_T_7 = busy_12 == 2'h0 ? 2'h0 : _busy_12_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_13_T_2 = busy_13 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_13_T_6 = busy_13 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_13_T_7 = busy_13 == 2'h0 ? 2'h0 : _busy_13_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_14_T_2 = busy_14 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_14_T_6 = busy_14 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_14_T_7 = busy_14 == 2'h0 ? 2'h0 : _busy_14_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_15_T_2 = busy_15 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_15_T_6 = busy_15 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_15_T_7 = busy_15 == 2'h0 ? 2'h0 : _busy_15_T_6; // @[ISU.scala 34:33]
  assign io_from_idu_ready = ~io_from_idu_valid | _io_from_idu_ready_T_1; // @[RVCore.scala 66:56]
  assign io_to_exu_valid = io_from_idu_valid & ~AnyInvalidCondition; // @[RVCore.scala 67:40]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_fuSrc1 = 3'h4 == io_from_idu_bits_ctrl_fuSrc1Type ? 32'h0 : _fuSrc1_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 3'h5 == io_from_idu_bits_ctrl_fuSrc2Type ? 32'h4 : _fuSrc2_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_rfSrc1 = io_from_reg_rfSrc1; // @[ISU.scala 156:30]
  assign io_to_exu_bits_data_rfSrc2 = io_from_reg_rfSrc2; // @[ISU.scala 157:30]
  always @(posedge clock) begin
    if (reset) begin // @[ISU.scala 23:23]
      busy_1 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[1] & wbuClearMask[1])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[1]) begin // @[ISU.scala 31:38]
        if (busy_1 == 2'h3) begin // @[ISU.scala 32:33]
          busy_1 <= 2'h3;
        end else begin
          busy_1 <= _busy_1_T_2;
        end
      end else if (wbuClearMask[1]) begin // @[ISU.scala 33:40]
        busy_1 <= _busy_1_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_2 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[2] & wbuClearMask[2])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[2]) begin // @[ISU.scala 31:38]
        if (busy_2 == 2'h3) begin // @[ISU.scala 32:33]
          busy_2 <= 2'h3;
        end else begin
          busy_2 <= _busy_2_T_2;
        end
      end else if (wbuClearMask[2]) begin // @[ISU.scala 33:40]
        busy_2 <= _busy_2_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_3 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[3] & wbuClearMask[3])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[3]) begin // @[ISU.scala 31:38]
        if (busy_3 == 2'h3) begin // @[ISU.scala 32:33]
          busy_3 <= 2'h3;
        end else begin
          busy_3 <= _busy_3_T_2;
        end
      end else if (wbuClearMask[3]) begin // @[ISU.scala 33:40]
        busy_3 <= _busy_3_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_4 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[4] & wbuClearMask[4])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[4]) begin // @[ISU.scala 31:38]
        if (busy_4 == 2'h3) begin // @[ISU.scala 32:33]
          busy_4 <= 2'h3;
        end else begin
          busy_4 <= _busy_4_T_2;
        end
      end else if (wbuClearMask[4]) begin // @[ISU.scala 33:40]
        busy_4 <= _busy_4_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_5 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[5] & wbuClearMask[5])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[5]) begin // @[ISU.scala 31:38]
        if (busy_5 == 2'h3) begin // @[ISU.scala 32:33]
          busy_5 <= 2'h3;
        end else begin
          busy_5 <= _busy_5_T_2;
        end
      end else if (wbuClearMask[5]) begin // @[ISU.scala 33:40]
        busy_5 <= _busy_5_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_6 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[6] & wbuClearMask[6])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[6]) begin // @[ISU.scala 31:38]
        if (busy_6 == 2'h3) begin // @[ISU.scala 32:33]
          busy_6 <= 2'h3;
        end else begin
          busy_6 <= _busy_6_T_2;
        end
      end else if (wbuClearMask[6]) begin // @[ISU.scala 33:40]
        busy_6 <= _busy_6_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_7 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[7] & wbuClearMask[7])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[7]) begin // @[ISU.scala 31:38]
        if (busy_7 == 2'h3) begin // @[ISU.scala 32:33]
          busy_7 <= 2'h3;
        end else begin
          busy_7 <= _busy_7_T_2;
        end
      end else if (wbuClearMask[7]) begin // @[ISU.scala 33:40]
        busy_7 <= _busy_7_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_8 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[8] & wbuClearMask[8])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[8]) begin // @[ISU.scala 31:38]
        if (busy_8 == 2'h3) begin // @[ISU.scala 32:33]
          busy_8 <= 2'h3;
        end else begin
          busy_8 <= _busy_8_T_2;
        end
      end else if (wbuClearMask[8]) begin // @[ISU.scala 33:40]
        busy_8 <= _busy_8_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_9 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[9] & wbuClearMask[9])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[9]) begin // @[ISU.scala 31:38]
        if (busy_9 == 2'h3) begin // @[ISU.scala 32:33]
          busy_9 <= 2'h3;
        end else begin
          busy_9 <= _busy_9_T_2;
        end
      end else if (wbuClearMask[9]) begin // @[ISU.scala 33:40]
        busy_9 <= _busy_9_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_10 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[10] & wbuClearMask[10])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[10]) begin // @[ISU.scala 31:38]
        if (busy_10 == 2'h3) begin // @[ISU.scala 32:33]
          busy_10 <= 2'h3;
        end else begin
          busy_10 <= _busy_10_T_2;
        end
      end else if (wbuClearMask[10]) begin // @[ISU.scala 33:40]
        busy_10 <= _busy_10_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_11 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[11] & wbuClearMask[11])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[11]) begin // @[ISU.scala 31:38]
        if (busy_11 == 2'h3) begin // @[ISU.scala 32:33]
          busy_11 <= 2'h3;
        end else begin
          busy_11 <= _busy_11_T_2;
        end
      end else if (wbuClearMask[11]) begin // @[ISU.scala 33:40]
        busy_11 <= _busy_11_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_12 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[12] & wbuClearMask[12])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[12]) begin // @[ISU.scala 31:38]
        if (busy_12 == 2'h3) begin // @[ISU.scala 32:33]
          busy_12 <= 2'h3;
        end else begin
          busy_12 <= _busy_12_T_2;
        end
      end else if (wbuClearMask[12]) begin // @[ISU.scala 33:40]
        busy_12 <= _busy_12_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_13 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[13] & wbuClearMask[13])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[13]) begin // @[ISU.scala 31:38]
        if (busy_13 == 2'h3) begin // @[ISU.scala 32:33]
          busy_13 <= 2'h3;
        end else begin
          busy_13 <= _busy_13_T_2;
        end
      end else if (wbuClearMask[13]) begin // @[ISU.scala 33:40]
        busy_13 <= _busy_13_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_14 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[14] & wbuClearMask[14])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[14]) begin // @[ISU.scala 31:38]
        if (busy_14 == 2'h3) begin // @[ISU.scala 32:33]
          busy_14 <= 2'h3;
        end else begin
          busy_14 <= _busy_14_T_2;
        end
      end else if (wbuClearMask[14]) begin // @[ISU.scala 33:40]
        busy_14 <= _busy_14_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_15 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[15] & wbuClearMask[15])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[15]) begin // @[ISU.scala 31:38]
        if (busy_15 == 2'h3) begin // @[ISU.scala 32:33]
          busy_15 <= 2'h3;
        end else begin
          busy_15 <= _busy_15_T_2;
        end
      end else if (wbuClearMask[15]) begin // @[ISU.scala 33:40]
        busy_15 <= _busy_15_T_7; // @[ISU.scala 34:27]
      end
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
  busy_1 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  busy_2 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  busy_3 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  busy_4 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  busy_5 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  busy_6 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  busy_7 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  busy_8 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  busy_9 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  busy_10 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  busy_11 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  busy_12 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  busy_13 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  busy_14 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  busy_15 = _RAND_14[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  output [31:0] io_out_bits,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  output        io_taken
);
  wire  isAdderSub = ~io_in_bits_fuOpType[6]; // @[EXU.scala 93:22]
  wire [31:0] _adderRes_T_1 = isAdderSub ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _adderRes_T_2 = io_in_bits_srcb ^ _adderRes_T_1; // @[EXU.scala 94:35]
  wire [32:0] _adderRes_T_3 = io_in_bits_srca + _adderRes_T_2; // @[EXU.scala 94:26]
  wire [32:0] _GEN_0 = {{32'd0}, isAdderSub}; // @[EXU.scala 94:62]
  wire [32:0] adderRes = _adderRes_T_3 + _GEN_0; // @[EXU.scala 94:62]
  wire [31:0] xorRes = io_in_bits_srca ^ io_in_bits_srcb; // @[EXU.scala 95:23]
  wire  sltu = ~adderRes[32]; // @[EXU.scala 96:16]
  wire  slt = xorRes[31] ^ sltu; // @[EXU.scala 97:30]
  wire [4:0] shamt = io_in_bits_fuOpType[5] ? io_in_bits_srcb[4:0] : io_in_bits_srcb[4:0]; // @[EXU.scala 103:20]
  wire [62:0] _GEN_1 = {{31'd0}, io_in_bits_srca}; // @[EXU.scala 105:35]
  wire [62:0] _res_T = _GEN_1 << shamt; // @[EXU.scala 105:35]
  wire [31:0] _res_T_2 = {31'h0,slt}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_3 = {31'h0,sltu}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_4 = io_in_bits_srca >> shamt; // @[EXU.scala 109:34]
  wire [31:0] _res_T_5 = io_in_bits_srca | io_in_bits_srcb; // @[EXU.scala 110:32]
  wire [31:0] _res_T_6 = io_in_bits_srca & io_in_bits_srcb; // @[EXU.scala 111:32]
  wire [31:0] _res_T_9 = $signed(io_in_bits_srca) >>> shamt; // @[EXU.scala 112:51]
  wire [32:0] _res_T_11 = 7'h1 == io_in_bits_fuOpType ? {{1'd0}, _res_T[31:0]} : adderRes; // @[Mux.scala 81:58]
  wire [32:0] _res_T_13 = 7'h2 == io_in_bits_fuOpType ? {{1'd0}, _res_T_2} : _res_T_11; // @[Mux.scala 81:58]
  wire [32:0] _res_T_15 = 7'h3 == io_in_bits_fuOpType ? {{1'd0}, _res_T_3} : _res_T_13; // @[Mux.scala 81:58]
  wire [32:0] _res_T_17 = 7'h4 == io_in_bits_fuOpType ? {{1'd0}, xorRes} : _res_T_15; // @[Mux.scala 81:58]
  wire [32:0] _res_T_19 = 7'h5 == io_in_bits_fuOpType ? {{1'd0}, _res_T_4} : _res_T_17; // @[Mux.scala 81:58]
  wire [32:0] _res_T_21 = 7'h6 == io_in_bits_fuOpType ? {{1'd0}, _res_T_5} : _res_T_19; // @[Mux.scala 81:58]
  wire [32:0] _res_T_23 = 7'h7 == io_in_bits_fuOpType ? {{1'd0}, _res_T_6} : _res_T_21; // @[Mux.scala 81:58]
  wire [32:0] res = 7'hd == io_in_bits_fuOpType ? {{1'd0}, _res_T_9} : _res_T_23; // @[Mux.scala 81:58]
  wire  aluRes_signBit = res[31]; // @[EXU.scala 8:20]
  wire [31:0] _aluRes_T_3 = aluRes_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _aluRes_T_4 = {_aluRes_T_3,res[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] aluRes = io_in_bits_fuOpType[5] ? _aluRes_T_4 : {{31'd0}, res}; // @[EXU.scala 114:18]
  wire  _T_1 = ~(|xorRes); // @[EXU.scala 118:48]
  wire  _io_taken_T_4 = 2'h2 == io_in_bits_fuOpType[2:1] ? slt : 2'h0 == io_in_bits_fuOpType[2:1] & _T_1; // @[Mux.scala 81:58]
  wire  _io_taken_T_6 = 2'h3 == io_in_bits_fuOpType[2:1] ? sltu : _io_taken_T_4; // @[Mux.scala 81:58]
  assign io_out_bits = aluRes[31:0]; // @[EXU.scala 90:17]
  assign io_taken = _io_taken_T_6 ^ io_in_bits_fuOpType[0]; // @[EXU.scala 122:86]
endmodule
module LSU(
  output [31:0] io_out_bits,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  input         io_ctrl_MemWrite,
  input  [6:0]  io_ctrl_fuOpType,
  input  [31:0] io_data_rfSrc2
);
  wire [1:0] _io_to_mem_Wmask_T_3 = 7'h9 == io_ctrl_fuOpType ? 2'h3 : {{1'd0}, 7'h8 == io_ctrl_fuOpType}; // @[Mux.scala 81:58]
  wire [3:0] _io_to_mem_Wmask_T_5 = 7'ha == io_ctrl_fuOpType ? 4'hf : {{2'd0}, _io_to_mem_Wmask_T_3}; // @[Mux.scala 81:58]
  wire  io_out_bits_signBit = io_from_mem_data[7]; // @[EXU.scala 8:20]
  wire [23:0] _io_out_bits_T_2 = io_out_bits_signBit ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_bits_T_3 = {_io_out_bits_T_2,io_from_mem_data[7:0]}; // @[Cat.scala 33:92]
  wire  io_out_bits_signBit_1 = io_from_mem_data[15]; // @[EXU.scala 8:20]
  wire [15:0] _io_out_bits_T_6 = io_out_bits_signBit_1 ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_bits_T_7 = {_io_out_bits_T_6,io_from_mem_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_11 = {24'h0,io_from_mem_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_13 = {16'h0,io_from_mem_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_17 = 7'h0 == io_ctrl_fuOpType ? _io_out_bits_T_3 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_19 = 7'h1 == io_ctrl_fuOpType ? _io_out_bits_T_7 : _io_out_bits_T_17; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_21 = 7'h2 == io_ctrl_fuOpType ? io_from_mem_data : _io_out_bits_T_19; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_23 = 7'h4 == io_ctrl_fuOpType ? _io_out_bits_T_11 : _io_out_bits_T_21; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_25 = 7'h5 == io_ctrl_fuOpType ? _io_out_bits_T_13 : _io_out_bits_T_23; // @[Mux.scala 81:58]
  assign io_out_bits = 7'h6 == io_ctrl_fuOpType ? io_from_mem_data : _io_out_bits_T_25; // @[Mux.scala 81:58]
  assign io_to_mem_data = io_data_rfSrc2; // @[LSU.scala 81:20]
  assign io_to_mem_addr = io_in_bits_srca + io_in_bits_srcb; // @[LSU.scala 83:39]
  assign io_to_mem_Wmask = 7'hb == io_ctrl_fuOpType ? 8'hff : {{4'd0}, _io_to_mem_Wmask_T_5}; // @[Mux.scala 81:58]
  assign io_to_mem_MemWrite = io_ctrl_MemWrite; // @[LSU.scala 91:24]
endmodule
module CSR(
  input         clock,
  input         reset,
  output [31:0] io_out_bits,
  input         io_in_valid,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  input  [31:0] io_cfIn_inst,
  input  [31:0] io_cfIn_pc,
  output        io_jmp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mtvec; // @[CSR.scala 183:24]
  reg [31:0] mcause; // @[CSR.scala 184:25]
  reg [31:0] mepc; // @[CSR.scala 186:23]
  reg [31:0] mstatus; // @[CSR.scala 190:26]
  wire  isEcall = io_cfIn_inst == 32'h73; // @[CSR.scala 194:29]
  wire  isMret = io_cfIn_inst == 32'h30200073; // @[CSR.scala 195:29]
  wire  isEbreak = io_cfIn_inst == 32'h100073; // @[CSR.scala 196:30]
  wire [31:0] _csr_T_1 = 32'h305 == io_in_bits_srcb ? mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_3 = 32'h342 == io_in_bits_srcb ? mcause : _csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_5 = 32'h341 == io_in_bits_srcb ? mepc : _csr_T_3; // @[Mux.scala 81:58]
  wire [31:0] csr = 32'h300 == io_in_bits_srcb ? mstatus : _csr_T_5; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T = io_in_bits_srca | csr; // @[CSR.scala 206:33]
  wire [31:0] _csrUpdate_T_1 = ~io_in_bits_srca; // @[CSR.scala 207:26]
  wire [31:0] _csrUpdate_T_2 = _csrUpdate_T_1 & csr; // @[CSR.scala 207:32]
  wire [31:0] _csrUpdate_T_4 = 7'h1 == io_in_bits_fuOpType ? io_in_bits_srca : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T_6 = 7'h2 == io_in_bits_fuOpType ? _csrUpdate_T : _csrUpdate_T_4; // @[Mux.scala 81:58]
  wire [31:0] csrUpdate = 7'h3 == io_in_bits_fuOpType ? _csrUpdate_T_2 : _csrUpdate_T_6; // @[Mux.scala 81:58]
  wire  csrWen = io_in_valid & io_in_bits_fuOpType != 7'h0; // @[CSR.scala 209:24]
  wire [31:0] _io_out_bits_T_2 = isMret ? mepc : csr; // @[Mux.scala 101:16]
  assign io_out_bits = isEcall ? mtvec : _io_out_bits_T_2; // @[Mux.scala 101:16]
  assign io_jmp = io_in_valid & io_in_bits_fuOpType == 7'h0 & ~isEbreak; // @[CSR.scala 230:53]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 183:24]
      mtvec <= 32'h0; // @[CSR.scala 183:24]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h305) begin // @[CSR.scala 211:33]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mtvec <= _csrUpdate_T_2;
        end else begin
          mtvec <= _csrUpdate_T_6;
        end
      end
    end
    if (reset) begin // @[CSR.scala 184:25]
      mcause <= 32'h0; // @[CSR.scala 184:25]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mcause <= 32'hb; // @[CSR.scala 226:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h342) begin // @[CSR.scala 214:34]
        mcause <= csrUpdate; // @[CSR.scala 215:16]
      end
    end
    if (reset) begin // @[CSR.scala 186:23]
      mepc <= 32'h0; // @[CSR.scala 186:23]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mepc <= io_cfIn_pc; // @[CSR.scala 227:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h341) begin // @[CSR.scala 217:32]
        mepc <= csrUpdate; // @[CSR.scala 218:15]
      end
    end
    if (reset) begin // @[CSR.scala 190:26]
      mstatus <= 32'h1800; // @[CSR.scala 190:26]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h300) begin // @[CSR.scala 220:35]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mstatus <= _csrUpdate_T_2;
        end else begin
          mstatus <= _csrUpdate_T_6;
        end
      end
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
  mtvec = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mcause = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mstatus = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXU_LLM(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [31:0] io_from_isu_bits_cf_pc,
  input  [31:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_isu_bits_ctrl_fuType,
  input  [6:0]  io_from_isu_bits_ctrl_fuOpType,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [31:0] io_from_isu_bits_data_fuSrc1,
  input  [31:0] io_from_isu_bits_data_fuSrc2,
  input  [31:0] io_from_isu_bits_data_imm,
  input  [31:0] io_from_isu_bits_data_rfSrc1,
  input  [31:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [31:0] io_to_wbu_bits_cf_pc,
  output [31:0] io_to_wbu_bits_cf_next_pc,
  output [1:0]  io_to_wbu_bits_ctrl_ResSrc,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [31:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [31:0] io_to_wbu_bits_data_data_from_mem,
  output [31:0] io_to_wbu_bits_data_csrRdata,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  output [31:0] io_redirect_target,
  output        io_redirect_valid
);
  wire [31:0] alu0_io_out_bits; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srca; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srcb; // @[EXU.scala 402:20]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[EXU.scala 402:20]
  wire  alu0_io_taken; // @[EXU.scala 402:20]
  wire [31:0] lsu0_io_out_bits; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srca; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srcb; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_data; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_addr; // @[EXU.scala 403:20]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[EXU.scala 403:20]
  wire  lsu0_io_to_mem_MemWrite; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_from_mem_data; // @[EXU.scala 403:20]
  wire  lsu0_io_ctrl_MemWrite; // @[EXU.scala 403:20]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_data_rfSrc2; // @[EXU.scala 403:20]
  wire  csr0_clock; // @[EXU.scala 404:20]
  wire  csr0_reset; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_out_bits; // @[EXU.scala 404:20]
  wire  csr0_io_in_valid; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srca; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srcb; // @[EXU.scala 404:20]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_inst; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_pc; // @[EXU.scala 404:20]
  wire  csr0_io_jmp; // @[EXU.scala 404:20]
  wire  bruRes_jalrBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[BruRes.scala 9:48]
  wire [31:0] _bruRes_jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[BruRes.scala 10:52]
  wire [31:0] bruRes_jalrBruRes_targetPc = _bruRes_jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[BruRes.scala 10:71]
  wire  bruRes_typebBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[BruRes.scala 13:49]
  wire [31:0] bruRes_pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[BruRes.scala 14:39]
  wire [31:0] _bruRes_typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[BruRes.scala 15:77]
  wire [31:0] bruRes_typebBruRes_targetPc = alu0_io_taken ? bruRes_pcIfBranch : _bruRes_typebBruRes_targetPc_T_1; // @[BruRes.scala 15:36]
  wire  bruRes_csrBruRes_valid = csr0_io_jmp; // @[BruRes.scala 17:29 18:25]
  wire [31:0] bruRes_csrBruRes_targetPc = csr0_io_out_bits; // @[BruRes.scala 17:29 19:28]
  wire [31:0] _bruRes_bruRes_T_targetPc = bruRes_csrBruRes_valid ? bruRes_csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_bruRes_T_1_valid = bruRes_typebBruRes_valid ? bruRes_typebBruRes_valid : bruRes_csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_bruRes_T_1_targetPc = bruRes_typebBruRes_valid ? bruRes_typebBruRes_targetPc :
    _bruRes_bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_bruRes_valid = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_valid : _bruRes_bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_bruRes_targetPc = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc :
    _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[EXU.scala 452:41]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU alu0 ( // @[EXU.scala 402:20]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU lsu0 ( // @[EXU.scala 403:20]
    .io_out_bits(lsu0_io_out_bits),
    .io_in_bits_srca(lsu0_io_in_bits_srca),
    .io_in_bits_srcb(lsu0_io_in_bits_srcb),
    .io_to_mem_data(lsu0_io_to_mem_data),
    .io_to_mem_addr(lsu0_io_to_mem_addr),
    .io_to_mem_Wmask(lsu0_io_to_mem_Wmask),
    .io_to_mem_MemWrite(lsu0_io_to_mem_MemWrite),
    .io_from_mem_data(lsu0_io_from_mem_data),
    .io_ctrl_MemWrite(lsu0_io_ctrl_MemWrite),
    .io_ctrl_fuOpType(lsu0_io_ctrl_fuOpType),
    .io_data_rfSrc2(lsu0_io_data_rfSrc2)
  );
  CSR csr0 ( // @[EXU.scala 404:20]
    .clock(csr0_clock),
    .reset(csr0_reset),
    .io_out_bits(csr0_io_out_bits),
    .io_in_valid(csr0_io_in_valid),
    .io_in_bits_srca(csr0_io_in_bits_srca),
    .io_in_bits_srcb(csr0_io_in_bits_srcb),
    .io_in_bits_fuOpType(csr0_io_in_bits_fuOpType),
    .io_cfIn_inst(csr0_io_cfIn_inst),
    .io_cfIn_pc(csr0_io_cfIn_pc),
    .io_jmp(csr0_io_jmp)
  );
  assign io_from_isu_ready = (~io_from_isu_valid | _io_from_isu_ready_T_1) & ~_T; // @[RVCore.scala 66:74]
  assign io_to_wbu_valid = io_from_isu_valid; // @[RVCore.scala 67:40]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_next_pc = io_redirect_valid ? bruRes_bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[EXU.scala 445:35]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[EXU.scala 431:36]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[EXU.scala 432:37]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[EXU.scala 434:32]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[EXU.scala 433:13]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[EXU.scala 433:13]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[EXU.scala 433:13]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[EXU.scala 433:13]
  assign io_redirect_target = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc : _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_bruRes_valid & io_from_isu_bits_cf_next_pc !=
    bruRes_bruRes_targetPc; // @[EXU.scala 441:58]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 407:24]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 408:24]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 409:28]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 413:24]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 414:24]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[EXU.scala 418:20]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[EXU.scala 416:16]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 416:16]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[EXU.scala 417:16]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[EXU.scala 427:41]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 423:24]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 424:24]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 425:28]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 426:16]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 426:16]
endmodule
module WBU_LLM(
  output        io_from_exu_ready,
  input         io_from_exu_valid,
  input  [31:0] io_from_exu_bits_cf_inst,
  input  [31:0] io_from_exu_bits_cf_pc,
  input  [31:0] io_from_exu_bits_cf_next_pc,
  input  [1:0]  io_from_exu_bits_ctrl_ResSrc,
  input         io_from_exu_bits_ctrl_rfWen,
  input  [4:0]  io_from_exu_bits_ctrl_rd,
  input  [31:0] io_from_exu_bits_data_Alu0Res_bits,
  input  [31:0] io_from_exu_bits_data_data_from_mem,
  input  [31:0] io_from_exu_bits_data_csrRdata,
  output        io_to_reg_valid,
  output [4:0]  io_to_reg_bits_rd,
  output [31:0] io_to_reg_bits_Res,
  output        io_to_reg_bits_RegWrite,
  output [31:0] io_to_commit_inst,
  output [31:0] io_to_commit_pc,
  output [31:0] io_to_commit_next_pc
);
  wire [31:0] _writeBackData_T_3 = io_from_exu_bits_ctrl_ResSrc == 2'h2 ? io_from_exu_bits_data_csrRdata : 32'h0; // @[WBU.scala 69:23]
  wire [31:0] _writeBackData_T_4 = io_from_exu_bits_ctrl_ResSrc == 2'h1 ? io_from_exu_bits_data_data_from_mem :
    _writeBackData_T_3; // @[WBU.scala 68:23]
  assign io_from_exu_ready = ~io_from_exu_valid | io_to_reg_valid; // @[RVCore.scala 66:56]
  assign io_to_reg_valid = io_from_exu_valid; // @[RVCore.scala 67:40]
  assign io_to_reg_bits_rd = io_from_exu_bits_ctrl_rd; // @[WBU.scala 74:21]
  assign io_to_reg_bits_Res = io_from_exu_bits_ctrl_ResSrc == 2'h0 ? io_from_exu_bits_data_Alu0Res_bits :
    _writeBackData_T_4; // @[WBU.scala 67:23]
  assign io_to_reg_bits_RegWrite = io_from_exu_bits_ctrl_rfWen & io_to_reg_valid; // @[WBU.scala 76:58]
  assign io_to_commit_inst = io_from_exu_bits_cf_inst; // @[WBU.scala 78:16]
  assign io_to_commit_pc = io_from_exu_bits_cf_pc; // @[WBU.scala 78:16]
  assign io_to_commit_next_pc = io_from_exu_bits_cf_next_pc; // @[WBU.scala 78:16]
endmodule
module RVCore2(
  input         clock,
  input         reset,
  input  [31:0] io_from_mem_data,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_inst,
  output [31:0] io_pc,
  output        io_commit_valid,
  output [31:0] io_commit_pc,
  output [31:0] io_commit_next_pc,
  output [31:0] io_commit_inst
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
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
`endif // RANDOMIZE_REG_INIT
  wire  ifu_clock; // @[RVCore.scala 96:19]
  wire  ifu_reset; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_inst; // @[RVCore.scala 96:19]
  wire  ifu_io_to_idu_ready; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_inst; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_pc; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_next_pc; // @[RVCore.scala 96:19]
  wire  ifu_io_to_idu_bits_isBranch; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_pc; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_redirect_target; // @[RVCore.scala 96:19]
  wire  ifu_io_redirect_valid; // @[RVCore.scala 96:19]
  wire  idu_io_from_ifu_ready; // @[RVCore.scala 97:19]
  wire  idu_io_from_ifu_valid; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_inst; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_pc; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_next_pc; // @[RVCore.scala 97:19]
  wire  idu_io_from_ifu_bits_isBranch; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_ready; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_valid; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_inst; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_pc; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_next_pc; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_cf_isBranch; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_ctrl_MemWrite; // @[RVCore.scala 97:19]
  wire [1:0] idu_io_to_isu_bits_ctrl_ResSrc; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuType; // @[RVCore.scala 97:19]
  wire [6:0] idu_io_to_isu_bits_ctrl_fuOpType; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs1; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs2; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_ctrl_rfWen; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rd; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_data_imm; // @[RVCore.scala 97:19]
  wire  isu_clock; // @[RVCore.scala 98:19]
  wire  isu_reset; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_ready; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_valid; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_inst; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_pc; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_next_pc; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_cf_isBranch; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_ctrl_MemWrite; // @[RVCore.scala 98:19]
  wire [1:0] isu_io_from_idu_bits_ctrl_ResSrc; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc1Type; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc2Type; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuType; // @[RVCore.scala 98:19]
  wire [6:0] isu_io_from_idu_bits_ctrl_fuOpType; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs1; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs2; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_ctrl_rfWen; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rd; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_data_imm; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_ready; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_valid; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_inst; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_pc; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_next_pc; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_cf_isBranch; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_ctrl_MemWrite; // @[RVCore.scala 98:19]
  wire [1:0] isu_io_to_exu_bits_ctrl_ResSrc; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuType; // @[RVCore.scala 98:19]
  wire [6:0] isu_io_to_exu_bits_ctrl_fuOpType; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_ctrl_rfWen; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_to_exu_bits_ctrl_rd; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc2; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_imm; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc2; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_wb_rd; // @[RVCore.scala 98:19]
  wire  isu_io_wb_RegWrite; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_reg_rfSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_reg_rfSrc2; // @[RVCore.scala 98:19]
  wire  exu_clock; // @[RVCore.scala 99:19]
  wire  exu_reset; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_ready; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_valid; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_inst; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_pc; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_next_pc; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_cf_isBranch; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_ctrl_MemWrite; // @[RVCore.scala 99:19]
  wire [1:0] exu_io_from_isu_bits_ctrl_ResSrc; // @[RVCore.scala 99:19]
  wire [2:0] exu_io_from_isu_bits_ctrl_fuType; // @[RVCore.scala 99:19]
  wire [6:0] exu_io_from_isu_bits_ctrl_fuOpType; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_ctrl_rfWen; // @[RVCore.scala 99:19]
  wire [4:0] exu_io_from_isu_bits_ctrl_rd; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc1; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc2; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_imm; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc1; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc2; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_ready; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_valid; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_inst; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_pc; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_next_pc; // @[RVCore.scala 99:19]
  wire [1:0] exu_io_to_wbu_bits_ctrl_ResSrc; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_bits_ctrl_rfWen; // @[RVCore.scala 99:19]
  wire [4:0] exu_io_to_wbu_bits_ctrl_rd; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_Alu0Res_bits; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_data_from_mem; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_csrRdata; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_mem_data; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_mem_addr; // @[RVCore.scala 99:19]
  wire [7:0] exu_io_to_mem_Wmask; // @[RVCore.scala 99:19]
  wire  exu_io_to_mem_MemWrite; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_mem_data; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_redirect_target; // @[RVCore.scala 99:19]
  wire  exu_io_redirect_valid; // @[RVCore.scala 99:19]
  wire  wbu_io_from_exu_ready; // @[RVCore.scala 100:19]
  wire  wbu_io_from_exu_valid; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_cf_inst; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_cf_pc; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_cf_next_pc; // @[RVCore.scala 100:19]
  wire [1:0] wbu_io_from_exu_bits_ctrl_ResSrc; // @[RVCore.scala 100:19]
  wire  wbu_io_from_exu_bits_ctrl_rfWen; // @[RVCore.scala 100:19]
  wire [4:0] wbu_io_from_exu_bits_ctrl_rd; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_data_Alu0Res_bits; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_data_data_from_mem; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_from_exu_bits_data_csrRdata; // @[RVCore.scala 100:19]
  wire  wbu_io_to_reg_valid; // @[RVCore.scala 100:19]
  wire [4:0] wbu_io_to_reg_bits_rd; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_to_reg_bits_Res; // @[RVCore.scala 100:19]
  wire  wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_to_commit_inst; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_to_commit_pc; // @[RVCore.scala 100:19]
  wire [31:0] wbu_io_to_commit_next_pc; // @[RVCore.scala 100:19]
  wire  regfile_clk; // @[RVCore.scala 136:23]
  wire [4:0] regfile_rs1; // @[RVCore.scala 136:23]
  wire [4:0] regfile_rs2; // @[RVCore.scala 136:23]
  wire [4:0] regfile_rd; // @[RVCore.scala 136:23]
  wire [31:0] regfile_dest; // @[RVCore.scala 136:23]
  wire  regfile_RegWrite; // @[RVCore.scala 136:23]
  wire [31:0] regfile_src1; // @[RVCore.scala 136:23]
  wire [31:0] regfile_src2; // @[RVCore.scala 136:23]
  wire  _T = idu_io_to_isu_ready & idu_io_to_isu_valid; // @[Decoupled.scala 51:35]
  reg  valid; // @[RVCore.scala 48:26]
  wire  _T_1 = idu_io_from_ifu_ready; // @[RVCore.scala 50:29]
  wire  _GEN_0 = _T ? 1'h0 : valid; // @[RVCore.scala 51:{38,45} 52:25]
  wire  _GEN_1 = idu_io_from_ifu_ready | _GEN_0; // @[RVCore.scala 50:{44,51}]
  reg [31:0] idu_io_from_ifu_bits_r_inst; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_pc; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_next_pc; // @[Reg.scala 19:16]
  reg  idu_io_from_ifu_bits_r_isBranch; // @[Reg.scala 19:16]
  wire  _T_2 = isu_io_to_exu_ready & isu_io_to_exu_valid; // @[Decoupled.scala 51:35]
  reg  valid_1; // @[RVCore.scala 48:26]
  wire  _isu_io_from_idu_bits_T = idu_io_to_isu_valid & isu_io_from_idu_ready; // @[RVCore.scala 57:53]
  reg [31:0] isu_io_from_idu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_cf_isBranch; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_MemWrite; // @[Reg.scala 19:16]
  reg [1:0] isu_io_from_idu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuType; // @[Reg.scala 19:16]
  reg [6:0] isu_io_from_idu_bits_r_ctrl_fuOpType; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs1; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs2; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_data_imm; // @[Reg.scala 19:16]
  wire  _T_4 = exu_io_to_wbu_ready & exu_io_to_wbu_valid; // @[Decoupled.scala 51:35]
  reg  valid_2; // @[RVCore.scala 48:26]
  wire  _exu_io_from_isu_bits_T = isu_io_to_exu_valid & exu_io_from_isu_ready; // @[RVCore.scala 57:53]
  reg [31:0] exu_io_from_isu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_cf_isBranch; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_ctrl_MemWrite; // @[Reg.scala 19:16]
  reg [1:0] exu_io_from_isu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg [2:0] exu_io_from_isu_bits_r_ctrl_fuType; // @[Reg.scala 19:16]
  reg [6:0] exu_io_from_isu_bits_r_ctrl_fuOpType; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] exu_io_from_isu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_fuSrc1; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_fuSrc2; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_imm; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_rfSrc1; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_rfSrc2; // @[Reg.scala 19:16]
  wire  _T_6 = wbu_io_to_reg_valid; // @[RVCore.scala 115:68]
  reg  valid_3; // @[RVCore.scala 48:26]
  wire  _wbu_io_from_exu_bits_T = exu_io_to_wbu_valid & wbu_io_from_exu_ready; // @[RVCore.scala 57:53]
  reg [31:0] wbu_io_from_exu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg [1:0] wbu_io_from_exu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg  wbu_io_from_exu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] wbu_io_from_exu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_Alu0Res_bits; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_data_from_mem; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_csrRdata; // @[Reg.scala 19:16]
  reg  io_commit_valid_REG; // @[RVCore.scala 129:29]
  reg [31:0] io_commit_pc_REG; // @[RVCore.scala 131:26]
  reg [31:0] io_commit_next_pc_REG; // @[RVCore.scala 132:31]
  reg [31:0] io_commit_inst_REG; // @[RVCore.scala 133:28]
  IFU_LLM ifu ( // @[RVCore.scala 96:19]
    .clock(ifu_clock),
    .reset(ifu_reset),
    .io_inst(ifu_io_inst),
    .io_to_idu_ready(ifu_io_to_idu_ready),
    .io_to_idu_bits_inst(ifu_io_to_idu_bits_inst),
    .io_to_idu_bits_pc(ifu_io_to_idu_bits_pc),
    .io_to_idu_bits_next_pc(ifu_io_to_idu_bits_next_pc),
    .io_to_idu_bits_isBranch(ifu_io_to_idu_bits_isBranch),
    .io_pc(ifu_io_pc),
    .io_redirect_target(ifu_io_redirect_target),
    .io_redirect_valid(ifu_io_redirect_valid)
  );
  IDU_LLM idu ( // @[RVCore.scala 97:19]
    .io_from_ifu_ready(idu_io_from_ifu_ready),
    .io_from_ifu_valid(idu_io_from_ifu_valid),
    .io_from_ifu_bits_inst(idu_io_from_ifu_bits_inst),
    .io_from_ifu_bits_pc(idu_io_from_ifu_bits_pc),
    .io_from_ifu_bits_next_pc(idu_io_from_ifu_bits_next_pc),
    .io_from_ifu_bits_isBranch(idu_io_from_ifu_bits_isBranch),
    .io_to_isu_ready(idu_io_to_isu_ready),
    .io_to_isu_valid(idu_io_to_isu_valid),
    .io_to_isu_bits_cf_inst(idu_io_to_isu_bits_cf_inst),
    .io_to_isu_bits_cf_pc(idu_io_to_isu_bits_cf_pc),
    .io_to_isu_bits_cf_next_pc(idu_io_to_isu_bits_cf_next_pc),
    .io_to_isu_bits_cf_isBranch(idu_io_to_isu_bits_cf_isBranch),
    .io_to_isu_bits_ctrl_MemWrite(idu_io_to_isu_bits_ctrl_MemWrite),
    .io_to_isu_bits_ctrl_ResSrc(idu_io_to_isu_bits_ctrl_ResSrc),
    .io_to_isu_bits_ctrl_fuSrc1Type(idu_io_to_isu_bits_ctrl_fuSrc1Type),
    .io_to_isu_bits_ctrl_fuSrc2Type(idu_io_to_isu_bits_ctrl_fuSrc2Type),
    .io_to_isu_bits_ctrl_fuType(idu_io_to_isu_bits_ctrl_fuType),
    .io_to_isu_bits_ctrl_fuOpType(idu_io_to_isu_bits_ctrl_fuOpType),
    .io_to_isu_bits_ctrl_rs1(idu_io_to_isu_bits_ctrl_rs1),
    .io_to_isu_bits_ctrl_rs2(idu_io_to_isu_bits_ctrl_rs2),
    .io_to_isu_bits_ctrl_rfWen(idu_io_to_isu_bits_ctrl_rfWen),
    .io_to_isu_bits_ctrl_rd(idu_io_to_isu_bits_ctrl_rd),
    .io_to_isu_bits_data_imm(idu_io_to_isu_bits_data_imm)
  );

module RegFile #(DATA_WIDTH = 32, ADDR_WIDTH = 5)(
	input		clk,
	/* verilator lint_off UNUSEDSIGNAL */
	input  [ADDR_WIDTH - 1 :0]	rs1,
	input  [ADDR_WIDTH - 1:0]	rs2,
	input  [ADDR_WIDTH - 1:0]	rd,
	/* verilator lint_on UNUSEDSIGNAL */
	input  [DATA_WIDTH - 1:0]	dest,
	input		RegWrite,
	output [DATA_WIDTH - 1:0]	src1,
	output [DATA_WIDTH - 1:0]	src2
);

`ifdef CONFIG_RVE
localparam NR_GPR = 16;
localparam REG_WIDTH = 4;
`else
localparam NR_GPR = 32;
localparam REG_WIDTH = 5;
`endif

reg [DATA_WIDTH - 1 :0] x[NR_GPR - 1:0];
/* DPI-C */
import "DPI-C" function void set_gpr_ptr(input logic [DATA_WIDTH - 1 :0] a []);
initial set_gpr_ptr(x);  // rf为通用寄存器的二维数组变量
/* DPI-C END */
assign src1 = x[rs1[REG_WIDTH - 1 : 0]];
assign src2 = x[rs2[REG_WIDTH - 1 : 0]];

always@(posedge clk)begin
	if(RegWrite)begin
		x[rd[REG_WIDTH - 1 : 0]] <= rd == 0? DATA_WIDTH'('b0):  dest;
	end
end



endmodule


  ISU_LLM isu ( // @[RVCore.scala 98:19]
    .clock(isu_clock),
    .reset(isu_reset),
    .io_from_idu_ready(isu_io_from_idu_ready),
    .io_from_idu_valid(isu_io_from_idu_valid),
    .io_from_idu_bits_cf_inst(isu_io_from_idu_bits_cf_inst),
    .io_from_idu_bits_cf_pc(isu_io_from_idu_bits_cf_pc),
    .io_from_idu_bits_cf_next_pc(isu_io_from_idu_bits_cf_next_pc),
    .io_from_idu_bits_cf_isBranch(isu_io_from_idu_bits_cf_isBranch),
    .io_from_idu_bits_ctrl_MemWrite(isu_io_from_idu_bits_ctrl_MemWrite),
    .io_from_idu_bits_ctrl_ResSrc(isu_io_from_idu_bits_ctrl_ResSrc),
    .io_from_idu_bits_ctrl_fuSrc1Type(isu_io_from_idu_bits_ctrl_fuSrc1Type),
    .io_from_idu_bits_ctrl_fuSrc2Type(isu_io_from_idu_bits_ctrl_fuSrc2Type),
    .io_from_idu_bits_ctrl_fuType(isu_io_from_idu_bits_ctrl_fuType),
    .io_from_idu_bits_ctrl_fuOpType(isu_io_from_idu_bits_ctrl_fuOpType),
    .io_from_idu_bits_ctrl_rs1(isu_io_from_idu_bits_ctrl_rs1),
    .io_from_idu_bits_ctrl_rs2(isu_io_from_idu_bits_ctrl_rs2),
    .io_from_idu_bits_ctrl_rfWen(isu_io_from_idu_bits_ctrl_rfWen),
    .io_from_idu_bits_ctrl_rd(isu_io_from_idu_bits_ctrl_rd),
    .io_from_idu_bits_data_imm(isu_io_from_idu_bits_data_imm),
    .io_to_exu_ready(isu_io_to_exu_ready),
    .io_to_exu_valid(isu_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(isu_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(isu_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(isu_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(isu_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(isu_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(isu_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuType(isu_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(isu_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rfWen(isu_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(isu_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(isu_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(isu_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(isu_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_rfSrc1(isu_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(isu_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(isu_io_wb_rd),
    .io_wb_RegWrite(isu_io_wb_RegWrite),
    .io_from_reg_rfSrc1(isu_io_from_reg_rfSrc1),
    .io_from_reg_rfSrc2(isu_io_from_reg_rfSrc2)
  );
  EXU_LLM exu ( // @[RVCore.scala 99:19]
    .clock(exu_clock),
    .reset(exu_reset),
    .io_from_isu_ready(exu_io_from_isu_ready),
    .io_from_isu_valid(exu_io_from_isu_valid),
    .io_from_isu_bits_cf_inst(exu_io_from_isu_bits_cf_inst),
    .io_from_isu_bits_cf_pc(exu_io_from_isu_bits_cf_pc),
    .io_from_isu_bits_cf_next_pc(exu_io_from_isu_bits_cf_next_pc),
    .io_from_isu_bits_cf_isBranch(exu_io_from_isu_bits_cf_isBranch),
    .io_from_isu_bits_ctrl_MemWrite(exu_io_from_isu_bits_ctrl_MemWrite),
    .io_from_isu_bits_ctrl_ResSrc(exu_io_from_isu_bits_ctrl_ResSrc),
    .io_from_isu_bits_ctrl_fuType(exu_io_from_isu_bits_ctrl_fuType),
    .io_from_isu_bits_ctrl_fuOpType(exu_io_from_isu_bits_ctrl_fuOpType),
    .io_from_isu_bits_ctrl_rfWen(exu_io_from_isu_bits_ctrl_rfWen),
    .io_from_isu_bits_ctrl_rd(exu_io_from_isu_bits_ctrl_rd),
    .io_from_isu_bits_data_fuSrc1(exu_io_from_isu_bits_data_fuSrc1),
    .io_from_isu_bits_data_fuSrc2(exu_io_from_isu_bits_data_fuSrc2),
    .io_from_isu_bits_data_imm(exu_io_from_isu_bits_data_imm),
    .io_from_isu_bits_data_rfSrc1(exu_io_from_isu_bits_data_rfSrc1),
    .io_from_isu_bits_data_rfSrc2(exu_io_from_isu_bits_data_rfSrc2),
    .io_to_wbu_ready(exu_io_to_wbu_ready),
    .io_to_wbu_valid(exu_io_to_wbu_valid),
    .io_to_wbu_bits_cf_inst(exu_io_to_wbu_bits_cf_inst),
    .io_to_wbu_bits_cf_pc(exu_io_to_wbu_bits_cf_pc),
    .io_to_wbu_bits_cf_next_pc(exu_io_to_wbu_bits_cf_next_pc),
    .io_to_wbu_bits_ctrl_ResSrc(exu_io_to_wbu_bits_ctrl_ResSrc),
    .io_to_wbu_bits_ctrl_rfWen(exu_io_to_wbu_bits_ctrl_rfWen),
    .io_to_wbu_bits_ctrl_rd(exu_io_to_wbu_bits_ctrl_rd),
    .io_to_wbu_bits_data_Alu0Res_bits(exu_io_to_wbu_bits_data_Alu0Res_bits),
    .io_to_wbu_bits_data_data_from_mem(exu_io_to_wbu_bits_data_data_from_mem),
    .io_to_wbu_bits_data_csrRdata(exu_io_to_wbu_bits_data_csrRdata),
    .io_to_mem_data(exu_io_to_mem_data),
    .io_to_mem_addr(exu_io_to_mem_addr),
    .io_to_mem_Wmask(exu_io_to_mem_Wmask),
    .io_to_mem_MemWrite(exu_io_to_mem_MemWrite),
    .io_from_mem_data(exu_io_from_mem_data),
    .io_redirect_target(exu_io_redirect_target),
    .io_redirect_valid(exu_io_redirect_valid)
  );
  WBU_LLM wbu ( // @[RVCore.scala 100:19]
    .io_from_exu_ready(wbu_io_from_exu_ready),
    .io_from_exu_valid(wbu_io_from_exu_valid),
    .io_from_exu_bits_cf_inst(wbu_io_from_exu_bits_cf_inst),
    .io_from_exu_bits_cf_pc(wbu_io_from_exu_bits_cf_pc),
    .io_from_exu_bits_cf_next_pc(wbu_io_from_exu_bits_cf_next_pc),
    .io_from_exu_bits_ctrl_ResSrc(wbu_io_from_exu_bits_ctrl_ResSrc),
    .io_from_exu_bits_ctrl_rfWen(wbu_io_from_exu_bits_ctrl_rfWen),
    .io_from_exu_bits_ctrl_rd(wbu_io_from_exu_bits_ctrl_rd),
    .io_from_exu_bits_data_Alu0Res_bits(wbu_io_from_exu_bits_data_Alu0Res_bits),
    .io_from_exu_bits_data_data_from_mem(wbu_io_from_exu_bits_data_data_from_mem),
    .io_from_exu_bits_data_csrRdata(wbu_io_from_exu_bits_data_csrRdata),
    .io_to_reg_valid(wbu_io_to_reg_valid),
    .io_to_reg_bits_rd(wbu_io_to_reg_bits_rd),
    .io_to_reg_bits_Res(wbu_io_to_reg_bits_Res),
    .io_to_reg_bits_RegWrite(wbu_io_to_reg_bits_RegWrite),
    .io_to_commit_inst(wbu_io_to_commit_inst),
    .io_to_commit_pc(wbu_io_to_commit_pc),
    .io_to_commit_next_pc(wbu_io_to_commit_next_pc)
  );
  RegFile #(.DATA_WIDTH(32)) regfile ( // @[RVCore.scala 136:23]
    .clk(regfile_clk),
    .rs1(regfile_rs1),
    .rs2(regfile_rs2),
    .rd(regfile_rd),
    .dest(regfile_dest),
    .RegWrite(regfile_RegWrite),
    .src1(regfile_src1),
    .src2(regfile_src2)
  );
  assign io_to_mem_data = exu_io_to_mem_data; // @[RVCore.scala 107:13]
  assign io_to_mem_addr = exu_io_to_mem_addr; // @[RVCore.scala 107:13]
  assign io_to_mem_Wmask = exu_io_to_mem_Wmask; // @[RVCore.scala 107:13]
  assign io_to_mem_MemWrite = exu_io_to_mem_MemWrite; // @[RVCore.scala 107:13]
  assign io_pc = ifu_io_pc; // @[RVCore.scala 104:9]
  assign io_commit_valid = io_commit_valid_REG; // @[RVCore.scala 129:19]
  assign io_commit_pc = io_commit_pc_REG; // @[RVCore.scala 131:16]
  assign io_commit_next_pc = io_commit_next_pc_REG; // @[RVCore.scala 132:21]
  assign io_commit_inst = io_commit_inst_REG; // @[RVCore.scala 133:18]
  assign ifu_clock = clock;
  assign ifu_reset = reset;
  assign ifu_io_inst = io_inst; // @[RVCore.scala 102:15]
  assign ifu_io_to_idu_ready = idu_io_from_ifu_ready; // @[RVCore.scala 55:18]
  assign ifu_io_redirect_target = exu_io_redirect_target; // @[RVCore.scala 119:19]
  assign ifu_io_redirect_valid = exu_io_redirect_valid; // @[RVCore.scala 119:19]
  assign idu_io_from_ifu_valid = valid; // @[RVCore.scala 54:19]
  assign idu_io_from_ifu_bits_inst = idu_io_from_ifu_bits_r_inst; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_pc = idu_io_from_ifu_bits_r_pc; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_next_pc = idu_io_from_ifu_bits_r_next_pc; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_isBranch = idu_io_from_ifu_bits_r_isBranch; // @[RVCore.scala 57:18]
  assign idu_io_to_isu_ready = isu_io_from_idu_ready; // @[RVCore.scala 55:18]
  assign isu_clock = clock;
  assign isu_reset = reset;
  assign isu_io_from_idu_valid = valid_1; // @[RVCore.scala 54:19]
  assign isu_io_from_idu_bits_cf_inst = isu_io_from_idu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_pc = isu_io_from_idu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_next_pc = isu_io_from_idu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_isBranch = isu_io_from_idu_bits_r_cf_isBranch; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_MemWrite = isu_io_from_idu_bits_r_ctrl_MemWrite; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_ResSrc = isu_io_from_idu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc1Type = isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc2Type = isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuType = isu_io_from_idu_bits_r_ctrl_fuType; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuOpType = isu_io_from_idu_bits_r_ctrl_fuOpType; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rs1 = isu_io_from_idu_bits_r_ctrl_rs1; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rs2 = isu_io_from_idu_bits_r_ctrl_rs2; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rfWen = isu_io_from_idu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rd = isu_io_from_idu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_data_imm = isu_io_from_idu_bits_r_data_imm; // @[RVCore.scala 57:18]
  assign isu_io_to_exu_ready = exu_io_from_isu_ready; // @[RVCore.scala 55:18]
  assign isu_io_wb_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 121:13]
  assign isu_io_wb_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 121:13]
  assign isu_io_from_reg_rfSrc1 = regfile_src1; // @[ISU.scala 132:32]
  assign isu_io_from_reg_rfSrc2 = regfile_src2; // @[ISU.scala 133:32]
  assign exu_clock = clock;
  assign exu_reset = reset;
  assign exu_io_from_isu_valid = valid_2; // @[RVCore.scala 54:19]
  assign exu_io_from_isu_bits_cf_inst = exu_io_from_isu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_pc = exu_io_from_isu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_next_pc = exu_io_from_isu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_isBranch = exu_io_from_isu_bits_r_cf_isBranch; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_MemWrite = exu_io_from_isu_bits_r_ctrl_MemWrite; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_ResSrc = exu_io_from_isu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_fuType = exu_io_from_isu_bits_r_ctrl_fuType; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_fuOpType = exu_io_from_isu_bits_r_ctrl_fuOpType; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_rfWen = exu_io_from_isu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_rd = exu_io_from_isu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_fuSrc1 = exu_io_from_isu_bits_r_data_fuSrc1; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_fuSrc2 = exu_io_from_isu_bits_r_data_fuSrc2; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_imm = exu_io_from_isu_bits_r_data_imm; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_rfSrc1 = exu_io_from_isu_bits_r_data_rfSrc1; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_rfSrc2 = exu_io_from_isu_bits_r_data_rfSrc2; // @[RVCore.scala 57:18]
  assign exu_io_to_wbu_ready = wbu_io_from_exu_ready; // @[RVCore.scala 55:18]
  assign exu_io_from_mem_data = io_from_mem_data; // @[RVCore.scala 103:19]
  assign wbu_io_from_exu_valid = valid_3; // @[RVCore.scala 54:19]
  assign wbu_io_from_exu_bits_cf_inst = wbu_io_from_exu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_pc = wbu_io_from_exu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_next_pc = wbu_io_from_exu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_ResSrc = wbu_io_from_exu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rfWen = wbu_io_from_exu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rd = wbu_io_from_exu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_Alu0Res_bits = wbu_io_from_exu_bits_r_data_Alu0Res_bits; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_data_from_mem = wbu_io_from_exu_bits_r_data_data_from_mem; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_csrRdata = wbu_io_from_exu_bits_r_data_csrRdata; // @[RVCore.scala 57:18]
  assign regfile_clk = clock; // @[RVCore.scala 137:18]
  assign regfile_rs1 = isu_io_from_idu_bits_ctrl_rs1; // @[RVCore.scala 139:18]
  assign regfile_rs2 = isu_io_from_idu_bits_ctrl_rs2; // @[RVCore.scala 140:18]
  assign regfile_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 141:19]
  assign regfile_dest = wbu_io_to_reg_bits_Res; // @[RVCore.scala 142:19]
  assign regfile_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 143:23]
  always @(posedge clock) begin
    if (reset) begin // @[RVCore.scala 48:26]
      valid <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_redirect_valid) begin // @[RVCore.scala 49:21]
      valid <= 1'h0; // @[RVCore.scala 49:28]
    end else begin
      valid <= _GEN_1;
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_inst <= ifu_io_to_idu_bits_inst; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_pc <= ifu_io_to_idu_bits_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_next_pc <= ifu_io_to_idu_bits_next_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_isBranch <= ifu_io_to_idu_bits_isBranch; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_1 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_redirect_valid) begin // @[RVCore.scala 49:21]
      valid_1 <= 1'h0; // @[RVCore.scala 49:28]
    end else if (isu_io_from_idu_ready & idu_io_to_isu_valid) begin // @[RVCore.scala 50:44]
      valid_1 <= idu_io_to_isu_valid; // @[RVCore.scala 50:51]
    end else if (_T_2) begin // @[RVCore.scala 51:38]
      valid_1 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_inst <= idu_io_to_isu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_pc <= idu_io_to_isu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_next_pc <= idu_io_to_isu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_isBranch <= idu_io_to_isu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_MemWrite <= idu_io_to_isu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_ResSrc <= idu_io_to_isu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc1Type <= idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc2Type <= idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuType <= idu_io_to_isu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuOpType <= idu_io_to_isu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs1 <= idu_io_to_isu_bits_ctrl_rs1; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs2 <= idu_io_to_isu_bits_ctrl_rs2; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rfWen <= idu_io_to_isu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rd <= idu_io_to_isu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_data_imm <= idu_io_to_isu_bits_data_imm; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_2 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_from_isu_ready & isu_io_to_exu_valid) begin // @[RVCore.scala 50:44]
      valid_2 <= isu_io_to_exu_valid; // @[RVCore.scala 50:51]
    end else if (_T_4) begin // @[RVCore.scala 51:38]
      valid_2 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_inst <= isu_io_to_exu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_pc <= isu_io_to_exu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_next_pc <= isu_io_to_exu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_isBranch <= isu_io_to_exu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_MemWrite <= isu_io_to_exu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_ResSrc <= isu_io_to_exu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuType <= isu_io_to_exu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuOpType <= isu_io_to_exu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rfWen <= isu_io_to_exu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rd <= isu_io_to_exu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc1 <= isu_io_to_exu_bits_data_fuSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc2 <= isu_io_to_exu_bits_data_fuSrc2; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_imm <= isu_io_to_exu_bits_data_imm; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc1 <= isu_io_to_exu_bits_data_rfSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc2 <= isu_io_to_exu_bits_data_rfSrc2; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_3 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (wbu_io_from_exu_ready & exu_io_to_wbu_valid) begin // @[RVCore.scala 50:44]
      valid_3 <= exu_io_to_wbu_valid; // @[RVCore.scala 50:51]
    end else if (_T_6) begin // @[RVCore.scala 51:38]
      valid_3 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_inst <= exu_io_to_wbu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_pc <= exu_io_to_wbu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_next_pc <= exu_io_to_wbu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_ResSrc <= exu_io_to_wbu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_rfWen <= exu_io_to_wbu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_rd <= exu_io_to_wbu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_Alu0Res_bits <= exu_io_to_wbu_bits_data_Alu0Res_bits; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_data_from_mem <= exu_io_to_wbu_bits_data_data_from_mem; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_csrRdata <= exu_io_to_wbu_bits_data_csrRdata; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 129:29]
      io_commit_valid_REG <= 1'h0; // @[RVCore.scala 129:29]
    end else begin
      io_commit_valid_REG <= wbu_io_to_reg_valid; // @[RVCore.scala 129:29]
    end
    io_commit_pc_REG <= wbu_io_to_commit_pc; // @[RVCore.scala 131:26]
    io_commit_next_pc_REG <= wbu_io_to_commit_next_pc; // @[RVCore.scala 132:31]
    io_commit_inst_REG <= wbu_io_to_commit_inst; // @[RVCore.scala 133:28]
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
  valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_next_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_isBranch = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_inst = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_pc = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_next_pc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_isBranch = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_MemWrite = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_ResSrc = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc1Type = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc2Type = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuType = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuOpType = _RAND_15[6:0];
  _RAND_16 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs1 = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs2 = _RAND_17[4:0];
  _RAND_18 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rfWen = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rd = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_data_imm = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  valid_2 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_inst = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_pc = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_next_pc = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_isBranch = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_MemWrite = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_ResSrc = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuType = _RAND_28[2:0];
  _RAND_29 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuOpType = _RAND_29[6:0];
  _RAND_30 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rfWen = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rd = _RAND_31[4:0];
  _RAND_32 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc1 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc2 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_imm = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc1 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc2 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  valid_3 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_inst = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_pc = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_next_pc = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_ResSrc = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rfWen = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rd = _RAND_43[4:0];
  _RAND_44 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_Alu0Res_bits = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_data_from_mem = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_csrRdata = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  io_commit_valid_REG = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  io_commit_pc_REG = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  io_commit_next_pc_REG = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  io_commit_inst_REG = _RAND_50[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
