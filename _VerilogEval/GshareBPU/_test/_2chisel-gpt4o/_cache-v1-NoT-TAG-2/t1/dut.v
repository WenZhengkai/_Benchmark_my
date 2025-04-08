module dut(
  input        clock,
  input        reset,
  input        io_predict_valid,
  input  [6:0] io_predict_pc,
  output       io_predict_taken,
  output [6:0] io_predict_history,
  input        io_train_valid,
  input        io_train_taken,
  input        io_train_mispredicted,
  input  [6:0] io_train_history,
  input  [6:0] io_train_pc
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
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
  reg [31:0] _RAND_228;
  reg [31:0] _RAND_229;
  reg [31:0] _RAND_230;
  reg [31:0] _RAND_231;
  reg [31:0] _RAND_232;
  reg [31:0] _RAND_233;
  reg [31:0] _RAND_234;
  reg [31:0] _RAND_235;
  reg [31:0] _RAND_236;
  reg [31:0] _RAND_237;
  reg [31:0] _RAND_238;
  reg [31:0] _RAND_239;
  reg [31:0] _RAND_240;
  reg [31:0] _RAND_241;
  reg [31:0] _RAND_242;
  reg [31:0] _RAND_243;
  reg [31:0] _RAND_244;
  reg [31:0] _RAND_245;
  reg [31:0] _RAND_246;
  reg [31:0] _RAND_247;
  reg [31:0] _RAND_248;
  reg [31:0] _RAND_249;
  reg [31:0] _RAND_250;
  reg [31:0] _RAND_251;
  reg [31:0] _RAND_252;
  reg [31:0] _RAND_253;
  reg [31:0] _RAND_254;
  reg [31:0] _RAND_255;
  reg [31:0] _RAND_256;
  reg [31:0] _RAND_257;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] pht_table_0; // @[dut.scala 21:26]
  reg [1:0] pht_table_1; // @[dut.scala 21:26]
  reg [1:0] pht_table_2; // @[dut.scala 21:26]
  reg [1:0] pht_table_3; // @[dut.scala 21:26]
  reg [1:0] pht_table_4; // @[dut.scala 21:26]
  reg [1:0] pht_table_5; // @[dut.scala 21:26]
  reg [1:0] pht_table_6; // @[dut.scala 21:26]
  reg [1:0] pht_table_7; // @[dut.scala 21:26]
  reg [1:0] pht_table_8; // @[dut.scala 21:26]
  reg [1:0] pht_table_9; // @[dut.scala 21:26]
  reg [1:0] pht_table_10; // @[dut.scala 21:26]
  reg [1:0] pht_table_11; // @[dut.scala 21:26]
  reg [1:0] pht_table_12; // @[dut.scala 21:26]
  reg [1:0] pht_table_13; // @[dut.scala 21:26]
  reg [1:0] pht_table_14; // @[dut.scala 21:26]
  reg [1:0] pht_table_15; // @[dut.scala 21:26]
  reg [1:0] pht_table_16; // @[dut.scala 21:26]
  reg [1:0] pht_table_17; // @[dut.scala 21:26]
  reg [1:0] pht_table_18; // @[dut.scala 21:26]
  reg [1:0] pht_table_19; // @[dut.scala 21:26]
  reg [1:0] pht_table_20; // @[dut.scala 21:26]
  reg [1:0] pht_table_21; // @[dut.scala 21:26]
  reg [1:0] pht_table_22; // @[dut.scala 21:26]
  reg [1:0] pht_table_23; // @[dut.scala 21:26]
  reg [1:0] pht_table_24; // @[dut.scala 21:26]
  reg [1:0] pht_table_25; // @[dut.scala 21:26]
  reg [1:0] pht_table_26; // @[dut.scala 21:26]
  reg [1:0] pht_table_27; // @[dut.scala 21:26]
  reg [1:0] pht_table_28; // @[dut.scala 21:26]
  reg [1:0] pht_table_29; // @[dut.scala 21:26]
  reg [1:0] pht_table_30; // @[dut.scala 21:26]
  reg [1:0] pht_table_31; // @[dut.scala 21:26]
  reg [1:0] pht_table_32; // @[dut.scala 21:26]
  reg [1:0] pht_table_33; // @[dut.scala 21:26]
  reg [1:0] pht_table_34; // @[dut.scala 21:26]
  reg [1:0] pht_table_35; // @[dut.scala 21:26]
  reg [1:0] pht_table_36; // @[dut.scala 21:26]
  reg [1:0] pht_table_37; // @[dut.scala 21:26]
  reg [1:0] pht_table_38; // @[dut.scala 21:26]
  reg [1:0] pht_table_39; // @[dut.scala 21:26]
  reg [1:0] pht_table_40; // @[dut.scala 21:26]
  reg [1:0] pht_table_41; // @[dut.scala 21:26]
  reg [1:0] pht_table_42; // @[dut.scala 21:26]
  reg [1:0] pht_table_43; // @[dut.scala 21:26]
  reg [1:0] pht_table_44; // @[dut.scala 21:26]
  reg [1:0] pht_table_45; // @[dut.scala 21:26]
  reg [1:0] pht_table_46; // @[dut.scala 21:26]
  reg [1:0] pht_table_47; // @[dut.scala 21:26]
  reg [1:0] pht_table_48; // @[dut.scala 21:26]
  reg [1:0] pht_table_49; // @[dut.scala 21:26]
  reg [1:0] pht_table_50; // @[dut.scala 21:26]
  reg [1:0] pht_table_51; // @[dut.scala 21:26]
  reg [1:0] pht_table_52; // @[dut.scala 21:26]
  reg [1:0] pht_table_53; // @[dut.scala 21:26]
  reg [1:0] pht_table_54; // @[dut.scala 21:26]
  reg [1:0] pht_table_55; // @[dut.scala 21:26]
  reg [1:0] pht_table_56; // @[dut.scala 21:26]
  reg [1:0] pht_table_57; // @[dut.scala 21:26]
  reg [1:0] pht_table_58; // @[dut.scala 21:26]
  reg [1:0] pht_table_59; // @[dut.scala 21:26]
  reg [1:0] pht_table_60; // @[dut.scala 21:26]
  reg [1:0] pht_table_61; // @[dut.scala 21:26]
  reg [1:0] pht_table_62; // @[dut.scala 21:26]
  reg [1:0] pht_table_63; // @[dut.scala 21:26]
  reg [1:0] pht_table_64; // @[dut.scala 21:26]
  reg [1:0] pht_table_65; // @[dut.scala 21:26]
  reg [1:0] pht_table_66; // @[dut.scala 21:26]
  reg [1:0] pht_table_67; // @[dut.scala 21:26]
  reg [1:0] pht_table_68; // @[dut.scala 21:26]
  reg [1:0] pht_table_69; // @[dut.scala 21:26]
  reg [1:0] pht_table_70; // @[dut.scala 21:26]
  reg [1:0] pht_table_71; // @[dut.scala 21:26]
  reg [1:0] pht_table_72; // @[dut.scala 21:26]
  reg [1:0] pht_table_73; // @[dut.scala 21:26]
  reg [1:0] pht_table_74; // @[dut.scala 21:26]
  reg [1:0] pht_table_75; // @[dut.scala 21:26]
  reg [1:0] pht_table_76; // @[dut.scala 21:26]
  reg [1:0] pht_table_77; // @[dut.scala 21:26]
  reg [1:0] pht_table_78; // @[dut.scala 21:26]
  reg [1:0] pht_table_79; // @[dut.scala 21:26]
  reg [1:0] pht_table_80; // @[dut.scala 21:26]
  reg [1:0] pht_table_81; // @[dut.scala 21:26]
  reg [1:0] pht_table_82; // @[dut.scala 21:26]
  reg [1:0] pht_table_83; // @[dut.scala 21:26]
  reg [1:0] pht_table_84; // @[dut.scala 21:26]
  reg [1:0] pht_table_85; // @[dut.scala 21:26]
  reg [1:0] pht_table_86; // @[dut.scala 21:26]
  reg [1:0] pht_table_87; // @[dut.scala 21:26]
  reg [1:0] pht_table_88; // @[dut.scala 21:26]
  reg [1:0] pht_table_89; // @[dut.scala 21:26]
  reg [1:0] pht_table_90; // @[dut.scala 21:26]
  reg [1:0] pht_table_91; // @[dut.scala 21:26]
  reg [1:0] pht_table_92; // @[dut.scala 21:26]
  reg [1:0] pht_table_93; // @[dut.scala 21:26]
  reg [1:0] pht_table_94; // @[dut.scala 21:26]
  reg [1:0] pht_table_95; // @[dut.scala 21:26]
  reg [1:0] pht_table_96; // @[dut.scala 21:26]
  reg [1:0] pht_table_97; // @[dut.scala 21:26]
  reg [1:0] pht_table_98; // @[dut.scala 21:26]
  reg [1:0] pht_table_99; // @[dut.scala 21:26]
  reg [1:0] pht_table_100; // @[dut.scala 21:26]
  reg [1:0] pht_table_101; // @[dut.scala 21:26]
  reg [1:0] pht_table_102; // @[dut.scala 21:26]
  reg [1:0] pht_table_103; // @[dut.scala 21:26]
  reg [1:0] pht_table_104; // @[dut.scala 21:26]
  reg [1:0] pht_table_105; // @[dut.scala 21:26]
  reg [1:0] pht_table_106; // @[dut.scala 21:26]
  reg [1:0] pht_table_107; // @[dut.scala 21:26]
  reg [1:0] pht_table_108; // @[dut.scala 21:26]
  reg [1:0] pht_table_109; // @[dut.scala 21:26]
  reg [1:0] pht_table_110; // @[dut.scala 21:26]
  reg [1:0] pht_table_111; // @[dut.scala 21:26]
  reg [1:0] pht_table_112; // @[dut.scala 21:26]
  reg [1:0] pht_table_113; // @[dut.scala 21:26]
  reg [1:0] pht_table_114; // @[dut.scala 21:26]
  reg [1:0] pht_table_115; // @[dut.scala 21:26]
  reg [1:0] pht_table_116; // @[dut.scala 21:26]
  reg [1:0] pht_table_117; // @[dut.scala 21:26]
  reg [1:0] pht_table_118; // @[dut.scala 21:26]
  reg [1:0] pht_table_119; // @[dut.scala 21:26]
  reg [1:0] pht_table_120; // @[dut.scala 21:26]
  reg [1:0] pht_table_121; // @[dut.scala 21:26]
  reg [1:0] pht_table_122; // @[dut.scala 21:26]
  reg [1:0] pht_table_123; // @[dut.scala 21:26]
  reg [1:0] pht_table_124; // @[dut.scala 21:26]
  reg [1:0] pht_table_125; // @[dut.scala 21:26]
  reg [1:0] pht_table_126; // @[dut.scala 21:26]
  reg [1:0] pht_table_127; // @[dut.scala 21:26]
  reg [6:0] ghr; // @[dut.scala 22:20]
  wire [6:0] predict_index = io_predict_pc ^ ghr; // @[dut.scala 25:37]
  wire [1:0] _GEN_1 = 7'h1 == predict_index ? pht_table_1 : pht_table_0; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_2 = 7'h2 == predict_index ? pht_table_2 : _GEN_1; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_3 = 7'h3 == predict_index ? pht_table_3 : _GEN_2; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_4 = 7'h4 == predict_index ? pht_table_4 : _GEN_3; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_5 = 7'h5 == predict_index ? pht_table_5 : _GEN_4; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_6 = 7'h6 == predict_index ? pht_table_6 : _GEN_5; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_7 = 7'h7 == predict_index ? pht_table_7 : _GEN_6; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_8 = 7'h8 == predict_index ? pht_table_8 : _GEN_7; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_9 = 7'h9 == predict_index ? pht_table_9 : _GEN_8; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_10 = 7'ha == predict_index ? pht_table_10 : _GEN_9; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_11 = 7'hb == predict_index ? pht_table_11 : _GEN_10; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_12 = 7'hc == predict_index ? pht_table_12 : _GEN_11; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_13 = 7'hd == predict_index ? pht_table_13 : _GEN_12; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_14 = 7'he == predict_index ? pht_table_14 : _GEN_13; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_15 = 7'hf == predict_index ? pht_table_15 : _GEN_14; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_16 = 7'h10 == predict_index ? pht_table_16 : _GEN_15; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_17 = 7'h11 == predict_index ? pht_table_17 : _GEN_16; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_18 = 7'h12 == predict_index ? pht_table_18 : _GEN_17; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_19 = 7'h13 == predict_index ? pht_table_19 : _GEN_18; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_20 = 7'h14 == predict_index ? pht_table_20 : _GEN_19; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_21 = 7'h15 == predict_index ? pht_table_21 : _GEN_20; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_22 = 7'h16 == predict_index ? pht_table_22 : _GEN_21; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_23 = 7'h17 == predict_index ? pht_table_23 : _GEN_22; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_24 = 7'h18 == predict_index ? pht_table_24 : _GEN_23; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_25 = 7'h19 == predict_index ? pht_table_25 : _GEN_24; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_26 = 7'h1a == predict_index ? pht_table_26 : _GEN_25; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_27 = 7'h1b == predict_index ? pht_table_27 : _GEN_26; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_28 = 7'h1c == predict_index ? pht_table_28 : _GEN_27; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_29 = 7'h1d == predict_index ? pht_table_29 : _GEN_28; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_30 = 7'h1e == predict_index ? pht_table_30 : _GEN_29; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_31 = 7'h1f == predict_index ? pht_table_31 : _GEN_30; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_32 = 7'h20 == predict_index ? pht_table_32 : _GEN_31; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_33 = 7'h21 == predict_index ? pht_table_33 : _GEN_32; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_34 = 7'h22 == predict_index ? pht_table_34 : _GEN_33; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_35 = 7'h23 == predict_index ? pht_table_35 : _GEN_34; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_36 = 7'h24 == predict_index ? pht_table_36 : _GEN_35; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_37 = 7'h25 == predict_index ? pht_table_37 : _GEN_36; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_38 = 7'h26 == predict_index ? pht_table_38 : _GEN_37; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_39 = 7'h27 == predict_index ? pht_table_39 : _GEN_38; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_40 = 7'h28 == predict_index ? pht_table_40 : _GEN_39; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_41 = 7'h29 == predict_index ? pht_table_41 : _GEN_40; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_42 = 7'h2a == predict_index ? pht_table_42 : _GEN_41; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_43 = 7'h2b == predict_index ? pht_table_43 : _GEN_42; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_44 = 7'h2c == predict_index ? pht_table_44 : _GEN_43; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_45 = 7'h2d == predict_index ? pht_table_45 : _GEN_44; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_46 = 7'h2e == predict_index ? pht_table_46 : _GEN_45; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_47 = 7'h2f == predict_index ? pht_table_47 : _GEN_46; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_48 = 7'h30 == predict_index ? pht_table_48 : _GEN_47; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_49 = 7'h31 == predict_index ? pht_table_49 : _GEN_48; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_50 = 7'h32 == predict_index ? pht_table_50 : _GEN_49; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_51 = 7'h33 == predict_index ? pht_table_51 : _GEN_50; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_52 = 7'h34 == predict_index ? pht_table_52 : _GEN_51; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_53 = 7'h35 == predict_index ? pht_table_53 : _GEN_52; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_54 = 7'h36 == predict_index ? pht_table_54 : _GEN_53; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_55 = 7'h37 == predict_index ? pht_table_55 : _GEN_54; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_56 = 7'h38 == predict_index ? pht_table_56 : _GEN_55; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_57 = 7'h39 == predict_index ? pht_table_57 : _GEN_56; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_58 = 7'h3a == predict_index ? pht_table_58 : _GEN_57; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_59 = 7'h3b == predict_index ? pht_table_59 : _GEN_58; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_60 = 7'h3c == predict_index ? pht_table_60 : _GEN_59; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_61 = 7'h3d == predict_index ? pht_table_61 : _GEN_60; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_62 = 7'h3e == predict_index ? pht_table_62 : _GEN_61; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_63 = 7'h3f == predict_index ? pht_table_63 : _GEN_62; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_64 = 7'h40 == predict_index ? pht_table_64 : _GEN_63; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_65 = 7'h41 == predict_index ? pht_table_65 : _GEN_64; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_66 = 7'h42 == predict_index ? pht_table_66 : _GEN_65; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_67 = 7'h43 == predict_index ? pht_table_67 : _GEN_66; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_68 = 7'h44 == predict_index ? pht_table_68 : _GEN_67; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_69 = 7'h45 == predict_index ? pht_table_69 : _GEN_68; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_70 = 7'h46 == predict_index ? pht_table_70 : _GEN_69; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_71 = 7'h47 == predict_index ? pht_table_71 : _GEN_70; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_72 = 7'h48 == predict_index ? pht_table_72 : _GEN_71; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_73 = 7'h49 == predict_index ? pht_table_73 : _GEN_72; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_74 = 7'h4a == predict_index ? pht_table_74 : _GEN_73; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_75 = 7'h4b == predict_index ? pht_table_75 : _GEN_74; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_76 = 7'h4c == predict_index ? pht_table_76 : _GEN_75; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_77 = 7'h4d == predict_index ? pht_table_77 : _GEN_76; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_78 = 7'h4e == predict_index ? pht_table_78 : _GEN_77; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_79 = 7'h4f == predict_index ? pht_table_79 : _GEN_78; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_80 = 7'h50 == predict_index ? pht_table_80 : _GEN_79; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_81 = 7'h51 == predict_index ? pht_table_81 : _GEN_80; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_82 = 7'h52 == predict_index ? pht_table_82 : _GEN_81; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_83 = 7'h53 == predict_index ? pht_table_83 : _GEN_82; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_84 = 7'h54 == predict_index ? pht_table_84 : _GEN_83; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_85 = 7'h55 == predict_index ? pht_table_85 : _GEN_84; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_86 = 7'h56 == predict_index ? pht_table_86 : _GEN_85; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_87 = 7'h57 == predict_index ? pht_table_87 : _GEN_86; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_88 = 7'h58 == predict_index ? pht_table_88 : _GEN_87; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_89 = 7'h59 == predict_index ? pht_table_89 : _GEN_88; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_90 = 7'h5a == predict_index ? pht_table_90 : _GEN_89; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_91 = 7'h5b == predict_index ? pht_table_91 : _GEN_90; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_92 = 7'h5c == predict_index ? pht_table_92 : _GEN_91; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_93 = 7'h5d == predict_index ? pht_table_93 : _GEN_92; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_94 = 7'h5e == predict_index ? pht_table_94 : _GEN_93; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_95 = 7'h5f == predict_index ? pht_table_95 : _GEN_94; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_96 = 7'h60 == predict_index ? pht_table_96 : _GEN_95; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_97 = 7'h61 == predict_index ? pht_table_97 : _GEN_96; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_98 = 7'h62 == predict_index ? pht_table_98 : _GEN_97; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_99 = 7'h63 == predict_index ? pht_table_99 : _GEN_98; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_100 = 7'h64 == predict_index ? pht_table_100 : _GEN_99; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_101 = 7'h65 == predict_index ? pht_table_101 : _GEN_100; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_102 = 7'h66 == predict_index ? pht_table_102 : _GEN_101; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_103 = 7'h67 == predict_index ? pht_table_103 : _GEN_102; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_104 = 7'h68 == predict_index ? pht_table_104 : _GEN_103; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_105 = 7'h69 == predict_index ? pht_table_105 : _GEN_104; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_106 = 7'h6a == predict_index ? pht_table_106 : _GEN_105; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_107 = 7'h6b == predict_index ? pht_table_107 : _GEN_106; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_108 = 7'h6c == predict_index ? pht_table_108 : _GEN_107; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_109 = 7'h6d == predict_index ? pht_table_109 : _GEN_108; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_110 = 7'h6e == predict_index ? pht_table_110 : _GEN_109; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_111 = 7'h6f == predict_index ? pht_table_111 : _GEN_110; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_112 = 7'h70 == predict_index ? pht_table_112 : _GEN_111; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_113 = 7'h71 == predict_index ? pht_table_113 : _GEN_112; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_114 = 7'h72 == predict_index ? pht_table_114 : _GEN_113; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_115 = 7'h73 == predict_index ? pht_table_115 : _GEN_114; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_116 = 7'h74 == predict_index ? pht_table_116 : _GEN_115; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_117 = 7'h75 == predict_index ? pht_table_117 : _GEN_116; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_118 = 7'h76 == predict_index ? pht_table_118 : _GEN_117; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_119 = 7'h77 == predict_index ? pht_table_119 : _GEN_118; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_120 = 7'h78 == predict_index ? pht_table_120 : _GEN_119; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_121 = 7'h79 == predict_index ? pht_table_121 : _GEN_120; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_122 = 7'h7a == predict_index ? pht_table_122 : _GEN_121; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_123 = 7'h7b == predict_index ? pht_table_123 : _GEN_122; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_124 = 7'h7c == predict_index ? pht_table_124 : _GEN_123; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_125 = 7'h7d == predict_index ? pht_table_125 : _GEN_124; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_126 = 7'h7e == predict_index ? pht_table_126 : _GEN_125; // @[dut.scala 28:{32,32}]
  wire [1:0] _GEN_127 = 7'h7f == predict_index ? pht_table_127 : _GEN_126; // @[dut.scala 28:{32,32}]
  wire [7:0] _next_ghr_prediction_T = {ghr, 1'h0}; // @[dut.scala 30:34]
  wire [7:0] _GEN_1156 = {{7'd0}, io_predict_taken}; // @[dut.scala 30:40]
  wire [7:0] next_ghr_prediction = _next_ghr_prediction_T | _GEN_1156; // @[dut.scala 30:40]
  wire [6:0] train_index = io_train_pc ^ io_train_history; // @[dut.scala 33:33]
  wire [1:0] _GEN_129 = 7'h1 == train_index ? pht_table_1 : pht_table_0; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_130 = 7'h2 == train_index ? pht_table_2 : _GEN_129; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_131 = 7'h3 == train_index ? pht_table_3 : _GEN_130; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_132 = 7'h4 == train_index ? pht_table_4 : _GEN_131; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_133 = 7'h5 == train_index ? pht_table_5 : _GEN_132; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_134 = 7'h6 == train_index ? pht_table_6 : _GEN_133; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_135 = 7'h7 == train_index ? pht_table_7 : _GEN_134; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_136 = 7'h8 == train_index ? pht_table_8 : _GEN_135; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_137 = 7'h9 == train_index ? pht_table_9 : _GEN_136; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_138 = 7'ha == train_index ? pht_table_10 : _GEN_137; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_139 = 7'hb == train_index ? pht_table_11 : _GEN_138; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_140 = 7'hc == train_index ? pht_table_12 : _GEN_139; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_141 = 7'hd == train_index ? pht_table_13 : _GEN_140; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_142 = 7'he == train_index ? pht_table_14 : _GEN_141; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_143 = 7'hf == train_index ? pht_table_15 : _GEN_142; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_144 = 7'h10 == train_index ? pht_table_16 : _GEN_143; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_145 = 7'h11 == train_index ? pht_table_17 : _GEN_144; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_146 = 7'h12 == train_index ? pht_table_18 : _GEN_145; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_147 = 7'h13 == train_index ? pht_table_19 : _GEN_146; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_148 = 7'h14 == train_index ? pht_table_20 : _GEN_147; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_149 = 7'h15 == train_index ? pht_table_21 : _GEN_148; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_150 = 7'h16 == train_index ? pht_table_22 : _GEN_149; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_151 = 7'h17 == train_index ? pht_table_23 : _GEN_150; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_152 = 7'h18 == train_index ? pht_table_24 : _GEN_151; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_153 = 7'h19 == train_index ? pht_table_25 : _GEN_152; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_154 = 7'h1a == train_index ? pht_table_26 : _GEN_153; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_155 = 7'h1b == train_index ? pht_table_27 : _GEN_154; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_156 = 7'h1c == train_index ? pht_table_28 : _GEN_155; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_157 = 7'h1d == train_index ? pht_table_29 : _GEN_156; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_158 = 7'h1e == train_index ? pht_table_30 : _GEN_157; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_159 = 7'h1f == train_index ? pht_table_31 : _GEN_158; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_160 = 7'h20 == train_index ? pht_table_32 : _GEN_159; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_161 = 7'h21 == train_index ? pht_table_33 : _GEN_160; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_162 = 7'h22 == train_index ? pht_table_34 : _GEN_161; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_163 = 7'h23 == train_index ? pht_table_35 : _GEN_162; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_164 = 7'h24 == train_index ? pht_table_36 : _GEN_163; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_165 = 7'h25 == train_index ? pht_table_37 : _GEN_164; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_166 = 7'h26 == train_index ? pht_table_38 : _GEN_165; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_167 = 7'h27 == train_index ? pht_table_39 : _GEN_166; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_168 = 7'h28 == train_index ? pht_table_40 : _GEN_167; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_169 = 7'h29 == train_index ? pht_table_41 : _GEN_168; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_170 = 7'h2a == train_index ? pht_table_42 : _GEN_169; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_171 = 7'h2b == train_index ? pht_table_43 : _GEN_170; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_172 = 7'h2c == train_index ? pht_table_44 : _GEN_171; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_173 = 7'h2d == train_index ? pht_table_45 : _GEN_172; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_174 = 7'h2e == train_index ? pht_table_46 : _GEN_173; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_175 = 7'h2f == train_index ? pht_table_47 : _GEN_174; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_176 = 7'h30 == train_index ? pht_table_48 : _GEN_175; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_177 = 7'h31 == train_index ? pht_table_49 : _GEN_176; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_178 = 7'h32 == train_index ? pht_table_50 : _GEN_177; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_179 = 7'h33 == train_index ? pht_table_51 : _GEN_178; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_180 = 7'h34 == train_index ? pht_table_52 : _GEN_179; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_181 = 7'h35 == train_index ? pht_table_53 : _GEN_180; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_182 = 7'h36 == train_index ? pht_table_54 : _GEN_181; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_183 = 7'h37 == train_index ? pht_table_55 : _GEN_182; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_184 = 7'h38 == train_index ? pht_table_56 : _GEN_183; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_185 = 7'h39 == train_index ? pht_table_57 : _GEN_184; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_186 = 7'h3a == train_index ? pht_table_58 : _GEN_185; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_187 = 7'h3b == train_index ? pht_table_59 : _GEN_186; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_188 = 7'h3c == train_index ? pht_table_60 : _GEN_187; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_189 = 7'h3d == train_index ? pht_table_61 : _GEN_188; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_190 = 7'h3e == train_index ? pht_table_62 : _GEN_189; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_191 = 7'h3f == train_index ? pht_table_63 : _GEN_190; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_192 = 7'h40 == train_index ? pht_table_64 : _GEN_191; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_193 = 7'h41 == train_index ? pht_table_65 : _GEN_192; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_194 = 7'h42 == train_index ? pht_table_66 : _GEN_193; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_195 = 7'h43 == train_index ? pht_table_67 : _GEN_194; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_196 = 7'h44 == train_index ? pht_table_68 : _GEN_195; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_197 = 7'h45 == train_index ? pht_table_69 : _GEN_196; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_198 = 7'h46 == train_index ? pht_table_70 : _GEN_197; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_199 = 7'h47 == train_index ? pht_table_71 : _GEN_198; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_200 = 7'h48 == train_index ? pht_table_72 : _GEN_199; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_201 = 7'h49 == train_index ? pht_table_73 : _GEN_200; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_202 = 7'h4a == train_index ? pht_table_74 : _GEN_201; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_203 = 7'h4b == train_index ? pht_table_75 : _GEN_202; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_204 = 7'h4c == train_index ? pht_table_76 : _GEN_203; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_205 = 7'h4d == train_index ? pht_table_77 : _GEN_204; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_206 = 7'h4e == train_index ? pht_table_78 : _GEN_205; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_207 = 7'h4f == train_index ? pht_table_79 : _GEN_206; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_208 = 7'h50 == train_index ? pht_table_80 : _GEN_207; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_209 = 7'h51 == train_index ? pht_table_81 : _GEN_208; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_210 = 7'h52 == train_index ? pht_table_82 : _GEN_209; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_211 = 7'h53 == train_index ? pht_table_83 : _GEN_210; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_212 = 7'h54 == train_index ? pht_table_84 : _GEN_211; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_213 = 7'h55 == train_index ? pht_table_85 : _GEN_212; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_214 = 7'h56 == train_index ? pht_table_86 : _GEN_213; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_215 = 7'h57 == train_index ? pht_table_87 : _GEN_214; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_216 = 7'h58 == train_index ? pht_table_88 : _GEN_215; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_217 = 7'h59 == train_index ? pht_table_89 : _GEN_216; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_218 = 7'h5a == train_index ? pht_table_90 : _GEN_217; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_219 = 7'h5b == train_index ? pht_table_91 : _GEN_218; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_220 = 7'h5c == train_index ? pht_table_92 : _GEN_219; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_221 = 7'h5d == train_index ? pht_table_93 : _GEN_220; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_222 = 7'h5e == train_index ? pht_table_94 : _GEN_221; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_223 = 7'h5f == train_index ? pht_table_95 : _GEN_222; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_224 = 7'h60 == train_index ? pht_table_96 : _GEN_223; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_225 = 7'h61 == train_index ? pht_table_97 : _GEN_224; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_226 = 7'h62 == train_index ? pht_table_98 : _GEN_225; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_227 = 7'h63 == train_index ? pht_table_99 : _GEN_226; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_228 = 7'h64 == train_index ? pht_table_100 : _GEN_227; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_229 = 7'h65 == train_index ? pht_table_101 : _GEN_228; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_230 = 7'h66 == train_index ? pht_table_102 : _GEN_229; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_231 = 7'h67 == train_index ? pht_table_103 : _GEN_230; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_232 = 7'h68 == train_index ? pht_table_104 : _GEN_231; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_233 = 7'h69 == train_index ? pht_table_105 : _GEN_232; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_234 = 7'h6a == train_index ? pht_table_106 : _GEN_233; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_235 = 7'h6b == train_index ? pht_table_107 : _GEN_234; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_236 = 7'h6c == train_index ? pht_table_108 : _GEN_235; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_237 = 7'h6d == train_index ? pht_table_109 : _GEN_236; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_238 = 7'h6e == train_index ? pht_table_110 : _GEN_237; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_239 = 7'h6f == train_index ? pht_table_111 : _GEN_238; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_240 = 7'h70 == train_index ? pht_table_112 : _GEN_239; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_241 = 7'h71 == train_index ? pht_table_113 : _GEN_240; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_242 = 7'h72 == train_index ? pht_table_114 : _GEN_241; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_243 = 7'h73 == train_index ? pht_table_115 : _GEN_242; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_244 = 7'h74 == train_index ? pht_table_116 : _GEN_243; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_245 = 7'h75 == train_index ? pht_table_117 : _GEN_244; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_246 = 7'h76 == train_index ? pht_table_118 : _GEN_245; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_247 = 7'h77 == train_index ? pht_table_119 : _GEN_246; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_248 = 7'h78 == train_index ? pht_table_120 : _GEN_247; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_249 = 7'h79 == train_index ? pht_table_121 : _GEN_248; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_250 = 7'h7a == train_index ? pht_table_122 : _GEN_249; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_251 = 7'h7b == train_index ? pht_table_123 : _GEN_250; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_252 = 7'h7c == train_index ? pht_table_124 : _GEN_251; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_253 = 7'h7d == train_index ? pht_table_125 : _GEN_252; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_254 = 7'h7e == train_index ? pht_table_126 : _GEN_253; // @[dut.scala 40:{35,35}]
  wire [1:0] _GEN_255 = 7'h7f == train_index ? pht_table_127 : _GEN_254; // @[dut.scala 40:{35,35}]
  wire [1:0] _updated_pht_table_T_1 = _GEN_255 + 2'h1; // @[dut.scala 41:66]
  wire [1:0] _updated_pht_table_T_3 = _GEN_255 - 2'h1; // @[dut.scala 45:66]
  wire [7:0] _corrected_ghr_T = {io_train_history, 1'h0}; // @[dut.scala 50:41]
  wire [7:0] _GEN_1157 = {{7'd0}, io_train_taken}; // @[dut.scala 50:47]
  wire [7:0] corrected_ghr = _corrected_ghr_T | _GEN_1157; // @[dut.scala 50:47]
  wire [7:0] next_ghr_training = io_train_mispredicted ? corrected_ghr : next_ghr_prediction; // @[dut.scala 51:30]
  wire [7:0] _GEN_1024 = io_predict_valid ? next_ghr_prediction : {{1'd0}, ghr}; // @[dut.scala 59:32 60:14 62:14]
  wire [7:0] _GEN_1025 = io_train_valid ? next_ghr_training : _GEN_1024; // @[dut.scala 57:30 58:14]
  wire [7:0] _GEN_1026 = io_train_valid & io_train_mispredicted ? corrected_ghr : _GEN_1025; // @[dut.scala 55:49 56:14]
  reg [1:0] REG_0; // @[dut.scala 66:23]
  reg [1:0] REG_1; // @[dut.scala 66:23]
  reg [1:0] REG_2; // @[dut.scala 66:23]
  reg [1:0] REG_3; // @[dut.scala 66:23]
  reg [1:0] REG_4; // @[dut.scala 66:23]
  reg [1:0] REG_5; // @[dut.scala 66:23]
  reg [1:0] REG_6; // @[dut.scala 66:23]
  reg [1:0] REG_7; // @[dut.scala 66:23]
  reg [1:0] REG_8; // @[dut.scala 66:23]
  reg [1:0] REG_9; // @[dut.scala 66:23]
  reg [1:0] REG_10; // @[dut.scala 66:23]
  reg [1:0] REG_11; // @[dut.scala 66:23]
  reg [1:0] REG_12; // @[dut.scala 66:23]
  reg [1:0] REG_13; // @[dut.scala 66:23]
  reg [1:0] REG_14; // @[dut.scala 66:23]
  reg [1:0] REG_15; // @[dut.scala 66:23]
  reg [1:0] REG_16; // @[dut.scala 66:23]
  reg [1:0] REG_17; // @[dut.scala 66:23]
  reg [1:0] REG_18; // @[dut.scala 66:23]
  reg [1:0] REG_19; // @[dut.scala 66:23]
  reg [1:0] REG_20; // @[dut.scala 66:23]
  reg [1:0] REG_21; // @[dut.scala 66:23]
  reg [1:0] REG_22; // @[dut.scala 66:23]
  reg [1:0] REG_23; // @[dut.scala 66:23]
  reg [1:0] REG_24; // @[dut.scala 66:23]
  reg [1:0] REG_25; // @[dut.scala 66:23]
  reg [1:0] REG_26; // @[dut.scala 66:23]
  reg [1:0] REG_27; // @[dut.scala 66:23]
  reg [1:0] REG_28; // @[dut.scala 66:23]
  reg [1:0] REG_29; // @[dut.scala 66:23]
  reg [1:0] REG_30; // @[dut.scala 66:23]
  reg [1:0] REG_31; // @[dut.scala 66:23]
  reg [1:0] REG_32; // @[dut.scala 66:23]
  reg [1:0] REG_33; // @[dut.scala 66:23]
  reg [1:0] REG_34; // @[dut.scala 66:23]
  reg [1:0] REG_35; // @[dut.scala 66:23]
  reg [1:0] REG_36; // @[dut.scala 66:23]
  reg [1:0] REG_37; // @[dut.scala 66:23]
  reg [1:0] REG_38; // @[dut.scala 66:23]
  reg [1:0] REG_39; // @[dut.scala 66:23]
  reg [1:0] REG_40; // @[dut.scala 66:23]
  reg [1:0] REG_41; // @[dut.scala 66:23]
  reg [1:0] REG_42; // @[dut.scala 66:23]
  reg [1:0] REG_43; // @[dut.scala 66:23]
  reg [1:0] REG_44; // @[dut.scala 66:23]
  reg [1:0] REG_45; // @[dut.scala 66:23]
  reg [1:0] REG_46; // @[dut.scala 66:23]
  reg [1:0] REG_47; // @[dut.scala 66:23]
  reg [1:0] REG_48; // @[dut.scala 66:23]
  reg [1:0] REG_49; // @[dut.scala 66:23]
  reg [1:0] REG_50; // @[dut.scala 66:23]
  reg [1:0] REG_51; // @[dut.scala 66:23]
  reg [1:0] REG_52; // @[dut.scala 66:23]
  reg [1:0] REG_53; // @[dut.scala 66:23]
  reg [1:0] REG_54; // @[dut.scala 66:23]
  reg [1:0] REG_55; // @[dut.scala 66:23]
  reg [1:0] REG_56; // @[dut.scala 66:23]
  reg [1:0] REG_57; // @[dut.scala 66:23]
  reg [1:0] REG_58; // @[dut.scala 66:23]
  reg [1:0] REG_59; // @[dut.scala 66:23]
  reg [1:0] REG_60; // @[dut.scala 66:23]
  reg [1:0] REG_61; // @[dut.scala 66:23]
  reg [1:0] REG_62; // @[dut.scala 66:23]
  reg [1:0] REG_63; // @[dut.scala 66:23]
  reg [1:0] REG_64; // @[dut.scala 66:23]
  reg [1:0] REG_65; // @[dut.scala 66:23]
  reg [1:0] REG_66; // @[dut.scala 66:23]
  reg [1:0] REG_67; // @[dut.scala 66:23]
  reg [1:0] REG_68; // @[dut.scala 66:23]
  reg [1:0] REG_69; // @[dut.scala 66:23]
  reg [1:0] REG_70; // @[dut.scala 66:23]
  reg [1:0] REG_71; // @[dut.scala 66:23]
  reg [1:0] REG_72; // @[dut.scala 66:23]
  reg [1:0] REG_73; // @[dut.scala 66:23]
  reg [1:0] REG_74; // @[dut.scala 66:23]
  reg [1:0] REG_75; // @[dut.scala 66:23]
  reg [1:0] REG_76; // @[dut.scala 66:23]
  reg [1:0] REG_77; // @[dut.scala 66:23]
  reg [1:0] REG_78; // @[dut.scala 66:23]
  reg [1:0] REG_79; // @[dut.scala 66:23]
  reg [1:0] REG_80; // @[dut.scala 66:23]
  reg [1:0] REG_81; // @[dut.scala 66:23]
  reg [1:0] REG_82; // @[dut.scala 66:23]
  reg [1:0] REG_83; // @[dut.scala 66:23]
  reg [1:0] REG_84; // @[dut.scala 66:23]
  reg [1:0] REG_85; // @[dut.scala 66:23]
  reg [1:0] REG_86; // @[dut.scala 66:23]
  reg [1:0] REG_87; // @[dut.scala 66:23]
  reg [1:0] REG_88; // @[dut.scala 66:23]
  reg [1:0] REG_89; // @[dut.scala 66:23]
  reg [1:0] REG_90; // @[dut.scala 66:23]
  reg [1:0] REG_91; // @[dut.scala 66:23]
  reg [1:0] REG_92; // @[dut.scala 66:23]
  reg [1:0] REG_93; // @[dut.scala 66:23]
  reg [1:0] REG_94; // @[dut.scala 66:23]
  reg [1:0] REG_95; // @[dut.scala 66:23]
  reg [1:0] REG_96; // @[dut.scala 66:23]
  reg [1:0] REG_97; // @[dut.scala 66:23]
  reg [1:0] REG_98; // @[dut.scala 66:23]
  reg [1:0] REG_99; // @[dut.scala 66:23]
  reg [1:0] REG_100; // @[dut.scala 66:23]
  reg [1:0] REG_101; // @[dut.scala 66:23]
  reg [1:0] REG_102; // @[dut.scala 66:23]
  reg [1:0] REG_103; // @[dut.scala 66:23]
  reg [1:0] REG_104; // @[dut.scala 66:23]
  reg [1:0] REG_105; // @[dut.scala 66:23]
  reg [1:0] REG_106; // @[dut.scala 66:23]
  reg [1:0] REG_107; // @[dut.scala 66:23]
  reg [1:0] REG_108; // @[dut.scala 66:23]
  reg [1:0] REG_109; // @[dut.scala 66:23]
  reg [1:0] REG_110; // @[dut.scala 66:23]
  reg [1:0] REG_111; // @[dut.scala 66:23]
  reg [1:0] REG_112; // @[dut.scala 66:23]
  reg [1:0] REG_113; // @[dut.scala 66:23]
  reg [1:0] REG_114; // @[dut.scala 66:23]
  reg [1:0] REG_115; // @[dut.scala 66:23]
  reg [1:0] REG_116; // @[dut.scala 66:23]
  reg [1:0] REG_117; // @[dut.scala 66:23]
  reg [1:0] REG_118; // @[dut.scala 66:23]
  reg [1:0] REG_119; // @[dut.scala 66:23]
  reg [1:0] REG_120; // @[dut.scala 66:23]
  reg [1:0] REG_121; // @[dut.scala 66:23]
  reg [1:0] REG_122; // @[dut.scala 66:23]
  reg [1:0] REG_123; // @[dut.scala 66:23]
  reg [1:0] REG_124; // @[dut.scala 66:23]
  reg [1:0] REG_125; // @[dut.scala 66:23]
  reg [1:0] REG_126; // @[dut.scala 66:23]
  reg [1:0] REG_127; // @[dut.scala 66:23]
  reg [6:0] ghr_REG; // @[dut.scala 67:17]
  assign io_predict_taken = _GEN_127[1]; // @[dut.scala 28:32]
  assign io_predict_history = ghr; // @[dut.scala 29:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:26]
      pht_table_0 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_0 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_0 <= REG_0; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_1 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_1 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_1 <= REG_1; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_2 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_2 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_2 <= REG_2; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_3 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_3 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_3 <= REG_3; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_4 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_4 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_4 <= REG_4; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_5 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_5 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_5 <= REG_5; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_6 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_6 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_6 <= REG_6; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_7 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_7 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_7 <= REG_7; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_8 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_8 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_8 <= REG_8; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_9 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_9 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_9 <= REG_9; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_10 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_10 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_10 <= REG_10; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_11 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_11 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_11 <= REG_11; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_12 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_12 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_12 <= REG_12; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_13 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_13 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_13 <= REG_13; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_14 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_14 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_14 <= REG_14; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_15 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_15 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_15 <= REG_15; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_16 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_16 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_16 <= REG_16; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_17 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_17 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_17 <= REG_17; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_18 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_18 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_18 <= REG_18; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_19 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_19 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_19 <= REG_19; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_20 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_20 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_20 <= REG_20; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_21 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_21 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_21 <= REG_21; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_22 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_22 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_22 <= REG_22; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_23 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_23 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_23 <= REG_23; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_24 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_24 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_24 <= REG_24; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_25 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_25 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_25 <= REG_25; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_26 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_26 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_26 <= REG_26; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_27 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_27 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_27 <= REG_27; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_28 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_28 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_28 <= REG_28; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_29 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_29 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_29 <= REG_29; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_30 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_30 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_30 <= REG_30; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_31 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_31 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_31 <= REG_31; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_32 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_32 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_32 <= REG_32; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_33 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_33 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_33 <= REG_33; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_34 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_34 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_34 <= REG_34; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_35 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_35 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_35 <= REG_35; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_36 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_36 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_36 <= REG_36; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_37 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_37 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_37 <= REG_37; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_38 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_38 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_38 <= REG_38; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_39 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_39 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_39 <= REG_39; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_40 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_40 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_40 <= REG_40; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_41 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_41 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_41 <= REG_41; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_42 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_42 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_42 <= REG_42; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_43 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_43 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_43 <= REG_43; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_44 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_44 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_44 <= REG_44; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_45 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_45 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_45 <= REG_45; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_46 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_46 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_46 <= REG_46; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_47 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_47 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_47 <= REG_47; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_48 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_48 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_48 <= REG_48; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_49 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_49 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_49 <= REG_49; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_50 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_50 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_50 <= REG_50; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_51 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_51 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_51 <= REG_51; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_52 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_52 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_52 <= REG_52; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_53 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_53 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_53 <= REG_53; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_54 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_54 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_54 <= REG_54; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_55 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_55 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_55 <= REG_55; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_56 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_56 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_56 <= REG_56; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_57 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_57 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_57 <= REG_57; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_58 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_58 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_58 <= REG_58; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_59 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_59 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_59 <= REG_59; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_60 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_60 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_60 <= REG_60; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_61 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_61 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_61 <= REG_61; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_62 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_62 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_62 <= REG_62; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_63 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_63 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_63 <= REG_63; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_64 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_64 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_64 <= REG_64; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_65 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_65 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_65 <= REG_65; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_66 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_66 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_66 <= REG_66; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_67 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_67 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_67 <= REG_67; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_68 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_68 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_68 <= REG_68; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_69 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_69 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_69 <= REG_69; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_70 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_70 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_70 <= REG_70; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_71 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_71 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_71 <= REG_71; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_72 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_72 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_72 <= REG_72; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_73 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_73 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_73 <= REG_73; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_74 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_74 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_74 <= REG_74; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_75 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_75 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_75 <= REG_75; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_76 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_76 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_76 <= REG_76; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_77 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_77 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_77 <= REG_77; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_78 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_78 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_78 <= REG_78; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_79 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_79 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_79 <= REG_79; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_80 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_80 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_80 <= REG_80; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_81 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_81 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_81 <= REG_81; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_82 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_82 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_82 <= REG_82; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_83 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_83 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_83 <= REG_83; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_84 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_84 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_84 <= REG_84; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_85 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_85 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_85 <= REG_85; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_86 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_86 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_86 <= REG_86; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_87 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_87 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_87 <= REG_87; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_88 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_88 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_88 <= REG_88; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_89 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_89 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_89 <= REG_89; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_90 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_90 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_90 <= REG_90; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_91 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_91 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_91 <= REG_91; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_92 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_92 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_92 <= REG_92; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_93 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_93 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_93 <= REG_93; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_94 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_94 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_94 <= REG_94; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_95 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_95 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_95 <= REG_95; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_96 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_96 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_96 <= REG_96; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_97 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_97 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_97 <= REG_97; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_98 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_98 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_98 <= REG_98; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_99 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_99 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_99 <= REG_99; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_100 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_100 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_100 <= REG_100; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_101 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_101 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_101 <= REG_101; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_102 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_102 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_102 <= REG_102; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_103 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_103 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_103 <= REG_103; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_104 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_104 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_104 <= REG_104; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_105 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_105 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_105 <= REG_105; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_106 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_106 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_106 <= REG_106; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_107 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_107 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_107 <= REG_107; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_108 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_108 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_108 <= REG_108; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_109 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_109 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_109 <= REG_109; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_110 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_110 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_110 <= REG_110; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_111 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_111 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_111 <= REG_111; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_112 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_112 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_112 <= REG_112; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_113 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_113 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_113 <= REG_113; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_114 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_114 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_114 <= REG_114; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_115 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_115 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_115 <= REG_115; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_116 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_116 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_116 <= REG_116; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_117 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_117 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_117 <= REG_117; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_118 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_118 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_118 <= REG_118; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_119 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_119 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_119 <= REG_119; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_120 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_120 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_120 <= REG_120; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_121 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_121 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_121 <= REG_121; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_122 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_122 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_122 <= REG_122; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_123 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_123 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_123 <= REG_123; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_124 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_124 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_124 <= REG_124; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_125 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_125 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_125 <= REG_125; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_126 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_126 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_126 <= REG_126; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 21:26]
      pht_table_127 <= 2'h1; // @[dut.scala 21:26]
    end else if (reset) begin // @[dut.scala 70:24]
      pht_table_127 <= 2'h1; // @[dut.scala 73:20]
    end else begin
      pht_table_127 <= REG_127; // @[dut.scala 66:13]
    end
    if (reset) begin // @[dut.scala 22:20]
      ghr <= 7'h0; // @[dut.scala 22:20]
    end else if (reset) begin // @[dut.scala 70:24]
      ghr <= 7'h0; // @[dut.scala 71:9]
    end else begin
      ghr <= ghr_REG; // @[dut.scala 67:7]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h0 == train_index) begin // @[dut.scala 41:40]
            REG_0 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_0 <= pht_table_0; // @[dut.scala 36:21]
          end
        end else begin
          REG_0 <= pht_table_0; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h0 == train_index) begin // @[dut.scala 45:40]
          REG_0 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_0 <= pht_table_0; // @[dut.scala 36:21]
        end
      end else begin
        REG_0 <= pht_table_0; // @[dut.scala 36:21]
      end
    end else begin
      REG_0 <= pht_table_0; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1 == train_index) begin // @[dut.scala 41:40]
            REG_1 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_1 <= pht_table_1; // @[dut.scala 36:21]
          end
        end else begin
          REG_1 <= pht_table_1; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1 == train_index) begin // @[dut.scala 45:40]
          REG_1 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_1 <= pht_table_1; // @[dut.scala 36:21]
        end
      end else begin
        REG_1 <= pht_table_1; // @[dut.scala 36:21]
      end
    end else begin
      REG_1 <= pht_table_1; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2 == train_index) begin // @[dut.scala 41:40]
            REG_2 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_2 <= pht_table_2; // @[dut.scala 36:21]
          end
        end else begin
          REG_2 <= pht_table_2; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2 == train_index) begin // @[dut.scala 45:40]
          REG_2 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_2 <= pht_table_2; // @[dut.scala 36:21]
        end
      end else begin
        REG_2 <= pht_table_2; // @[dut.scala 36:21]
      end
    end else begin
      REG_2 <= pht_table_2; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3 == train_index) begin // @[dut.scala 41:40]
            REG_3 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_3 <= pht_table_3; // @[dut.scala 36:21]
          end
        end else begin
          REG_3 <= pht_table_3; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3 == train_index) begin // @[dut.scala 45:40]
          REG_3 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_3 <= pht_table_3; // @[dut.scala 36:21]
        end
      end else begin
        REG_3 <= pht_table_3; // @[dut.scala 36:21]
      end
    end else begin
      REG_3 <= pht_table_3; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4 == train_index) begin // @[dut.scala 41:40]
            REG_4 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_4 <= pht_table_4; // @[dut.scala 36:21]
          end
        end else begin
          REG_4 <= pht_table_4; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4 == train_index) begin // @[dut.scala 45:40]
          REG_4 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_4 <= pht_table_4; // @[dut.scala 36:21]
        end
      end else begin
        REG_4 <= pht_table_4; // @[dut.scala 36:21]
      end
    end else begin
      REG_4 <= pht_table_4; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5 == train_index) begin // @[dut.scala 41:40]
            REG_5 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_5 <= pht_table_5; // @[dut.scala 36:21]
          end
        end else begin
          REG_5 <= pht_table_5; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5 == train_index) begin // @[dut.scala 45:40]
          REG_5 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_5 <= pht_table_5; // @[dut.scala 36:21]
        end
      end else begin
        REG_5 <= pht_table_5; // @[dut.scala 36:21]
      end
    end else begin
      REG_5 <= pht_table_5; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6 == train_index) begin // @[dut.scala 41:40]
            REG_6 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_6 <= pht_table_6; // @[dut.scala 36:21]
          end
        end else begin
          REG_6 <= pht_table_6; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6 == train_index) begin // @[dut.scala 45:40]
          REG_6 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_6 <= pht_table_6; // @[dut.scala 36:21]
        end
      end else begin
        REG_6 <= pht_table_6; // @[dut.scala 36:21]
      end
    end else begin
      REG_6 <= pht_table_6; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7 == train_index) begin // @[dut.scala 41:40]
            REG_7 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_7 <= pht_table_7; // @[dut.scala 36:21]
          end
        end else begin
          REG_7 <= pht_table_7; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7 == train_index) begin // @[dut.scala 45:40]
          REG_7 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_7 <= pht_table_7; // @[dut.scala 36:21]
        end
      end else begin
        REG_7 <= pht_table_7; // @[dut.scala 36:21]
      end
    end else begin
      REG_7 <= pht_table_7; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h8 == train_index) begin // @[dut.scala 41:40]
            REG_8 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_8 <= pht_table_8; // @[dut.scala 36:21]
          end
        end else begin
          REG_8 <= pht_table_8; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h8 == train_index) begin // @[dut.scala 45:40]
          REG_8 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_8 <= pht_table_8; // @[dut.scala 36:21]
        end
      end else begin
        REG_8 <= pht_table_8; // @[dut.scala 36:21]
      end
    end else begin
      REG_8 <= pht_table_8; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h9 == train_index) begin // @[dut.scala 41:40]
            REG_9 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_9 <= pht_table_9; // @[dut.scala 36:21]
          end
        end else begin
          REG_9 <= pht_table_9; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h9 == train_index) begin // @[dut.scala 45:40]
          REG_9 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_9 <= pht_table_9; // @[dut.scala 36:21]
        end
      end else begin
        REG_9 <= pht_table_9; // @[dut.scala 36:21]
      end
    end else begin
      REG_9 <= pht_table_9; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'ha == train_index) begin // @[dut.scala 41:40]
            REG_10 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_10 <= pht_table_10; // @[dut.scala 36:21]
          end
        end else begin
          REG_10 <= pht_table_10; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'ha == train_index) begin // @[dut.scala 45:40]
          REG_10 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_10 <= pht_table_10; // @[dut.scala 36:21]
        end
      end else begin
        REG_10 <= pht_table_10; // @[dut.scala 36:21]
      end
    end else begin
      REG_10 <= pht_table_10; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'hb == train_index) begin // @[dut.scala 41:40]
            REG_11 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_11 <= pht_table_11; // @[dut.scala 36:21]
          end
        end else begin
          REG_11 <= pht_table_11; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'hb == train_index) begin // @[dut.scala 45:40]
          REG_11 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_11 <= pht_table_11; // @[dut.scala 36:21]
        end
      end else begin
        REG_11 <= pht_table_11; // @[dut.scala 36:21]
      end
    end else begin
      REG_11 <= pht_table_11; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'hc == train_index) begin // @[dut.scala 41:40]
            REG_12 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_12 <= pht_table_12; // @[dut.scala 36:21]
          end
        end else begin
          REG_12 <= pht_table_12; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'hc == train_index) begin // @[dut.scala 45:40]
          REG_12 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_12 <= pht_table_12; // @[dut.scala 36:21]
        end
      end else begin
        REG_12 <= pht_table_12; // @[dut.scala 36:21]
      end
    end else begin
      REG_12 <= pht_table_12; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'hd == train_index) begin // @[dut.scala 41:40]
            REG_13 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_13 <= pht_table_13; // @[dut.scala 36:21]
          end
        end else begin
          REG_13 <= pht_table_13; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'hd == train_index) begin // @[dut.scala 45:40]
          REG_13 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_13 <= pht_table_13; // @[dut.scala 36:21]
        end
      end else begin
        REG_13 <= pht_table_13; // @[dut.scala 36:21]
      end
    end else begin
      REG_13 <= pht_table_13; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'he == train_index) begin // @[dut.scala 41:40]
            REG_14 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_14 <= pht_table_14; // @[dut.scala 36:21]
          end
        end else begin
          REG_14 <= pht_table_14; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'he == train_index) begin // @[dut.scala 45:40]
          REG_14 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_14 <= pht_table_14; // @[dut.scala 36:21]
        end
      end else begin
        REG_14 <= pht_table_14; // @[dut.scala 36:21]
      end
    end else begin
      REG_14 <= pht_table_14; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'hf == train_index) begin // @[dut.scala 41:40]
            REG_15 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_15 <= pht_table_15; // @[dut.scala 36:21]
          end
        end else begin
          REG_15 <= pht_table_15; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'hf == train_index) begin // @[dut.scala 45:40]
          REG_15 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_15 <= pht_table_15; // @[dut.scala 36:21]
        end
      end else begin
        REG_15 <= pht_table_15; // @[dut.scala 36:21]
      end
    end else begin
      REG_15 <= pht_table_15; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h10 == train_index) begin // @[dut.scala 41:40]
            REG_16 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_16 <= pht_table_16; // @[dut.scala 36:21]
          end
        end else begin
          REG_16 <= pht_table_16; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h10 == train_index) begin // @[dut.scala 45:40]
          REG_16 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_16 <= pht_table_16; // @[dut.scala 36:21]
        end
      end else begin
        REG_16 <= pht_table_16; // @[dut.scala 36:21]
      end
    end else begin
      REG_16 <= pht_table_16; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h11 == train_index) begin // @[dut.scala 41:40]
            REG_17 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_17 <= pht_table_17; // @[dut.scala 36:21]
          end
        end else begin
          REG_17 <= pht_table_17; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h11 == train_index) begin // @[dut.scala 45:40]
          REG_17 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_17 <= pht_table_17; // @[dut.scala 36:21]
        end
      end else begin
        REG_17 <= pht_table_17; // @[dut.scala 36:21]
      end
    end else begin
      REG_17 <= pht_table_17; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h12 == train_index) begin // @[dut.scala 41:40]
            REG_18 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_18 <= pht_table_18; // @[dut.scala 36:21]
          end
        end else begin
          REG_18 <= pht_table_18; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h12 == train_index) begin // @[dut.scala 45:40]
          REG_18 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_18 <= pht_table_18; // @[dut.scala 36:21]
        end
      end else begin
        REG_18 <= pht_table_18; // @[dut.scala 36:21]
      end
    end else begin
      REG_18 <= pht_table_18; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h13 == train_index) begin // @[dut.scala 41:40]
            REG_19 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_19 <= pht_table_19; // @[dut.scala 36:21]
          end
        end else begin
          REG_19 <= pht_table_19; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h13 == train_index) begin // @[dut.scala 45:40]
          REG_19 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_19 <= pht_table_19; // @[dut.scala 36:21]
        end
      end else begin
        REG_19 <= pht_table_19; // @[dut.scala 36:21]
      end
    end else begin
      REG_19 <= pht_table_19; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h14 == train_index) begin // @[dut.scala 41:40]
            REG_20 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_20 <= pht_table_20; // @[dut.scala 36:21]
          end
        end else begin
          REG_20 <= pht_table_20; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h14 == train_index) begin // @[dut.scala 45:40]
          REG_20 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_20 <= pht_table_20; // @[dut.scala 36:21]
        end
      end else begin
        REG_20 <= pht_table_20; // @[dut.scala 36:21]
      end
    end else begin
      REG_20 <= pht_table_20; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h15 == train_index) begin // @[dut.scala 41:40]
            REG_21 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_21 <= pht_table_21; // @[dut.scala 36:21]
          end
        end else begin
          REG_21 <= pht_table_21; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h15 == train_index) begin // @[dut.scala 45:40]
          REG_21 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_21 <= pht_table_21; // @[dut.scala 36:21]
        end
      end else begin
        REG_21 <= pht_table_21; // @[dut.scala 36:21]
      end
    end else begin
      REG_21 <= pht_table_21; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h16 == train_index) begin // @[dut.scala 41:40]
            REG_22 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_22 <= pht_table_22; // @[dut.scala 36:21]
          end
        end else begin
          REG_22 <= pht_table_22; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h16 == train_index) begin // @[dut.scala 45:40]
          REG_22 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_22 <= pht_table_22; // @[dut.scala 36:21]
        end
      end else begin
        REG_22 <= pht_table_22; // @[dut.scala 36:21]
      end
    end else begin
      REG_22 <= pht_table_22; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h17 == train_index) begin // @[dut.scala 41:40]
            REG_23 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_23 <= pht_table_23; // @[dut.scala 36:21]
          end
        end else begin
          REG_23 <= pht_table_23; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h17 == train_index) begin // @[dut.scala 45:40]
          REG_23 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_23 <= pht_table_23; // @[dut.scala 36:21]
        end
      end else begin
        REG_23 <= pht_table_23; // @[dut.scala 36:21]
      end
    end else begin
      REG_23 <= pht_table_23; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h18 == train_index) begin // @[dut.scala 41:40]
            REG_24 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_24 <= pht_table_24; // @[dut.scala 36:21]
          end
        end else begin
          REG_24 <= pht_table_24; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h18 == train_index) begin // @[dut.scala 45:40]
          REG_24 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_24 <= pht_table_24; // @[dut.scala 36:21]
        end
      end else begin
        REG_24 <= pht_table_24; // @[dut.scala 36:21]
      end
    end else begin
      REG_24 <= pht_table_24; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h19 == train_index) begin // @[dut.scala 41:40]
            REG_25 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_25 <= pht_table_25; // @[dut.scala 36:21]
          end
        end else begin
          REG_25 <= pht_table_25; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h19 == train_index) begin // @[dut.scala 45:40]
          REG_25 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_25 <= pht_table_25; // @[dut.scala 36:21]
        end
      end else begin
        REG_25 <= pht_table_25; // @[dut.scala 36:21]
      end
    end else begin
      REG_25 <= pht_table_25; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1a == train_index) begin // @[dut.scala 41:40]
            REG_26 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_26 <= pht_table_26; // @[dut.scala 36:21]
          end
        end else begin
          REG_26 <= pht_table_26; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1a == train_index) begin // @[dut.scala 45:40]
          REG_26 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_26 <= pht_table_26; // @[dut.scala 36:21]
        end
      end else begin
        REG_26 <= pht_table_26; // @[dut.scala 36:21]
      end
    end else begin
      REG_26 <= pht_table_26; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1b == train_index) begin // @[dut.scala 41:40]
            REG_27 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_27 <= pht_table_27; // @[dut.scala 36:21]
          end
        end else begin
          REG_27 <= pht_table_27; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1b == train_index) begin // @[dut.scala 45:40]
          REG_27 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_27 <= pht_table_27; // @[dut.scala 36:21]
        end
      end else begin
        REG_27 <= pht_table_27; // @[dut.scala 36:21]
      end
    end else begin
      REG_27 <= pht_table_27; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1c == train_index) begin // @[dut.scala 41:40]
            REG_28 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_28 <= pht_table_28; // @[dut.scala 36:21]
          end
        end else begin
          REG_28 <= pht_table_28; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1c == train_index) begin // @[dut.scala 45:40]
          REG_28 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_28 <= pht_table_28; // @[dut.scala 36:21]
        end
      end else begin
        REG_28 <= pht_table_28; // @[dut.scala 36:21]
      end
    end else begin
      REG_28 <= pht_table_28; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1d == train_index) begin // @[dut.scala 41:40]
            REG_29 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_29 <= pht_table_29; // @[dut.scala 36:21]
          end
        end else begin
          REG_29 <= pht_table_29; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1d == train_index) begin // @[dut.scala 45:40]
          REG_29 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_29 <= pht_table_29; // @[dut.scala 36:21]
        end
      end else begin
        REG_29 <= pht_table_29; // @[dut.scala 36:21]
      end
    end else begin
      REG_29 <= pht_table_29; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1e == train_index) begin // @[dut.scala 41:40]
            REG_30 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_30 <= pht_table_30; // @[dut.scala 36:21]
          end
        end else begin
          REG_30 <= pht_table_30; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1e == train_index) begin // @[dut.scala 45:40]
          REG_30 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_30 <= pht_table_30; // @[dut.scala 36:21]
        end
      end else begin
        REG_30 <= pht_table_30; // @[dut.scala 36:21]
      end
    end else begin
      REG_30 <= pht_table_30; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h1f == train_index) begin // @[dut.scala 41:40]
            REG_31 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_31 <= pht_table_31; // @[dut.scala 36:21]
          end
        end else begin
          REG_31 <= pht_table_31; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h1f == train_index) begin // @[dut.scala 45:40]
          REG_31 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_31 <= pht_table_31; // @[dut.scala 36:21]
        end
      end else begin
        REG_31 <= pht_table_31; // @[dut.scala 36:21]
      end
    end else begin
      REG_31 <= pht_table_31; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h20 == train_index) begin // @[dut.scala 41:40]
            REG_32 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_32 <= pht_table_32; // @[dut.scala 36:21]
          end
        end else begin
          REG_32 <= pht_table_32; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h20 == train_index) begin // @[dut.scala 45:40]
          REG_32 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_32 <= pht_table_32; // @[dut.scala 36:21]
        end
      end else begin
        REG_32 <= pht_table_32; // @[dut.scala 36:21]
      end
    end else begin
      REG_32 <= pht_table_32; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h21 == train_index) begin // @[dut.scala 41:40]
            REG_33 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_33 <= pht_table_33; // @[dut.scala 36:21]
          end
        end else begin
          REG_33 <= pht_table_33; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h21 == train_index) begin // @[dut.scala 45:40]
          REG_33 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_33 <= pht_table_33; // @[dut.scala 36:21]
        end
      end else begin
        REG_33 <= pht_table_33; // @[dut.scala 36:21]
      end
    end else begin
      REG_33 <= pht_table_33; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h22 == train_index) begin // @[dut.scala 41:40]
            REG_34 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_34 <= pht_table_34; // @[dut.scala 36:21]
          end
        end else begin
          REG_34 <= pht_table_34; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h22 == train_index) begin // @[dut.scala 45:40]
          REG_34 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_34 <= pht_table_34; // @[dut.scala 36:21]
        end
      end else begin
        REG_34 <= pht_table_34; // @[dut.scala 36:21]
      end
    end else begin
      REG_34 <= pht_table_34; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h23 == train_index) begin // @[dut.scala 41:40]
            REG_35 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_35 <= pht_table_35; // @[dut.scala 36:21]
          end
        end else begin
          REG_35 <= pht_table_35; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h23 == train_index) begin // @[dut.scala 45:40]
          REG_35 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_35 <= pht_table_35; // @[dut.scala 36:21]
        end
      end else begin
        REG_35 <= pht_table_35; // @[dut.scala 36:21]
      end
    end else begin
      REG_35 <= pht_table_35; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h24 == train_index) begin // @[dut.scala 41:40]
            REG_36 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_36 <= pht_table_36; // @[dut.scala 36:21]
          end
        end else begin
          REG_36 <= pht_table_36; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h24 == train_index) begin // @[dut.scala 45:40]
          REG_36 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_36 <= pht_table_36; // @[dut.scala 36:21]
        end
      end else begin
        REG_36 <= pht_table_36; // @[dut.scala 36:21]
      end
    end else begin
      REG_36 <= pht_table_36; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h25 == train_index) begin // @[dut.scala 41:40]
            REG_37 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_37 <= pht_table_37; // @[dut.scala 36:21]
          end
        end else begin
          REG_37 <= pht_table_37; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h25 == train_index) begin // @[dut.scala 45:40]
          REG_37 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_37 <= pht_table_37; // @[dut.scala 36:21]
        end
      end else begin
        REG_37 <= pht_table_37; // @[dut.scala 36:21]
      end
    end else begin
      REG_37 <= pht_table_37; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h26 == train_index) begin // @[dut.scala 41:40]
            REG_38 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_38 <= pht_table_38; // @[dut.scala 36:21]
          end
        end else begin
          REG_38 <= pht_table_38; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h26 == train_index) begin // @[dut.scala 45:40]
          REG_38 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_38 <= pht_table_38; // @[dut.scala 36:21]
        end
      end else begin
        REG_38 <= pht_table_38; // @[dut.scala 36:21]
      end
    end else begin
      REG_38 <= pht_table_38; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h27 == train_index) begin // @[dut.scala 41:40]
            REG_39 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_39 <= pht_table_39; // @[dut.scala 36:21]
          end
        end else begin
          REG_39 <= pht_table_39; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h27 == train_index) begin // @[dut.scala 45:40]
          REG_39 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_39 <= pht_table_39; // @[dut.scala 36:21]
        end
      end else begin
        REG_39 <= pht_table_39; // @[dut.scala 36:21]
      end
    end else begin
      REG_39 <= pht_table_39; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h28 == train_index) begin // @[dut.scala 41:40]
            REG_40 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_40 <= pht_table_40; // @[dut.scala 36:21]
          end
        end else begin
          REG_40 <= pht_table_40; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h28 == train_index) begin // @[dut.scala 45:40]
          REG_40 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_40 <= pht_table_40; // @[dut.scala 36:21]
        end
      end else begin
        REG_40 <= pht_table_40; // @[dut.scala 36:21]
      end
    end else begin
      REG_40 <= pht_table_40; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h29 == train_index) begin // @[dut.scala 41:40]
            REG_41 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_41 <= pht_table_41; // @[dut.scala 36:21]
          end
        end else begin
          REG_41 <= pht_table_41; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h29 == train_index) begin // @[dut.scala 45:40]
          REG_41 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_41 <= pht_table_41; // @[dut.scala 36:21]
        end
      end else begin
        REG_41 <= pht_table_41; // @[dut.scala 36:21]
      end
    end else begin
      REG_41 <= pht_table_41; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2a == train_index) begin // @[dut.scala 41:40]
            REG_42 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_42 <= pht_table_42; // @[dut.scala 36:21]
          end
        end else begin
          REG_42 <= pht_table_42; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2a == train_index) begin // @[dut.scala 45:40]
          REG_42 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_42 <= pht_table_42; // @[dut.scala 36:21]
        end
      end else begin
        REG_42 <= pht_table_42; // @[dut.scala 36:21]
      end
    end else begin
      REG_42 <= pht_table_42; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2b == train_index) begin // @[dut.scala 41:40]
            REG_43 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_43 <= pht_table_43; // @[dut.scala 36:21]
          end
        end else begin
          REG_43 <= pht_table_43; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2b == train_index) begin // @[dut.scala 45:40]
          REG_43 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_43 <= pht_table_43; // @[dut.scala 36:21]
        end
      end else begin
        REG_43 <= pht_table_43; // @[dut.scala 36:21]
      end
    end else begin
      REG_43 <= pht_table_43; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2c == train_index) begin // @[dut.scala 41:40]
            REG_44 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_44 <= pht_table_44; // @[dut.scala 36:21]
          end
        end else begin
          REG_44 <= pht_table_44; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2c == train_index) begin // @[dut.scala 45:40]
          REG_44 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_44 <= pht_table_44; // @[dut.scala 36:21]
        end
      end else begin
        REG_44 <= pht_table_44; // @[dut.scala 36:21]
      end
    end else begin
      REG_44 <= pht_table_44; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2d == train_index) begin // @[dut.scala 41:40]
            REG_45 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_45 <= pht_table_45; // @[dut.scala 36:21]
          end
        end else begin
          REG_45 <= pht_table_45; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2d == train_index) begin // @[dut.scala 45:40]
          REG_45 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_45 <= pht_table_45; // @[dut.scala 36:21]
        end
      end else begin
        REG_45 <= pht_table_45; // @[dut.scala 36:21]
      end
    end else begin
      REG_45 <= pht_table_45; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2e == train_index) begin // @[dut.scala 41:40]
            REG_46 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_46 <= pht_table_46; // @[dut.scala 36:21]
          end
        end else begin
          REG_46 <= pht_table_46; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2e == train_index) begin // @[dut.scala 45:40]
          REG_46 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_46 <= pht_table_46; // @[dut.scala 36:21]
        end
      end else begin
        REG_46 <= pht_table_46; // @[dut.scala 36:21]
      end
    end else begin
      REG_46 <= pht_table_46; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h2f == train_index) begin // @[dut.scala 41:40]
            REG_47 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_47 <= pht_table_47; // @[dut.scala 36:21]
          end
        end else begin
          REG_47 <= pht_table_47; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h2f == train_index) begin // @[dut.scala 45:40]
          REG_47 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_47 <= pht_table_47; // @[dut.scala 36:21]
        end
      end else begin
        REG_47 <= pht_table_47; // @[dut.scala 36:21]
      end
    end else begin
      REG_47 <= pht_table_47; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h30 == train_index) begin // @[dut.scala 41:40]
            REG_48 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_48 <= pht_table_48; // @[dut.scala 36:21]
          end
        end else begin
          REG_48 <= pht_table_48; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h30 == train_index) begin // @[dut.scala 45:40]
          REG_48 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_48 <= pht_table_48; // @[dut.scala 36:21]
        end
      end else begin
        REG_48 <= pht_table_48; // @[dut.scala 36:21]
      end
    end else begin
      REG_48 <= pht_table_48; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h31 == train_index) begin // @[dut.scala 41:40]
            REG_49 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_49 <= pht_table_49; // @[dut.scala 36:21]
          end
        end else begin
          REG_49 <= pht_table_49; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h31 == train_index) begin // @[dut.scala 45:40]
          REG_49 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_49 <= pht_table_49; // @[dut.scala 36:21]
        end
      end else begin
        REG_49 <= pht_table_49; // @[dut.scala 36:21]
      end
    end else begin
      REG_49 <= pht_table_49; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h32 == train_index) begin // @[dut.scala 41:40]
            REG_50 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_50 <= pht_table_50; // @[dut.scala 36:21]
          end
        end else begin
          REG_50 <= pht_table_50; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h32 == train_index) begin // @[dut.scala 45:40]
          REG_50 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_50 <= pht_table_50; // @[dut.scala 36:21]
        end
      end else begin
        REG_50 <= pht_table_50; // @[dut.scala 36:21]
      end
    end else begin
      REG_50 <= pht_table_50; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h33 == train_index) begin // @[dut.scala 41:40]
            REG_51 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_51 <= pht_table_51; // @[dut.scala 36:21]
          end
        end else begin
          REG_51 <= pht_table_51; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h33 == train_index) begin // @[dut.scala 45:40]
          REG_51 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_51 <= pht_table_51; // @[dut.scala 36:21]
        end
      end else begin
        REG_51 <= pht_table_51; // @[dut.scala 36:21]
      end
    end else begin
      REG_51 <= pht_table_51; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h34 == train_index) begin // @[dut.scala 41:40]
            REG_52 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_52 <= pht_table_52; // @[dut.scala 36:21]
          end
        end else begin
          REG_52 <= pht_table_52; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h34 == train_index) begin // @[dut.scala 45:40]
          REG_52 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_52 <= pht_table_52; // @[dut.scala 36:21]
        end
      end else begin
        REG_52 <= pht_table_52; // @[dut.scala 36:21]
      end
    end else begin
      REG_52 <= pht_table_52; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h35 == train_index) begin // @[dut.scala 41:40]
            REG_53 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_53 <= pht_table_53; // @[dut.scala 36:21]
          end
        end else begin
          REG_53 <= pht_table_53; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h35 == train_index) begin // @[dut.scala 45:40]
          REG_53 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_53 <= pht_table_53; // @[dut.scala 36:21]
        end
      end else begin
        REG_53 <= pht_table_53; // @[dut.scala 36:21]
      end
    end else begin
      REG_53 <= pht_table_53; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h36 == train_index) begin // @[dut.scala 41:40]
            REG_54 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_54 <= pht_table_54; // @[dut.scala 36:21]
          end
        end else begin
          REG_54 <= pht_table_54; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h36 == train_index) begin // @[dut.scala 45:40]
          REG_54 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_54 <= pht_table_54; // @[dut.scala 36:21]
        end
      end else begin
        REG_54 <= pht_table_54; // @[dut.scala 36:21]
      end
    end else begin
      REG_54 <= pht_table_54; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h37 == train_index) begin // @[dut.scala 41:40]
            REG_55 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_55 <= pht_table_55; // @[dut.scala 36:21]
          end
        end else begin
          REG_55 <= pht_table_55; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h37 == train_index) begin // @[dut.scala 45:40]
          REG_55 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_55 <= pht_table_55; // @[dut.scala 36:21]
        end
      end else begin
        REG_55 <= pht_table_55; // @[dut.scala 36:21]
      end
    end else begin
      REG_55 <= pht_table_55; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h38 == train_index) begin // @[dut.scala 41:40]
            REG_56 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_56 <= pht_table_56; // @[dut.scala 36:21]
          end
        end else begin
          REG_56 <= pht_table_56; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h38 == train_index) begin // @[dut.scala 45:40]
          REG_56 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_56 <= pht_table_56; // @[dut.scala 36:21]
        end
      end else begin
        REG_56 <= pht_table_56; // @[dut.scala 36:21]
      end
    end else begin
      REG_56 <= pht_table_56; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h39 == train_index) begin // @[dut.scala 41:40]
            REG_57 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_57 <= pht_table_57; // @[dut.scala 36:21]
          end
        end else begin
          REG_57 <= pht_table_57; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h39 == train_index) begin // @[dut.scala 45:40]
          REG_57 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_57 <= pht_table_57; // @[dut.scala 36:21]
        end
      end else begin
        REG_57 <= pht_table_57; // @[dut.scala 36:21]
      end
    end else begin
      REG_57 <= pht_table_57; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3a == train_index) begin // @[dut.scala 41:40]
            REG_58 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_58 <= pht_table_58; // @[dut.scala 36:21]
          end
        end else begin
          REG_58 <= pht_table_58; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3a == train_index) begin // @[dut.scala 45:40]
          REG_58 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_58 <= pht_table_58; // @[dut.scala 36:21]
        end
      end else begin
        REG_58 <= pht_table_58; // @[dut.scala 36:21]
      end
    end else begin
      REG_58 <= pht_table_58; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3b == train_index) begin // @[dut.scala 41:40]
            REG_59 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_59 <= pht_table_59; // @[dut.scala 36:21]
          end
        end else begin
          REG_59 <= pht_table_59; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3b == train_index) begin // @[dut.scala 45:40]
          REG_59 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_59 <= pht_table_59; // @[dut.scala 36:21]
        end
      end else begin
        REG_59 <= pht_table_59; // @[dut.scala 36:21]
      end
    end else begin
      REG_59 <= pht_table_59; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3c == train_index) begin // @[dut.scala 41:40]
            REG_60 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_60 <= pht_table_60; // @[dut.scala 36:21]
          end
        end else begin
          REG_60 <= pht_table_60; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3c == train_index) begin // @[dut.scala 45:40]
          REG_60 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_60 <= pht_table_60; // @[dut.scala 36:21]
        end
      end else begin
        REG_60 <= pht_table_60; // @[dut.scala 36:21]
      end
    end else begin
      REG_60 <= pht_table_60; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3d == train_index) begin // @[dut.scala 41:40]
            REG_61 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_61 <= pht_table_61; // @[dut.scala 36:21]
          end
        end else begin
          REG_61 <= pht_table_61; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3d == train_index) begin // @[dut.scala 45:40]
          REG_61 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_61 <= pht_table_61; // @[dut.scala 36:21]
        end
      end else begin
        REG_61 <= pht_table_61; // @[dut.scala 36:21]
      end
    end else begin
      REG_61 <= pht_table_61; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3e == train_index) begin // @[dut.scala 41:40]
            REG_62 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_62 <= pht_table_62; // @[dut.scala 36:21]
          end
        end else begin
          REG_62 <= pht_table_62; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3e == train_index) begin // @[dut.scala 45:40]
          REG_62 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_62 <= pht_table_62; // @[dut.scala 36:21]
        end
      end else begin
        REG_62 <= pht_table_62; // @[dut.scala 36:21]
      end
    end else begin
      REG_62 <= pht_table_62; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h3f == train_index) begin // @[dut.scala 41:40]
            REG_63 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_63 <= pht_table_63; // @[dut.scala 36:21]
          end
        end else begin
          REG_63 <= pht_table_63; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h3f == train_index) begin // @[dut.scala 45:40]
          REG_63 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_63 <= pht_table_63; // @[dut.scala 36:21]
        end
      end else begin
        REG_63 <= pht_table_63; // @[dut.scala 36:21]
      end
    end else begin
      REG_63 <= pht_table_63; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h40 == train_index) begin // @[dut.scala 41:40]
            REG_64 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_64 <= pht_table_64; // @[dut.scala 36:21]
          end
        end else begin
          REG_64 <= pht_table_64; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h40 == train_index) begin // @[dut.scala 45:40]
          REG_64 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_64 <= pht_table_64; // @[dut.scala 36:21]
        end
      end else begin
        REG_64 <= pht_table_64; // @[dut.scala 36:21]
      end
    end else begin
      REG_64 <= pht_table_64; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h41 == train_index) begin // @[dut.scala 41:40]
            REG_65 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_65 <= pht_table_65; // @[dut.scala 36:21]
          end
        end else begin
          REG_65 <= pht_table_65; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h41 == train_index) begin // @[dut.scala 45:40]
          REG_65 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_65 <= pht_table_65; // @[dut.scala 36:21]
        end
      end else begin
        REG_65 <= pht_table_65; // @[dut.scala 36:21]
      end
    end else begin
      REG_65 <= pht_table_65; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h42 == train_index) begin // @[dut.scala 41:40]
            REG_66 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_66 <= pht_table_66; // @[dut.scala 36:21]
          end
        end else begin
          REG_66 <= pht_table_66; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h42 == train_index) begin // @[dut.scala 45:40]
          REG_66 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_66 <= pht_table_66; // @[dut.scala 36:21]
        end
      end else begin
        REG_66 <= pht_table_66; // @[dut.scala 36:21]
      end
    end else begin
      REG_66 <= pht_table_66; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h43 == train_index) begin // @[dut.scala 41:40]
            REG_67 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_67 <= pht_table_67; // @[dut.scala 36:21]
          end
        end else begin
          REG_67 <= pht_table_67; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h43 == train_index) begin // @[dut.scala 45:40]
          REG_67 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_67 <= pht_table_67; // @[dut.scala 36:21]
        end
      end else begin
        REG_67 <= pht_table_67; // @[dut.scala 36:21]
      end
    end else begin
      REG_67 <= pht_table_67; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h44 == train_index) begin // @[dut.scala 41:40]
            REG_68 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_68 <= pht_table_68; // @[dut.scala 36:21]
          end
        end else begin
          REG_68 <= pht_table_68; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h44 == train_index) begin // @[dut.scala 45:40]
          REG_68 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_68 <= pht_table_68; // @[dut.scala 36:21]
        end
      end else begin
        REG_68 <= pht_table_68; // @[dut.scala 36:21]
      end
    end else begin
      REG_68 <= pht_table_68; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h45 == train_index) begin // @[dut.scala 41:40]
            REG_69 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_69 <= pht_table_69; // @[dut.scala 36:21]
          end
        end else begin
          REG_69 <= pht_table_69; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h45 == train_index) begin // @[dut.scala 45:40]
          REG_69 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_69 <= pht_table_69; // @[dut.scala 36:21]
        end
      end else begin
        REG_69 <= pht_table_69; // @[dut.scala 36:21]
      end
    end else begin
      REG_69 <= pht_table_69; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h46 == train_index) begin // @[dut.scala 41:40]
            REG_70 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_70 <= pht_table_70; // @[dut.scala 36:21]
          end
        end else begin
          REG_70 <= pht_table_70; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h46 == train_index) begin // @[dut.scala 45:40]
          REG_70 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_70 <= pht_table_70; // @[dut.scala 36:21]
        end
      end else begin
        REG_70 <= pht_table_70; // @[dut.scala 36:21]
      end
    end else begin
      REG_70 <= pht_table_70; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h47 == train_index) begin // @[dut.scala 41:40]
            REG_71 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_71 <= pht_table_71; // @[dut.scala 36:21]
          end
        end else begin
          REG_71 <= pht_table_71; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h47 == train_index) begin // @[dut.scala 45:40]
          REG_71 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_71 <= pht_table_71; // @[dut.scala 36:21]
        end
      end else begin
        REG_71 <= pht_table_71; // @[dut.scala 36:21]
      end
    end else begin
      REG_71 <= pht_table_71; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h48 == train_index) begin // @[dut.scala 41:40]
            REG_72 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_72 <= pht_table_72; // @[dut.scala 36:21]
          end
        end else begin
          REG_72 <= pht_table_72; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h48 == train_index) begin // @[dut.scala 45:40]
          REG_72 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_72 <= pht_table_72; // @[dut.scala 36:21]
        end
      end else begin
        REG_72 <= pht_table_72; // @[dut.scala 36:21]
      end
    end else begin
      REG_72 <= pht_table_72; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h49 == train_index) begin // @[dut.scala 41:40]
            REG_73 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_73 <= pht_table_73; // @[dut.scala 36:21]
          end
        end else begin
          REG_73 <= pht_table_73; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h49 == train_index) begin // @[dut.scala 45:40]
          REG_73 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_73 <= pht_table_73; // @[dut.scala 36:21]
        end
      end else begin
        REG_73 <= pht_table_73; // @[dut.scala 36:21]
      end
    end else begin
      REG_73 <= pht_table_73; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4a == train_index) begin // @[dut.scala 41:40]
            REG_74 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_74 <= pht_table_74; // @[dut.scala 36:21]
          end
        end else begin
          REG_74 <= pht_table_74; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4a == train_index) begin // @[dut.scala 45:40]
          REG_74 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_74 <= pht_table_74; // @[dut.scala 36:21]
        end
      end else begin
        REG_74 <= pht_table_74; // @[dut.scala 36:21]
      end
    end else begin
      REG_74 <= pht_table_74; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4b == train_index) begin // @[dut.scala 41:40]
            REG_75 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_75 <= pht_table_75; // @[dut.scala 36:21]
          end
        end else begin
          REG_75 <= pht_table_75; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4b == train_index) begin // @[dut.scala 45:40]
          REG_75 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_75 <= pht_table_75; // @[dut.scala 36:21]
        end
      end else begin
        REG_75 <= pht_table_75; // @[dut.scala 36:21]
      end
    end else begin
      REG_75 <= pht_table_75; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4c == train_index) begin // @[dut.scala 41:40]
            REG_76 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_76 <= pht_table_76; // @[dut.scala 36:21]
          end
        end else begin
          REG_76 <= pht_table_76; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4c == train_index) begin // @[dut.scala 45:40]
          REG_76 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_76 <= pht_table_76; // @[dut.scala 36:21]
        end
      end else begin
        REG_76 <= pht_table_76; // @[dut.scala 36:21]
      end
    end else begin
      REG_76 <= pht_table_76; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4d == train_index) begin // @[dut.scala 41:40]
            REG_77 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_77 <= pht_table_77; // @[dut.scala 36:21]
          end
        end else begin
          REG_77 <= pht_table_77; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4d == train_index) begin // @[dut.scala 45:40]
          REG_77 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_77 <= pht_table_77; // @[dut.scala 36:21]
        end
      end else begin
        REG_77 <= pht_table_77; // @[dut.scala 36:21]
      end
    end else begin
      REG_77 <= pht_table_77; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4e == train_index) begin // @[dut.scala 41:40]
            REG_78 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_78 <= pht_table_78; // @[dut.scala 36:21]
          end
        end else begin
          REG_78 <= pht_table_78; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4e == train_index) begin // @[dut.scala 45:40]
          REG_78 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_78 <= pht_table_78; // @[dut.scala 36:21]
        end
      end else begin
        REG_78 <= pht_table_78; // @[dut.scala 36:21]
      end
    end else begin
      REG_78 <= pht_table_78; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h4f == train_index) begin // @[dut.scala 41:40]
            REG_79 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_79 <= pht_table_79; // @[dut.scala 36:21]
          end
        end else begin
          REG_79 <= pht_table_79; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h4f == train_index) begin // @[dut.scala 45:40]
          REG_79 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_79 <= pht_table_79; // @[dut.scala 36:21]
        end
      end else begin
        REG_79 <= pht_table_79; // @[dut.scala 36:21]
      end
    end else begin
      REG_79 <= pht_table_79; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h50 == train_index) begin // @[dut.scala 41:40]
            REG_80 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_80 <= pht_table_80; // @[dut.scala 36:21]
          end
        end else begin
          REG_80 <= pht_table_80; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h50 == train_index) begin // @[dut.scala 45:40]
          REG_80 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_80 <= pht_table_80; // @[dut.scala 36:21]
        end
      end else begin
        REG_80 <= pht_table_80; // @[dut.scala 36:21]
      end
    end else begin
      REG_80 <= pht_table_80; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h51 == train_index) begin // @[dut.scala 41:40]
            REG_81 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_81 <= pht_table_81; // @[dut.scala 36:21]
          end
        end else begin
          REG_81 <= pht_table_81; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h51 == train_index) begin // @[dut.scala 45:40]
          REG_81 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_81 <= pht_table_81; // @[dut.scala 36:21]
        end
      end else begin
        REG_81 <= pht_table_81; // @[dut.scala 36:21]
      end
    end else begin
      REG_81 <= pht_table_81; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h52 == train_index) begin // @[dut.scala 41:40]
            REG_82 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_82 <= pht_table_82; // @[dut.scala 36:21]
          end
        end else begin
          REG_82 <= pht_table_82; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h52 == train_index) begin // @[dut.scala 45:40]
          REG_82 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_82 <= pht_table_82; // @[dut.scala 36:21]
        end
      end else begin
        REG_82 <= pht_table_82; // @[dut.scala 36:21]
      end
    end else begin
      REG_82 <= pht_table_82; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h53 == train_index) begin // @[dut.scala 41:40]
            REG_83 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_83 <= pht_table_83; // @[dut.scala 36:21]
          end
        end else begin
          REG_83 <= pht_table_83; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h53 == train_index) begin // @[dut.scala 45:40]
          REG_83 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_83 <= pht_table_83; // @[dut.scala 36:21]
        end
      end else begin
        REG_83 <= pht_table_83; // @[dut.scala 36:21]
      end
    end else begin
      REG_83 <= pht_table_83; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h54 == train_index) begin // @[dut.scala 41:40]
            REG_84 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_84 <= pht_table_84; // @[dut.scala 36:21]
          end
        end else begin
          REG_84 <= pht_table_84; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h54 == train_index) begin // @[dut.scala 45:40]
          REG_84 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_84 <= pht_table_84; // @[dut.scala 36:21]
        end
      end else begin
        REG_84 <= pht_table_84; // @[dut.scala 36:21]
      end
    end else begin
      REG_84 <= pht_table_84; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h55 == train_index) begin // @[dut.scala 41:40]
            REG_85 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_85 <= pht_table_85; // @[dut.scala 36:21]
          end
        end else begin
          REG_85 <= pht_table_85; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h55 == train_index) begin // @[dut.scala 45:40]
          REG_85 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_85 <= pht_table_85; // @[dut.scala 36:21]
        end
      end else begin
        REG_85 <= pht_table_85; // @[dut.scala 36:21]
      end
    end else begin
      REG_85 <= pht_table_85; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h56 == train_index) begin // @[dut.scala 41:40]
            REG_86 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_86 <= pht_table_86; // @[dut.scala 36:21]
          end
        end else begin
          REG_86 <= pht_table_86; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h56 == train_index) begin // @[dut.scala 45:40]
          REG_86 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_86 <= pht_table_86; // @[dut.scala 36:21]
        end
      end else begin
        REG_86 <= pht_table_86; // @[dut.scala 36:21]
      end
    end else begin
      REG_86 <= pht_table_86; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h57 == train_index) begin // @[dut.scala 41:40]
            REG_87 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_87 <= pht_table_87; // @[dut.scala 36:21]
          end
        end else begin
          REG_87 <= pht_table_87; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h57 == train_index) begin // @[dut.scala 45:40]
          REG_87 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_87 <= pht_table_87; // @[dut.scala 36:21]
        end
      end else begin
        REG_87 <= pht_table_87; // @[dut.scala 36:21]
      end
    end else begin
      REG_87 <= pht_table_87; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h58 == train_index) begin // @[dut.scala 41:40]
            REG_88 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_88 <= pht_table_88; // @[dut.scala 36:21]
          end
        end else begin
          REG_88 <= pht_table_88; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h58 == train_index) begin // @[dut.scala 45:40]
          REG_88 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_88 <= pht_table_88; // @[dut.scala 36:21]
        end
      end else begin
        REG_88 <= pht_table_88; // @[dut.scala 36:21]
      end
    end else begin
      REG_88 <= pht_table_88; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h59 == train_index) begin // @[dut.scala 41:40]
            REG_89 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_89 <= pht_table_89; // @[dut.scala 36:21]
          end
        end else begin
          REG_89 <= pht_table_89; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h59 == train_index) begin // @[dut.scala 45:40]
          REG_89 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_89 <= pht_table_89; // @[dut.scala 36:21]
        end
      end else begin
        REG_89 <= pht_table_89; // @[dut.scala 36:21]
      end
    end else begin
      REG_89 <= pht_table_89; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5a == train_index) begin // @[dut.scala 41:40]
            REG_90 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_90 <= pht_table_90; // @[dut.scala 36:21]
          end
        end else begin
          REG_90 <= pht_table_90; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5a == train_index) begin // @[dut.scala 45:40]
          REG_90 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_90 <= pht_table_90; // @[dut.scala 36:21]
        end
      end else begin
        REG_90 <= pht_table_90; // @[dut.scala 36:21]
      end
    end else begin
      REG_90 <= pht_table_90; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5b == train_index) begin // @[dut.scala 41:40]
            REG_91 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_91 <= pht_table_91; // @[dut.scala 36:21]
          end
        end else begin
          REG_91 <= pht_table_91; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5b == train_index) begin // @[dut.scala 45:40]
          REG_91 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_91 <= pht_table_91; // @[dut.scala 36:21]
        end
      end else begin
        REG_91 <= pht_table_91; // @[dut.scala 36:21]
      end
    end else begin
      REG_91 <= pht_table_91; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5c == train_index) begin // @[dut.scala 41:40]
            REG_92 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_92 <= pht_table_92; // @[dut.scala 36:21]
          end
        end else begin
          REG_92 <= pht_table_92; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5c == train_index) begin // @[dut.scala 45:40]
          REG_92 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_92 <= pht_table_92; // @[dut.scala 36:21]
        end
      end else begin
        REG_92 <= pht_table_92; // @[dut.scala 36:21]
      end
    end else begin
      REG_92 <= pht_table_92; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5d == train_index) begin // @[dut.scala 41:40]
            REG_93 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_93 <= pht_table_93; // @[dut.scala 36:21]
          end
        end else begin
          REG_93 <= pht_table_93; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5d == train_index) begin // @[dut.scala 45:40]
          REG_93 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_93 <= pht_table_93; // @[dut.scala 36:21]
        end
      end else begin
        REG_93 <= pht_table_93; // @[dut.scala 36:21]
      end
    end else begin
      REG_93 <= pht_table_93; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5e == train_index) begin // @[dut.scala 41:40]
            REG_94 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_94 <= pht_table_94; // @[dut.scala 36:21]
          end
        end else begin
          REG_94 <= pht_table_94; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5e == train_index) begin // @[dut.scala 45:40]
          REG_94 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_94 <= pht_table_94; // @[dut.scala 36:21]
        end
      end else begin
        REG_94 <= pht_table_94; // @[dut.scala 36:21]
      end
    end else begin
      REG_94 <= pht_table_94; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h5f == train_index) begin // @[dut.scala 41:40]
            REG_95 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_95 <= pht_table_95; // @[dut.scala 36:21]
          end
        end else begin
          REG_95 <= pht_table_95; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h5f == train_index) begin // @[dut.scala 45:40]
          REG_95 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_95 <= pht_table_95; // @[dut.scala 36:21]
        end
      end else begin
        REG_95 <= pht_table_95; // @[dut.scala 36:21]
      end
    end else begin
      REG_95 <= pht_table_95; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h60 == train_index) begin // @[dut.scala 41:40]
            REG_96 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_96 <= pht_table_96; // @[dut.scala 36:21]
          end
        end else begin
          REG_96 <= pht_table_96; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h60 == train_index) begin // @[dut.scala 45:40]
          REG_96 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_96 <= pht_table_96; // @[dut.scala 36:21]
        end
      end else begin
        REG_96 <= pht_table_96; // @[dut.scala 36:21]
      end
    end else begin
      REG_96 <= pht_table_96; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h61 == train_index) begin // @[dut.scala 41:40]
            REG_97 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_97 <= pht_table_97; // @[dut.scala 36:21]
          end
        end else begin
          REG_97 <= pht_table_97; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h61 == train_index) begin // @[dut.scala 45:40]
          REG_97 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_97 <= pht_table_97; // @[dut.scala 36:21]
        end
      end else begin
        REG_97 <= pht_table_97; // @[dut.scala 36:21]
      end
    end else begin
      REG_97 <= pht_table_97; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h62 == train_index) begin // @[dut.scala 41:40]
            REG_98 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_98 <= pht_table_98; // @[dut.scala 36:21]
          end
        end else begin
          REG_98 <= pht_table_98; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h62 == train_index) begin // @[dut.scala 45:40]
          REG_98 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_98 <= pht_table_98; // @[dut.scala 36:21]
        end
      end else begin
        REG_98 <= pht_table_98; // @[dut.scala 36:21]
      end
    end else begin
      REG_98 <= pht_table_98; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h63 == train_index) begin // @[dut.scala 41:40]
            REG_99 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_99 <= pht_table_99; // @[dut.scala 36:21]
          end
        end else begin
          REG_99 <= pht_table_99; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h63 == train_index) begin // @[dut.scala 45:40]
          REG_99 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_99 <= pht_table_99; // @[dut.scala 36:21]
        end
      end else begin
        REG_99 <= pht_table_99; // @[dut.scala 36:21]
      end
    end else begin
      REG_99 <= pht_table_99; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h64 == train_index) begin // @[dut.scala 41:40]
            REG_100 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_100 <= pht_table_100; // @[dut.scala 36:21]
          end
        end else begin
          REG_100 <= pht_table_100; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h64 == train_index) begin // @[dut.scala 45:40]
          REG_100 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_100 <= pht_table_100; // @[dut.scala 36:21]
        end
      end else begin
        REG_100 <= pht_table_100; // @[dut.scala 36:21]
      end
    end else begin
      REG_100 <= pht_table_100; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h65 == train_index) begin // @[dut.scala 41:40]
            REG_101 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_101 <= pht_table_101; // @[dut.scala 36:21]
          end
        end else begin
          REG_101 <= pht_table_101; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h65 == train_index) begin // @[dut.scala 45:40]
          REG_101 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_101 <= pht_table_101; // @[dut.scala 36:21]
        end
      end else begin
        REG_101 <= pht_table_101; // @[dut.scala 36:21]
      end
    end else begin
      REG_101 <= pht_table_101; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h66 == train_index) begin // @[dut.scala 41:40]
            REG_102 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_102 <= pht_table_102; // @[dut.scala 36:21]
          end
        end else begin
          REG_102 <= pht_table_102; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h66 == train_index) begin // @[dut.scala 45:40]
          REG_102 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_102 <= pht_table_102; // @[dut.scala 36:21]
        end
      end else begin
        REG_102 <= pht_table_102; // @[dut.scala 36:21]
      end
    end else begin
      REG_102 <= pht_table_102; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h67 == train_index) begin // @[dut.scala 41:40]
            REG_103 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_103 <= pht_table_103; // @[dut.scala 36:21]
          end
        end else begin
          REG_103 <= pht_table_103; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h67 == train_index) begin // @[dut.scala 45:40]
          REG_103 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_103 <= pht_table_103; // @[dut.scala 36:21]
        end
      end else begin
        REG_103 <= pht_table_103; // @[dut.scala 36:21]
      end
    end else begin
      REG_103 <= pht_table_103; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h68 == train_index) begin // @[dut.scala 41:40]
            REG_104 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_104 <= pht_table_104; // @[dut.scala 36:21]
          end
        end else begin
          REG_104 <= pht_table_104; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h68 == train_index) begin // @[dut.scala 45:40]
          REG_104 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_104 <= pht_table_104; // @[dut.scala 36:21]
        end
      end else begin
        REG_104 <= pht_table_104; // @[dut.scala 36:21]
      end
    end else begin
      REG_104 <= pht_table_104; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h69 == train_index) begin // @[dut.scala 41:40]
            REG_105 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_105 <= pht_table_105; // @[dut.scala 36:21]
          end
        end else begin
          REG_105 <= pht_table_105; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h69 == train_index) begin // @[dut.scala 45:40]
          REG_105 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_105 <= pht_table_105; // @[dut.scala 36:21]
        end
      end else begin
        REG_105 <= pht_table_105; // @[dut.scala 36:21]
      end
    end else begin
      REG_105 <= pht_table_105; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6a == train_index) begin // @[dut.scala 41:40]
            REG_106 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_106 <= pht_table_106; // @[dut.scala 36:21]
          end
        end else begin
          REG_106 <= pht_table_106; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6a == train_index) begin // @[dut.scala 45:40]
          REG_106 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_106 <= pht_table_106; // @[dut.scala 36:21]
        end
      end else begin
        REG_106 <= pht_table_106; // @[dut.scala 36:21]
      end
    end else begin
      REG_106 <= pht_table_106; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6b == train_index) begin // @[dut.scala 41:40]
            REG_107 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_107 <= pht_table_107; // @[dut.scala 36:21]
          end
        end else begin
          REG_107 <= pht_table_107; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6b == train_index) begin // @[dut.scala 45:40]
          REG_107 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_107 <= pht_table_107; // @[dut.scala 36:21]
        end
      end else begin
        REG_107 <= pht_table_107; // @[dut.scala 36:21]
      end
    end else begin
      REG_107 <= pht_table_107; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6c == train_index) begin // @[dut.scala 41:40]
            REG_108 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_108 <= pht_table_108; // @[dut.scala 36:21]
          end
        end else begin
          REG_108 <= pht_table_108; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6c == train_index) begin // @[dut.scala 45:40]
          REG_108 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_108 <= pht_table_108; // @[dut.scala 36:21]
        end
      end else begin
        REG_108 <= pht_table_108; // @[dut.scala 36:21]
      end
    end else begin
      REG_108 <= pht_table_108; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6d == train_index) begin // @[dut.scala 41:40]
            REG_109 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_109 <= pht_table_109; // @[dut.scala 36:21]
          end
        end else begin
          REG_109 <= pht_table_109; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6d == train_index) begin // @[dut.scala 45:40]
          REG_109 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_109 <= pht_table_109; // @[dut.scala 36:21]
        end
      end else begin
        REG_109 <= pht_table_109; // @[dut.scala 36:21]
      end
    end else begin
      REG_109 <= pht_table_109; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6e == train_index) begin // @[dut.scala 41:40]
            REG_110 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_110 <= pht_table_110; // @[dut.scala 36:21]
          end
        end else begin
          REG_110 <= pht_table_110; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6e == train_index) begin // @[dut.scala 45:40]
          REG_110 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_110 <= pht_table_110; // @[dut.scala 36:21]
        end
      end else begin
        REG_110 <= pht_table_110; // @[dut.scala 36:21]
      end
    end else begin
      REG_110 <= pht_table_110; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h6f == train_index) begin // @[dut.scala 41:40]
            REG_111 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_111 <= pht_table_111; // @[dut.scala 36:21]
          end
        end else begin
          REG_111 <= pht_table_111; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h6f == train_index) begin // @[dut.scala 45:40]
          REG_111 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_111 <= pht_table_111; // @[dut.scala 36:21]
        end
      end else begin
        REG_111 <= pht_table_111; // @[dut.scala 36:21]
      end
    end else begin
      REG_111 <= pht_table_111; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h70 == train_index) begin // @[dut.scala 41:40]
            REG_112 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_112 <= pht_table_112; // @[dut.scala 36:21]
          end
        end else begin
          REG_112 <= pht_table_112; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h70 == train_index) begin // @[dut.scala 45:40]
          REG_112 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_112 <= pht_table_112; // @[dut.scala 36:21]
        end
      end else begin
        REG_112 <= pht_table_112; // @[dut.scala 36:21]
      end
    end else begin
      REG_112 <= pht_table_112; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h71 == train_index) begin // @[dut.scala 41:40]
            REG_113 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_113 <= pht_table_113; // @[dut.scala 36:21]
          end
        end else begin
          REG_113 <= pht_table_113; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h71 == train_index) begin // @[dut.scala 45:40]
          REG_113 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_113 <= pht_table_113; // @[dut.scala 36:21]
        end
      end else begin
        REG_113 <= pht_table_113; // @[dut.scala 36:21]
      end
    end else begin
      REG_113 <= pht_table_113; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h72 == train_index) begin // @[dut.scala 41:40]
            REG_114 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_114 <= pht_table_114; // @[dut.scala 36:21]
          end
        end else begin
          REG_114 <= pht_table_114; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h72 == train_index) begin // @[dut.scala 45:40]
          REG_114 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_114 <= pht_table_114; // @[dut.scala 36:21]
        end
      end else begin
        REG_114 <= pht_table_114; // @[dut.scala 36:21]
      end
    end else begin
      REG_114 <= pht_table_114; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h73 == train_index) begin // @[dut.scala 41:40]
            REG_115 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_115 <= pht_table_115; // @[dut.scala 36:21]
          end
        end else begin
          REG_115 <= pht_table_115; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h73 == train_index) begin // @[dut.scala 45:40]
          REG_115 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_115 <= pht_table_115; // @[dut.scala 36:21]
        end
      end else begin
        REG_115 <= pht_table_115; // @[dut.scala 36:21]
      end
    end else begin
      REG_115 <= pht_table_115; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h74 == train_index) begin // @[dut.scala 41:40]
            REG_116 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_116 <= pht_table_116; // @[dut.scala 36:21]
          end
        end else begin
          REG_116 <= pht_table_116; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h74 == train_index) begin // @[dut.scala 45:40]
          REG_116 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_116 <= pht_table_116; // @[dut.scala 36:21]
        end
      end else begin
        REG_116 <= pht_table_116; // @[dut.scala 36:21]
      end
    end else begin
      REG_116 <= pht_table_116; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h75 == train_index) begin // @[dut.scala 41:40]
            REG_117 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_117 <= pht_table_117; // @[dut.scala 36:21]
          end
        end else begin
          REG_117 <= pht_table_117; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h75 == train_index) begin // @[dut.scala 45:40]
          REG_117 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_117 <= pht_table_117; // @[dut.scala 36:21]
        end
      end else begin
        REG_117 <= pht_table_117; // @[dut.scala 36:21]
      end
    end else begin
      REG_117 <= pht_table_117; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h76 == train_index) begin // @[dut.scala 41:40]
            REG_118 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_118 <= pht_table_118; // @[dut.scala 36:21]
          end
        end else begin
          REG_118 <= pht_table_118; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h76 == train_index) begin // @[dut.scala 45:40]
          REG_118 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_118 <= pht_table_118; // @[dut.scala 36:21]
        end
      end else begin
        REG_118 <= pht_table_118; // @[dut.scala 36:21]
      end
    end else begin
      REG_118 <= pht_table_118; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h77 == train_index) begin // @[dut.scala 41:40]
            REG_119 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_119 <= pht_table_119; // @[dut.scala 36:21]
          end
        end else begin
          REG_119 <= pht_table_119; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h77 == train_index) begin // @[dut.scala 45:40]
          REG_119 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_119 <= pht_table_119; // @[dut.scala 36:21]
        end
      end else begin
        REG_119 <= pht_table_119; // @[dut.scala 36:21]
      end
    end else begin
      REG_119 <= pht_table_119; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h78 == train_index) begin // @[dut.scala 41:40]
            REG_120 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_120 <= pht_table_120; // @[dut.scala 36:21]
          end
        end else begin
          REG_120 <= pht_table_120; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h78 == train_index) begin // @[dut.scala 45:40]
          REG_120 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_120 <= pht_table_120; // @[dut.scala 36:21]
        end
      end else begin
        REG_120 <= pht_table_120; // @[dut.scala 36:21]
      end
    end else begin
      REG_120 <= pht_table_120; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h79 == train_index) begin // @[dut.scala 41:40]
            REG_121 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_121 <= pht_table_121; // @[dut.scala 36:21]
          end
        end else begin
          REG_121 <= pht_table_121; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h79 == train_index) begin // @[dut.scala 45:40]
          REG_121 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_121 <= pht_table_121; // @[dut.scala 36:21]
        end
      end else begin
        REG_121 <= pht_table_121; // @[dut.scala 36:21]
      end
    end else begin
      REG_121 <= pht_table_121; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7a == train_index) begin // @[dut.scala 41:40]
            REG_122 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_122 <= pht_table_122; // @[dut.scala 36:21]
          end
        end else begin
          REG_122 <= pht_table_122; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7a == train_index) begin // @[dut.scala 45:40]
          REG_122 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_122 <= pht_table_122; // @[dut.scala 36:21]
        end
      end else begin
        REG_122 <= pht_table_122; // @[dut.scala 36:21]
      end
    end else begin
      REG_122 <= pht_table_122; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7b == train_index) begin // @[dut.scala 41:40]
            REG_123 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_123 <= pht_table_123; // @[dut.scala 36:21]
          end
        end else begin
          REG_123 <= pht_table_123; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7b == train_index) begin // @[dut.scala 45:40]
          REG_123 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_123 <= pht_table_123; // @[dut.scala 36:21]
        end
      end else begin
        REG_123 <= pht_table_123; // @[dut.scala 36:21]
      end
    end else begin
      REG_123 <= pht_table_123; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7c == train_index) begin // @[dut.scala 41:40]
            REG_124 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_124 <= pht_table_124; // @[dut.scala 36:21]
          end
        end else begin
          REG_124 <= pht_table_124; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7c == train_index) begin // @[dut.scala 45:40]
          REG_124 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_124 <= pht_table_124; // @[dut.scala 36:21]
        end
      end else begin
        REG_124 <= pht_table_124; // @[dut.scala 36:21]
      end
    end else begin
      REG_124 <= pht_table_124; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7d == train_index) begin // @[dut.scala 41:40]
            REG_125 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_125 <= pht_table_125; // @[dut.scala 36:21]
          end
        end else begin
          REG_125 <= pht_table_125; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7d == train_index) begin // @[dut.scala 45:40]
          REG_125 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_125 <= pht_table_125; // @[dut.scala 36:21]
        end
      end else begin
        REG_125 <= pht_table_125; // @[dut.scala 36:21]
      end
    end else begin
      REG_125 <= pht_table_125; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7e == train_index) begin // @[dut.scala 41:40]
            REG_126 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_126 <= pht_table_126; // @[dut.scala 36:21]
          end
        end else begin
          REG_126 <= pht_table_126; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7e == train_index) begin // @[dut.scala 45:40]
          REG_126 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_126 <= pht_table_126; // @[dut.scala 36:21]
        end
      end else begin
        REG_126 <= pht_table_126; // @[dut.scala 36:21]
      end
    end else begin
      REG_126 <= pht_table_126; // @[dut.scala 36:21]
    end
    if (io_train_valid) begin // @[dut.scala 38:24]
      if (io_train_taken) begin // @[dut.scala 39:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 40:44]
          if (7'h7f == train_index) begin // @[dut.scala 41:40]
            REG_127 <= _updated_pht_table_T_1; // @[dut.scala 41:40]
          end else begin
            REG_127 <= pht_table_127; // @[dut.scala 36:21]
          end
        end else begin
          REG_127 <= pht_table_127; // @[dut.scala 36:21]
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 44:44]
        if (7'h7f == train_index) begin // @[dut.scala 45:40]
          REG_127 <= _updated_pht_table_T_3; // @[dut.scala 45:40]
        end else begin
          REG_127 <= pht_table_127; // @[dut.scala 36:21]
        end
      end else begin
        REG_127 <= pht_table_127; // @[dut.scala 36:21]
      end
    end else begin
      REG_127 <= pht_table_127; // @[dut.scala 36:21]
    end
    ghr_REG <= _GEN_1026[6:0]; // @[dut.scala 54:22]
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
  pht_table_0 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  pht_table_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  pht_table_2 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  pht_table_3 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  pht_table_4 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  pht_table_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  pht_table_6 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  pht_table_7 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  pht_table_8 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  pht_table_9 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  pht_table_10 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  pht_table_11 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  pht_table_12 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  pht_table_13 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  pht_table_14 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  pht_table_15 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  pht_table_16 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  pht_table_17 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  pht_table_18 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  pht_table_19 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  pht_table_20 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  pht_table_21 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  pht_table_22 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  pht_table_23 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  pht_table_24 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  pht_table_25 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  pht_table_26 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  pht_table_27 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  pht_table_28 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  pht_table_29 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  pht_table_30 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  pht_table_31 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  pht_table_32 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  pht_table_33 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  pht_table_34 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  pht_table_35 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  pht_table_36 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  pht_table_37 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  pht_table_38 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  pht_table_39 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  pht_table_40 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  pht_table_41 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  pht_table_42 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  pht_table_43 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  pht_table_44 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  pht_table_45 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  pht_table_46 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  pht_table_47 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  pht_table_48 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  pht_table_49 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  pht_table_50 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  pht_table_51 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  pht_table_52 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  pht_table_53 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  pht_table_54 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  pht_table_55 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  pht_table_56 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  pht_table_57 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  pht_table_58 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  pht_table_59 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  pht_table_60 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  pht_table_61 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  pht_table_62 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  pht_table_63 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  pht_table_64 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  pht_table_65 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  pht_table_66 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  pht_table_67 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  pht_table_68 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  pht_table_69 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  pht_table_70 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  pht_table_71 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  pht_table_72 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  pht_table_73 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  pht_table_74 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  pht_table_75 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  pht_table_76 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  pht_table_77 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  pht_table_78 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  pht_table_79 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  pht_table_80 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  pht_table_81 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  pht_table_82 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  pht_table_83 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  pht_table_84 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  pht_table_85 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  pht_table_86 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  pht_table_87 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  pht_table_88 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  pht_table_89 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  pht_table_90 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  pht_table_91 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  pht_table_92 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  pht_table_93 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  pht_table_94 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  pht_table_95 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  pht_table_96 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  pht_table_97 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  pht_table_98 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  pht_table_99 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  pht_table_100 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  pht_table_101 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  pht_table_102 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  pht_table_103 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  pht_table_104 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  pht_table_105 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  pht_table_106 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  pht_table_107 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  pht_table_108 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  pht_table_109 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  pht_table_110 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  pht_table_111 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  pht_table_112 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  pht_table_113 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  pht_table_114 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  pht_table_115 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  pht_table_116 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  pht_table_117 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  pht_table_118 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  pht_table_119 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  pht_table_120 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  pht_table_121 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  pht_table_122 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  pht_table_123 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  pht_table_124 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  pht_table_125 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  pht_table_126 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  pht_table_127 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  ghr = _RAND_128[6:0];
  _RAND_129 = {1{`RANDOM}};
  REG_0 = _RAND_129[1:0];
  _RAND_130 = {1{`RANDOM}};
  REG_1 = _RAND_130[1:0];
  _RAND_131 = {1{`RANDOM}};
  REG_2 = _RAND_131[1:0];
  _RAND_132 = {1{`RANDOM}};
  REG_3 = _RAND_132[1:0];
  _RAND_133 = {1{`RANDOM}};
  REG_4 = _RAND_133[1:0];
  _RAND_134 = {1{`RANDOM}};
  REG_5 = _RAND_134[1:0];
  _RAND_135 = {1{`RANDOM}};
  REG_6 = _RAND_135[1:0];
  _RAND_136 = {1{`RANDOM}};
  REG_7 = _RAND_136[1:0];
  _RAND_137 = {1{`RANDOM}};
  REG_8 = _RAND_137[1:0];
  _RAND_138 = {1{`RANDOM}};
  REG_9 = _RAND_138[1:0];
  _RAND_139 = {1{`RANDOM}};
  REG_10 = _RAND_139[1:0];
  _RAND_140 = {1{`RANDOM}};
  REG_11 = _RAND_140[1:0];
  _RAND_141 = {1{`RANDOM}};
  REG_12 = _RAND_141[1:0];
  _RAND_142 = {1{`RANDOM}};
  REG_13 = _RAND_142[1:0];
  _RAND_143 = {1{`RANDOM}};
  REG_14 = _RAND_143[1:0];
  _RAND_144 = {1{`RANDOM}};
  REG_15 = _RAND_144[1:0];
  _RAND_145 = {1{`RANDOM}};
  REG_16 = _RAND_145[1:0];
  _RAND_146 = {1{`RANDOM}};
  REG_17 = _RAND_146[1:0];
  _RAND_147 = {1{`RANDOM}};
  REG_18 = _RAND_147[1:0];
  _RAND_148 = {1{`RANDOM}};
  REG_19 = _RAND_148[1:0];
  _RAND_149 = {1{`RANDOM}};
  REG_20 = _RAND_149[1:0];
  _RAND_150 = {1{`RANDOM}};
  REG_21 = _RAND_150[1:0];
  _RAND_151 = {1{`RANDOM}};
  REG_22 = _RAND_151[1:0];
  _RAND_152 = {1{`RANDOM}};
  REG_23 = _RAND_152[1:0];
  _RAND_153 = {1{`RANDOM}};
  REG_24 = _RAND_153[1:0];
  _RAND_154 = {1{`RANDOM}};
  REG_25 = _RAND_154[1:0];
  _RAND_155 = {1{`RANDOM}};
  REG_26 = _RAND_155[1:0];
  _RAND_156 = {1{`RANDOM}};
  REG_27 = _RAND_156[1:0];
  _RAND_157 = {1{`RANDOM}};
  REG_28 = _RAND_157[1:0];
  _RAND_158 = {1{`RANDOM}};
  REG_29 = _RAND_158[1:0];
  _RAND_159 = {1{`RANDOM}};
  REG_30 = _RAND_159[1:0];
  _RAND_160 = {1{`RANDOM}};
  REG_31 = _RAND_160[1:0];
  _RAND_161 = {1{`RANDOM}};
  REG_32 = _RAND_161[1:0];
  _RAND_162 = {1{`RANDOM}};
  REG_33 = _RAND_162[1:0];
  _RAND_163 = {1{`RANDOM}};
  REG_34 = _RAND_163[1:0];
  _RAND_164 = {1{`RANDOM}};
  REG_35 = _RAND_164[1:0];
  _RAND_165 = {1{`RANDOM}};
  REG_36 = _RAND_165[1:0];
  _RAND_166 = {1{`RANDOM}};
  REG_37 = _RAND_166[1:0];
  _RAND_167 = {1{`RANDOM}};
  REG_38 = _RAND_167[1:0];
  _RAND_168 = {1{`RANDOM}};
  REG_39 = _RAND_168[1:0];
  _RAND_169 = {1{`RANDOM}};
  REG_40 = _RAND_169[1:0];
  _RAND_170 = {1{`RANDOM}};
  REG_41 = _RAND_170[1:0];
  _RAND_171 = {1{`RANDOM}};
  REG_42 = _RAND_171[1:0];
  _RAND_172 = {1{`RANDOM}};
  REG_43 = _RAND_172[1:0];
  _RAND_173 = {1{`RANDOM}};
  REG_44 = _RAND_173[1:0];
  _RAND_174 = {1{`RANDOM}};
  REG_45 = _RAND_174[1:0];
  _RAND_175 = {1{`RANDOM}};
  REG_46 = _RAND_175[1:0];
  _RAND_176 = {1{`RANDOM}};
  REG_47 = _RAND_176[1:0];
  _RAND_177 = {1{`RANDOM}};
  REG_48 = _RAND_177[1:0];
  _RAND_178 = {1{`RANDOM}};
  REG_49 = _RAND_178[1:0];
  _RAND_179 = {1{`RANDOM}};
  REG_50 = _RAND_179[1:0];
  _RAND_180 = {1{`RANDOM}};
  REG_51 = _RAND_180[1:0];
  _RAND_181 = {1{`RANDOM}};
  REG_52 = _RAND_181[1:0];
  _RAND_182 = {1{`RANDOM}};
  REG_53 = _RAND_182[1:0];
  _RAND_183 = {1{`RANDOM}};
  REG_54 = _RAND_183[1:0];
  _RAND_184 = {1{`RANDOM}};
  REG_55 = _RAND_184[1:0];
  _RAND_185 = {1{`RANDOM}};
  REG_56 = _RAND_185[1:0];
  _RAND_186 = {1{`RANDOM}};
  REG_57 = _RAND_186[1:0];
  _RAND_187 = {1{`RANDOM}};
  REG_58 = _RAND_187[1:0];
  _RAND_188 = {1{`RANDOM}};
  REG_59 = _RAND_188[1:0];
  _RAND_189 = {1{`RANDOM}};
  REG_60 = _RAND_189[1:0];
  _RAND_190 = {1{`RANDOM}};
  REG_61 = _RAND_190[1:0];
  _RAND_191 = {1{`RANDOM}};
  REG_62 = _RAND_191[1:0];
  _RAND_192 = {1{`RANDOM}};
  REG_63 = _RAND_192[1:0];
  _RAND_193 = {1{`RANDOM}};
  REG_64 = _RAND_193[1:0];
  _RAND_194 = {1{`RANDOM}};
  REG_65 = _RAND_194[1:0];
  _RAND_195 = {1{`RANDOM}};
  REG_66 = _RAND_195[1:0];
  _RAND_196 = {1{`RANDOM}};
  REG_67 = _RAND_196[1:0];
  _RAND_197 = {1{`RANDOM}};
  REG_68 = _RAND_197[1:0];
  _RAND_198 = {1{`RANDOM}};
  REG_69 = _RAND_198[1:0];
  _RAND_199 = {1{`RANDOM}};
  REG_70 = _RAND_199[1:0];
  _RAND_200 = {1{`RANDOM}};
  REG_71 = _RAND_200[1:0];
  _RAND_201 = {1{`RANDOM}};
  REG_72 = _RAND_201[1:0];
  _RAND_202 = {1{`RANDOM}};
  REG_73 = _RAND_202[1:0];
  _RAND_203 = {1{`RANDOM}};
  REG_74 = _RAND_203[1:0];
  _RAND_204 = {1{`RANDOM}};
  REG_75 = _RAND_204[1:0];
  _RAND_205 = {1{`RANDOM}};
  REG_76 = _RAND_205[1:0];
  _RAND_206 = {1{`RANDOM}};
  REG_77 = _RAND_206[1:0];
  _RAND_207 = {1{`RANDOM}};
  REG_78 = _RAND_207[1:0];
  _RAND_208 = {1{`RANDOM}};
  REG_79 = _RAND_208[1:0];
  _RAND_209 = {1{`RANDOM}};
  REG_80 = _RAND_209[1:0];
  _RAND_210 = {1{`RANDOM}};
  REG_81 = _RAND_210[1:0];
  _RAND_211 = {1{`RANDOM}};
  REG_82 = _RAND_211[1:0];
  _RAND_212 = {1{`RANDOM}};
  REG_83 = _RAND_212[1:0];
  _RAND_213 = {1{`RANDOM}};
  REG_84 = _RAND_213[1:0];
  _RAND_214 = {1{`RANDOM}};
  REG_85 = _RAND_214[1:0];
  _RAND_215 = {1{`RANDOM}};
  REG_86 = _RAND_215[1:0];
  _RAND_216 = {1{`RANDOM}};
  REG_87 = _RAND_216[1:0];
  _RAND_217 = {1{`RANDOM}};
  REG_88 = _RAND_217[1:0];
  _RAND_218 = {1{`RANDOM}};
  REG_89 = _RAND_218[1:0];
  _RAND_219 = {1{`RANDOM}};
  REG_90 = _RAND_219[1:0];
  _RAND_220 = {1{`RANDOM}};
  REG_91 = _RAND_220[1:0];
  _RAND_221 = {1{`RANDOM}};
  REG_92 = _RAND_221[1:0];
  _RAND_222 = {1{`RANDOM}};
  REG_93 = _RAND_222[1:0];
  _RAND_223 = {1{`RANDOM}};
  REG_94 = _RAND_223[1:0];
  _RAND_224 = {1{`RANDOM}};
  REG_95 = _RAND_224[1:0];
  _RAND_225 = {1{`RANDOM}};
  REG_96 = _RAND_225[1:0];
  _RAND_226 = {1{`RANDOM}};
  REG_97 = _RAND_226[1:0];
  _RAND_227 = {1{`RANDOM}};
  REG_98 = _RAND_227[1:0];
  _RAND_228 = {1{`RANDOM}};
  REG_99 = _RAND_228[1:0];
  _RAND_229 = {1{`RANDOM}};
  REG_100 = _RAND_229[1:0];
  _RAND_230 = {1{`RANDOM}};
  REG_101 = _RAND_230[1:0];
  _RAND_231 = {1{`RANDOM}};
  REG_102 = _RAND_231[1:0];
  _RAND_232 = {1{`RANDOM}};
  REG_103 = _RAND_232[1:0];
  _RAND_233 = {1{`RANDOM}};
  REG_104 = _RAND_233[1:0];
  _RAND_234 = {1{`RANDOM}};
  REG_105 = _RAND_234[1:0];
  _RAND_235 = {1{`RANDOM}};
  REG_106 = _RAND_235[1:0];
  _RAND_236 = {1{`RANDOM}};
  REG_107 = _RAND_236[1:0];
  _RAND_237 = {1{`RANDOM}};
  REG_108 = _RAND_237[1:0];
  _RAND_238 = {1{`RANDOM}};
  REG_109 = _RAND_238[1:0];
  _RAND_239 = {1{`RANDOM}};
  REG_110 = _RAND_239[1:0];
  _RAND_240 = {1{`RANDOM}};
  REG_111 = _RAND_240[1:0];
  _RAND_241 = {1{`RANDOM}};
  REG_112 = _RAND_241[1:0];
  _RAND_242 = {1{`RANDOM}};
  REG_113 = _RAND_242[1:0];
  _RAND_243 = {1{`RANDOM}};
  REG_114 = _RAND_243[1:0];
  _RAND_244 = {1{`RANDOM}};
  REG_115 = _RAND_244[1:0];
  _RAND_245 = {1{`RANDOM}};
  REG_116 = _RAND_245[1:0];
  _RAND_246 = {1{`RANDOM}};
  REG_117 = _RAND_246[1:0];
  _RAND_247 = {1{`RANDOM}};
  REG_118 = _RAND_247[1:0];
  _RAND_248 = {1{`RANDOM}};
  REG_119 = _RAND_248[1:0];
  _RAND_249 = {1{`RANDOM}};
  REG_120 = _RAND_249[1:0];
  _RAND_250 = {1{`RANDOM}};
  REG_121 = _RAND_250[1:0];
  _RAND_251 = {1{`RANDOM}};
  REG_122 = _RAND_251[1:0];
  _RAND_252 = {1{`RANDOM}};
  REG_123 = _RAND_252[1:0];
  _RAND_253 = {1{`RANDOM}};
  REG_124 = _RAND_253[1:0];
  _RAND_254 = {1{`RANDOM}};
  REG_125 = _RAND_254[1:0];
  _RAND_255 = {1{`RANDOM}};
  REG_126 = _RAND_255[1:0];
  _RAND_256 = {1{`RANDOM}};
  REG_127 = _RAND_256[1:0];
  _RAND_257 = {1{`RANDOM}};
  ghr_REG = _RAND_257[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
