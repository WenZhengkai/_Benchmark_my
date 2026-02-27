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
  reg [6:0] globalHistoryReg; // @[dut.scala 23:33]
  reg [1:0] pht_0; // @[dut.scala 26:20]
  reg [1:0] pht_1; // @[dut.scala 26:20]
  reg [1:0] pht_2; // @[dut.scala 26:20]
  reg [1:0] pht_3; // @[dut.scala 26:20]
  reg [1:0] pht_4; // @[dut.scala 26:20]
  reg [1:0] pht_5; // @[dut.scala 26:20]
  reg [1:0] pht_6; // @[dut.scala 26:20]
  reg [1:0] pht_7; // @[dut.scala 26:20]
  reg [1:0] pht_8; // @[dut.scala 26:20]
  reg [1:0] pht_9; // @[dut.scala 26:20]
  reg [1:0] pht_10; // @[dut.scala 26:20]
  reg [1:0] pht_11; // @[dut.scala 26:20]
  reg [1:0] pht_12; // @[dut.scala 26:20]
  reg [1:0] pht_13; // @[dut.scala 26:20]
  reg [1:0] pht_14; // @[dut.scala 26:20]
  reg [1:0] pht_15; // @[dut.scala 26:20]
  reg [1:0] pht_16; // @[dut.scala 26:20]
  reg [1:0] pht_17; // @[dut.scala 26:20]
  reg [1:0] pht_18; // @[dut.scala 26:20]
  reg [1:0] pht_19; // @[dut.scala 26:20]
  reg [1:0] pht_20; // @[dut.scala 26:20]
  reg [1:0] pht_21; // @[dut.scala 26:20]
  reg [1:0] pht_22; // @[dut.scala 26:20]
  reg [1:0] pht_23; // @[dut.scala 26:20]
  reg [1:0] pht_24; // @[dut.scala 26:20]
  reg [1:0] pht_25; // @[dut.scala 26:20]
  reg [1:0] pht_26; // @[dut.scala 26:20]
  reg [1:0] pht_27; // @[dut.scala 26:20]
  reg [1:0] pht_28; // @[dut.scala 26:20]
  reg [1:0] pht_29; // @[dut.scala 26:20]
  reg [1:0] pht_30; // @[dut.scala 26:20]
  reg [1:0] pht_31; // @[dut.scala 26:20]
  reg [1:0] pht_32; // @[dut.scala 26:20]
  reg [1:0] pht_33; // @[dut.scala 26:20]
  reg [1:0] pht_34; // @[dut.scala 26:20]
  reg [1:0] pht_35; // @[dut.scala 26:20]
  reg [1:0] pht_36; // @[dut.scala 26:20]
  reg [1:0] pht_37; // @[dut.scala 26:20]
  reg [1:0] pht_38; // @[dut.scala 26:20]
  reg [1:0] pht_39; // @[dut.scala 26:20]
  reg [1:0] pht_40; // @[dut.scala 26:20]
  reg [1:0] pht_41; // @[dut.scala 26:20]
  reg [1:0] pht_42; // @[dut.scala 26:20]
  reg [1:0] pht_43; // @[dut.scala 26:20]
  reg [1:0] pht_44; // @[dut.scala 26:20]
  reg [1:0] pht_45; // @[dut.scala 26:20]
  reg [1:0] pht_46; // @[dut.scala 26:20]
  reg [1:0] pht_47; // @[dut.scala 26:20]
  reg [1:0] pht_48; // @[dut.scala 26:20]
  reg [1:0] pht_49; // @[dut.scala 26:20]
  reg [1:0] pht_50; // @[dut.scala 26:20]
  reg [1:0] pht_51; // @[dut.scala 26:20]
  reg [1:0] pht_52; // @[dut.scala 26:20]
  reg [1:0] pht_53; // @[dut.scala 26:20]
  reg [1:0] pht_54; // @[dut.scala 26:20]
  reg [1:0] pht_55; // @[dut.scala 26:20]
  reg [1:0] pht_56; // @[dut.scala 26:20]
  reg [1:0] pht_57; // @[dut.scala 26:20]
  reg [1:0] pht_58; // @[dut.scala 26:20]
  reg [1:0] pht_59; // @[dut.scala 26:20]
  reg [1:0] pht_60; // @[dut.scala 26:20]
  reg [1:0] pht_61; // @[dut.scala 26:20]
  reg [1:0] pht_62; // @[dut.scala 26:20]
  reg [1:0] pht_63; // @[dut.scala 26:20]
  reg [1:0] pht_64; // @[dut.scala 26:20]
  reg [1:0] pht_65; // @[dut.scala 26:20]
  reg [1:0] pht_66; // @[dut.scala 26:20]
  reg [1:0] pht_67; // @[dut.scala 26:20]
  reg [1:0] pht_68; // @[dut.scala 26:20]
  reg [1:0] pht_69; // @[dut.scala 26:20]
  reg [1:0] pht_70; // @[dut.scala 26:20]
  reg [1:0] pht_71; // @[dut.scala 26:20]
  reg [1:0] pht_72; // @[dut.scala 26:20]
  reg [1:0] pht_73; // @[dut.scala 26:20]
  reg [1:0] pht_74; // @[dut.scala 26:20]
  reg [1:0] pht_75; // @[dut.scala 26:20]
  reg [1:0] pht_76; // @[dut.scala 26:20]
  reg [1:0] pht_77; // @[dut.scala 26:20]
  reg [1:0] pht_78; // @[dut.scala 26:20]
  reg [1:0] pht_79; // @[dut.scala 26:20]
  reg [1:0] pht_80; // @[dut.scala 26:20]
  reg [1:0] pht_81; // @[dut.scala 26:20]
  reg [1:0] pht_82; // @[dut.scala 26:20]
  reg [1:0] pht_83; // @[dut.scala 26:20]
  reg [1:0] pht_84; // @[dut.scala 26:20]
  reg [1:0] pht_85; // @[dut.scala 26:20]
  reg [1:0] pht_86; // @[dut.scala 26:20]
  reg [1:0] pht_87; // @[dut.scala 26:20]
  reg [1:0] pht_88; // @[dut.scala 26:20]
  reg [1:0] pht_89; // @[dut.scala 26:20]
  reg [1:0] pht_90; // @[dut.scala 26:20]
  reg [1:0] pht_91; // @[dut.scala 26:20]
  reg [1:0] pht_92; // @[dut.scala 26:20]
  reg [1:0] pht_93; // @[dut.scala 26:20]
  reg [1:0] pht_94; // @[dut.scala 26:20]
  reg [1:0] pht_95; // @[dut.scala 26:20]
  reg [1:0] pht_96; // @[dut.scala 26:20]
  reg [1:0] pht_97; // @[dut.scala 26:20]
  reg [1:0] pht_98; // @[dut.scala 26:20]
  reg [1:0] pht_99; // @[dut.scala 26:20]
  reg [1:0] pht_100; // @[dut.scala 26:20]
  reg [1:0] pht_101; // @[dut.scala 26:20]
  reg [1:0] pht_102; // @[dut.scala 26:20]
  reg [1:0] pht_103; // @[dut.scala 26:20]
  reg [1:0] pht_104; // @[dut.scala 26:20]
  reg [1:0] pht_105; // @[dut.scala 26:20]
  reg [1:0] pht_106; // @[dut.scala 26:20]
  reg [1:0] pht_107; // @[dut.scala 26:20]
  reg [1:0] pht_108; // @[dut.scala 26:20]
  reg [1:0] pht_109; // @[dut.scala 26:20]
  reg [1:0] pht_110; // @[dut.scala 26:20]
  reg [1:0] pht_111; // @[dut.scala 26:20]
  reg [1:0] pht_112; // @[dut.scala 26:20]
  reg [1:0] pht_113; // @[dut.scala 26:20]
  reg [1:0] pht_114; // @[dut.scala 26:20]
  reg [1:0] pht_115; // @[dut.scala 26:20]
  reg [1:0] pht_116; // @[dut.scala 26:20]
  reg [1:0] pht_117; // @[dut.scala 26:20]
  reg [1:0] pht_118; // @[dut.scala 26:20]
  reg [1:0] pht_119; // @[dut.scala 26:20]
  reg [1:0] pht_120; // @[dut.scala 26:20]
  reg [1:0] pht_121; // @[dut.scala 26:20]
  reg [1:0] pht_122; // @[dut.scala 26:20]
  reg [1:0] pht_123; // @[dut.scala 26:20]
  reg [1:0] pht_124; // @[dut.scala 26:20]
  reg [1:0] pht_125; // @[dut.scala 26:20]
  reg [1:0] pht_126; // @[dut.scala 26:20]
  reg [1:0] pht_127; // @[dut.scala 26:20]
  wire [6:0] predictIndex = io_predict_pc ^ globalHistoryReg; // @[dut.scala 30:8]
  wire [1:0] _GEN_1 = 7'h1 == predictIndex ? pht_1 : pht_0; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_2 = 7'h2 == predictIndex ? pht_2 : _GEN_1; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_3 = 7'h3 == predictIndex ? pht_3 : _GEN_2; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_4 = 7'h4 == predictIndex ? pht_4 : _GEN_3; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_5 = 7'h5 == predictIndex ? pht_5 : _GEN_4; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_6 = 7'h6 == predictIndex ? pht_6 : _GEN_5; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_7 = 7'h7 == predictIndex ? pht_7 : _GEN_6; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_8 = 7'h8 == predictIndex ? pht_8 : _GEN_7; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_9 = 7'h9 == predictIndex ? pht_9 : _GEN_8; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_10 = 7'ha == predictIndex ? pht_10 : _GEN_9; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_11 = 7'hb == predictIndex ? pht_11 : _GEN_10; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_12 = 7'hc == predictIndex ? pht_12 : _GEN_11; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_13 = 7'hd == predictIndex ? pht_13 : _GEN_12; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_14 = 7'he == predictIndex ? pht_14 : _GEN_13; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_15 = 7'hf == predictIndex ? pht_15 : _GEN_14; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_16 = 7'h10 == predictIndex ? pht_16 : _GEN_15; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_17 = 7'h11 == predictIndex ? pht_17 : _GEN_16; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_18 = 7'h12 == predictIndex ? pht_18 : _GEN_17; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_19 = 7'h13 == predictIndex ? pht_19 : _GEN_18; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_20 = 7'h14 == predictIndex ? pht_20 : _GEN_19; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_21 = 7'h15 == predictIndex ? pht_21 : _GEN_20; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_22 = 7'h16 == predictIndex ? pht_22 : _GEN_21; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_23 = 7'h17 == predictIndex ? pht_23 : _GEN_22; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_24 = 7'h18 == predictIndex ? pht_24 : _GEN_23; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_25 = 7'h19 == predictIndex ? pht_25 : _GEN_24; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_26 = 7'h1a == predictIndex ? pht_26 : _GEN_25; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_27 = 7'h1b == predictIndex ? pht_27 : _GEN_26; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_28 = 7'h1c == predictIndex ? pht_28 : _GEN_27; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_29 = 7'h1d == predictIndex ? pht_29 : _GEN_28; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_30 = 7'h1e == predictIndex ? pht_30 : _GEN_29; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_31 = 7'h1f == predictIndex ? pht_31 : _GEN_30; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_32 = 7'h20 == predictIndex ? pht_32 : _GEN_31; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_33 = 7'h21 == predictIndex ? pht_33 : _GEN_32; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_34 = 7'h22 == predictIndex ? pht_34 : _GEN_33; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_35 = 7'h23 == predictIndex ? pht_35 : _GEN_34; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_36 = 7'h24 == predictIndex ? pht_36 : _GEN_35; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_37 = 7'h25 == predictIndex ? pht_37 : _GEN_36; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_38 = 7'h26 == predictIndex ? pht_38 : _GEN_37; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_39 = 7'h27 == predictIndex ? pht_39 : _GEN_38; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_40 = 7'h28 == predictIndex ? pht_40 : _GEN_39; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_41 = 7'h29 == predictIndex ? pht_41 : _GEN_40; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_42 = 7'h2a == predictIndex ? pht_42 : _GEN_41; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_43 = 7'h2b == predictIndex ? pht_43 : _GEN_42; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_44 = 7'h2c == predictIndex ? pht_44 : _GEN_43; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_45 = 7'h2d == predictIndex ? pht_45 : _GEN_44; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_46 = 7'h2e == predictIndex ? pht_46 : _GEN_45; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_47 = 7'h2f == predictIndex ? pht_47 : _GEN_46; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_48 = 7'h30 == predictIndex ? pht_48 : _GEN_47; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_49 = 7'h31 == predictIndex ? pht_49 : _GEN_48; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_50 = 7'h32 == predictIndex ? pht_50 : _GEN_49; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_51 = 7'h33 == predictIndex ? pht_51 : _GEN_50; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_52 = 7'h34 == predictIndex ? pht_52 : _GEN_51; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_53 = 7'h35 == predictIndex ? pht_53 : _GEN_52; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_54 = 7'h36 == predictIndex ? pht_54 : _GEN_53; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_55 = 7'h37 == predictIndex ? pht_55 : _GEN_54; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_56 = 7'h38 == predictIndex ? pht_56 : _GEN_55; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_57 = 7'h39 == predictIndex ? pht_57 : _GEN_56; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_58 = 7'h3a == predictIndex ? pht_58 : _GEN_57; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_59 = 7'h3b == predictIndex ? pht_59 : _GEN_58; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_60 = 7'h3c == predictIndex ? pht_60 : _GEN_59; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_61 = 7'h3d == predictIndex ? pht_61 : _GEN_60; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_62 = 7'h3e == predictIndex ? pht_62 : _GEN_61; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_63 = 7'h3f == predictIndex ? pht_63 : _GEN_62; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_64 = 7'h40 == predictIndex ? pht_64 : _GEN_63; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_65 = 7'h41 == predictIndex ? pht_65 : _GEN_64; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_66 = 7'h42 == predictIndex ? pht_66 : _GEN_65; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_67 = 7'h43 == predictIndex ? pht_67 : _GEN_66; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_68 = 7'h44 == predictIndex ? pht_68 : _GEN_67; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_69 = 7'h45 == predictIndex ? pht_69 : _GEN_68; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_70 = 7'h46 == predictIndex ? pht_70 : _GEN_69; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_71 = 7'h47 == predictIndex ? pht_71 : _GEN_70; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_72 = 7'h48 == predictIndex ? pht_72 : _GEN_71; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_73 = 7'h49 == predictIndex ? pht_73 : _GEN_72; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_74 = 7'h4a == predictIndex ? pht_74 : _GEN_73; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_75 = 7'h4b == predictIndex ? pht_75 : _GEN_74; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_76 = 7'h4c == predictIndex ? pht_76 : _GEN_75; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_77 = 7'h4d == predictIndex ? pht_77 : _GEN_76; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_78 = 7'h4e == predictIndex ? pht_78 : _GEN_77; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_79 = 7'h4f == predictIndex ? pht_79 : _GEN_78; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_80 = 7'h50 == predictIndex ? pht_80 : _GEN_79; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_81 = 7'h51 == predictIndex ? pht_81 : _GEN_80; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_82 = 7'h52 == predictIndex ? pht_82 : _GEN_81; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_83 = 7'h53 == predictIndex ? pht_83 : _GEN_82; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_84 = 7'h54 == predictIndex ? pht_84 : _GEN_83; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_85 = 7'h55 == predictIndex ? pht_85 : _GEN_84; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_86 = 7'h56 == predictIndex ? pht_86 : _GEN_85; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_87 = 7'h57 == predictIndex ? pht_87 : _GEN_86; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_88 = 7'h58 == predictIndex ? pht_88 : _GEN_87; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_89 = 7'h59 == predictIndex ? pht_89 : _GEN_88; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_90 = 7'h5a == predictIndex ? pht_90 : _GEN_89; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_91 = 7'h5b == predictIndex ? pht_91 : _GEN_90; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_92 = 7'h5c == predictIndex ? pht_92 : _GEN_91; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_93 = 7'h5d == predictIndex ? pht_93 : _GEN_92; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_94 = 7'h5e == predictIndex ? pht_94 : _GEN_93; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_95 = 7'h5f == predictIndex ? pht_95 : _GEN_94; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_96 = 7'h60 == predictIndex ? pht_96 : _GEN_95; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_97 = 7'h61 == predictIndex ? pht_97 : _GEN_96; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_98 = 7'h62 == predictIndex ? pht_98 : _GEN_97; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_99 = 7'h63 == predictIndex ? pht_99 : _GEN_98; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_100 = 7'h64 == predictIndex ? pht_100 : _GEN_99; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_101 = 7'h65 == predictIndex ? pht_101 : _GEN_100; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_102 = 7'h66 == predictIndex ? pht_102 : _GEN_101; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_103 = 7'h67 == predictIndex ? pht_103 : _GEN_102; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_104 = 7'h68 == predictIndex ? pht_104 : _GEN_103; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_105 = 7'h69 == predictIndex ? pht_105 : _GEN_104; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_106 = 7'h6a == predictIndex ? pht_106 : _GEN_105; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_107 = 7'h6b == predictIndex ? pht_107 : _GEN_106; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_108 = 7'h6c == predictIndex ? pht_108 : _GEN_107; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_109 = 7'h6d == predictIndex ? pht_109 : _GEN_108; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_110 = 7'h6e == predictIndex ? pht_110 : _GEN_109; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_111 = 7'h6f == predictIndex ? pht_111 : _GEN_110; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_112 = 7'h70 == predictIndex ? pht_112 : _GEN_111; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_113 = 7'h71 == predictIndex ? pht_113 : _GEN_112; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_114 = 7'h72 == predictIndex ? pht_114 : _GEN_113; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_115 = 7'h73 == predictIndex ? pht_115 : _GEN_114; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_116 = 7'h74 == predictIndex ? pht_116 : _GEN_115; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_117 = 7'h75 == predictIndex ? pht_117 : _GEN_116; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_118 = 7'h76 == predictIndex ? pht_118 : _GEN_117; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_119 = 7'h77 == predictIndex ? pht_119 : _GEN_118; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_120 = 7'h78 == predictIndex ? pht_120 : _GEN_119; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_121 = 7'h79 == predictIndex ? pht_121 : _GEN_120; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_122 = 7'h7a == predictIndex ? pht_122 : _GEN_121; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_123 = 7'h7b == predictIndex ? pht_123 : _GEN_122; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_124 = 7'h7c == predictIndex ? pht_124 : _GEN_123; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_125 = 7'h7d == predictIndex ? pht_125 : _GEN_124; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_126 = 7'h7e == predictIndex ? pht_126 : _GEN_125; // @[dut.scala 35:{62,62}]
  wire [1:0] _GEN_127 = 7'h7f == predictIndex ? pht_127 : _GEN_126; // @[dut.scala 35:{62,62}]
  wire [6:0] trainIndex = io_train_pc ^ io_train_history; // @[dut.scala 30:8]
  wire [1:0] _GEN_129 = 7'h1 == trainIndex ? pht_1 : pht_0; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_130 = 7'h2 == trainIndex ? pht_2 : _GEN_129; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_131 = 7'h3 == trainIndex ? pht_3 : _GEN_130; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_132 = 7'h4 == trainIndex ? pht_4 : _GEN_131; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_133 = 7'h5 == trainIndex ? pht_5 : _GEN_132; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_134 = 7'h6 == trainIndex ? pht_6 : _GEN_133; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_135 = 7'h7 == trainIndex ? pht_7 : _GEN_134; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_136 = 7'h8 == trainIndex ? pht_8 : _GEN_135; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_137 = 7'h9 == trainIndex ? pht_9 : _GEN_136; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_138 = 7'ha == trainIndex ? pht_10 : _GEN_137; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_139 = 7'hb == trainIndex ? pht_11 : _GEN_138; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_140 = 7'hc == trainIndex ? pht_12 : _GEN_139; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_141 = 7'hd == trainIndex ? pht_13 : _GEN_140; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_142 = 7'he == trainIndex ? pht_14 : _GEN_141; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_143 = 7'hf == trainIndex ? pht_15 : _GEN_142; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_144 = 7'h10 == trainIndex ? pht_16 : _GEN_143; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_145 = 7'h11 == trainIndex ? pht_17 : _GEN_144; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_146 = 7'h12 == trainIndex ? pht_18 : _GEN_145; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_147 = 7'h13 == trainIndex ? pht_19 : _GEN_146; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_148 = 7'h14 == trainIndex ? pht_20 : _GEN_147; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_149 = 7'h15 == trainIndex ? pht_21 : _GEN_148; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_150 = 7'h16 == trainIndex ? pht_22 : _GEN_149; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_151 = 7'h17 == trainIndex ? pht_23 : _GEN_150; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_152 = 7'h18 == trainIndex ? pht_24 : _GEN_151; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_153 = 7'h19 == trainIndex ? pht_25 : _GEN_152; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_154 = 7'h1a == trainIndex ? pht_26 : _GEN_153; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_155 = 7'h1b == trainIndex ? pht_27 : _GEN_154; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_156 = 7'h1c == trainIndex ? pht_28 : _GEN_155; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_157 = 7'h1d == trainIndex ? pht_29 : _GEN_156; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_158 = 7'h1e == trainIndex ? pht_30 : _GEN_157; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_159 = 7'h1f == trainIndex ? pht_31 : _GEN_158; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_160 = 7'h20 == trainIndex ? pht_32 : _GEN_159; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_161 = 7'h21 == trainIndex ? pht_33 : _GEN_160; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_162 = 7'h22 == trainIndex ? pht_34 : _GEN_161; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_163 = 7'h23 == trainIndex ? pht_35 : _GEN_162; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_164 = 7'h24 == trainIndex ? pht_36 : _GEN_163; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_165 = 7'h25 == trainIndex ? pht_37 : _GEN_164; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_166 = 7'h26 == trainIndex ? pht_38 : _GEN_165; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_167 = 7'h27 == trainIndex ? pht_39 : _GEN_166; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_168 = 7'h28 == trainIndex ? pht_40 : _GEN_167; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_169 = 7'h29 == trainIndex ? pht_41 : _GEN_168; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_170 = 7'h2a == trainIndex ? pht_42 : _GEN_169; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_171 = 7'h2b == trainIndex ? pht_43 : _GEN_170; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_172 = 7'h2c == trainIndex ? pht_44 : _GEN_171; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_173 = 7'h2d == trainIndex ? pht_45 : _GEN_172; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_174 = 7'h2e == trainIndex ? pht_46 : _GEN_173; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_175 = 7'h2f == trainIndex ? pht_47 : _GEN_174; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_176 = 7'h30 == trainIndex ? pht_48 : _GEN_175; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_177 = 7'h31 == trainIndex ? pht_49 : _GEN_176; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_178 = 7'h32 == trainIndex ? pht_50 : _GEN_177; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_179 = 7'h33 == trainIndex ? pht_51 : _GEN_178; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_180 = 7'h34 == trainIndex ? pht_52 : _GEN_179; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_181 = 7'h35 == trainIndex ? pht_53 : _GEN_180; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_182 = 7'h36 == trainIndex ? pht_54 : _GEN_181; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_183 = 7'h37 == trainIndex ? pht_55 : _GEN_182; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_184 = 7'h38 == trainIndex ? pht_56 : _GEN_183; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_185 = 7'h39 == trainIndex ? pht_57 : _GEN_184; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_186 = 7'h3a == trainIndex ? pht_58 : _GEN_185; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_187 = 7'h3b == trainIndex ? pht_59 : _GEN_186; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_188 = 7'h3c == trainIndex ? pht_60 : _GEN_187; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_189 = 7'h3d == trainIndex ? pht_61 : _GEN_188; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_190 = 7'h3e == trainIndex ? pht_62 : _GEN_189; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_191 = 7'h3f == trainIndex ? pht_63 : _GEN_190; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_192 = 7'h40 == trainIndex ? pht_64 : _GEN_191; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_193 = 7'h41 == trainIndex ? pht_65 : _GEN_192; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_194 = 7'h42 == trainIndex ? pht_66 : _GEN_193; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_195 = 7'h43 == trainIndex ? pht_67 : _GEN_194; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_196 = 7'h44 == trainIndex ? pht_68 : _GEN_195; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_197 = 7'h45 == trainIndex ? pht_69 : _GEN_196; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_198 = 7'h46 == trainIndex ? pht_70 : _GEN_197; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_199 = 7'h47 == trainIndex ? pht_71 : _GEN_198; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_200 = 7'h48 == trainIndex ? pht_72 : _GEN_199; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_201 = 7'h49 == trainIndex ? pht_73 : _GEN_200; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_202 = 7'h4a == trainIndex ? pht_74 : _GEN_201; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_203 = 7'h4b == trainIndex ? pht_75 : _GEN_202; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_204 = 7'h4c == trainIndex ? pht_76 : _GEN_203; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_205 = 7'h4d == trainIndex ? pht_77 : _GEN_204; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_206 = 7'h4e == trainIndex ? pht_78 : _GEN_205; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_207 = 7'h4f == trainIndex ? pht_79 : _GEN_206; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_208 = 7'h50 == trainIndex ? pht_80 : _GEN_207; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_209 = 7'h51 == trainIndex ? pht_81 : _GEN_208; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_210 = 7'h52 == trainIndex ? pht_82 : _GEN_209; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_211 = 7'h53 == trainIndex ? pht_83 : _GEN_210; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_212 = 7'h54 == trainIndex ? pht_84 : _GEN_211; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_213 = 7'h55 == trainIndex ? pht_85 : _GEN_212; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_214 = 7'h56 == trainIndex ? pht_86 : _GEN_213; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_215 = 7'h57 == trainIndex ? pht_87 : _GEN_214; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_216 = 7'h58 == trainIndex ? pht_88 : _GEN_215; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_217 = 7'h59 == trainIndex ? pht_89 : _GEN_216; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_218 = 7'h5a == trainIndex ? pht_90 : _GEN_217; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_219 = 7'h5b == trainIndex ? pht_91 : _GEN_218; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_220 = 7'h5c == trainIndex ? pht_92 : _GEN_219; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_221 = 7'h5d == trainIndex ? pht_93 : _GEN_220; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_222 = 7'h5e == trainIndex ? pht_94 : _GEN_221; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_223 = 7'h5f == trainIndex ? pht_95 : _GEN_222; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_224 = 7'h60 == trainIndex ? pht_96 : _GEN_223; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_225 = 7'h61 == trainIndex ? pht_97 : _GEN_224; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_226 = 7'h62 == trainIndex ? pht_98 : _GEN_225; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_227 = 7'h63 == trainIndex ? pht_99 : _GEN_226; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_228 = 7'h64 == trainIndex ? pht_100 : _GEN_227; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_229 = 7'h65 == trainIndex ? pht_101 : _GEN_228; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_230 = 7'h66 == trainIndex ? pht_102 : _GEN_229; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_231 = 7'h67 == trainIndex ? pht_103 : _GEN_230; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_232 = 7'h68 == trainIndex ? pht_104 : _GEN_231; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_233 = 7'h69 == trainIndex ? pht_105 : _GEN_232; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_234 = 7'h6a == trainIndex ? pht_106 : _GEN_233; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_235 = 7'h6b == trainIndex ? pht_107 : _GEN_234; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_236 = 7'h6c == trainIndex ? pht_108 : _GEN_235; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_237 = 7'h6d == trainIndex ? pht_109 : _GEN_236; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_238 = 7'h6e == trainIndex ? pht_110 : _GEN_237; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_239 = 7'h6f == trainIndex ? pht_111 : _GEN_238; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_240 = 7'h70 == trainIndex ? pht_112 : _GEN_239; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_241 = 7'h71 == trainIndex ? pht_113 : _GEN_240; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_242 = 7'h72 == trainIndex ? pht_114 : _GEN_241; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_243 = 7'h73 == trainIndex ? pht_115 : _GEN_242; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_244 = 7'h74 == trainIndex ? pht_116 : _GEN_243; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_245 = 7'h75 == trainIndex ? pht_117 : _GEN_244; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_246 = 7'h76 == trainIndex ? pht_118 : _GEN_245; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_247 = 7'h77 == trainIndex ? pht_119 : _GEN_246; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_248 = 7'h78 == trainIndex ? pht_120 : _GEN_247; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_249 = 7'h79 == trainIndex ? pht_121 : _GEN_248; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_250 = 7'h7a == trainIndex ? pht_122 : _GEN_249; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_251 = 7'h7b == trainIndex ? pht_123 : _GEN_250; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_252 = 7'h7c == trainIndex ? pht_124 : _GEN_251; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_253 = 7'h7d == trainIndex ? pht_125 : _GEN_252; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_254 = 7'h7e == trainIndex ? pht_126 : _GEN_253; // @[dut.scala 44:{28,28}]
  wire [1:0] _GEN_255 = 7'h7f == trainIndex ? pht_127 : _GEN_254; // @[dut.scala 44:{28,28}]
  wire [1:0] _pht_T_1 = _GEN_255 + 2'h1; // @[dut.scala 45:44]
  wire [1:0] _GEN_256 = 7'h0 == trainIndex ? _pht_T_1 : pht_0; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_257 = 7'h1 == trainIndex ? _pht_T_1 : pht_1; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_258 = 7'h2 == trainIndex ? _pht_T_1 : pht_2; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_259 = 7'h3 == trainIndex ? _pht_T_1 : pht_3; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_260 = 7'h4 == trainIndex ? _pht_T_1 : pht_4; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_261 = 7'h5 == trainIndex ? _pht_T_1 : pht_5; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_262 = 7'h6 == trainIndex ? _pht_T_1 : pht_6; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_263 = 7'h7 == trainIndex ? _pht_T_1 : pht_7; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_264 = 7'h8 == trainIndex ? _pht_T_1 : pht_8; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_265 = 7'h9 == trainIndex ? _pht_T_1 : pht_9; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_266 = 7'ha == trainIndex ? _pht_T_1 : pht_10; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_267 = 7'hb == trainIndex ? _pht_T_1 : pht_11; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_268 = 7'hc == trainIndex ? _pht_T_1 : pht_12; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_269 = 7'hd == trainIndex ? _pht_T_1 : pht_13; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_270 = 7'he == trainIndex ? _pht_T_1 : pht_14; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_271 = 7'hf == trainIndex ? _pht_T_1 : pht_15; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_272 = 7'h10 == trainIndex ? _pht_T_1 : pht_16; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_273 = 7'h11 == trainIndex ? _pht_T_1 : pht_17; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_274 = 7'h12 == trainIndex ? _pht_T_1 : pht_18; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_275 = 7'h13 == trainIndex ? _pht_T_1 : pht_19; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_276 = 7'h14 == trainIndex ? _pht_T_1 : pht_20; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_277 = 7'h15 == trainIndex ? _pht_T_1 : pht_21; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_278 = 7'h16 == trainIndex ? _pht_T_1 : pht_22; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_279 = 7'h17 == trainIndex ? _pht_T_1 : pht_23; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_280 = 7'h18 == trainIndex ? _pht_T_1 : pht_24; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_281 = 7'h19 == trainIndex ? _pht_T_1 : pht_25; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_282 = 7'h1a == trainIndex ? _pht_T_1 : pht_26; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_283 = 7'h1b == trainIndex ? _pht_T_1 : pht_27; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_284 = 7'h1c == trainIndex ? _pht_T_1 : pht_28; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_285 = 7'h1d == trainIndex ? _pht_T_1 : pht_29; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_286 = 7'h1e == trainIndex ? _pht_T_1 : pht_30; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_287 = 7'h1f == trainIndex ? _pht_T_1 : pht_31; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_288 = 7'h20 == trainIndex ? _pht_T_1 : pht_32; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_289 = 7'h21 == trainIndex ? _pht_T_1 : pht_33; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_290 = 7'h22 == trainIndex ? _pht_T_1 : pht_34; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_291 = 7'h23 == trainIndex ? _pht_T_1 : pht_35; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_292 = 7'h24 == trainIndex ? _pht_T_1 : pht_36; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_293 = 7'h25 == trainIndex ? _pht_T_1 : pht_37; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_294 = 7'h26 == trainIndex ? _pht_T_1 : pht_38; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_295 = 7'h27 == trainIndex ? _pht_T_1 : pht_39; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_296 = 7'h28 == trainIndex ? _pht_T_1 : pht_40; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_297 = 7'h29 == trainIndex ? _pht_T_1 : pht_41; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_298 = 7'h2a == trainIndex ? _pht_T_1 : pht_42; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_299 = 7'h2b == trainIndex ? _pht_T_1 : pht_43; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_300 = 7'h2c == trainIndex ? _pht_T_1 : pht_44; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_301 = 7'h2d == trainIndex ? _pht_T_1 : pht_45; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_302 = 7'h2e == trainIndex ? _pht_T_1 : pht_46; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_303 = 7'h2f == trainIndex ? _pht_T_1 : pht_47; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_304 = 7'h30 == trainIndex ? _pht_T_1 : pht_48; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_305 = 7'h31 == trainIndex ? _pht_T_1 : pht_49; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_306 = 7'h32 == trainIndex ? _pht_T_1 : pht_50; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_307 = 7'h33 == trainIndex ? _pht_T_1 : pht_51; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_308 = 7'h34 == trainIndex ? _pht_T_1 : pht_52; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_309 = 7'h35 == trainIndex ? _pht_T_1 : pht_53; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_310 = 7'h36 == trainIndex ? _pht_T_1 : pht_54; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_311 = 7'h37 == trainIndex ? _pht_T_1 : pht_55; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_312 = 7'h38 == trainIndex ? _pht_T_1 : pht_56; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_313 = 7'h39 == trainIndex ? _pht_T_1 : pht_57; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_314 = 7'h3a == trainIndex ? _pht_T_1 : pht_58; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_315 = 7'h3b == trainIndex ? _pht_T_1 : pht_59; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_316 = 7'h3c == trainIndex ? _pht_T_1 : pht_60; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_317 = 7'h3d == trainIndex ? _pht_T_1 : pht_61; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_318 = 7'h3e == trainIndex ? _pht_T_1 : pht_62; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_319 = 7'h3f == trainIndex ? _pht_T_1 : pht_63; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_320 = 7'h40 == trainIndex ? _pht_T_1 : pht_64; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_321 = 7'h41 == trainIndex ? _pht_T_1 : pht_65; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_322 = 7'h42 == trainIndex ? _pht_T_1 : pht_66; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_323 = 7'h43 == trainIndex ? _pht_T_1 : pht_67; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_324 = 7'h44 == trainIndex ? _pht_T_1 : pht_68; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_325 = 7'h45 == trainIndex ? _pht_T_1 : pht_69; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_326 = 7'h46 == trainIndex ? _pht_T_1 : pht_70; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_327 = 7'h47 == trainIndex ? _pht_T_1 : pht_71; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_328 = 7'h48 == trainIndex ? _pht_T_1 : pht_72; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_329 = 7'h49 == trainIndex ? _pht_T_1 : pht_73; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_330 = 7'h4a == trainIndex ? _pht_T_1 : pht_74; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_331 = 7'h4b == trainIndex ? _pht_T_1 : pht_75; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_332 = 7'h4c == trainIndex ? _pht_T_1 : pht_76; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_333 = 7'h4d == trainIndex ? _pht_T_1 : pht_77; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_334 = 7'h4e == trainIndex ? _pht_T_1 : pht_78; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_335 = 7'h4f == trainIndex ? _pht_T_1 : pht_79; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_336 = 7'h50 == trainIndex ? _pht_T_1 : pht_80; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_337 = 7'h51 == trainIndex ? _pht_T_1 : pht_81; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_338 = 7'h52 == trainIndex ? _pht_T_1 : pht_82; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_339 = 7'h53 == trainIndex ? _pht_T_1 : pht_83; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_340 = 7'h54 == trainIndex ? _pht_T_1 : pht_84; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_341 = 7'h55 == trainIndex ? _pht_T_1 : pht_85; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_342 = 7'h56 == trainIndex ? _pht_T_1 : pht_86; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_343 = 7'h57 == trainIndex ? _pht_T_1 : pht_87; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_344 = 7'h58 == trainIndex ? _pht_T_1 : pht_88; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_345 = 7'h59 == trainIndex ? _pht_T_1 : pht_89; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_346 = 7'h5a == trainIndex ? _pht_T_1 : pht_90; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_347 = 7'h5b == trainIndex ? _pht_T_1 : pht_91; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_348 = 7'h5c == trainIndex ? _pht_T_1 : pht_92; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_349 = 7'h5d == trainIndex ? _pht_T_1 : pht_93; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_350 = 7'h5e == trainIndex ? _pht_T_1 : pht_94; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_351 = 7'h5f == trainIndex ? _pht_T_1 : pht_95; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_352 = 7'h60 == trainIndex ? _pht_T_1 : pht_96; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_353 = 7'h61 == trainIndex ? _pht_T_1 : pht_97; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_354 = 7'h62 == trainIndex ? _pht_T_1 : pht_98; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_355 = 7'h63 == trainIndex ? _pht_T_1 : pht_99; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_356 = 7'h64 == trainIndex ? _pht_T_1 : pht_100; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_357 = 7'h65 == trainIndex ? _pht_T_1 : pht_101; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_358 = 7'h66 == trainIndex ? _pht_T_1 : pht_102; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_359 = 7'h67 == trainIndex ? _pht_T_1 : pht_103; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_360 = 7'h68 == trainIndex ? _pht_T_1 : pht_104; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_361 = 7'h69 == trainIndex ? _pht_T_1 : pht_105; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_362 = 7'h6a == trainIndex ? _pht_T_1 : pht_106; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_363 = 7'h6b == trainIndex ? _pht_T_1 : pht_107; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_364 = 7'h6c == trainIndex ? _pht_T_1 : pht_108; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_365 = 7'h6d == trainIndex ? _pht_T_1 : pht_109; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_366 = 7'h6e == trainIndex ? _pht_T_1 : pht_110; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_367 = 7'h6f == trainIndex ? _pht_T_1 : pht_111; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_368 = 7'h70 == trainIndex ? _pht_T_1 : pht_112; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_369 = 7'h71 == trainIndex ? _pht_T_1 : pht_113; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_370 = 7'h72 == trainIndex ? _pht_T_1 : pht_114; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_371 = 7'h73 == trainIndex ? _pht_T_1 : pht_115; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_372 = 7'h74 == trainIndex ? _pht_T_1 : pht_116; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_373 = 7'h75 == trainIndex ? _pht_T_1 : pht_117; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_374 = 7'h76 == trainIndex ? _pht_T_1 : pht_118; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_375 = 7'h77 == trainIndex ? _pht_T_1 : pht_119; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_376 = 7'h78 == trainIndex ? _pht_T_1 : pht_120; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_377 = 7'h79 == trainIndex ? _pht_T_1 : pht_121; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_378 = 7'h7a == trainIndex ? _pht_T_1 : pht_122; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_379 = 7'h7b == trainIndex ? _pht_T_1 : pht_123; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_380 = 7'h7c == trainIndex ? _pht_T_1 : pht_124; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_381 = 7'h7d == trainIndex ? _pht_T_1 : pht_125; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_382 = 7'h7e == trainIndex ? _pht_T_1 : pht_126; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _GEN_383 = 7'h7f == trainIndex ? _pht_T_1 : pht_127; // @[dut.scala 26:20 45:{25,25}]
  wire [1:0] _pht_T_3 = _GEN_255 - 2'h1; // @[dut.scala 49:44]
  wire [1:0] _GEN_512 = 7'h0 == trainIndex ? _pht_T_3 : pht_0; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_513 = 7'h1 == trainIndex ? _pht_T_3 : pht_1; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_514 = 7'h2 == trainIndex ? _pht_T_3 : pht_2; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_515 = 7'h3 == trainIndex ? _pht_T_3 : pht_3; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_516 = 7'h4 == trainIndex ? _pht_T_3 : pht_4; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_517 = 7'h5 == trainIndex ? _pht_T_3 : pht_5; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_518 = 7'h6 == trainIndex ? _pht_T_3 : pht_6; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_519 = 7'h7 == trainIndex ? _pht_T_3 : pht_7; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_520 = 7'h8 == trainIndex ? _pht_T_3 : pht_8; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_521 = 7'h9 == trainIndex ? _pht_T_3 : pht_9; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_522 = 7'ha == trainIndex ? _pht_T_3 : pht_10; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_523 = 7'hb == trainIndex ? _pht_T_3 : pht_11; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_524 = 7'hc == trainIndex ? _pht_T_3 : pht_12; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_525 = 7'hd == trainIndex ? _pht_T_3 : pht_13; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_526 = 7'he == trainIndex ? _pht_T_3 : pht_14; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_527 = 7'hf == trainIndex ? _pht_T_3 : pht_15; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_528 = 7'h10 == trainIndex ? _pht_T_3 : pht_16; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_529 = 7'h11 == trainIndex ? _pht_T_3 : pht_17; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_530 = 7'h12 == trainIndex ? _pht_T_3 : pht_18; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_531 = 7'h13 == trainIndex ? _pht_T_3 : pht_19; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_532 = 7'h14 == trainIndex ? _pht_T_3 : pht_20; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_533 = 7'h15 == trainIndex ? _pht_T_3 : pht_21; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_534 = 7'h16 == trainIndex ? _pht_T_3 : pht_22; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_535 = 7'h17 == trainIndex ? _pht_T_3 : pht_23; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_536 = 7'h18 == trainIndex ? _pht_T_3 : pht_24; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_537 = 7'h19 == trainIndex ? _pht_T_3 : pht_25; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_538 = 7'h1a == trainIndex ? _pht_T_3 : pht_26; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_539 = 7'h1b == trainIndex ? _pht_T_3 : pht_27; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_540 = 7'h1c == trainIndex ? _pht_T_3 : pht_28; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_541 = 7'h1d == trainIndex ? _pht_T_3 : pht_29; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_542 = 7'h1e == trainIndex ? _pht_T_3 : pht_30; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_543 = 7'h1f == trainIndex ? _pht_T_3 : pht_31; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_544 = 7'h20 == trainIndex ? _pht_T_3 : pht_32; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_545 = 7'h21 == trainIndex ? _pht_T_3 : pht_33; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_546 = 7'h22 == trainIndex ? _pht_T_3 : pht_34; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_547 = 7'h23 == trainIndex ? _pht_T_3 : pht_35; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_548 = 7'h24 == trainIndex ? _pht_T_3 : pht_36; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_549 = 7'h25 == trainIndex ? _pht_T_3 : pht_37; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_550 = 7'h26 == trainIndex ? _pht_T_3 : pht_38; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_551 = 7'h27 == trainIndex ? _pht_T_3 : pht_39; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_552 = 7'h28 == trainIndex ? _pht_T_3 : pht_40; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_553 = 7'h29 == trainIndex ? _pht_T_3 : pht_41; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_554 = 7'h2a == trainIndex ? _pht_T_3 : pht_42; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_555 = 7'h2b == trainIndex ? _pht_T_3 : pht_43; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_556 = 7'h2c == trainIndex ? _pht_T_3 : pht_44; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_557 = 7'h2d == trainIndex ? _pht_T_3 : pht_45; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_558 = 7'h2e == trainIndex ? _pht_T_3 : pht_46; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_559 = 7'h2f == trainIndex ? _pht_T_3 : pht_47; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_560 = 7'h30 == trainIndex ? _pht_T_3 : pht_48; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_561 = 7'h31 == trainIndex ? _pht_T_3 : pht_49; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_562 = 7'h32 == trainIndex ? _pht_T_3 : pht_50; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_563 = 7'h33 == trainIndex ? _pht_T_3 : pht_51; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_564 = 7'h34 == trainIndex ? _pht_T_3 : pht_52; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_565 = 7'h35 == trainIndex ? _pht_T_3 : pht_53; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_566 = 7'h36 == trainIndex ? _pht_T_3 : pht_54; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_567 = 7'h37 == trainIndex ? _pht_T_3 : pht_55; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_568 = 7'h38 == trainIndex ? _pht_T_3 : pht_56; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_569 = 7'h39 == trainIndex ? _pht_T_3 : pht_57; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_570 = 7'h3a == trainIndex ? _pht_T_3 : pht_58; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_571 = 7'h3b == trainIndex ? _pht_T_3 : pht_59; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_572 = 7'h3c == trainIndex ? _pht_T_3 : pht_60; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_573 = 7'h3d == trainIndex ? _pht_T_3 : pht_61; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_574 = 7'h3e == trainIndex ? _pht_T_3 : pht_62; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_575 = 7'h3f == trainIndex ? _pht_T_3 : pht_63; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_576 = 7'h40 == trainIndex ? _pht_T_3 : pht_64; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_577 = 7'h41 == trainIndex ? _pht_T_3 : pht_65; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_578 = 7'h42 == trainIndex ? _pht_T_3 : pht_66; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_579 = 7'h43 == trainIndex ? _pht_T_3 : pht_67; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_580 = 7'h44 == trainIndex ? _pht_T_3 : pht_68; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_581 = 7'h45 == trainIndex ? _pht_T_3 : pht_69; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_582 = 7'h46 == trainIndex ? _pht_T_3 : pht_70; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_583 = 7'h47 == trainIndex ? _pht_T_3 : pht_71; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_584 = 7'h48 == trainIndex ? _pht_T_3 : pht_72; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_585 = 7'h49 == trainIndex ? _pht_T_3 : pht_73; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_586 = 7'h4a == trainIndex ? _pht_T_3 : pht_74; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_587 = 7'h4b == trainIndex ? _pht_T_3 : pht_75; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_588 = 7'h4c == trainIndex ? _pht_T_3 : pht_76; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_589 = 7'h4d == trainIndex ? _pht_T_3 : pht_77; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_590 = 7'h4e == trainIndex ? _pht_T_3 : pht_78; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_591 = 7'h4f == trainIndex ? _pht_T_3 : pht_79; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_592 = 7'h50 == trainIndex ? _pht_T_3 : pht_80; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_593 = 7'h51 == trainIndex ? _pht_T_3 : pht_81; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_594 = 7'h52 == trainIndex ? _pht_T_3 : pht_82; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_595 = 7'h53 == trainIndex ? _pht_T_3 : pht_83; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_596 = 7'h54 == trainIndex ? _pht_T_3 : pht_84; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_597 = 7'h55 == trainIndex ? _pht_T_3 : pht_85; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_598 = 7'h56 == trainIndex ? _pht_T_3 : pht_86; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_599 = 7'h57 == trainIndex ? _pht_T_3 : pht_87; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_600 = 7'h58 == trainIndex ? _pht_T_3 : pht_88; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_601 = 7'h59 == trainIndex ? _pht_T_3 : pht_89; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_602 = 7'h5a == trainIndex ? _pht_T_3 : pht_90; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_603 = 7'h5b == trainIndex ? _pht_T_3 : pht_91; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_604 = 7'h5c == trainIndex ? _pht_T_3 : pht_92; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_605 = 7'h5d == trainIndex ? _pht_T_3 : pht_93; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_606 = 7'h5e == trainIndex ? _pht_T_3 : pht_94; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_607 = 7'h5f == trainIndex ? _pht_T_3 : pht_95; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_608 = 7'h60 == trainIndex ? _pht_T_3 : pht_96; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_609 = 7'h61 == trainIndex ? _pht_T_3 : pht_97; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_610 = 7'h62 == trainIndex ? _pht_T_3 : pht_98; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_611 = 7'h63 == trainIndex ? _pht_T_3 : pht_99; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_612 = 7'h64 == trainIndex ? _pht_T_3 : pht_100; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_613 = 7'h65 == trainIndex ? _pht_T_3 : pht_101; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_614 = 7'h66 == trainIndex ? _pht_T_3 : pht_102; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_615 = 7'h67 == trainIndex ? _pht_T_3 : pht_103; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_616 = 7'h68 == trainIndex ? _pht_T_3 : pht_104; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_617 = 7'h69 == trainIndex ? _pht_T_3 : pht_105; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_618 = 7'h6a == trainIndex ? _pht_T_3 : pht_106; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_619 = 7'h6b == trainIndex ? _pht_T_3 : pht_107; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_620 = 7'h6c == trainIndex ? _pht_T_3 : pht_108; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_621 = 7'h6d == trainIndex ? _pht_T_3 : pht_109; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_622 = 7'h6e == trainIndex ? _pht_T_3 : pht_110; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_623 = 7'h6f == trainIndex ? _pht_T_3 : pht_111; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_624 = 7'h70 == trainIndex ? _pht_T_3 : pht_112; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_625 = 7'h71 == trainIndex ? _pht_T_3 : pht_113; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_626 = 7'h72 == trainIndex ? _pht_T_3 : pht_114; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_627 = 7'h73 == trainIndex ? _pht_T_3 : pht_115; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_628 = 7'h74 == trainIndex ? _pht_T_3 : pht_116; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_629 = 7'h75 == trainIndex ? _pht_T_3 : pht_117; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_630 = 7'h76 == trainIndex ? _pht_T_3 : pht_118; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_631 = 7'h77 == trainIndex ? _pht_T_3 : pht_119; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_632 = 7'h78 == trainIndex ? _pht_T_3 : pht_120; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_633 = 7'h79 == trainIndex ? _pht_T_3 : pht_121; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_634 = 7'h7a == trainIndex ? _pht_T_3 : pht_122; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_635 = 7'h7b == trainIndex ? _pht_T_3 : pht_123; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_636 = 7'h7c == trainIndex ? _pht_T_3 : pht_124; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_637 = 7'h7d == trainIndex ? _pht_T_3 : pht_125; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_638 = 7'h7e == trainIndex ? _pht_T_3 : pht_126; // @[dut.scala 26:20 49:{25,25}]
  wire [1:0] _GEN_639 = 7'h7f == trainIndex ? _pht_T_3 : pht_127; // @[dut.scala 26:20 49:{25,25}]
  wire [6:0] _globalHistoryReg_T_1 = {globalHistoryReg[5:0],io_train_taken}; // @[Cat.scala 33:92]
  wire [6:0] _globalHistoryReg_T_3 = {globalHistoryReg[5:0],io_predict_taken}; // @[Cat.scala 33:92]
  assign io_predict_taken = io_predict_valid & (_GEN_127 == 2'h2 | _GEN_127 == 2'h3); // @[dut.scala 35:40]
  assign io_predict_history = globalHistoryReg; // @[dut.scala 36:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 23:33]
      globalHistoryReg <= 7'h0; // @[dut.scala 23:33]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_mispredicted) begin // @[dut.scala 54:33]
        globalHistoryReg <= io_train_history; // @[dut.scala 56:24]
      end else begin
        globalHistoryReg <= _globalHistoryReg_T_1; // @[dut.scala 59:24]
      end
    end else if (io_predict_valid) begin // @[dut.scala 63:28]
      globalHistoryReg <= _globalHistoryReg_T_3; // @[dut.scala 64:24]
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_0 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_0 <= _GEN_256;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_0 <= _GEN_512;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_1 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_1 <= _GEN_257;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_1 <= _GEN_513;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_2 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_2 <= _GEN_258;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_2 <= _GEN_514;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_3 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_3 <= _GEN_259;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_3 <= _GEN_515;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_4 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_4 <= _GEN_260;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_4 <= _GEN_516;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_5 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_5 <= _GEN_261;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_5 <= _GEN_517;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_6 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_6 <= _GEN_262;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_6 <= _GEN_518;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_7 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_7 <= _GEN_263;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_7 <= _GEN_519;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_8 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_8 <= _GEN_264;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_8 <= _GEN_520;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_9 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_9 <= _GEN_265;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_9 <= _GEN_521;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_10 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_10 <= _GEN_266;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_10 <= _GEN_522;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_11 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_11 <= _GEN_267;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_11 <= _GEN_523;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_12 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_12 <= _GEN_268;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_12 <= _GEN_524;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_13 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_13 <= _GEN_269;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_13 <= _GEN_525;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_14 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_14 <= _GEN_270;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_14 <= _GEN_526;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_15 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_15 <= _GEN_271;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_15 <= _GEN_527;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_16 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_16 <= _GEN_272;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_16 <= _GEN_528;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_17 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_17 <= _GEN_273;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_17 <= _GEN_529;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_18 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_18 <= _GEN_274;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_18 <= _GEN_530;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_19 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_19 <= _GEN_275;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_19 <= _GEN_531;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_20 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_20 <= _GEN_276;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_20 <= _GEN_532;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_21 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_21 <= _GEN_277;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_21 <= _GEN_533;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_22 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_22 <= _GEN_278;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_22 <= _GEN_534;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_23 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_23 <= _GEN_279;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_23 <= _GEN_535;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_24 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_24 <= _GEN_280;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_24 <= _GEN_536;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_25 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_25 <= _GEN_281;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_25 <= _GEN_537;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_26 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_26 <= _GEN_282;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_26 <= _GEN_538;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_27 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_27 <= _GEN_283;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_27 <= _GEN_539;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_28 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_28 <= _GEN_284;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_28 <= _GEN_540;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_29 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_29 <= _GEN_285;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_29 <= _GEN_541;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_30 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_30 <= _GEN_286;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_30 <= _GEN_542;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_31 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_31 <= _GEN_287;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_31 <= _GEN_543;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_32 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_32 <= _GEN_288;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_32 <= _GEN_544;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_33 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_33 <= _GEN_289;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_33 <= _GEN_545;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_34 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_34 <= _GEN_290;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_34 <= _GEN_546;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_35 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_35 <= _GEN_291;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_35 <= _GEN_547;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_36 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_36 <= _GEN_292;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_36 <= _GEN_548;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_37 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_37 <= _GEN_293;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_37 <= _GEN_549;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_38 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_38 <= _GEN_294;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_38 <= _GEN_550;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_39 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_39 <= _GEN_295;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_39 <= _GEN_551;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_40 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_40 <= _GEN_296;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_40 <= _GEN_552;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_41 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_41 <= _GEN_297;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_41 <= _GEN_553;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_42 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_42 <= _GEN_298;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_42 <= _GEN_554;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_43 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_43 <= _GEN_299;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_43 <= _GEN_555;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_44 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_44 <= _GEN_300;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_44 <= _GEN_556;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_45 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_45 <= _GEN_301;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_45 <= _GEN_557;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_46 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_46 <= _GEN_302;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_46 <= _GEN_558;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_47 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_47 <= _GEN_303;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_47 <= _GEN_559;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_48 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_48 <= _GEN_304;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_48 <= _GEN_560;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_49 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_49 <= _GEN_305;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_49 <= _GEN_561;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_50 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_50 <= _GEN_306;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_50 <= _GEN_562;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_51 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_51 <= _GEN_307;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_51 <= _GEN_563;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_52 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_52 <= _GEN_308;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_52 <= _GEN_564;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_53 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_53 <= _GEN_309;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_53 <= _GEN_565;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_54 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_54 <= _GEN_310;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_54 <= _GEN_566;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_55 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_55 <= _GEN_311;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_55 <= _GEN_567;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_56 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_56 <= _GEN_312;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_56 <= _GEN_568;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_57 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_57 <= _GEN_313;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_57 <= _GEN_569;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_58 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_58 <= _GEN_314;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_58 <= _GEN_570;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_59 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_59 <= _GEN_315;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_59 <= _GEN_571;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_60 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_60 <= _GEN_316;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_60 <= _GEN_572;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_61 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_61 <= _GEN_317;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_61 <= _GEN_573;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_62 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_62 <= _GEN_318;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_62 <= _GEN_574;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_63 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_63 <= _GEN_319;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_63 <= _GEN_575;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_64 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_64 <= _GEN_320;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_64 <= _GEN_576;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_65 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_65 <= _GEN_321;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_65 <= _GEN_577;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_66 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_66 <= _GEN_322;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_66 <= _GEN_578;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_67 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_67 <= _GEN_323;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_67 <= _GEN_579;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_68 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_68 <= _GEN_324;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_68 <= _GEN_580;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_69 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_69 <= _GEN_325;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_69 <= _GEN_581;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_70 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_70 <= _GEN_326;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_70 <= _GEN_582;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_71 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_71 <= _GEN_327;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_71 <= _GEN_583;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_72 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_72 <= _GEN_328;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_72 <= _GEN_584;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_73 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_73 <= _GEN_329;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_73 <= _GEN_585;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_74 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_74 <= _GEN_330;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_74 <= _GEN_586;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_75 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_75 <= _GEN_331;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_75 <= _GEN_587;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_76 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_76 <= _GEN_332;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_76 <= _GEN_588;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_77 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_77 <= _GEN_333;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_77 <= _GEN_589;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_78 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_78 <= _GEN_334;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_78 <= _GEN_590;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_79 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_79 <= _GEN_335;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_79 <= _GEN_591;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_80 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_80 <= _GEN_336;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_80 <= _GEN_592;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_81 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_81 <= _GEN_337;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_81 <= _GEN_593;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_82 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_82 <= _GEN_338;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_82 <= _GEN_594;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_83 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_83 <= _GEN_339;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_83 <= _GEN_595;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_84 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_84 <= _GEN_340;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_84 <= _GEN_596;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_85 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_85 <= _GEN_341;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_85 <= _GEN_597;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_86 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_86 <= _GEN_342;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_86 <= _GEN_598;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_87 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_87 <= _GEN_343;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_87 <= _GEN_599;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_88 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_88 <= _GEN_344;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_88 <= _GEN_600;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_89 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_89 <= _GEN_345;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_89 <= _GEN_601;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_90 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_90 <= _GEN_346;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_90 <= _GEN_602;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_91 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_91 <= _GEN_347;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_91 <= _GEN_603;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_92 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_92 <= _GEN_348;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_92 <= _GEN_604;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_93 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_93 <= _GEN_349;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_93 <= _GEN_605;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_94 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_94 <= _GEN_350;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_94 <= _GEN_606;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_95 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_95 <= _GEN_351;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_95 <= _GEN_607;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_96 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_96 <= _GEN_352;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_96 <= _GEN_608;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_97 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_97 <= _GEN_353;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_97 <= _GEN_609;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_98 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_98 <= _GEN_354;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_98 <= _GEN_610;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_99 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_99 <= _GEN_355;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_99 <= _GEN_611;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_100 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_100 <= _GEN_356;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_100 <= _GEN_612;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_101 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_101 <= _GEN_357;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_101 <= _GEN_613;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_102 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_102 <= _GEN_358;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_102 <= _GEN_614;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_103 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_103 <= _GEN_359;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_103 <= _GEN_615;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_104 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_104 <= _GEN_360;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_104 <= _GEN_616;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_105 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_105 <= _GEN_361;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_105 <= _GEN_617;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_106 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_106 <= _GEN_362;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_106 <= _GEN_618;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_107 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_107 <= _GEN_363;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_107 <= _GEN_619;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_108 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_108 <= _GEN_364;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_108 <= _GEN_620;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_109 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_109 <= _GEN_365;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_109 <= _GEN_621;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_110 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_110 <= _GEN_366;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_110 <= _GEN_622;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_111 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_111 <= _GEN_367;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_111 <= _GEN_623;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_112 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_112 <= _GEN_368;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_112 <= _GEN_624;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_113 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_113 <= _GEN_369;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_113 <= _GEN_625;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_114 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_114 <= _GEN_370;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_114 <= _GEN_626;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_115 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_115 <= _GEN_371;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_115 <= _GEN_627;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_116 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_116 <= _GEN_372;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_116 <= _GEN_628;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_117 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_117 <= _GEN_373;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_117 <= _GEN_629;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_118 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_118 <= _GEN_374;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_118 <= _GEN_630;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_119 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_119 <= _GEN_375;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_119 <= _GEN_631;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_120 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_120 <= _GEN_376;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_120 <= _GEN_632;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_121 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_121 <= _GEN_377;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_121 <= _GEN_633;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_122 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_122 <= _GEN_378;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_122 <= _GEN_634;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_123 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_123 <= _GEN_379;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_123 <= _GEN_635;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_124 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_124 <= _GEN_380;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_124 <= _GEN_636;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_125 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_125 <= _GEN_381;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_125 <= _GEN_637;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_126 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_126 <= _GEN_382;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_126 <= _GEN_638;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      pht_127 <= 2'h3; // @[dut.scala 26:20]
    end else if (io_train_valid) begin // @[dut.scala 39:24]
      if (io_train_taken) begin // @[dut.scala 43:26]
        if (_GEN_255 != 2'h3) begin // @[dut.scala 44:37]
          pht_127 <= _GEN_383;
        end
      end else if (_GEN_255 != 2'h0) begin // @[dut.scala 48:37]
        pht_127 <= _GEN_639;
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
  globalHistoryReg = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  pht_0 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  pht_1 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  pht_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  pht_3 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  pht_4 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  pht_5 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  pht_6 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  pht_7 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  pht_8 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  pht_9 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  pht_10 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  pht_11 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  pht_12 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  pht_13 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  pht_14 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  pht_15 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  pht_16 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  pht_17 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  pht_18 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  pht_19 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  pht_20 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  pht_21 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  pht_22 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  pht_23 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  pht_24 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  pht_25 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  pht_26 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  pht_27 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  pht_28 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  pht_29 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  pht_30 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  pht_31 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  pht_32 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  pht_33 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  pht_34 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  pht_35 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  pht_36 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  pht_37 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  pht_38 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  pht_39 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  pht_40 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  pht_41 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  pht_42 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  pht_43 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  pht_44 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  pht_45 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  pht_46 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  pht_47 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  pht_48 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  pht_49 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  pht_50 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  pht_51 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  pht_52 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  pht_53 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  pht_54 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  pht_55 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  pht_56 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  pht_57 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  pht_58 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  pht_59 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  pht_60 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  pht_61 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  pht_62 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  pht_63 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  pht_64 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  pht_65 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  pht_66 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  pht_67 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  pht_68 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  pht_69 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  pht_70 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  pht_71 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  pht_72 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  pht_73 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  pht_74 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  pht_75 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  pht_76 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  pht_77 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  pht_78 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  pht_79 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  pht_80 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  pht_81 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  pht_82 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  pht_83 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  pht_84 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  pht_85 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  pht_86 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  pht_87 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  pht_88 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  pht_89 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  pht_90 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  pht_91 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  pht_92 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  pht_93 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  pht_94 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  pht_95 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  pht_96 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  pht_97 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  pht_98 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  pht_99 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  pht_100 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  pht_101 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  pht_102 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  pht_103 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  pht_104 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  pht_105 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  pht_106 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  pht_107 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  pht_108 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  pht_109 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  pht_110 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  pht_111 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  pht_112 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  pht_113 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  pht_114 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  pht_115 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  pht_116 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  pht_117 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  pht_118 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  pht_119 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  pht_120 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  pht_121 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  pht_122 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  pht_123 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  pht_124 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  pht_125 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  pht_126 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  pht_127 = _RAND_128[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
