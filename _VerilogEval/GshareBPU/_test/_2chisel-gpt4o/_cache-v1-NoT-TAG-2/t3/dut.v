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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] pht_table_0; // @[dut.scala 23:26]
  reg [1:0] pht_table_1; // @[dut.scala 23:26]
  reg [1:0] pht_table_2; // @[dut.scala 23:26]
  reg [1:0] pht_table_3; // @[dut.scala 23:26]
  reg [1:0] pht_table_4; // @[dut.scala 23:26]
  reg [1:0] pht_table_5; // @[dut.scala 23:26]
  reg [1:0] pht_table_6; // @[dut.scala 23:26]
  reg [1:0] pht_table_7; // @[dut.scala 23:26]
  reg [1:0] pht_table_8; // @[dut.scala 23:26]
  reg [1:0] pht_table_9; // @[dut.scala 23:26]
  reg [1:0] pht_table_10; // @[dut.scala 23:26]
  reg [1:0] pht_table_11; // @[dut.scala 23:26]
  reg [1:0] pht_table_12; // @[dut.scala 23:26]
  reg [1:0] pht_table_13; // @[dut.scala 23:26]
  reg [1:0] pht_table_14; // @[dut.scala 23:26]
  reg [1:0] pht_table_15; // @[dut.scala 23:26]
  reg [1:0] pht_table_16; // @[dut.scala 23:26]
  reg [1:0] pht_table_17; // @[dut.scala 23:26]
  reg [1:0] pht_table_18; // @[dut.scala 23:26]
  reg [1:0] pht_table_19; // @[dut.scala 23:26]
  reg [1:0] pht_table_20; // @[dut.scala 23:26]
  reg [1:0] pht_table_21; // @[dut.scala 23:26]
  reg [1:0] pht_table_22; // @[dut.scala 23:26]
  reg [1:0] pht_table_23; // @[dut.scala 23:26]
  reg [1:0] pht_table_24; // @[dut.scala 23:26]
  reg [1:0] pht_table_25; // @[dut.scala 23:26]
  reg [1:0] pht_table_26; // @[dut.scala 23:26]
  reg [1:0] pht_table_27; // @[dut.scala 23:26]
  reg [1:0] pht_table_28; // @[dut.scala 23:26]
  reg [1:0] pht_table_29; // @[dut.scala 23:26]
  reg [1:0] pht_table_30; // @[dut.scala 23:26]
  reg [1:0] pht_table_31; // @[dut.scala 23:26]
  reg [1:0] pht_table_32; // @[dut.scala 23:26]
  reg [1:0] pht_table_33; // @[dut.scala 23:26]
  reg [1:0] pht_table_34; // @[dut.scala 23:26]
  reg [1:0] pht_table_35; // @[dut.scala 23:26]
  reg [1:0] pht_table_36; // @[dut.scala 23:26]
  reg [1:0] pht_table_37; // @[dut.scala 23:26]
  reg [1:0] pht_table_38; // @[dut.scala 23:26]
  reg [1:0] pht_table_39; // @[dut.scala 23:26]
  reg [1:0] pht_table_40; // @[dut.scala 23:26]
  reg [1:0] pht_table_41; // @[dut.scala 23:26]
  reg [1:0] pht_table_42; // @[dut.scala 23:26]
  reg [1:0] pht_table_43; // @[dut.scala 23:26]
  reg [1:0] pht_table_44; // @[dut.scala 23:26]
  reg [1:0] pht_table_45; // @[dut.scala 23:26]
  reg [1:0] pht_table_46; // @[dut.scala 23:26]
  reg [1:0] pht_table_47; // @[dut.scala 23:26]
  reg [1:0] pht_table_48; // @[dut.scala 23:26]
  reg [1:0] pht_table_49; // @[dut.scala 23:26]
  reg [1:0] pht_table_50; // @[dut.scala 23:26]
  reg [1:0] pht_table_51; // @[dut.scala 23:26]
  reg [1:0] pht_table_52; // @[dut.scala 23:26]
  reg [1:0] pht_table_53; // @[dut.scala 23:26]
  reg [1:0] pht_table_54; // @[dut.scala 23:26]
  reg [1:0] pht_table_55; // @[dut.scala 23:26]
  reg [1:0] pht_table_56; // @[dut.scala 23:26]
  reg [1:0] pht_table_57; // @[dut.scala 23:26]
  reg [1:0] pht_table_58; // @[dut.scala 23:26]
  reg [1:0] pht_table_59; // @[dut.scala 23:26]
  reg [1:0] pht_table_60; // @[dut.scala 23:26]
  reg [1:0] pht_table_61; // @[dut.scala 23:26]
  reg [1:0] pht_table_62; // @[dut.scala 23:26]
  reg [1:0] pht_table_63; // @[dut.scala 23:26]
  reg [1:0] pht_table_64; // @[dut.scala 23:26]
  reg [1:0] pht_table_65; // @[dut.scala 23:26]
  reg [1:0] pht_table_66; // @[dut.scala 23:26]
  reg [1:0] pht_table_67; // @[dut.scala 23:26]
  reg [1:0] pht_table_68; // @[dut.scala 23:26]
  reg [1:0] pht_table_69; // @[dut.scala 23:26]
  reg [1:0] pht_table_70; // @[dut.scala 23:26]
  reg [1:0] pht_table_71; // @[dut.scala 23:26]
  reg [1:0] pht_table_72; // @[dut.scala 23:26]
  reg [1:0] pht_table_73; // @[dut.scala 23:26]
  reg [1:0] pht_table_74; // @[dut.scala 23:26]
  reg [1:0] pht_table_75; // @[dut.scala 23:26]
  reg [1:0] pht_table_76; // @[dut.scala 23:26]
  reg [1:0] pht_table_77; // @[dut.scala 23:26]
  reg [1:0] pht_table_78; // @[dut.scala 23:26]
  reg [1:0] pht_table_79; // @[dut.scala 23:26]
  reg [1:0] pht_table_80; // @[dut.scala 23:26]
  reg [1:0] pht_table_81; // @[dut.scala 23:26]
  reg [1:0] pht_table_82; // @[dut.scala 23:26]
  reg [1:0] pht_table_83; // @[dut.scala 23:26]
  reg [1:0] pht_table_84; // @[dut.scala 23:26]
  reg [1:0] pht_table_85; // @[dut.scala 23:26]
  reg [1:0] pht_table_86; // @[dut.scala 23:26]
  reg [1:0] pht_table_87; // @[dut.scala 23:26]
  reg [1:0] pht_table_88; // @[dut.scala 23:26]
  reg [1:0] pht_table_89; // @[dut.scala 23:26]
  reg [1:0] pht_table_90; // @[dut.scala 23:26]
  reg [1:0] pht_table_91; // @[dut.scala 23:26]
  reg [1:0] pht_table_92; // @[dut.scala 23:26]
  reg [1:0] pht_table_93; // @[dut.scala 23:26]
  reg [1:0] pht_table_94; // @[dut.scala 23:26]
  reg [1:0] pht_table_95; // @[dut.scala 23:26]
  reg [1:0] pht_table_96; // @[dut.scala 23:26]
  reg [1:0] pht_table_97; // @[dut.scala 23:26]
  reg [1:0] pht_table_98; // @[dut.scala 23:26]
  reg [1:0] pht_table_99; // @[dut.scala 23:26]
  reg [1:0] pht_table_100; // @[dut.scala 23:26]
  reg [1:0] pht_table_101; // @[dut.scala 23:26]
  reg [1:0] pht_table_102; // @[dut.scala 23:26]
  reg [1:0] pht_table_103; // @[dut.scala 23:26]
  reg [1:0] pht_table_104; // @[dut.scala 23:26]
  reg [1:0] pht_table_105; // @[dut.scala 23:26]
  reg [1:0] pht_table_106; // @[dut.scala 23:26]
  reg [1:0] pht_table_107; // @[dut.scala 23:26]
  reg [1:0] pht_table_108; // @[dut.scala 23:26]
  reg [1:0] pht_table_109; // @[dut.scala 23:26]
  reg [1:0] pht_table_110; // @[dut.scala 23:26]
  reg [1:0] pht_table_111; // @[dut.scala 23:26]
  reg [1:0] pht_table_112; // @[dut.scala 23:26]
  reg [1:0] pht_table_113; // @[dut.scala 23:26]
  reg [1:0] pht_table_114; // @[dut.scala 23:26]
  reg [1:0] pht_table_115; // @[dut.scala 23:26]
  reg [1:0] pht_table_116; // @[dut.scala 23:26]
  reg [1:0] pht_table_117; // @[dut.scala 23:26]
  reg [1:0] pht_table_118; // @[dut.scala 23:26]
  reg [1:0] pht_table_119; // @[dut.scala 23:26]
  reg [1:0] pht_table_120; // @[dut.scala 23:26]
  reg [1:0] pht_table_121; // @[dut.scala 23:26]
  reg [1:0] pht_table_122; // @[dut.scala 23:26]
  reg [1:0] pht_table_123; // @[dut.scala 23:26]
  reg [1:0] pht_table_124; // @[dut.scala 23:26]
  reg [1:0] pht_table_125; // @[dut.scala 23:26]
  reg [1:0] pht_table_126; // @[dut.scala 23:26]
  reg [1:0] pht_table_127; // @[dut.scala 23:26]
  reg [6:0] ghr; // @[dut.scala 26:20]
  wire [6:0] predict_index = io_predict_pc ^ ghr; // @[dut.scala 29:37]
  wire [1:0] _GEN_1 = 7'h1 == predict_index ? pht_table_1 : pht_table_0; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_2 = 7'h2 == predict_index ? pht_table_2 : _GEN_1; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_3 = 7'h3 == predict_index ? pht_table_3 : _GEN_2; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_4 = 7'h4 == predict_index ? pht_table_4 : _GEN_3; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_5 = 7'h5 == predict_index ? pht_table_5 : _GEN_4; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_6 = 7'h6 == predict_index ? pht_table_6 : _GEN_5; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_7 = 7'h7 == predict_index ? pht_table_7 : _GEN_6; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_8 = 7'h8 == predict_index ? pht_table_8 : _GEN_7; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_9 = 7'h9 == predict_index ? pht_table_9 : _GEN_8; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_10 = 7'ha == predict_index ? pht_table_10 : _GEN_9; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_11 = 7'hb == predict_index ? pht_table_11 : _GEN_10; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_12 = 7'hc == predict_index ? pht_table_12 : _GEN_11; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_13 = 7'hd == predict_index ? pht_table_13 : _GEN_12; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_14 = 7'he == predict_index ? pht_table_14 : _GEN_13; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_15 = 7'hf == predict_index ? pht_table_15 : _GEN_14; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_16 = 7'h10 == predict_index ? pht_table_16 : _GEN_15; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_17 = 7'h11 == predict_index ? pht_table_17 : _GEN_16; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_18 = 7'h12 == predict_index ? pht_table_18 : _GEN_17; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_19 = 7'h13 == predict_index ? pht_table_19 : _GEN_18; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_20 = 7'h14 == predict_index ? pht_table_20 : _GEN_19; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_21 = 7'h15 == predict_index ? pht_table_21 : _GEN_20; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_22 = 7'h16 == predict_index ? pht_table_22 : _GEN_21; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_23 = 7'h17 == predict_index ? pht_table_23 : _GEN_22; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_24 = 7'h18 == predict_index ? pht_table_24 : _GEN_23; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_25 = 7'h19 == predict_index ? pht_table_25 : _GEN_24; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_26 = 7'h1a == predict_index ? pht_table_26 : _GEN_25; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_27 = 7'h1b == predict_index ? pht_table_27 : _GEN_26; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_28 = 7'h1c == predict_index ? pht_table_28 : _GEN_27; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_29 = 7'h1d == predict_index ? pht_table_29 : _GEN_28; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_30 = 7'h1e == predict_index ? pht_table_30 : _GEN_29; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_31 = 7'h1f == predict_index ? pht_table_31 : _GEN_30; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_32 = 7'h20 == predict_index ? pht_table_32 : _GEN_31; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_33 = 7'h21 == predict_index ? pht_table_33 : _GEN_32; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_34 = 7'h22 == predict_index ? pht_table_34 : _GEN_33; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_35 = 7'h23 == predict_index ? pht_table_35 : _GEN_34; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_36 = 7'h24 == predict_index ? pht_table_36 : _GEN_35; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_37 = 7'h25 == predict_index ? pht_table_37 : _GEN_36; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_38 = 7'h26 == predict_index ? pht_table_38 : _GEN_37; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_39 = 7'h27 == predict_index ? pht_table_39 : _GEN_38; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_40 = 7'h28 == predict_index ? pht_table_40 : _GEN_39; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_41 = 7'h29 == predict_index ? pht_table_41 : _GEN_40; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_42 = 7'h2a == predict_index ? pht_table_42 : _GEN_41; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_43 = 7'h2b == predict_index ? pht_table_43 : _GEN_42; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_44 = 7'h2c == predict_index ? pht_table_44 : _GEN_43; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_45 = 7'h2d == predict_index ? pht_table_45 : _GEN_44; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_46 = 7'h2e == predict_index ? pht_table_46 : _GEN_45; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_47 = 7'h2f == predict_index ? pht_table_47 : _GEN_46; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_48 = 7'h30 == predict_index ? pht_table_48 : _GEN_47; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_49 = 7'h31 == predict_index ? pht_table_49 : _GEN_48; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_50 = 7'h32 == predict_index ? pht_table_50 : _GEN_49; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_51 = 7'h33 == predict_index ? pht_table_51 : _GEN_50; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_52 = 7'h34 == predict_index ? pht_table_52 : _GEN_51; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_53 = 7'h35 == predict_index ? pht_table_53 : _GEN_52; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_54 = 7'h36 == predict_index ? pht_table_54 : _GEN_53; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_55 = 7'h37 == predict_index ? pht_table_55 : _GEN_54; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_56 = 7'h38 == predict_index ? pht_table_56 : _GEN_55; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_57 = 7'h39 == predict_index ? pht_table_57 : _GEN_56; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_58 = 7'h3a == predict_index ? pht_table_58 : _GEN_57; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_59 = 7'h3b == predict_index ? pht_table_59 : _GEN_58; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_60 = 7'h3c == predict_index ? pht_table_60 : _GEN_59; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_61 = 7'h3d == predict_index ? pht_table_61 : _GEN_60; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_62 = 7'h3e == predict_index ? pht_table_62 : _GEN_61; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_63 = 7'h3f == predict_index ? pht_table_63 : _GEN_62; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_64 = 7'h40 == predict_index ? pht_table_64 : _GEN_63; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_65 = 7'h41 == predict_index ? pht_table_65 : _GEN_64; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_66 = 7'h42 == predict_index ? pht_table_66 : _GEN_65; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_67 = 7'h43 == predict_index ? pht_table_67 : _GEN_66; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_68 = 7'h44 == predict_index ? pht_table_68 : _GEN_67; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_69 = 7'h45 == predict_index ? pht_table_69 : _GEN_68; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_70 = 7'h46 == predict_index ? pht_table_70 : _GEN_69; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_71 = 7'h47 == predict_index ? pht_table_71 : _GEN_70; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_72 = 7'h48 == predict_index ? pht_table_72 : _GEN_71; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_73 = 7'h49 == predict_index ? pht_table_73 : _GEN_72; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_74 = 7'h4a == predict_index ? pht_table_74 : _GEN_73; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_75 = 7'h4b == predict_index ? pht_table_75 : _GEN_74; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_76 = 7'h4c == predict_index ? pht_table_76 : _GEN_75; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_77 = 7'h4d == predict_index ? pht_table_77 : _GEN_76; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_78 = 7'h4e == predict_index ? pht_table_78 : _GEN_77; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_79 = 7'h4f == predict_index ? pht_table_79 : _GEN_78; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_80 = 7'h50 == predict_index ? pht_table_80 : _GEN_79; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_81 = 7'h51 == predict_index ? pht_table_81 : _GEN_80; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_82 = 7'h52 == predict_index ? pht_table_82 : _GEN_81; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_83 = 7'h53 == predict_index ? pht_table_83 : _GEN_82; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_84 = 7'h54 == predict_index ? pht_table_84 : _GEN_83; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_85 = 7'h55 == predict_index ? pht_table_85 : _GEN_84; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_86 = 7'h56 == predict_index ? pht_table_86 : _GEN_85; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_87 = 7'h57 == predict_index ? pht_table_87 : _GEN_86; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_88 = 7'h58 == predict_index ? pht_table_88 : _GEN_87; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_89 = 7'h59 == predict_index ? pht_table_89 : _GEN_88; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_90 = 7'h5a == predict_index ? pht_table_90 : _GEN_89; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_91 = 7'h5b == predict_index ? pht_table_91 : _GEN_90; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_92 = 7'h5c == predict_index ? pht_table_92 : _GEN_91; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_93 = 7'h5d == predict_index ? pht_table_93 : _GEN_92; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_94 = 7'h5e == predict_index ? pht_table_94 : _GEN_93; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_95 = 7'h5f == predict_index ? pht_table_95 : _GEN_94; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_96 = 7'h60 == predict_index ? pht_table_96 : _GEN_95; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_97 = 7'h61 == predict_index ? pht_table_97 : _GEN_96; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_98 = 7'h62 == predict_index ? pht_table_98 : _GEN_97; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_99 = 7'h63 == predict_index ? pht_table_99 : _GEN_98; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_100 = 7'h64 == predict_index ? pht_table_100 : _GEN_99; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_101 = 7'h65 == predict_index ? pht_table_101 : _GEN_100; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_102 = 7'h66 == predict_index ? pht_table_102 : _GEN_101; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_103 = 7'h67 == predict_index ? pht_table_103 : _GEN_102; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_104 = 7'h68 == predict_index ? pht_table_104 : _GEN_103; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_105 = 7'h69 == predict_index ? pht_table_105 : _GEN_104; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_106 = 7'h6a == predict_index ? pht_table_106 : _GEN_105; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_107 = 7'h6b == predict_index ? pht_table_107 : _GEN_106; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_108 = 7'h6c == predict_index ? pht_table_108 : _GEN_107; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_109 = 7'h6d == predict_index ? pht_table_109 : _GEN_108; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_110 = 7'h6e == predict_index ? pht_table_110 : _GEN_109; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_111 = 7'h6f == predict_index ? pht_table_111 : _GEN_110; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_112 = 7'h70 == predict_index ? pht_table_112 : _GEN_111; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_113 = 7'h71 == predict_index ? pht_table_113 : _GEN_112; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_114 = 7'h72 == predict_index ? pht_table_114 : _GEN_113; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_115 = 7'h73 == predict_index ? pht_table_115 : _GEN_114; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_116 = 7'h74 == predict_index ? pht_table_116 : _GEN_115; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_117 = 7'h75 == predict_index ? pht_table_117 : _GEN_116; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_118 = 7'h76 == predict_index ? pht_table_118 : _GEN_117; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_119 = 7'h77 == predict_index ? pht_table_119 : _GEN_118; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_120 = 7'h78 == predict_index ? pht_table_120 : _GEN_119; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_121 = 7'h79 == predict_index ? pht_table_121 : _GEN_120; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_122 = 7'h7a == predict_index ? pht_table_122 : _GEN_121; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_123 = 7'h7b == predict_index ? pht_table_123 : _GEN_122; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_124 = 7'h7c == predict_index ? pht_table_124 : _GEN_123; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_125 = 7'h7d == predict_index ? pht_table_125 : _GEN_124; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_126 = 7'h7e == predict_index ? pht_table_126 : _GEN_125; // @[dut.scala 32:{38,38}]
  wire [1:0] _GEN_127 = 7'h7f == predict_index ? pht_table_127 : _GEN_126; // @[dut.scala 32:{38,38}]
  wire [7:0] _next_ghr_prediction_T = {ghr, 1'h0}; // @[dut.scala 34:34]
  wire [7:0] _GEN_1027 = {{7'd0}, io_predict_taken}; // @[dut.scala 34:40]
  wire [7:0] next_ghr_prediction = _next_ghr_prediction_T | _GEN_1027; // @[dut.scala 34:40]
  wire [6:0] train_index = io_train_pc ^ io_train_history; // @[dut.scala 37:33]
  wire [1:0] _GEN_129 = 7'h1 == train_index ? pht_table_1 : pht_table_0; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_130 = 7'h2 == train_index ? pht_table_2 : _GEN_129; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_131 = 7'h3 == train_index ? pht_table_3 : _GEN_130; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_132 = 7'h4 == train_index ? pht_table_4 : _GEN_131; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_133 = 7'h5 == train_index ? pht_table_5 : _GEN_132; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_134 = 7'h6 == train_index ? pht_table_6 : _GEN_133; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_135 = 7'h7 == train_index ? pht_table_7 : _GEN_134; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_136 = 7'h8 == train_index ? pht_table_8 : _GEN_135; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_137 = 7'h9 == train_index ? pht_table_9 : _GEN_136; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_138 = 7'ha == train_index ? pht_table_10 : _GEN_137; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_139 = 7'hb == train_index ? pht_table_11 : _GEN_138; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_140 = 7'hc == train_index ? pht_table_12 : _GEN_139; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_141 = 7'hd == train_index ? pht_table_13 : _GEN_140; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_142 = 7'he == train_index ? pht_table_14 : _GEN_141; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_143 = 7'hf == train_index ? pht_table_15 : _GEN_142; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_144 = 7'h10 == train_index ? pht_table_16 : _GEN_143; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_145 = 7'h11 == train_index ? pht_table_17 : _GEN_144; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_146 = 7'h12 == train_index ? pht_table_18 : _GEN_145; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_147 = 7'h13 == train_index ? pht_table_19 : _GEN_146; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_148 = 7'h14 == train_index ? pht_table_20 : _GEN_147; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_149 = 7'h15 == train_index ? pht_table_21 : _GEN_148; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_150 = 7'h16 == train_index ? pht_table_22 : _GEN_149; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_151 = 7'h17 == train_index ? pht_table_23 : _GEN_150; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_152 = 7'h18 == train_index ? pht_table_24 : _GEN_151; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_153 = 7'h19 == train_index ? pht_table_25 : _GEN_152; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_154 = 7'h1a == train_index ? pht_table_26 : _GEN_153; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_155 = 7'h1b == train_index ? pht_table_27 : _GEN_154; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_156 = 7'h1c == train_index ? pht_table_28 : _GEN_155; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_157 = 7'h1d == train_index ? pht_table_29 : _GEN_156; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_158 = 7'h1e == train_index ? pht_table_30 : _GEN_157; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_159 = 7'h1f == train_index ? pht_table_31 : _GEN_158; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_160 = 7'h20 == train_index ? pht_table_32 : _GEN_159; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_161 = 7'h21 == train_index ? pht_table_33 : _GEN_160; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_162 = 7'h22 == train_index ? pht_table_34 : _GEN_161; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_163 = 7'h23 == train_index ? pht_table_35 : _GEN_162; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_164 = 7'h24 == train_index ? pht_table_36 : _GEN_163; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_165 = 7'h25 == train_index ? pht_table_37 : _GEN_164; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_166 = 7'h26 == train_index ? pht_table_38 : _GEN_165; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_167 = 7'h27 == train_index ? pht_table_39 : _GEN_166; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_168 = 7'h28 == train_index ? pht_table_40 : _GEN_167; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_169 = 7'h29 == train_index ? pht_table_41 : _GEN_168; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_170 = 7'h2a == train_index ? pht_table_42 : _GEN_169; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_171 = 7'h2b == train_index ? pht_table_43 : _GEN_170; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_172 = 7'h2c == train_index ? pht_table_44 : _GEN_171; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_173 = 7'h2d == train_index ? pht_table_45 : _GEN_172; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_174 = 7'h2e == train_index ? pht_table_46 : _GEN_173; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_175 = 7'h2f == train_index ? pht_table_47 : _GEN_174; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_176 = 7'h30 == train_index ? pht_table_48 : _GEN_175; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_177 = 7'h31 == train_index ? pht_table_49 : _GEN_176; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_178 = 7'h32 == train_index ? pht_table_50 : _GEN_177; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_179 = 7'h33 == train_index ? pht_table_51 : _GEN_178; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_180 = 7'h34 == train_index ? pht_table_52 : _GEN_179; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_181 = 7'h35 == train_index ? pht_table_53 : _GEN_180; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_182 = 7'h36 == train_index ? pht_table_54 : _GEN_181; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_183 = 7'h37 == train_index ? pht_table_55 : _GEN_182; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_184 = 7'h38 == train_index ? pht_table_56 : _GEN_183; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_185 = 7'h39 == train_index ? pht_table_57 : _GEN_184; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_186 = 7'h3a == train_index ? pht_table_58 : _GEN_185; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_187 = 7'h3b == train_index ? pht_table_59 : _GEN_186; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_188 = 7'h3c == train_index ? pht_table_60 : _GEN_187; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_189 = 7'h3d == train_index ? pht_table_61 : _GEN_188; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_190 = 7'h3e == train_index ? pht_table_62 : _GEN_189; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_191 = 7'h3f == train_index ? pht_table_63 : _GEN_190; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_192 = 7'h40 == train_index ? pht_table_64 : _GEN_191; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_193 = 7'h41 == train_index ? pht_table_65 : _GEN_192; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_194 = 7'h42 == train_index ? pht_table_66 : _GEN_193; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_195 = 7'h43 == train_index ? pht_table_67 : _GEN_194; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_196 = 7'h44 == train_index ? pht_table_68 : _GEN_195; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_197 = 7'h45 == train_index ? pht_table_69 : _GEN_196; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_198 = 7'h46 == train_index ? pht_table_70 : _GEN_197; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_199 = 7'h47 == train_index ? pht_table_71 : _GEN_198; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_200 = 7'h48 == train_index ? pht_table_72 : _GEN_199; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_201 = 7'h49 == train_index ? pht_table_73 : _GEN_200; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_202 = 7'h4a == train_index ? pht_table_74 : _GEN_201; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_203 = 7'h4b == train_index ? pht_table_75 : _GEN_202; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_204 = 7'h4c == train_index ? pht_table_76 : _GEN_203; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_205 = 7'h4d == train_index ? pht_table_77 : _GEN_204; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_206 = 7'h4e == train_index ? pht_table_78 : _GEN_205; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_207 = 7'h4f == train_index ? pht_table_79 : _GEN_206; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_208 = 7'h50 == train_index ? pht_table_80 : _GEN_207; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_209 = 7'h51 == train_index ? pht_table_81 : _GEN_208; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_210 = 7'h52 == train_index ? pht_table_82 : _GEN_209; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_211 = 7'h53 == train_index ? pht_table_83 : _GEN_210; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_212 = 7'h54 == train_index ? pht_table_84 : _GEN_211; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_213 = 7'h55 == train_index ? pht_table_85 : _GEN_212; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_214 = 7'h56 == train_index ? pht_table_86 : _GEN_213; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_215 = 7'h57 == train_index ? pht_table_87 : _GEN_214; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_216 = 7'h58 == train_index ? pht_table_88 : _GEN_215; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_217 = 7'h59 == train_index ? pht_table_89 : _GEN_216; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_218 = 7'h5a == train_index ? pht_table_90 : _GEN_217; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_219 = 7'h5b == train_index ? pht_table_91 : _GEN_218; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_220 = 7'h5c == train_index ? pht_table_92 : _GEN_219; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_221 = 7'h5d == train_index ? pht_table_93 : _GEN_220; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_222 = 7'h5e == train_index ? pht_table_94 : _GEN_221; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_223 = 7'h5f == train_index ? pht_table_95 : _GEN_222; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_224 = 7'h60 == train_index ? pht_table_96 : _GEN_223; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_225 = 7'h61 == train_index ? pht_table_97 : _GEN_224; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_226 = 7'h62 == train_index ? pht_table_98 : _GEN_225; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_227 = 7'h63 == train_index ? pht_table_99 : _GEN_226; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_228 = 7'h64 == train_index ? pht_table_100 : _GEN_227; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_229 = 7'h65 == train_index ? pht_table_101 : _GEN_228; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_230 = 7'h66 == train_index ? pht_table_102 : _GEN_229; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_231 = 7'h67 == train_index ? pht_table_103 : _GEN_230; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_232 = 7'h68 == train_index ? pht_table_104 : _GEN_231; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_233 = 7'h69 == train_index ? pht_table_105 : _GEN_232; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_234 = 7'h6a == train_index ? pht_table_106 : _GEN_233; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_235 = 7'h6b == train_index ? pht_table_107 : _GEN_234; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_236 = 7'h6c == train_index ? pht_table_108 : _GEN_235; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_237 = 7'h6d == train_index ? pht_table_109 : _GEN_236; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_238 = 7'h6e == train_index ? pht_table_110 : _GEN_237; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_239 = 7'h6f == train_index ? pht_table_111 : _GEN_238; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_240 = 7'h70 == train_index ? pht_table_112 : _GEN_239; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_241 = 7'h71 == train_index ? pht_table_113 : _GEN_240; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_242 = 7'h72 == train_index ? pht_table_114 : _GEN_241; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_243 = 7'h73 == train_index ? pht_table_115 : _GEN_242; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_244 = 7'h74 == train_index ? pht_table_116 : _GEN_243; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_245 = 7'h75 == train_index ? pht_table_117 : _GEN_244; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_246 = 7'h76 == train_index ? pht_table_118 : _GEN_245; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_247 = 7'h77 == train_index ? pht_table_119 : _GEN_246; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_248 = 7'h78 == train_index ? pht_table_120 : _GEN_247; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_249 = 7'h79 == train_index ? pht_table_121 : _GEN_248; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_250 = 7'h7a == train_index ? pht_table_122 : _GEN_249; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_251 = 7'h7b == train_index ? pht_table_123 : _GEN_250; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_252 = 7'h7c == train_index ? pht_table_124 : _GEN_251; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_253 = 7'h7d == train_index ? pht_table_125 : _GEN_252; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_254 = 7'h7e == train_index ? pht_table_126 : _GEN_253; // @[dut.scala 43:{35,35}]
  wire [1:0] _GEN_255 = 7'h7f == train_index ? pht_table_127 : _GEN_254; // @[dut.scala 43:{35,35}]
  wire [1:0] _pht_table_T_1 = _GEN_255 + 2'h1; // @[dut.scala 44:58]
  wire [1:0] _GEN_256 = 7'h0 == train_index ? _pht_table_T_1 : pht_table_0; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_257 = 7'h1 == train_index ? _pht_table_T_1 : pht_table_1; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_258 = 7'h2 == train_index ? _pht_table_T_1 : pht_table_2; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_259 = 7'h3 == train_index ? _pht_table_T_1 : pht_table_3; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_260 = 7'h4 == train_index ? _pht_table_T_1 : pht_table_4; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_261 = 7'h5 == train_index ? _pht_table_T_1 : pht_table_5; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_262 = 7'h6 == train_index ? _pht_table_T_1 : pht_table_6; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_263 = 7'h7 == train_index ? _pht_table_T_1 : pht_table_7; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_264 = 7'h8 == train_index ? _pht_table_T_1 : pht_table_8; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_265 = 7'h9 == train_index ? _pht_table_T_1 : pht_table_9; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_266 = 7'ha == train_index ? _pht_table_T_1 : pht_table_10; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_267 = 7'hb == train_index ? _pht_table_T_1 : pht_table_11; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_268 = 7'hc == train_index ? _pht_table_T_1 : pht_table_12; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_269 = 7'hd == train_index ? _pht_table_T_1 : pht_table_13; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_270 = 7'he == train_index ? _pht_table_T_1 : pht_table_14; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_271 = 7'hf == train_index ? _pht_table_T_1 : pht_table_15; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_272 = 7'h10 == train_index ? _pht_table_T_1 : pht_table_16; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_273 = 7'h11 == train_index ? _pht_table_T_1 : pht_table_17; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_274 = 7'h12 == train_index ? _pht_table_T_1 : pht_table_18; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_275 = 7'h13 == train_index ? _pht_table_T_1 : pht_table_19; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_276 = 7'h14 == train_index ? _pht_table_T_1 : pht_table_20; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_277 = 7'h15 == train_index ? _pht_table_T_1 : pht_table_21; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_278 = 7'h16 == train_index ? _pht_table_T_1 : pht_table_22; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_279 = 7'h17 == train_index ? _pht_table_T_1 : pht_table_23; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_280 = 7'h18 == train_index ? _pht_table_T_1 : pht_table_24; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_281 = 7'h19 == train_index ? _pht_table_T_1 : pht_table_25; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_282 = 7'h1a == train_index ? _pht_table_T_1 : pht_table_26; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_283 = 7'h1b == train_index ? _pht_table_T_1 : pht_table_27; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_284 = 7'h1c == train_index ? _pht_table_T_1 : pht_table_28; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_285 = 7'h1d == train_index ? _pht_table_T_1 : pht_table_29; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_286 = 7'h1e == train_index ? _pht_table_T_1 : pht_table_30; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_287 = 7'h1f == train_index ? _pht_table_T_1 : pht_table_31; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_288 = 7'h20 == train_index ? _pht_table_T_1 : pht_table_32; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_289 = 7'h21 == train_index ? _pht_table_T_1 : pht_table_33; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_290 = 7'h22 == train_index ? _pht_table_T_1 : pht_table_34; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_291 = 7'h23 == train_index ? _pht_table_T_1 : pht_table_35; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_292 = 7'h24 == train_index ? _pht_table_T_1 : pht_table_36; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_293 = 7'h25 == train_index ? _pht_table_T_1 : pht_table_37; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_294 = 7'h26 == train_index ? _pht_table_T_1 : pht_table_38; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_295 = 7'h27 == train_index ? _pht_table_T_1 : pht_table_39; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_296 = 7'h28 == train_index ? _pht_table_T_1 : pht_table_40; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_297 = 7'h29 == train_index ? _pht_table_T_1 : pht_table_41; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_298 = 7'h2a == train_index ? _pht_table_T_1 : pht_table_42; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_299 = 7'h2b == train_index ? _pht_table_T_1 : pht_table_43; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_300 = 7'h2c == train_index ? _pht_table_T_1 : pht_table_44; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_301 = 7'h2d == train_index ? _pht_table_T_1 : pht_table_45; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_302 = 7'h2e == train_index ? _pht_table_T_1 : pht_table_46; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_303 = 7'h2f == train_index ? _pht_table_T_1 : pht_table_47; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_304 = 7'h30 == train_index ? _pht_table_T_1 : pht_table_48; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_305 = 7'h31 == train_index ? _pht_table_T_1 : pht_table_49; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_306 = 7'h32 == train_index ? _pht_table_T_1 : pht_table_50; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_307 = 7'h33 == train_index ? _pht_table_T_1 : pht_table_51; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_308 = 7'h34 == train_index ? _pht_table_T_1 : pht_table_52; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_309 = 7'h35 == train_index ? _pht_table_T_1 : pht_table_53; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_310 = 7'h36 == train_index ? _pht_table_T_1 : pht_table_54; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_311 = 7'h37 == train_index ? _pht_table_T_1 : pht_table_55; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_312 = 7'h38 == train_index ? _pht_table_T_1 : pht_table_56; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_313 = 7'h39 == train_index ? _pht_table_T_1 : pht_table_57; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_314 = 7'h3a == train_index ? _pht_table_T_1 : pht_table_58; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_315 = 7'h3b == train_index ? _pht_table_T_1 : pht_table_59; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_316 = 7'h3c == train_index ? _pht_table_T_1 : pht_table_60; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_317 = 7'h3d == train_index ? _pht_table_T_1 : pht_table_61; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_318 = 7'h3e == train_index ? _pht_table_T_1 : pht_table_62; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_319 = 7'h3f == train_index ? _pht_table_T_1 : pht_table_63; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_320 = 7'h40 == train_index ? _pht_table_T_1 : pht_table_64; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_321 = 7'h41 == train_index ? _pht_table_T_1 : pht_table_65; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_322 = 7'h42 == train_index ? _pht_table_T_1 : pht_table_66; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_323 = 7'h43 == train_index ? _pht_table_T_1 : pht_table_67; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_324 = 7'h44 == train_index ? _pht_table_T_1 : pht_table_68; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_325 = 7'h45 == train_index ? _pht_table_T_1 : pht_table_69; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_326 = 7'h46 == train_index ? _pht_table_T_1 : pht_table_70; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_327 = 7'h47 == train_index ? _pht_table_T_1 : pht_table_71; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_328 = 7'h48 == train_index ? _pht_table_T_1 : pht_table_72; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_329 = 7'h49 == train_index ? _pht_table_T_1 : pht_table_73; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_330 = 7'h4a == train_index ? _pht_table_T_1 : pht_table_74; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_331 = 7'h4b == train_index ? _pht_table_T_1 : pht_table_75; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_332 = 7'h4c == train_index ? _pht_table_T_1 : pht_table_76; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_333 = 7'h4d == train_index ? _pht_table_T_1 : pht_table_77; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_334 = 7'h4e == train_index ? _pht_table_T_1 : pht_table_78; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_335 = 7'h4f == train_index ? _pht_table_T_1 : pht_table_79; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_336 = 7'h50 == train_index ? _pht_table_T_1 : pht_table_80; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_337 = 7'h51 == train_index ? _pht_table_T_1 : pht_table_81; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_338 = 7'h52 == train_index ? _pht_table_T_1 : pht_table_82; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_339 = 7'h53 == train_index ? _pht_table_T_1 : pht_table_83; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_340 = 7'h54 == train_index ? _pht_table_T_1 : pht_table_84; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_341 = 7'h55 == train_index ? _pht_table_T_1 : pht_table_85; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_342 = 7'h56 == train_index ? _pht_table_T_1 : pht_table_86; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_343 = 7'h57 == train_index ? _pht_table_T_1 : pht_table_87; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_344 = 7'h58 == train_index ? _pht_table_T_1 : pht_table_88; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_345 = 7'h59 == train_index ? _pht_table_T_1 : pht_table_89; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_346 = 7'h5a == train_index ? _pht_table_T_1 : pht_table_90; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_347 = 7'h5b == train_index ? _pht_table_T_1 : pht_table_91; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_348 = 7'h5c == train_index ? _pht_table_T_1 : pht_table_92; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_349 = 7'h5d == train_index ? _pht_table_T_1 : pht_table_93; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_350 = 7'h5e == train_index ? _pht_table_T_1 : pht_table_94; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_351 = 7'h5f == train_index ? _pht_table_T_1 : pht_table_95; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_352 = 7'h60 == train_index ? _pht_table_T_1 : pht_table_96; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_353 = 7'h61 == train_index ? _pht_table_T_1 : pht_table_97; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_354 = 7'h62 == train_index ? _pht_table_T_1 : pht_table_98; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_355 = 7'h63 == train_index ? _pht_table_T_1 : pht_table_99; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_356 = 7'h64 == train_index ? _pht_table_T_1 : pht_table_100; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_357 = 7'h65 == train_index ? _pht_table_T_1 : pht_table_101; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_358 = 7'h66 == train_index ? _pht_table_T_1 : pht_table_102; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_359 = 7'h67 == train_index ? _pht_table_T_1 : pht_table_103; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_360 = 7'h68 == train_index ? _pht_table_T_1 : pht_table_104; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_361 = 7'h69 == train_index ? _pht_table_T_1 : pht_table_105; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_362 = 7'h6a == train_index ? _pht_table_T_1 : pht_table_106; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_363 = 7'h6b == train_index ? _pht_table_T_1 : pht_table_107; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_364 = 7'h6c == train_index ? _pht_table_T_1 : pht_table_108; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_365 = 7'h6d == train_index ? _pht_table_T_1 : pht_table_109; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_366 = 7'h6e == train_index ? _pht_table_T_1 : pht_table_110; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_367 = 7'h6f == train_index ? _pht_table_T_1 : pht_table_111; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_368 = 7'h70 == train_index ? _pht_table_T_1 : pht_table_112; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_369 = 7'h71 == train_index ? _pht_table_T_1 : pht_table_113; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_370 = 7'h72 == train_index ? _pht_table_T_1 : pht_table_114; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_371 = 7'h73 == train_index ? _pht_table_T_1 : pht_table_115; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_372 = 7'h74 == train_index ? _pht_table_T_1 : pht_table_116; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_373 = 7'h75 == train_index ? _pht_table_T_1 : pht_table_117; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_374 = 7'h76 == train_index ? _pht_table_T_1 : pht_table_118; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_375 = 7'h77 == train_index ? _pht_table_T_1 : pht_table_119; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_376 = 7'h78 == train_index ? _pht_table_T_1 : pht_table_120; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_377 = 7'h79 == train_index ? _pht_table_T_1 : pht_table_121; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_378 = 7'h7a == train_index ? _pht_table_T_1 : pht_table_122; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_379 = 7'h7b == train_index ? _pht_table_T_1 : pht_table_123; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_380 = 7'h7c == train_index ? _pht_table_T_1 : pht_table_124; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_381 = 7'h7d == train_index ? _pht_table_T_1 : pht_table_125; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_382 = 7'h7e == train_index ? _pht_table_T_1 : pht_table_126; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _GEN_383 = 7'h7f == train_index ? _pht_table_T_1 : pht_table_127; // @[dut.scala 23:26 44:{32,32}]
  wire [1:0] _pht_table_T_3 = _GEN_255 - 2'h1; // @[dut.scala 49:58]
  wire [1:0] _GEN_512 = 7'h0 == train_index ? _pht_table_T_3 : pht_table_0; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_513 = 7'h1 == train_index ? _pht_table_T_3 : pht_table_1; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_514 = 7'h2 == train_index ? _pht_table_T_3 : pht_table_2; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_515 = 7'h3 == train_index ? _pht_table_T_3 : pht_table_3; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_516 = 7'h4 == train_index ? _pht_table_T_3 : pht_table_4; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_517 = 7'h5 == train_index ? _pht_table_T_3 : pht_table_5; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_518 = 7'h6 == train_index ? _pht_table_T_3 : pht_table_6; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_519 = 7'h7 == train_index ? _pht_table_T_3 : pht_table_7; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_520 = 7'h8 == train_index ? _pht_table_T_3 : pht_table_8; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_521 = 7'h9 == train_index ? _pht_table_T_3 : pht_table_9; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_522 = 7'ha == train_index ? _pht_table_T_3 : pht_table_10; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_523 = 7'hb == train_index ? _pht_table_T_3 : pht_table_11; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_524 = 7'hc == train_index ? _pht_table_T_3 : pht_table_12; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_525 = 7'hd == train_index ? _pht_table_T_3 : pht_table_13; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_526 = 7'he == train_index ? _pht_table_T_3 : pht_table_14; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_527 = 7'hf == train_index ? _pht_table_T_3 : pht_table_15; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_528 = 7'h10 == train_index ? _pht_table_T_3 : pht_table_16; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_529 = 7'h11 == train_index ? _pht_table_T_3 : pht_table_17; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_530 = 7'h12 == train_index ? _pht_table_T_3 : pht_table_18; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_531 = 7'h13 == train_index ? _pht_table_T_3 : pht_table_19; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_532 = 7'h14 == train_index ? _pht_table_T_3 : pht_table_20; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_533 = 7'h15 == train_index ? _pht_table_T_3 : pht_table_21; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_534 = 7'h16 == train_index ? _pht_table_T_3 : pht_table_22; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_535 = 7'h17 == train_index ? _pht_table_T_3 : pht_table_23; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_536 = 7'h18 == train_index ? _pht_table_T_3 : pht_table_24; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_537 = 7'h19 == train_index ? _pht_table_T_3 : pht_table_25; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_538 = 7'h1a == train_index ? _pht_table_T_3 : pht_table_26; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_539 = 7'h1b == train_index ? _pht_table_T_3 : pht_table_27; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_540 = 7'h1c == train_index ? _pht_table_T_3 : pht_table_28; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_541 = 7'h1d == train_index ? _pht_table_T_3 : pht_table_29; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_542 = 7'h1e == train_index ? _pht_table_T_3 : pht_table_30; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_543 = 7'h1f == train_index ? _pht_table_T_3 : pht_table_31; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_544 = 7'h20 == train_index ? _pht_table_T_3 : pht_table_32; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_545 = 7'h21 == train_index ? _pht_table_T_3 : pht_table_33; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_546 = 7'h22 == train_index ? _pht_table_T_3 : pht_table_34; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_547 = 7'h23 == train_index ? _pht_table_T_3 : pht_table_35; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_548 = 7'h24 == train_index ? _pht_table_T_3 : pht_table_36; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_549 = 7'h25 == train_index ? _pht_table_T_3 : pht_table_37; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_550 = 7'h26 == train_index ? _pht_table_T_3 : pht_table_38; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_551 = 7'h27 == train_index ? _pht_table_T_3 : pht_table_39; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_552 = 7'h28 == train_index ? _pht_table_T_3 : pht_table_40; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_553 = 7'h29 == train_index ? _pht_table_T_3 : pht_table_41; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_554 = 7'h2a == train_index ? _pht_table_T_3 : pht_table_42; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_555 = 7'h2b == train_index ? _pht_table_T_3 : pht_table_43; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_556 = 7'h2c == train_index ? _pht_table_T_3 : pht_table_44; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_557 = 7'h2d == train_index ? _pht_table_T_3 : pht_table_45; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_558 = 7'h2e == train_index ? _pht_table_T_3 : pht_table_46; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_559 = 7'h2f == train_index ? _pht_table_T_3 : pht_table_47; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_560 = 7'h30 == train_index ? _pht_table_T_3 : pht_table_48; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_561 = 7'h31 == train_index ? _pht_table_T_3 : pht_table_49; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_562 = 7'h32 == train_index ? _pht_table_T_3 : pht_table_50; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_563 = 7'h33 == train_index ? _pht_table_T_3 : pht_table_51; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_564 = 7'h34 == train_index ? _pht_table_T_3 : pht_table_52; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_565 = 7'h35 == train_index ? _pht_table_T_3 : pht_table_53; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_566 = 7'h36 == train_index ? _pht_table_T_3 : pht_table_54; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_567 = 7'h37 == train_index ? _pht_table_T_3 : pht_table_55; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_568 = 7'h38 == train_index ? _pht_table_T_3 : pht_table_56; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_569 = 7'h39 == train_index ? _pht_table_T_3 : pht_table_57; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_570 = 7'h3a == train_index ? _pht_table_T_3 : pht_table_58; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_571 = 7'h3b == train_index ? _pht_table_T_3 : pht_table_59; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_572 = 7'h3c == train_index ? _pht_table_T_3 : pht_table_60; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_573 = 7'h3d == train_index ? _pht_table_T_3 : pht_table_61; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_574 = 7'h3e == train_index ? _pht_table_T_3 : pht_table_62; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_575 = 7'h3f == train_index ? _pht_table_T_3 : pht_table_63; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_576 = 7'h40 == train_index ? _pht_table_T_3 : pht_table_64; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_577 = 7'h41 == train_index ? _pht_table_T_3 : pht_table_65; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_578 = 7'h42 == train_index ? _pht_table_T_3 : pht_table_66; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_579 = 7'h43 == train_index ? _pht_table_T_3 : pht_table_67; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_580 = 7'h44 == train_index ? _pht_table_T_3 : pht_table_68; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_581 = 7'h45 == train_index ? _pht_table_T_3 : pht_table_69; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_582 = 7'h46 == train_index ? _pht_table_T_3 : pht_table_70; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_583 = 7'h47 == train_index ? _pht_table_T_3 : pht_table_71; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_584 = 7'h48 == train_index ? _pht_table_T_3 : pht_table_72; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_585 = 7'h49 == train_index ? _pht_table_T_3 : pht_table_73; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_586 = 7'h4a == train_index ? _pht_table_T_3 : pht_table_74; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_587 = 7'h4b == train_index ? _pht_table_T_3 : pht_table_75; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_588 = 7'h4c == train_index ? _pht_table_T_3 : pht_table_76; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_589 = 7'h4d == train_index ? _pht_table_T_3 : pht_table_77; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_590 = 7'h4e == train_index ? _pht_table_T_3 : pht_table_78; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_591 = 7'h4f == train_index ? _pht_table_T_3 : pht_table_79; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_592 = 7'h50 == train_index ? _pht_table_T_3 : pht_table_80; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_593 = 7'h51 == train_index ? _pht_table_T_3 : pht_table_81; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_594 = 7'h52 == train_index ? _pht_table_T_3 : pht_table_82; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_595 = 7'h53 == train_index ? _pht_table_T_3 : pht_table_83; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_596 = 7'h54 == train_index ? _pht_table_T_3 : pht_table_84; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_597 = 7'h55 == train_index ? _pht_table_T_3 : pht_table_85; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_598 = 7'h56 == train_index ? _pht_table_T_3 : pht_table_86; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_599 = 7'h57 == train_index ? _pht_table_T_3 : pht_table_87; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_600 = 7'h58 == train_index ? _pht_table_T_3 : pht_table_88; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_601 = 7'h59 == train_index ? _pht_table_T_3 : pht_table_89; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_602 = 7'h5a == train_index ? _pht_table_T_3 : pht_table_90; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_603 = 7'h5b == train_index ? _pht_table_T_3 : pht_table_91; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_604 = 7'h5c == train_index ? _pht_table_T_3 : pht_table_92; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_605 = 7'h5d == train_index ? _pht_table_T_3 : pht_table_93; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_606 = 7'h5e == train_index ? _pht_table_T_3 : pht_table_94; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_607 = 7'h5f == train_index ? _pht_table_T_3 : pht_table_95; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_608 = 7'h60 == train_index ? _pht_table_T_3 : pht_table_96; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_609 = 7'h61 == train_index ? _pht_table_T_3 : pht_table_97; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_610 = 7'h62 == train_index ? _pht_table_T_3 : pht_table_98; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_611 = 7'h63 == train_index ? _pht_table_T_3 : pht_table_99; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_612 = 7'h64 == train_index ? _pht_table_T_3 : pht_table_100; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_613 = 7'h65 == train_index ? _pht_table_T_3 : pht_table_101; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_614 = 7'h66 == train_index ? _pht_table_T_3 : pht_table_102; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_615 = 7'h67 == train_index ? _pht_table_T_3 : pht_table_103; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_616 = 7'h68 == train_index ? _pht_table_T_3 : pht_table_104; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_617 = 7'h69 == train_index ? _pht_table_T_3 : pht_table_105; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_618 = 7'h6a == train_index ? _pht_table_T_3 : pht_table_106; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_619 = 7'h6b == train_index ? _pht_table_T_3 : pht_table_107; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_620 = 7'h6c == train_index ? _pht_table_T_3 : pht_table_108; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_621 = 7'h6d == train_index ? _pht_table_T_3 : pht_table_109; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_622 = 7'h6e == train_index ? _pht_table_T_3 : pht_table_110; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_623 = 7'h6f == train_index ? _pht_table_T_3 : pht_table_111; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_624 = 7'h70 == train_index ? _pht_table_T_3 : pht_table_112; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_625 = 7'h71 == train_index ? _pht_table_T_3 : pht_table_113; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_626 = 7'h72 == train_index ? _pht_table_T_3 : pht_table_114; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_627 = 7'h73 == train_index ? _pht_table_T_3 : pht_table_115; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_628 = 7'h74 == train_index ? _pht_table_T_3 : pht_table_116; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_629 = 7'h75 == train_index ? _pht_table_T_3 : pht_table_117; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_630 = 7'h76 == train_index ? _pht_table_T_3 : pht_table_118; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_631 = 7'h77 == train_index ? _pht_table_T_3 : pht_table_119; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_632 = 7'h78 == train_index ? _pht_table_T_3 : pht_table_120; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_633 = 7'h79 == train_index ? _pht_table_T_3 : pht_table_121; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_634 = 7'h7a == train_index ? _pht_table_T_3 : pht_table_122; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_635 = 7'h7b == train_index ? _pht_table_T_3 : pht_table_123; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_636 = 7'h7c == train_index ? _pht_table_T_3 : pht_table_124; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_637 = 7'h7d == train_index ? _pht_table_T_3 : pht_table_125; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_638 = 7'h7e == train_index ? _pht_table_T_3 : pht_table_126; // @[dut.scala 23:26 49:{32,32}]
  wire [1:0] _GEN_639 = 7'h7f == train_index ? _pht_table_T_3 : pht_table_127; // @[dut.scala 23:26 49:{32,32}]
  wire [7:0] _corrected_ghr_T = {io_train_history, 1'h0}; // @[dut.scala 55:41]
  wire [7:0] _GEN_1028 = {{7'd0}, io_train_taken}; // @[dut.scala 55:47]
  wire [7:0] corrected_ghr = _corrected_ghr_T | _GEN_1028; // @[dut.scala 55:47]
  wire [7:0] next_ghr_training = io_train_mispredicted ? corrected_ghr : next_ghr_prediction; // @[dut.scala 56:30]
  wire [7:0] _GEN_1024 = io_predict_valid ? next_ghr_prediction : {{1'd0}, ghr}; // @[dut.scala 26:20 63:32 64:9]
  wire [7:0] _GEN_1025 = io_train_valid ? next_ghr_training : _GEN_1024; // @[dut.scala 61:30 62:9]
  wire [7:0] _GEN_1026 = io_train_valid & io_train_mispredicted ? corrected_ghr : _GEN_1025; // @[dut.scala 59:49 60:9]
  wire [7:0] _GEN_1029 = reset ? 8'h0 : _GEN_1026; // @[dut.scala 26:{20,20}]
  assign io_predict_taken = _GEN_127[1]; // @[dut.scala 32:38]
  assign io_predict_history = ghr; // @[dut.scala 33:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 23:26]
      pht_table_0 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_0 <= _GEN_256;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_0 <= _GEN_512;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_1 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_1 <= _GEN_257;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_1 <= _GEN_513;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_2 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_2 <= _GEN_258;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_2 <= _GEN_514;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_3 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_3 <= _GEN_259;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_3 <= _GEN_515;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_4 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_4 <= _GEN_260;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_4 <= _GEN_516;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_5 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_5 <= _GEN_261;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_5 <= _GEN_517;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_6 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_6 <= _GEN_262;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_6 <= _GEN_518;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_7 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_7 <= _GEN_263;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_7 <= _GEN_519;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_8 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_8 <= _GEN_264;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_8 <= _GEN_520;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_9 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_9 <= _GEN_265;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_9 <= _GEN_521;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_10 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_10 <= _GEN_266;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_10 <= _GEN_522;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_11 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_11 <= _GEN_267;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_11 <= _GEN_523;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_12 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_12 <= _GEN_268;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_12 <= _GEN_524;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_13 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_13 <= _GEN_269;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_13 <= _GEN_525;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_14 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_14 <= _GEN_270;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_14 <= _GEN_526;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_15 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_15 <= _GEN_271;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_15 <= _GEN_527;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_16 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_16 <= _GEN_272;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_16 <= _GEN_528;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_17 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_17 <= _GEN_273;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_17 <= _GEN_529;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_18 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_18 <= _GEN_274;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_18 <= _GEN_530;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_19 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_19 <= _GEN_275;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_19 <= _GEN_531;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_20 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_20 <= _GEN_276;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_20 <= _GEN_532;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_21 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_21 <= _GEN_277;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_21 <= _GEN_533;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_22 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_22 <= _GEN_278;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_22 <= _GEN_534;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_23 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_23 <= _GEN_279;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_23 <= _GEN_535;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_24 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_24 <= _GEN_280;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_24 <= _GEN_536;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_25 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_25 <= _GEN_281;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_25 <= _GEN_537;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_26 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_26 <= _GEN_282;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_26 <= _GEN_538;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_27 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_27 <= _GEN_283;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_27 <= _GEN_539;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_28 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_28 <= _GEN_284;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_28 <= _GEN_540;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_29 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_29 <= _GEN_285;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_29 <= _GEN_541;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_30 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_30 <= _GEN_286;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_30 <= _GEN_542;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_31 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_31 <= _GEN_287;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_31 <= _GEN_543;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_32 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_32 <= _GEN_288;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_32 <= _GEN_544;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_33 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_33 <= _GEN_289;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_33 <= _GEN_545;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_34 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_34 <= _GEN_290;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_34 <= _GEN_546;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_35 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_35 <= _GEN_291;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_35 <= _GEN_547;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_36 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_36 <= _GEN_292;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_36 <= _GEN_548;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_37 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_37 <= _GEN_293;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_37 <= _GEN_549;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_38 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_38 <= _GEN_294;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_38 <= _GEN_550;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_39 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_39 <= _GEN_295;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_39 <= _GEN_551;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_40 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_40 <= _GEN_296;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_40 <= _GEN_552;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_41 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_41 <= _GEN_297;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_41 <= _GEN_553;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_42 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_42 <= _GEN_298;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_42 <= _GEN_554;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_43 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_43 <= _GEN_299;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_43 <= _GEN_555;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_44 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_44 <= _GEN_300;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_44 <= _GEN_556;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_45 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_45 <= _GEN_301;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_45 <= _GEN_557;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_46 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_46 <= _GEN_302;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_46 <= _GEN_558;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_47 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_47 <= _GEN_303;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_47 <= _GEN_559;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_48 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_48 <= _GEN_304;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_48 <= _GEN_560;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_49 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_49 <= _GEN_305;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_49 <= _GEN_561;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_50 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_50 <= _GEN_306;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_50 <= _GEN_562;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_51 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_51 <= _GEN_307;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_51 <= _GEN_563;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_52 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_52 <= _GEN_308;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_52 <= _GEN_564;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_53 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_53 <= _GEN_309;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_53 <= _GEN_565;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_54 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_54 <= _GEN_310;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_54 <= _GEN_566;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_55 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_55 <= _GEN_311;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_55 <= _GEN_567;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_56 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_56 <= _GEN_312;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_56 <= _GEN_568;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_57 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_57 <= _GEN_313;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_57 <= _GEN_569;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_58 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_58 <= _GEN_314;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_58 <= _GEN_570;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_59 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_59 <= _GEN_315;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_59 <= _GEN_571;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_60 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_60 <= _GEN_316;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_60 <= _GEN_572;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_61 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_61 <= _GEN_317;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_61 <= _GEN_573;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_62 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_62 <= _GEN_318;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_62 <= _GEN_574;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_63 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_63 <= _GEN_319;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_63 <= _GEN_575;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_64 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_64 <= _GEN_320;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_64 <= _GEN_576;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_65 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_65 <= _GEN_321;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_65 <= _GEN_577;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_66 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_66 <= _GEN_322;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_66 <= _GEN_578;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_67 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_67 <= _GEN_323;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_67 <= _GEN_579;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_68 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_68 <= _GEN_324;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_68 <= _GEN_580;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_69 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_69 <= _GEN_325;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_69 <= _GEN_581;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_70 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_70 <= _GEN_326;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_70 <= _GEN_582;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_71 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_71 <= _GEN_327;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_71 <= _GEN_583;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_72 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_72 <= _GEN_328;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_72 <= _GEN_584;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_73 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_73 <= _GEN_329;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_73 <= _GEN_585;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_74 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_74 <= _GEN_330;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_74 <= _GEN_586;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_75 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_75 <= _GEN_331;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_75 <= _GEN_587;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_76 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_76 <= _GEN_332;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_76 <= _GEN_588;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_77 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_77 <= _GEN_333;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_77 <= _GEN_589;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_78 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_78 <= _GEN_334;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_78 <= _GEN_590;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_79 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_79 <= _GEN_335;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_79 <= _GEN_591;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_80 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_80 <= _GEN_336;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_80 <= _GEN_592;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_81 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_81 <= _GEN_337;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_81 <= _GEN_593;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_82 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_82 <= _GEN_338;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_82 <= _GEN_594;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_83 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_83 <= _GEN_339;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_83 <= _GEN_595;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_84 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_84 <= _GEN_340;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_84 <= _GEN_596;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_85 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_85 <= _GEN_341;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_85 <= _GEN_597;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_86 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_86 <= _GEN_342;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_86 <= _GEN_598;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_87 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_87 <= _GEN_343;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_87 <= _GEN_599;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_88 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_88 <= _GEN_344;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_88 <= _GEN_600;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_89 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_89 <= _GEN_345;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_89 <= _GEN_601;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_90 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_90 <= _GEN_346;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_90 <= _GEN_602;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_91 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_91 <= _GEN_347;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_91 <= _GEN_603;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_92 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_92 <= _GEN_348;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_92 <= _GEN_604;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_93 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_93 <= _GEN_349;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_93 <= _GEN_605;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_94 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_94 <= _GEN_350;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_94 <= _GEN_606;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_95 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_95 <= _GEN_351;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_95 <= _GEN_607;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_96 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_96 <= _GEN_352;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_96 <= _GEN_608;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_97 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_97 <= _GEN_353;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_97 <= _GEN_609;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_98 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_98 <= _GEN_354;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_98 <= _GEN_610;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_99 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_99 <= _GEN_355;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_99 <= _GEN_611;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_100 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_100 <= _GEN_356;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_100 <= _GEN_612;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_101 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_101 <= _GEN_357;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_101 <= _GEN_613;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_102 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_102 <= _GEN_358;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_102 <= _GEN_614;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_103 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_103 <= _GEN_359;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_103 <= _GEN_615;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_104 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_104 <= _GEN_360;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_104 <= _GEN_616;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_105 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_105 <= _GEN_361;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_105 <= _GEN_617;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_106 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_106 <= _GEN_362;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_106 <= _GEN_618;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_107 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_107 <= _GEN_363;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_107 <= _GEN_619;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_108 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_108 <= _GEN_364;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_108 <= _GEN_620;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_109 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_109 <= _GEN_365;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_109 <= _GEN_621;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_110 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_110 <= _GEN_366;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_110 <= _GEN_622;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_111 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_111 <= _GEN_367;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_111 <= _GEN_623;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_112 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_112 <= _GEN_368;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_112 <= _GEN_624;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_113 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_113 <= _GEN_369;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_113 <= _GEN_625;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_114 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_114 <= _GEN_370;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_114 <= _GEN_626;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_115 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_115 <= _GEN_371;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_115 <= _GEN_627;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_116 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_116 <= _GEN_372;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_116 <= _GEN_628;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_117 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_117 <= _GEN_373;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_117 <= _GEN_629;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_118 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_118 <= _GEN_374;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_118 <= _GEN_630;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_119 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_119 <= _GEN_375;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_119 <= _GEN_631;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_120 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_120 <= _GEN_376;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_120 <= _GEN_632;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_121 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_121 <= _GEN_377;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_121 <= _GEN_633;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_122 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_122 <= _GEN_378;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_122 <= _GEN_634;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_123 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_123 <= _GEN_379;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_123 <= _GEN_635;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_124 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_124 <= _GEN_380;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_124 <= _GEN_636;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_125 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_125 <= _GEN_381;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_125 <= _GEN_637;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_126 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_126 <= _GEN_382;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_126 <= _GEN_638;
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      pht_table_127 <= 2'h1; // @[dut.scala 23:26]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 41:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 43:44]
          pht_table_127 <= _GEN_383;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:44]
        pht_table_127 <= _GEN_639;
      end
    end
    ghr <= _GEN_1029[6:0]; // @[dut.scala 26:{20,20}]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
