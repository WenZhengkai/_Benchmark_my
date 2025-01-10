module Allocator(
  input         clock,
  input         reset,
  input  [31:0] io_s1_req_rmeta_0_0_tag,
  input  [31:0] io_s1_req_rmeta_0_1_tag,
  input  [31:0] io_s1_req_rmeta_1_0_tag,
  input  [31:0] io_s1_req_rmeta_1_1_tag,
  input  [31:0] io_s1_req_tag,
  input         io_s1_hits_0,
  input         io_s1_hits_1,
  output        io_s1_meta_write_way
);
  wire [159:0] alloc_way_r_metas = {io_s1_req_rmeta_1_0_tag,io_s1_req_rmeta_1_1_tag,io_s1_req_rmeta_0_0_tag,
    io_s1_req_rmeta_0_1_tag,io_s1_req_tag}; // @[Cat.scala 33:92]
  wire  alloc_way_chunks_0 = alloc_way_r_metas[0]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_1 = alloc_way_r_metas[1]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_2 = alloc_way_r_metas[2]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_3 = alloc_way_r_metas[3]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_4 = alloc_way_r_metas[4]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_5 = alloc_way_r_metas[5]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_6 = alloc_way_r_metas[6]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_7 = alloc_way_r_metas[7]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_8 = alloc_way_r_metas[8]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_9 = alloc_way_r_metas[9]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_10 = alloc_way_r_metas[10]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_11 = alloc_way_r_metas[11]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_12 = alloc_way_r_metas[12]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_13 = alloc_way_r_metas[13]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_14 = alloc_way_r_metas[14]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_15 = alloc_way_r_metas[15]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_16 = alloc_way_r_metas[16]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_17 = alloc_way_r_metas[17]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_18 = alloc_way_r_metas[18]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_19 = alloc_way_r_metas[19]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_20 = alloc_way_r_metas[20]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_21 = alloc_way_r_metas[21]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_22 = alloc_way_r_metas[22]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_23 = alloc_way_r_metas[23]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_24 = alloc_way_r_metas[24]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_25 = alloc_way_r_metas[25]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_26 = alloc_way_r_metas[26]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_27 = alloc_way_r_metas[27]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_28 = alloc_way_r_metas[28]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_29 = alloc_way_r_metas[29]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_30 = alloc_way_r_metas[30]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_31 = alloc_way_r_metas[31]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_32 = alloc_way_r_metas[32]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_33 = alloc_way_r_metas[33]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_34 = alloc_way_r_metas[34]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_35 = alloc_way_r_metas[35]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_36 = alloc_way_r_metas[36]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_37 = alloc_way_r_metas[37]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_38 = alloc_way_r_metas[38]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_39 = alloc_way_r_metas[39]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_40 = alloc_way_r_metas[40]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_41 = alloc_way_r_metas[41]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_42 = alloc_way_r_metas[42]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_43 = alloc_way_r_metas[43]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_44 = alloc_way_r_metas[44]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_45 = alloc_way_r_metas[45]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_46 = alloc_way_r_metas[46]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_47 = alloc_way_r_metas[47]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_48 = alloc_way_r_metas[48]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_49 = alloc_way_r_metas[49]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_50 = alloc_way_r_metas[50]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_51 = alloc_way_r_metas[51]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_52 = alloc_way_r_metas[52]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_53 = alloc_way_r_metas[53]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_54 = alloc_way_r_metas[54]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_55 = alloc_way_r_metas[55]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_56 = alloc_way_r_metas[56]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_57 = alloc_way_r_metas[57]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_58 = alloc_way_r_metas[58]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_59 = alloc_way_r_metas[59]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_60 = alloc_way_r_metas[60]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_61 = alloc_way_r_metas[61]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_62 = alloc_way_r_metas[62]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_63 = alloc_way_r_metas[63]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_64 = alloc_way_r_metas[64]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_65 = alloc_way_r_metas[65]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_66 = alloc_way_r_metas[66]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_67 = alloc_way_r_metas[67]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_68 = alloc_way_r_metas[68]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_69 = alloc_way_r_metas[69]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_70 = alloc_way_r_metas[70]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_71 = alloc_way_r_metas[71]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_72 = alloc_way_r_metas[72]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_73 = alloc_way_r_metas[73]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_74 = alloc_way_r_metas[74]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_75 = alloc_way_r_metas[75]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_76 = alloc_way_r_metas[76]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_77 = alloc_way_r_metas[77]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_78 = alloc_way_r_metas[78]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_79 = alloc_way_r_metas[79]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_80 = alloc_way_r_metas[80]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_81 = alloc_way_r_metas[81]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_82 = alloc_way_r_metas[82]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_83 = alloc_way_r_metas[83]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_84 = alloc_way_r_metas[84]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_85 = alloc_way_r_metas[85]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_86 = alloc_way_r_metas[86]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_87 = alloc_way_r_metas[87]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_88 = alloc_way_r_metas[88]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_89 = alloc_way_r_metas[89]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_90 = alloc_way_r_metas[90]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_91 = alloc_way_r_metas[91]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_92 = alloc_way_r_metas[92]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_93 = alloc_way_r_metas[93]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_94 = alloc_way_r_metas[94]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_95 = alloc_way_r_metas[95]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_96 = alloc_way_r_metas[96]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_97 = alloc_way_r_metas[97]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_98 = alloc_way_r_metas[98]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_99 = alloc_way_r_metas[99]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_100 = alloc_way_r_metas[100]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_101 = alloc_way_r_metas[101]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_102 = alloc_way_r_metas[102]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_103 = alloc_way_r_metas[103]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_104 = alloc_way_r_metas[104]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_105 = alloc_way_r_metas[105]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_106 = alloc_way_r_metas[106]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_107 = alloc_way_r_metas[107]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_108 = alloc_way_r_metas[108]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_109 = alloc_way_r_metas[109]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_110 = alloc_way_r_metas[110]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_111 = alloc_way_r_metas[111]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_112 = alloc_way_r_metas[112]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_113 = alloc_way_r_metas[113]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_114 = alloc_way_r_metas[114]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_115 = alloc_way_r_metas[115]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_116 = alloc_way_r_metas[116]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_117 = alloc_way_r_metas[117]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_118 = alloc_way_r_metas[118]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_119 = alloc_way_r_metas[119]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_120 = alloc_way_r_metas[120]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_121 = alloc_way_r_metas[121]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_122 = alloc_way_r_metas[122]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_123 = alloc_way_r_metas[123]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_124 = alloc_way_r_metas[124]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_125 = alloc_way_r_metas[125]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_126 = alloc_way_r_metas[126]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_127 = alloc_way_r_metas[127]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_128 = alloc_way_r_metas[128]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_129 = alloc_way_r_metas[129]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_130 = alloc_way_r_metas[130]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_131 = alloc_way_r_metas[131]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_132 = alloc_way_r_metas[132]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_133 = alloc_way_r_metas[133]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_134 = alloc_way_r_metas[134]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_135 = alloc_way_r_metas[135]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_136 = alloc_way_r_metas[136]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_137 = alloc_way_r_metas[137]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_138 = alloc_way_r_metas[138]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_139 = alloc_way_r_metas[139]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_140 = alloc_way_r_metas[140]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_141 = alloc_way_r_metas[141]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_142 = alloc_way_r_metas[142]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_143 = alloc_way_r_metas[143]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_144 = alloc_way_r_metas[144]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_145 = alloc_way_r_metas[145]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_146 = alloc_way_r_metas[146]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_147 = alloc_way_r_metas[147]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_148 = alloc_way_r_metas[148]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_149 = alloc_way_r_metas[149]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_150 = alloc_way_r_metas[150]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_151 = alloc_way_r_metas[151]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_152 = alloc_way_r_metas[152]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_153 = alloc_way_r_metas[153]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_154 = alloc_way_r_metas[154]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_155 = alloc_way_r_metas[155]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_156 = alloc_way_r_metas[156]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_157 = alloc_way_r_metas[157]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_158 = alloc_way_r_metas[158]; // @[Allocator.scala 24:14]
  wire  alloc_way_chunks_159 = alloc_way_r_metas[159]; // @[Allocator.scala 24:14]
  wire  _alloc_way_T_29 = alloc_way_chunks_0 ^ alloc_way_chunks_1 ^ alloc_way_chunks_2 ^ alloc_way_chunks_3 ^
    alloc_way_chunks_4 ^ alloc_way_chunks_5 ^ alloc_way_chunks_6 ^ alloc_way_chunks_7 ^ alloc_way_chunks_8 ^
    alloc_way_chunks_9 ^ alloc_way_chunks_10 ^ alloc_way_chunks_11 ^ alloc_way_chunks_12 ^ alloc_way_chunks_13 ^
    alloc_way_chunks_14 ^ alloc_way_chunks_15 ^ alloc_way_chunks_16 ^ alloc_way_chunks_17 ^ alloc_way_chunks_18 ^
    alloc_way_chunks_19 ^ alloc_way_chunks_20 ^ alloc_way_chunks_21 ^ alloc_way_chunks_22 ^ alloc_way_chunks_23 ^
    alloc_way_chunks_24 ^ alloc_way_chunks_25 ^ alloc_way_chunks_26 ^ alloc_way_chunks_27 ^ alloc_way_chunks_28 ^
    alloc_way_chunks_29 ^ alloc_way_chunks_30; // @[Allocator.scala 26:21]
  wire  _alloc_way_T_59 = _alloc_way_T_29 ^ alloc_way_chunks_31 ^ alloc_way_chunks_32 ^ alloc_way_chunks_33 ^
    alloc_way_chunks_34 ^ alloc_way_chunks_35 ^ alloc_way_chunks_36 ^ alloc_way_chunks_37 ^ alloc_way_chunks_38 ^
    alloc_way_chunks_39 ^ alloc_way_chunks_40 ^ alloc_way_chunks_41 ^ alloc_way_chunks_42 ^ alloc_way_chunks_43 ^
    alloc_way_chunks_44 ^ alloc_way_chunks_45 ^ alloc_way_chunks_46 ^ alloc_way_chunks_47 ^ alloc_way_chunks_48 ^
    alloc_way_chunks_49 ^ alloc_way_chunks_50 ^ alloc_way_chunks_51 ^ alloc_way_chunks_52 ^ alloc_way_chunks_53 ^
    alloc_way_chunks_54 ^ alloc_way_chunks_55 ^ alloc_way_chunks_56 ^ alloc_way_chunks_57 ^ alloc_way_chunks_58 ^
    alloc_way_chunks_59 ^ alloc_way_chunks_60; // @[Allocator.scala 26:21]
  wire  _alloc_way_T_89 = _alloc_way_T_59 ^ alloc_way_chunks_61 ^ alloc_way_chunks_62 ^ alloc_way_chunks_63 ^
    alloc_way_chunks_64 ^ alloc_way_chunks_65 ^ alloc_way_chunks_66 ^ alloc_way_chunks_67 ^ alloc_way_chunks_68 ^
    alloc_way_chunks_69 ^ alloc_way_chunks_70 ^ alloc_way_chunks_71 ^ alloc_way_chunks_72 ^ alloc_way_chunks_73 ^
    alloc_way_chunks_74 ^ alloc_way_chunks_75 ^ alloc_way_chunks_76 ^ alloc_way_chunks_77 ^ alloc_way_chunks_78 ^
    alloc_way_chunks_79 ^ alloc_way_chunks_80 ^ alloc_way_chunks_81 ^ alloc_way_chunks_82 ^ alloc_way_chunks_83 ^
    alloc_way_chunks_84 ^ alloc_way_chunks_85 ^ alloc_way_chunks_86 ^ alloc_way_chunks_87 ^ alloc_way_chunks_88 ^
    alloc_way_chunks_89 ^ alloc_way_chunks_90; // @[Allocator.scala 26:21]
  wire  _alloc_way_T_119 = _alloc_way_T_89 ^ alloc_way_chunks_91 ^ alloc_way_chunks_92 ^ alloc_way_chunks_93 ^
    alloc_way_chunks_94 ^ alloc_way_chunks_95 ^ alloc_way_chunks_96 ^ alloc_way_chunks_97 ^ alloc_way_chunks_98 ^
    alloc_way_chunks_99 ^ alloc_way_chunks_100 ^ alloc_way_chunks_101 ^ alloc_way_chunks_102 ^ alloc_way_chunks_103 ^
    alloc_way_chunks_104 ^ alloc_way_chunks_105 ^ alloc_way_chunks_106 ^ alloc_way_chunks_107 ^ alloc_way_chunks_108 ^
    alloc_way_chunks_109 ^ alloc_way_chunks_110 ^ alloc_way_chunks_111 ^ alloc_way_chunks_112 ^ alloc_way_chunks_113 ^
    alloc_way_chunks_114 ^ alloc_way_chunks_115 ^ alloc_way_chunks_116 ^ alloc_way_chunks_117 ^ alloc_way_chunks_118 ^
    alloc_way_chunks_119 ^ alloc_way_chunks_120; // @[Allocator.scala 26:21]
  wire  _alloc_way_T_149 = _alloc_way_T_119 ^ alloc_way_chunks_121 ^ alloc_way_chunks_122 ^ alloc_way_chunks_123 ^
    alloc_way_chunks_124 ^ alloc_way_chunks_125 ^ alloc_way_chunks_126 ^ alloc_way_chunks_127 ^ alloc_way_chunks_128 ^
    alloc_way_chunks_129 ^ alloc_way_chunks_130 ^ alloc_way_chunks_131 ^ alloc_way_chunks_132 ^ alloc_way_chunks_133 ^
    alloc_way_chunks_134 ^ alloc_way_chunks_135 ^ alloc_way_chunks_136 ^ alloc_way_chunks_137 ^ alloc_way_chunks_138 ^
    alloc_way_chunks_139 ^ alloc_way_chunks_140 ^ alloc_way_chunks_141 ^ alloc_way_chunks_142 ^ alloc_way_chunks_143 ^
    alloc_way_chunks_144 ^ alloc_way_chunks_145 ^ alloc_way_chunks_146 ^ alloc_way_chunks_147 ^ alloc_way_chunks_148 ^
    alloc_way_chunks_149 ^ alloc_way_chunks_150; // @[Allocator.scala 26:21]
  wire  alloc_way = _alloc_way_T_149 ^ alloc_way_chunks_151 ^ alloc_way_chunks_152 ^ alloc_way_chunks_153 ^
    alloc_way_chunks_154 ^ alloc_way_chunks_155 ^ alloc_way_chunks_156 ^ alloc_way_chunks_157 ^ alloc_way_chunks_158 ^
    alloc_way_chunks_159; // @[Allocator.scala 26:21]
  assign io_s1_meta_write_way = io_s1_hits_0 | io_s1_hits_1 ? 1'h0 : alloc_way; // @[Allocator.scala 31:30]
endmodule
