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
  input  [6:0] io_train_pc,
  input        io_reset
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
  reg [6:0] globalHistory; // @[dut.scala 24:30]
  reg [1:0] patternHistoryTable_0; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_1; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_2; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_3; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_4; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_5; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_6; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_7; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_8; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_9; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_10; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_11; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_12; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_13; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_14; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_15; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_16; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_17; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_18; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_19; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_20; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_21; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_22; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_23; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_24; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_25; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_26; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_27; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_28; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_29; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_30; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_31; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_32; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_33; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_34; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_35; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_36; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_37; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_38; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_39; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_40; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_41; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_42; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_43; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_44; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_45; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_46; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_47; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_48; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_49; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_50; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_51; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_52; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_53; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_54; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_55; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_56; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_57; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_58; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_59; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_60; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_61; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_62; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_63; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_64; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_65; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_66; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_67; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_68; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_69; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_70; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_71; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_72; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_73; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_74; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_75; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_76; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_77; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_78; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_79; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_80; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_81; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_82; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_83; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_84; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_85; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_86; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_87; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_88; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_89; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_90; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_91; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_92; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_93; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_94; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_95; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_96; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_97; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_98; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_99; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_100; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_101; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_102; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_103; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_104; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_105; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_106; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_107; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_108; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_109; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_110; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_111; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_112; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_113; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_114; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_115; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_116; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_117; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_118; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_119; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_120; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_121; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_122; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_123; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_124; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_125; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_126; // @[dut.scala 27:36]
  reg [1:0] patternHistoryTable_127; // @[dut.scala 27:36]
  wire [6:0] predictionIndex = io_predict_pc ^ globalHistory; // @[dut.scala 31:8]
  wire [1:0] _GEN_1 = 7'h1 == predictionIndex ? patternHistoryTable_1 : patternHistoryTable_0; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_2 = 7'h2 == predictionIndex ? patternHistoryTable_2 : _GEN_1; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_3 = 7'h3 == predictionIndex ? patternHistoryTable_3 : _GEN_2; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_4 = 7'h4 == predictionIndex ? patternHistoryTable_4 : _GEN_3; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_5 = 7'h5 == predictionIndex ? patternHistoryTable_5 : _GEN_4; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_6 = 7'h6 == predictionIndex ? patternHistoryTable_6 : _GEN_5; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_7 = 7'h7 == predictionIndex ? patternHistoryTable_7 : _GEN_6; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_8 = 7'h8 == predictionIndex ? patternHistoryTable_8 : _GEN_7; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_9 = 7'h9 == predictionIndex ? patternHistoryTable_9 : _GEN_8; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_10 = 7'ha == predictionIndex ? patternHistoryTable_10 : _GEN_9; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_11 = 7'hb == predictionIndex ? patternHistoryTable_11 : _GEN_10; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_12 = 7'hc == predictionIndex ? patternHistoryTable_12 : _GEN_11; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_13 = 7'hd == predictionIndex ? patternHistoryTable_13 : _GEN_12; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_14 = 7'he == predictionIndex ? patternHistoryTable_14 : _GEN_13; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_15 = 7'hf == predictionIndex ? patternHistoryTable_15 : _GEN_14; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_16 = 7'h10 == predictionIndex ? patternHistoryTable_16 : _GEN_15; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_17 = 7'h11 == predictionIndex ? patternHistoryTable_17 : _GEN_16; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_18 = 7'h12 == predictionIndex ? patternHistoryTable_18 : _GEN_17; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_19 = 7'h13 == predictionIndex ? patternHistoryTable_19 : _GEN_18; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_20 = 7'h14 == predictionIndex ? patternHistoryTable_20 : _GEN_19; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_21 = 7'h15 == predictionIndex ? patternHistoryTable_21 : _GEN_20; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_22 = 7'h16 == predictionIndex ? patternHistoryTable_22 : _GEN_21; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_23 = 7'h17 == predictionIndex ? patternHistoryTable_23 : _GEN_22; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_24 = 7'h18 == predictionIndex ? patternHistoryTable_24 : _GEN_23; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_25 = 7'h19 == predictionIndex ? patternHistoryTable_25 : _GEN_24; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_26 = 7'h1a == predictionIndex ? patternHistoryTable_26 : _GEN_25; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_27 = 7'h1b == predictionIndex ? patternHistoryTable_27 : _GEN_26; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_28 = 7'h1c == predictionIndex ? patternHistoryTable_28 : _GEN_27; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_29 = 7'h1d == predictionIndex ? patternHistoryTable_29 : _GEN_28; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_30 = 7'h1e == predictionIndex ? patternHistoryTable_30 : _GEN_29; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_31 = 7'h1f == predictionIndex ? patternHistoryTable_31 : _GEN_30; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_32 = 7'h20 == predictionIndex ? patternHistoryTable_32 : _GEN_31; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_33 = 7'h21 == predictionIndex ? patternHistoryTable_33 : _GEN_32; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_34 = 7'h22 == predictionIndex ? patternHistoryTable_34 : _GEN_33; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_35 = 7'h23 == predictionIndex ? patternHistoryTable_35 : _GEN_34; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_36 = 7'h24 == predictionIndex ? patternHistoryTable_36 : _GEN_35; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_37 = 7'h25 == predictionIndex ? patternHistoryTable_37 : _GEN_36; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_38 = 7'h26 == predictionIndex ? patternHistoryTable_38 : _GEN_37; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_39 = 7'h27 == predictionIndex ? patternHistoryTable_39 : _GEN_38; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_40 = 7'h28 == predictionIndex ? patternHistoryTable_40 : _GEN_39; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_41 = 7'h29 == predictionIndex ? patternHistoryTable_41 : _GEN_40; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_42 = 7'h2a == predictionIndex ? patternHistoryTable_42 : _GEN_41; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_43 = 7'h2b == predictionIndex ? patternHistoryTable_43 : _GEN_42; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_44 = 7'h2c == predictionIndex ? patternHistoryTable_44 : _GEN_43; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_45 = 7'h2d == predictionIndex ? patternHistoryTable_45 : _GEN_44; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_46 = 7'h2e == predictionIndex ? patternHistoryTable_46 : _GEN_45; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_47 = 7'h2f == predictionIndex ? patternHistoryTable_47 : _GEN_46; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_48 = 7'h30 == predictionIndex ? patternHistoryTable_48 : _GEN_47; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_49 = 7'h31 == predictionIndex ? patternHistoryTable_49 : _GEN_48; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_50 = 7'h32 == predictionIndex ? patternHistoryTable_50 : _GEN_49; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_51 = 7'h33 == predictionIndex ? patternHistoryTable_51 : _GEN_50; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_52 = 7'h34 == predictionIndex ? patternHistoryTable_52 : _GEN_51; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_53 = 7'h35 == predictionIndex ? patternHistoryTable_53 : _GEN_52; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_54 = 7'h36 == predictionIndex ? patternHistoryTable_54 : _GEN_53; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_55 = 7'h37 == predictionIndex ? patternHistoryTable_55 : _GEN_54; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_56 = 7'h38 == predictionIndex ? patternHistoryTable_56 : _GEN_55; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_57 = 7'h39 == predictionIndex ? patternHistoryTable_57 : _GEN_56; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_58 = 7'h3a == predictionIndex ? patternHistoryTable_58 : _GEN_57; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_59 = 7'h3b == predictionIndex ? patternHistoryTable_59 : _GEN_58; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_60 = 7'h3c == predictionIndex ? patternHistoryTable_60 : _GEN_59; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_61 = 7'h3d == predictionIndex ? patternHistoryTable_61 : _GEN_60; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_62 = 7'h3e == predictionIndex ? patternHistoryTable_62 : _GEN_61; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_63 = 7'h3f == predictionIndex ? patternHistoryTable_63 : _GEN_62; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_64 = 7'h40 == predictionIndex ? patternHistoryTable_64 : _GEN_63; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_65 = 7'h41 == predictionIndex ? patternHistoryTable_65 : _GEN_64; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_66 = 7'h42 == predictionIndex ? patternHistoryTable_66 : _GEN_65; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_67 = 7'h43 == predictionIndex ? patternHistoryTable_67 : _GEN_66; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_68 = 7'h44 == predictionIndex ? patternHistoryTable_68 : _GEN_67; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_69 = 7'h45 == predictionIndex ? patternHistoryTable_69 : _GEN_68; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_70 = 7'h46 == predictionIndex ? patternHistoryTable_70 : _GEN_69; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_71 = 7'h47 == predictionIndex ? patternHistoryTable_71 : _GEN_70; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_72 = 7'h48 == predictionIndex ? patternHistoryTable_72 : _GEN_71; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_73 = 7'h49 == predictionIndex ? patternHistoryTable_73 : _GEN_72; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_74 = 7'h4a == predictionIndex ? patternHistoryTable_74 : _GEN_73; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_75 = 7'h4b == predictionIndex ? patternHistoryTable_75 : _GEN_74; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_76 = 7'h4c == predictionIndex ? patternHistoryTable_76 : _GEN_75; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_77 = 7'h4d == predictionIndex ? patternHistoryTable_77 : _GEN_76; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_78 = 7'h4e == predictionIndex ? patternHistoryTable_78 : _GEN_77; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_79 = 7'h4f == predictionIndex ? patternHistoryTable_79 : _GEN_78; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_80 = 7'h50 == predictionIndex ? patternHistoryTable_80 : _GEN_79; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_81 = 7'h51 == predictionIndex ? patternHistoryTable_81 : _GEN_80; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_82 = 7'h52 == predictionIndex ? patternHistoryTable_82 : _GEN_81; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_83 = 7'h53 == predictionIndex ? patternHistoryTable_83 : _GEN_82; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_84 = 7'h54 == predictionIndex ? patternHistoryTable_84 : _GEN_83; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_85 = 7'h55 == predictionIndex ? patternHistoryTable_85 : _GEN_84; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_86 = 7'h56 == predictionIndex ? patternHistoryTable_86 : _GEN_85; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_87 = 7'h57 == predictionIndex ? patternHistoryTable_87 : _GEN_86; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_88 = 7'h58 == predictionIndex ? patternHistoryTable_88 : _GEN_87; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_89 = 7'h59 == predictionIndex ? patternHistoryTable_89 : _GEN_88; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_90 = 7'h5a == predictionIndex ? patternHistoryTable_90 : _GEN_89; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_91 = 7'h5b == predictionIndex ? patternHistoryTable_91 : _GEN_90; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_92 = 7'h5c == predictionIndex ? patternHistoryTable_92 : _GEN_91; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_93 = 7'h5d == predictionIndex ? patternHistoryTable_93 : _GEN_92; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_94 = 7'h5e == predictionIndex ? patternHistoryTable_94 : _GEN_93; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_95 = 7'h5f == predictionIndex ? patternHistoryTable_95 : _GEN_94; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_96 = 7'h60 == predictionIndex ? patternHistoryTable_96 : _GEN_95; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_97 = 7'h61 == predictionIndex ? patternHistoryTable_97 : _GEN_96; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_98 = 7'h62 == predictionIndex ? patternHistoryTable_98 : _GEN_97; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_99 = 7'h63 == predictionIndex ? patternHistoryTable_99 : _GEN_98; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_100 = 7'h64 == predictionIndex ? patternHistoryTable_100 : _GEN_99; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_101 = 7'h65 == predictionIndex ? patternHistoryTable_101 : _GEN_100; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_102 = 7'h66 == predictionIndex ? patternHistoryTable_102 : _GEN_101; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_103 = 7'h67 == predictionIndex ? patternHistoryTable_103 : _GEN_102; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_104 = 7'h68 == predictionIndex ? patternHistoryTable_104 : _GEN_103; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_105 = 7'h69 == predictionIndex ? patternHistoryTable_105 : _GEN_104; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_106 = 7'h6a == predictionIndex ? patternHistoryTable_106 : _GEN_105; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_107 = 7'h6b == predictionIndex ? patternHistoryTable_107 : _GEN_106; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_108 = 7'h6c == predictionIndex ? patternHistoryTable_108 : _GEN_107; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_109 = 7'h6d == predictionIndex ? patternHistoryTable_109 : _GEN_108; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_110 = 7'h6e == predictionIndex ? patternHistoryTable_110 : _GEN_109; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_111 = 7'h6f == predictionIndex ? patternHistoryTable_111 : _GEN_110; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_112 = 7'h70 == predictionIndex ? patternHistoryTable_112 : _GEN_111; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_113 = 7'h71 == predictionIndex ? patternHistoryTable_113 : _GEN_112; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_114 = 7'h72 == predictionIndex ? patternHistoryTable_114 : _GEN_113; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_115 = 7'h73 == predictionIndex ? patternHistoryTable_115 : _GEN_114; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_116 = 7'h74 == predictionIndex ? patternHistoryTable_116 : _GEN_115; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_117 = 7'h75 == predictionIndex ? patternHistoryTable_117 : _GEN_116; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_118 = 7'h76 == predictionIndex ? patternHistoryTable_118 : _GEN_117; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_119 = 7'h77 == predictionIndex ? patternHistoryTable_119 : _GEN_118; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_120 = 7'h78 == predictionIndex ? patternHistoryTable_120 : _GEN_119; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_121 = 7'h79 == predictionIndex ? patternHistoryTable_121 : _GEN_120; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_122 = 7'h7a == predictionIndex ? patternHistoryTable_122 : _GEN_121; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_123 = 7'h7b == predictionIndex ? patternHistoryTable_123 : _GEN_122; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_124 = 7'h7c == predictionIndex ? patternHistoryTable_124 : _GEN_123; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_125 = 7'h7d == predictionIndex ? patternHistoryTable_125 : _GEN_124; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_126 = 7'h7e == predictionIndex ? patternHistoryTable_126 : _GEN_125; // @[dut.scala 37:{40,40}]
  wire [1:0] _GEN_127 = 7'h7f == predictionIndex ? patternHistoryTable_127 : _GEN_126; // @[dut.scala 37:{40,40}]
  wire [6:0] trainIndex = io_train_pc ^ io_train_history; // @[dut.scala 31:8]
  wire [1:0] _GEN_129 = 7'h1 == trainIndex ? patternHistoryTable_1 : patternHistoryTable_0; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_130 = 7'h2 == trainIndex ? patternHistoryTable_2 : _GEN_129; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_131 = 7'h3 == trainIndex ? patternHistoryTable_3 : _GEN_130; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_132 = 7'h4 == trainIndex ? patternHistoryTable_4 : _GEN_131; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_133 = 7'h5 == trainIndex ? patternHistoryTable_5 : _GEN_132; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_134 = 7'h6 == trainIndex ? patternHistoryTable_6 : _GEN_133; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_135 = 7'h7 == trainIndex ? patternHistoryTable_7 : _GEN_134; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_136 = 7'h8 == trainIndex ? patternHistoryTable_8 : _GEN_135; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_137 = 7'h9 == trainIndex ? patternHistoryTable_9 : _GEN_136; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_138 = 7'ha == trainIndex ? patternHistoryTable_10 : _GEN_137; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_139 = 7'hb == trainIndex ? patternHistoryTable_11 : _GEN_138; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_140 = 7'hc == trainIndex ? patternHistoryTable_12 : _GEN_139; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_141 = 7'hd == trainIndex ? patternHistoryTable_13 : _GEN_140; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_142 = 7'he == trainIndex ? patternHistoryTable_14 : _GEN_141; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_143 = 7'hf == trainIndex ? patternHistoryTable_15 : _GEN_142; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_144 = 7'h10 == trainIndex ? patternHistoryTable_16 : _GEN_143; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_145 = 7'h11 == trainIndex ? patternHistoryTable_17 : _GEN_144; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_146 = 7'h12 == trainIndex ? patternHistoryTable_18 : _GEN_145; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_147 = 7'h13 == trainIndex ? patternHistoryTable_19 : _GEN_146; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_148 = 7'h14 == trainIndex ? patternHistoryTable_20 : _GEN_147; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_149 = 7'h15 == trainIndex ? patternHistoryTable_21 : _GEN_148; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_150 = 7'h16 == trainIndex ? patternHistoryTable_22 : _GEN_149; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_151 = 7'h17 == trainIndex ? patternHistoryTable_23 : _GEN_150; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_152 = 7'h18 == trainIndex ? patternHistoryTable_24 : _GEN_151; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_153 = 7'h19 == trainIndex ? patternHistoryTable_25 : _GEN_152; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_154 = 7'h1a == trainIndex ? patternHistoryTable_26 : _GEN_153; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_155 = 7'h1b == trainIndex ? patternHistoryTable_27 : _GEN_154; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_156 = 7'h1c == trainIndex ? patternHistoryTable_28 : _GEN_155; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_157 = 7'h1d == trainIndex ? patternHistoryTable_29 : _GEN_156; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_158 = 7'h1e == trainIndex ? patternHistoryTable_30 : _GEN_157; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_159 = 7'h1f == trainIndex ? patternHistoryTable_31 : _GEN_158; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_160 = 7'h20 == trainIndex ? patternHistoryTable_32 : _GEN_159; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_161 = 7'h21 == trainIndex ? patternHistoryTable_33 : _GEN_160; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_162 = 7'h22 == trainIndex ? patternHistoryTable_34 : _GEN_161; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_163 = 7'h23 == trainIndex ? patternHistoryTable_35 : _GEN_162; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_164 = 7'h24 == trainIndex ? patternHistoryTable_36 : _GEN_163; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_165 = 7'h25 == trainIndex ? patternHistoryTable_37 : _GEN_164; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_166 = 7'h26 == trainIndex ? patternHistoryTable_38 : _GEN_165; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_167 = 7'h27 == trainIndex ? patternHistoryTable_39 : _GEN_166; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_168 = 7'h28 == trainIndex ? patternHistoryTable_40 : _GEN_167; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_169 = 7'h29 == trainIndex ? patternHistoryTable_41 : _GEN_168; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_170 = 7'h2a == trainIndex ? patternHistoryTable_42 : _GEN_169; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_171 = 7'h2b == trainIndex ? patternHistoryTable_43 : _GEN_170; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_172 = 7'h2c == trainIndex ? patternHistoryTable_44 : _GEN_171; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_173 = 7'h2d == trainIndex ? patternHistoryTable_45 : _GEN_172; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_174 = 7'h2e == trainIndex ? patternHistoryTable_46 : _GEN_173; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_175 = 7'h2f == trainIndex ? patternHistoryTable_47 : _GEN_174; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_176 = 7'h30 == trainIndex ? patternHistoryTable_48 : _GEN_175; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_177 = 7'h31 == trainIndex ? patternHistoryTable_49 : _GEN_176; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_178 = 7'h32 == trainIndex ? patternHistoryTable_50 : _GEN_177; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_179 = 7'h33 == trainIndex ? patternHistoryTable_51 : _GEN_178; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_180 = 7'h34 == trainIndex ? patternHistoryTable_52 : _GEN_179; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_181 = 7'h35 == trainIndex ? patternHistoryTable_53 : _GEN_180; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_182 = 7'h36 == trainIndex ? patternHistoryTable_54 : _GEN_181; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_183 = 7'h37 == trainIndex ? patternHistoryTable_55 : _GEN_182; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_184 = 7'h38 == trainIndex ? patternHistoryTable_56 : _GEN_183; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_185 = 7'h39 == trainIndex ? patternHistoryTable_57 : _GEN_184; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_186 = 7'h3a == trainIndex ? patternHistoryTable_58 : _GEN_185; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_187 = 7'h3b == trainIndex ? patternHistoryTable_59 : _GEN_186; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_188 = 7'h3c == trainIndex ? patternHistoryTable_60 : _GEN_187; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_189 = 7'h3d == trainIndex ? patternHistoryTable_61 : _GEN_188; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_190 = 7'h3e == trainIndex ? patternHistoryTable_62 : _GEN_189; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_191 = 7'h3f == trainIndex ? patternHistoryTable_63 : _GEN_190; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_192 = 7'h40 == trainIndex ? patternHistoryTable_64 : _GEN_191; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_193 = 7'h41 == trainIndex ? patternHistoryTable_65 : _GEN_192; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_194 = 7'h42 == trainIndex ? patternHistoryTable_66 : _GEN_193; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_195 = 7'h43 == trainIndex ? patternHistoryTable_67 : _GEN_194; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_196 = 7'h44 == trainIndex ? patternHistoryTable_68 : _GEN_195; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_197 = 7'h45 == trainIndex ? patternHistoryTable_69 : _GEN_196; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_198 = 7'h46 == trainIndex ? patternHistoryTable_70 : _GEN_197; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_199 = 7'h47 == trainIndex ? patternHistoryTable_71 : _GEN_198; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_200 = 7'h48 == trainIndex ? patternHistoryTable_72 : _GEN_199; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_201 = 7'h49 == trainIndex ? patternHistoryTable_73 : _GEN_200; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_202 = 7'h4a == trainIndex ? patternHistoryTable_74 : _GEN_201; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_203 = 7'h4b == trainIndex ? patternHistoryTable_75 : _GEN_202; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_204 = 7'h4c == trainIndex ? patternHistoryTable_76 : _GEN_203; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_205 = 7'h4d == trainIndex ? patternHistoryTable_77 : _GEN_204; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_206 = 7'h4e == trainIndex ? patternHistoryTable_78 : _GEN_205; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_207 = 7'h4f == trainIndex ? patternHistoryTable_79 : _GEN_206; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_208 = 7'h50 == trainIndex ? patternHistoryTable_80 : _GEN_207; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_209 = 7'h51 == trainIndex ? patternHistoryTable_81 : _GEN_208; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_210 = 7'h52 == trainIndex ? patternHistoryTable_82 : _GEN_209; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_211 = 7'h53 == trainIndex ? patternHistoryTable_83 : _GEN_210; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_212 = 7'h54 == trainIndex ? patternHistoryTable_84 : _GEN_211; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_213 = 7'h55 == trainIndex ? patternHistoryTable_85 : _GEN_212; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_214 = 7'h56 == trainIndex ? patternHistoryTable_86 : _GEN_213; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_215 = 7'h57 == trainIndex ? patternHistoryTable_87 : _GEN_214; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_216 = 7'h58 == trainIndex ? patternHistoryTable_88 : _GEN_215; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_217 = 7'h59 == trainIndex ? patternHistoryTable_89 : _GEN_216; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_218 = 7'h5a == trainIndex ? patternHistoryTable_90 : _GEN_217; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_219 = 7'h5b == trainIndex ? patternHistoryTable_91 : _GEN_218; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_220 = 7'h5c == trainIndex ? patternHistoryTable_92 : _GEN_219; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_221 = 7'h5d == trainIndex ? patternHistoryTable_93 : _GEN_220; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_222 = 7'h5e == trainIndex ? patternHistoryTable_94 : _GEN_221; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_223 = 7'h5f == trainIndex ? patternHistoryTable_95 : _GEN_222; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_224 = 7'h60 == trainIndex ? patternHistoryTable_96 : _GEN_223; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_225 = 7'h61 == trainIndex ? patternHistoryTable_97 : _GEN_224; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_226 = 7'h62 == trainIndex ? patternHistoryTable_98 : _GEN_225; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_227 = 7'h63 == trainIndex ? patternHistoryTable_99 : _GEN_226; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_228 = 7'h64 == trainIndex ? patternHistoryTable_100 : _GEN_227; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_229 = 7'h65 == trainIndex ? patternHistoryTable_101 : _GEN_228; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_230 = 7'h66 == trainIndex ? patternHistoryTable_102 : _GEN_229; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_231 = 7'h67 == trainIndex ? patternHistoryTable_103 : _GEN_230; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_232 = 7'h68 == trainIndex ? patternHistoryTable_104 : _GEN_231; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_233 = 7'h69 == trainIndex ? patternHistoryTable_105 : _GEN_232; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_234 = 7'h6a == trainIndex ? patternHistoryTable_106 : _GEN_233; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_235 = 7'h6b == trainIndex ? patternHistoryTable_107 : _GEN_234; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_236 = 7'h6c == trainIndex ? patternHistoryTable_108 : _GEN_235; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_237 = 7'h6d == trainIndex ? patternHistoryTable_109 : _GEN_236; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_238 = 7'h6e == trainIndex ? patternHistoryTable_110 : _GEN_237; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_239 = 7'h6f == trainIndex ? patternHistoryTable_111 : _GEN_238; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_240 = 7'h70 == trainIndex ? patternHistoryTable_112 : _GEN_239; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_241 = 7'h71 == trainIndex ? patternHistoryTable_113 : _GEN_240; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_242 = 7'h72 == trainIndex ? patternHistoryTable_114 : _GEN_241; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_243 = 7'h73 == trainIndex ? patternHistoryTable_115 : _GEN_242; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_244 = 7'h74 == trainIndex ? patternHistoryTable_116 : _GEN_243; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_245 = 7'h75 == trainIndex ? patternHistoryTable_117 : _GEN_244; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_246 = 7'h76 == trainIndex ? patternHistoryTable_118 : _GEN_245; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_247 = 7'h77 == trainIndex ? patternHistoryTable_119 : _GEN_246; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_248 = 7'h78 == trainIndex ? patternHistoryTable_120 : _GEN_247; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_249 = 7'h79 == trainIndex ? patternHistoryTable_121 : _GEN_248; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_250 = 7'h7a == trainIndex ? patternHistoryTable_122 : _GEN_249; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_251 = 7'h7b == trainIndex ? patternHistoryTable_123 : _GEN_250; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_252 = 7'h7c == trainIndex ? patternHistoryTable_124 : _GEN_251; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_253 = 7'h7d == trainIndex ? patternHistoryTable_125 : _GEN_252; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_254 = 7'h7e == trainIndex ? patternHistoryTable_126 : _GEN_253; // @[dut.scala 46:{19,19}]
  wire [1:0] _GEN_255 = 7'h7f == trainIndex ? patternHistoryTable_127 : _GEN_254; // @[dut.scala 46:{19,19}]
  wire [1:0] _updatedCounter_T_2 = _GEN_255 + 2'h1; // @[dut.scala 46:41]
  wire [1:0] _updatedCounter_T_3 = _GEN_255 == 2'h3 ? 2'h3 : _updatedCounter_T_2; // @[dut.scala 46:10]
  wire [1:0] _updatedCounter_T_6 = _GEN_255 - 2'h1; // @[dut.scala 47:41]
  wire [1:0] _updatedCounter_T_7 = _GEN_255 == 2'h0 ? 2'h0 : _updatedCounter_T_6; // @[dut.scala 47:10]
  wire [1:0] updatedCounter = io_train_taken ? _updatedCounter_T_3 : _updatedCounter_T_7; // @[dut.scala 45:29]
  wire [6:0] _globalHistory_T_1 = {globalHistory[5:0],io_train_taken}; // @[Cat.scala 33:92]
  wire [6:0] _globalHistory_T_3 = {globalHistory[5:0],io_predict_taken}; // @[Cat.scala 33:92]
  assign io_predict_taken = _GEN_127[1]; // @[dut.scala 37:40]
  assign io_predict_history = globalHistory; // @[dut.scala 38:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 24:30]
      globalHistory <= 7'h0; // @[dut.scala 24:30]
    end else if (io_reset) begin // @[dut.scala 62:18]
      globalHistory <= 7'h0; // @[dut.scala 63:19]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (io_train_mispredicted) begin // @[dut.scala 52:33]
        globalHistory <= io_train_history; // @[dut.scala 53:21]
      end else begin
        globalHistory <= _globalHistory_T_1; // @[dut.scala 55:21]
      end
    end else if (io_predict_valid) begin // @[dut.scala 57:32]
      globalHistory <= _globalHistory_T_3; // @[dut.scala 58:19]
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_0 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_0 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h0 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_0 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_1 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_1 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_1 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_2 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_2 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_2 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_3 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_3 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_3 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_4 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_4 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_4 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_5 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_5 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_5 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_6 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_6 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_6 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_7 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_7 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_7 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_8 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_8 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h8 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_8 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_9 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_9 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h9 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_9 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_10 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_10 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'ha == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_10 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_11 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_11 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'hb == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_11 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_12 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_12 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'hc == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_12 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_13 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_13 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'hd == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_13 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_14 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_14 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'he == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_14 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_15 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_15 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'hf == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_15 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_16 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_16 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h10 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_16 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_17 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_17 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h11 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_17 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_18 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_18 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h12 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_18 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_19 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_19 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h13 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_19 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_20 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_20 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h14 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_20 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_21 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_21 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h15 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_21 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_22 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_22 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h16 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_22 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_23 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_23 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h17 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_23 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_24 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_24 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h18 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_24 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_25 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_25 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h19 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_25 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_26 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_26 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_26 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_27 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_27 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_27 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_28 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_28 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_28 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_29 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_29 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_29 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_30 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_30 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_30 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_31 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_31 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h1f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_31 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_32 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_32 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h20 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_32 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_33 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_33 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h21 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_33 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_34 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_34 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h22 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_34 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_35 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_35 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h23 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_35 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_36 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_36 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h24 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_36 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_37 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_37 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h25 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_37 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_38 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_38 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h26 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_38 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_39 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_39 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h27 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_39 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_40 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_40 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h28 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_40 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_41 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_41 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h29 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_41 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_42 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_42 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_42 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_43 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_43 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_43 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_44 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_44 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_44 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_45 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_45 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_45 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_46 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_46 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_46 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_47 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_47 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h2f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_47 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_48 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_48 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h30 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_48 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_49 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_49 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h31 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_49 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_50 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_50 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h32 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_50 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_51 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_51 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h33 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_51 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_52 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_52 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h34 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_52 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_53 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_53 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h35 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_53 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_54 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_54 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h36 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_54 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_55 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_55 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h37 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_55 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_56 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_56 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h38 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_56 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_57 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_57 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h39 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_57 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_58 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_58 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_58 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_59 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_59 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_59 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_60 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_60 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_60 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_61 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_61 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_61 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_62 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_62 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_62 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_63 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_63 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h3f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_63 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_64 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_64 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h40 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_64 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_65 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_65 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h41 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_65 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_66 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_66 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h42 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_66 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_67 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_67 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h43 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_67 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_68 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_68 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h44 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_68 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_69 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_69 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h45 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_69 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_70 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_70 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h46 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_70 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_71 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_71 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h47 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_71 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_72 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_72 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h48 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_72 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_73 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_73 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h49 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_73 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_74 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_74 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_74 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_75 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_75 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_75 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_76 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_76 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_76 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_77 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_77 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_77 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_78 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_78 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_78 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_79 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_79 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h4f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_79 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_80 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_80 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h50 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_80 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_81 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_81 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h51 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_81 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_82 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_82 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h52 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_82 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_83 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_83 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h53 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_83 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_84 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_84 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h54 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_84 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_85 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_85 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h55 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_85 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_86 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_86 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h56 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_86 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_87 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_87 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h57 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_87 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_88 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_88 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h58 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_88 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_89 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_89 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h59 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_89 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_90 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_90 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_90 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_91 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_91 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_91 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_92 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_92 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_92 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_93 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_93 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_93 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_94 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_94 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_94 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_95 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_95 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h5f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_95 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_96 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_96 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h60 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_96 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_97 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_97 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h61 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_97 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_98 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_98 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h62 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_98 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_99 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_99 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h63 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_99 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_100 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_100 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h64 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_100 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_101 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_101 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h65 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_101 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_102 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_102 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h66 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_102 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_103 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_103 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h67 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_103 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_104 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_104 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h68 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_104 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_105 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_105 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h69 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_105 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_106 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_106 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_106 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_107 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_107 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_107 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_108 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_108 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_108 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_109 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_109 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_109 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_110 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_110 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_110 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_111 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_111 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h6f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_111 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_112 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_112 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h70 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_112 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_113 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_113 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h71 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_113 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_114 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_114 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h72 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_114 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_115 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_115 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h73 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_115 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_116 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_116 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h74 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_116 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_117 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_117 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h75 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_117 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_118 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_118 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h76 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_118 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_119 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_119 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h77 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_119 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_120 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_120 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h78 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_120 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_121 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_121 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h79 == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_121 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_122 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_122 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7a == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_122 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_123 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_123 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7b == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_123 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_124 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_124 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7c == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_124 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_125 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_125 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7d == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_125 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_126 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_126 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7e == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_126 <= updatedCounter; // @[dut.scala 49:37]
      end
    end
    if (reset) begin // @[dut.scala 27:36]
      patternHistoryTable_127 <= 2'h1; // @[dut.scala 27:36]
    end else if (io_reset) begin // @[dut.scala 62:18]
      patternHistoryTable_127 <= 2'h1; // @[dut.scala 65:30]
    end else if (io_train_valid) begin // @[dut.scala 43:24]
      if (7'h7f == trainIndex) begin // @[dut.scala 49:37]
        patternHistoryTable_127 <= updatedCounter; // @[dut.scala 49:37]
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
  globalHistory = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  patternHistoryTable_0 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  patternHistoryTable_1 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  patternHistoryTable_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  patternHistoryTable_3 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  patternHistoryTable_4 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  patternHistoryTable_5 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  patternHistoryTable_6 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  patternHistoryTable_7 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  patternHistoryTable_8 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  patternHistoryTable_9 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  patternHistoryTable_10 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  patternHistoryTable_11 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  patternHistoryTable_12 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  patternHistoryTable_13 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  patternHistoryTable_14 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  patternHistoryTable_15 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  patternHistoryTable_16 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  patternHistoryTable_17 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  patternHistoryTable_18 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  patternHistoryTable_19 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  patternHistoryTable_20 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  patternHistoryTable_21 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  patternHistoryTable_22 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  patternHistoryTable_23 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  patternHistoryTable_24 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  patternHistoryTable_25 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  patternHistoryTable_26 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  patternHistoryTable_27 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  patternHistoryTable_28 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  patternHistoryTable_29 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  patternHistoryTable_30 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  patternHistoryTable_31 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  patternHistoryTable_32 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  patternHistoryTable_33 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  patternHistoryTable_34 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  patternHistoryTable_35 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  patternHistoryTable_36 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  patternHistoryTable_37 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  patternHistoryTable_38 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  patternHistoryTable_39 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  patternHistoryTable_40 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  patternHistoryTable_41 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  patternHistoryTable_42 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  patternHistoryTable_43 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  patternHistoryTable_44 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  patternHistoryTable_45 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  patternHistoryTable_46 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  patternHistoryTable_47 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  patternHistoryTable_48 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  patternHistoryTable_49 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  patternHistoryTable_50 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  patternHistoryTable_51 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  patternHistoryTable_52 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  patternHistoryTable_53 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  patternHistoryTable_54 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  patternHistoryTable_55 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  patternHistoryTable_56 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  patternHistoryTable_57 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  patternHistoryTable_58 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  patternHistoryTable_59 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  patternHistoryTable_60 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  patternHistoryTable_61 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  patternHistoryTable_62 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  patternHistoryTable_63 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  patternHistoryTable_64 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  patternHistoryTable_65 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  patternHistoryTable_66 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  patternHistoryTable_67 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  patternHistoryTable_68 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  patternHistoryTable_69 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  patternHistoryTable_70 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  patternHistoryTable_71 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  patternHistoryTable_72 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  patternHistoryTable_73 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  patternHistoryTable_74 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  patternHistoryTable_75 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  patternHistoryTable_76 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  patternHistoryTable_77 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  patternHistoryTable_78 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  patternHistoryTable_79 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  patternHistoryTable_80 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  patternHistoryTable_81 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  patternHistoryTable_82 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  patternHistoryTable_83 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  patternHistoryTable_84 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  patternHistoryTable_85 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  patternHistoryTable_86 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  patternHistoryTable_87 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  patternHistoryTable_88 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  patternHistoryTable_89 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  patternHistoryTable_90 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  patternHistoryTable_91 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  patternHistoryTable_92 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  patternHistoryTable_93 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  patternHistoryTable_94 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  patternHistoryTable_95 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  patternHistoryTable_96 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  patternHistoryTable_97 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  patternHistoryTable_98 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  patternHistoryTable_99 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  patternHistoryTable_100 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  patternHistoryTable_101 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  patternHistoryTable_102 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  patternHistoryTable_103 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  patternHistoryTable_104 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  patternHistoryTable_105 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  patternHistoryTable_106 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  patternHistoryTable_107 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  patternHistoryTable_108 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  patternHistoryTable_109 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  patternHistoryTable_110 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  patternHistoryTable_111 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  patternHistoryTable_112 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  patternHistoryTable_113 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  patternHistoryTable_114 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  patternHistoryTable_115 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  patternHistoryTable_116 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  patternHistoryTable_117 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  patternHistoryTable_118 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  patternHistoryTable_119 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  patternHistoryTable_120 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  patternHistoryTable_121 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  patternHistoryTable_122 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  patternHistoryTable_123 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  patternHistoryTable_124 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  patternHistoryTable_125 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  patternHistoryTable_126 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  patternHistoryTable_127 = _RAND_128[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
