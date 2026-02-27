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
  reg [1:0] phtTable_0; // @[dut.scala 21:25]
  reg [1:0] phtTable_1; // @[dut.scala 21:25]
  reg [1:0] phtTable_2; // @[dut.scala 21:25]
  reg [1:0] phtTable_3; // @[dut.scala 21:25]
  reg [1:0] phtTable_4; // @[dut.scala 21:25]
  reg [1:0] phtTable_5; // @[dut.scala 21:25]
  reg [1:0] phtTable_6; // @[dut.scala 21:25]
  reg [1:0] phtTable_7; // @[dut.scala 21:25]
  reg [1:0] phtTable_8; // @[dut.scala 21:25]
  reg [1:0] phtTable_9; // @[dut.scala 21:25]
  reg [1:0] phtTable_10; // @[dut.scala 21:25]
  reg [1:0] phtTable_11; // @[dut.scala 21:25]
  reg [1:0] phtTable_12; // @[dut.scala 21:25]
  reg [1:0] phtTable_13; // @[dut.scala 21:25]
  reg [1:0] phtTable_14; // @[dut.scala 21:25]
  reg [1:0] phtTable_15; // @[dut.scala 21:25]
  reg [1:0] phtTable_16; // @[dut.scala 21:25]
  reg [1:0] phtTable_17; // @[dut.scala 21:25]
  reg [1:0] phtTable_18; // @[dut.scala 21:25]
  reg [1:0] phtTable_19; // @[dut.scala 21:25]
  reg [1:0] phtTable_20; // @[dut.scala 21:25]
  reg [1:0] phtTable_21; // @[dut.scala 21:25]
  reg [1:0] phtTable_22; // @[dut.scala 21:25]
  reg [1:0] phtTable_23; // @[dut.scala 21:25]
  reg [1:0] phtTable_24; // @[dut.scala 21:25]
  reg [1:0] phtTable_25; // @[dut.scala 21:25]
  reg [1:0] phtTable_26; // @[dut.scala 21:25]
  reg [1:0] phtTable_27; // @[dut.scala 21:25]
  reg [1:0] phtTable_28; // @[dut.scala 21:25]
  reg [1:0] phtTable_29; // @[dut.scala 21:25]
  reg [1:0] phtTable_30; // @[dut.scala 21:25]
  reg [1:0] phtTable_31; // @[dut.scala 21:25]
  reg [1:0] phtTable_32; // @[dut.scala 21:25]
  reg [1:0] phtTable_33; // @[dut.scala 21:25]
  reg [1:0] phtTable_34; // @[dut.scala 21:25]
  reg [1:0] phtTable_35; // @[dut.scala 21:25]
  reg [1:0] phtTable_36; // @[dut.scala 21:25]
  reg [1:0] phtTable_37; // @[dut.scala 21:25]
  reg [1:0] phtTable_38; // @[dut.scala 21:25]
  reg [1:0] phtTable_39; // @[dut.scala 21:25]
  reg [1:0] phtTable_40; // @[dut.scala 21:25]
  reg [1:0] phtTable_41; // @[dut.scala 21:25]
  reg [1:0] phtTable_42; // @[dut.scala 21:25]
  reg [1:0] phtTable_43; // @[dut.scala 21:25]
  reg [1:0] phtTable_44; // @[dut.scala 21:25]
  reg [1:0] phtTable_45; // @[dut.scala 21:25]
  reg [1:0] phtTable_46; // @[dut.scala 21:25]
  reg [1:0] phtTable_47; // @[dut.scala 21:25]
  reg [1:0] phtTable_48; // @[dut.scala 21:25]
  reg [1:0] phtTable_49; // @[dut.scala 21:25]
  reg [1:0] phtTable_50; // @[dut.scala 21:25]
  reg [1:0] phtTable_51; // @[dut.scala 21:25]
  reg [1:0] phtTable_52; // @[dut.scala 21:25]
  reg [1:0] phtTable_53; // @[dut.scala 21:25]
  reg [1:0] phtTable_54; // @[dut.scala 21:25]
  reg [1:0] phtTable_55; // @[dut.scala 21:25]
  reg [1:0] phtTable_56; // @[dut.scala 21:25]
  reg [1:0] phtTable_57; // @[dut.scala 21:25]
  reg [1:0] phtTable_58; // @[dut.scala 21:25]
  reg [1:0] phtTable_59; // @[dut.scala 21:25]
  reg [1:0] phtTable_60; // @[dut.scala 21:25]
  reg [1:0] phtTable_61; // @[dut.scala 21:25]
  reg [1:0] phtTable_62; // @[dut.scala 21:25]
  reg [1:0] phtTable_63; // @[dut.scala 21:25]
  reg [1:0] phtTable_64; // @[dut.scala 21:25]
  reg [1:0] phtTable_65; // @[dut.scala 21:25]
  reg [1:0] phtTable_66; // @[dut.scala 21:25]
  reg [1:0] phtTable_67; // @[dut.scala 21:25]
  reg [1:0] phtTable_68; // @[dut.scala 21:25]
  reg [1:0] phtTable_69; // @[dut.scala 21:25]
  reg [1:0] phtTable_70; // @[dut.scala 21:25]
  reg [1:0] phtTable_71; // @[dut.scala 21:25]
  reg [1:0] phtTable_72; // @[dut.scala 21:25]
  reg [1:0] phtTable_73; // @[dut.scala 21:25]
  reg [1:0] phtTable_74; // @[dut.scala 21:25]
  reg [1:0] phtTable_75; // @[dut.scala 21:25]
  reg [1:0] phtTable_76; // @[dut.scala 21:25]
  reg [1:0] phtTable_77; // @[dut.scala 21:25]
  reg [1:0] phtTable_78; // @[dut.scala 21:25]
  reg [1:0] phtTable_79; // @[dut.scala 21:25]
  reg [1:0] phtTable_80; // @[dut.scala 21:25]
  reg [1:0] phtTable_81; // @[dut.scala 21:25]
  reg [1:0] phtTable_82; // @[dut.scala 21:25]
  reg [1:0] phtTable_83; // @[dut.scala 21:25]
  reg [1:0] phtTable_84; // @[dut.scala 21:25]
  reg [1:0] phtTable_85; // @[dut.scala 21:25]
  reg [1:0] phtTable_86; // @[dut.scala 21:25]
  reg [1:0] phtTable_87; // @[dut.scala 21:25]
  reg [1:0] phtTable_88; // @[dut.scala 21:25]
  reg [1:0] phtTable_89; // @[dut.scala 21:25]
  reg [1:0] phtTable_90; // @[dut.scala 21:25]
  reg [1:0] phtTable_91; // @[dut.scala 21:25]
  reg [1:0] phtTable_92; // @[dut.scala 21:25]
  reg [1:0] phtTable_93; // @[dut.scala 21:25]
  reg [1:0] phtTable_94; // @[dut.scala 21:25]
  reg [1:0] phtTable_95; // @[dut.scala 21:25]
  reg [1:0] phtTable_96; // @[dut.scala 21:25]
  reg [1:0] phtTable_97; // @[dut.scala 21:25]
  reg [1:0] phtTable_98; // @[dut.scala 21:25]
  reg [1:0] phtTable_99; // @[dut.scala 21:25]
  reg [1:0] phtTable_100; // @[dut.scala 21:25]
  reg [1:0] phtTable_101; // @[dut.scala 21:25]
  reg [1:0] phtTable_102; // @[dut.scala 21:25]
  reg [1:0] phtTable_103; // @[dut.scala 21:25]
  reg [1:0] phtTable_104; // @[dut.scala 21:25]
  reg [1:0] phtTable_105; // @[dut.scala 21:25]
  reg [1:0] phtTable_106; // @[dut.scala 21:25]
  reg [1:0] phtTable_107; // @[dut.scala 21:25]
  reg [1:0] phtTable_108; // @[dut.scala 21:25]
  reg [1:0] phtTable_109; // @[dut.scala 21:25]
  reg [1:0] phtTable_110; // @[dut.scala 21:25]
  reg [1:0] phtTable_111; // @[dut.scala 21:25]
  reg [1:0] phtTable_112; // @[dut.scala 21:25]
  reg [1:0] phtTable_113; // @[dut.scala 21:25]
  reg [1:0] phtTable_114; // @[dut.scala 21:25]
  reg [1:0] phtTable_115; // @[dut.scala 21:25]
  reg [1:0] phtTable_116; // @[dut.scala 21:25]
  reg [1:0] phtTable_117; // @[dut.scala 21:25]
  reg [1:0] phtTable_118; // @[dut.scala 21:25]
  reg [1:0] phtTable_119; // @[dut.scala 21:25]
  reg [1:0] phtTable_120; // @[dut.scala 21:25]
  reg [1:0] phtTable_121; // @[dut.scala 21:25]
  reg [1:0] phtTable_122; // @[dut.scala 21:25]
  reg [1:0] phtTable_123; // @[dut.scala 21:25]
  reg [1:0] phtTable_124; // @[dut.scala 21:25]
  reg [1:0] phtTable_125; // @[dut.scala 21:25]
  reg [1:0] phtTable_126; // @[dut.scala 21:25]
  reg [1:0] phtTable_127; // @[dut.scala 21:25]
  reg [6:0] ghr; // @[dut.scala 22:20]
  wire [6:0] predictIndex = io_predict_pc ^ ghr; // @[dut.scala 25:36]
  wire [1:0] _GEN_1 = 7'h1 == predictIndex ? phtTable_1 : phtTable_0; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_2 = 7'h2 == predictIndex ? phtTable_2 : _GEN_1; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_3 = 7'h3 == predictIndex ? phtTable_3 : _GEN_2; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_4 = 7'h4 == predictIndex ? phtTable_4 : _GEN_3; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_5 = 7'h5 == predictIndex ? phtTable_5 : _GEN_4; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_6 = 7'h6 == predictIndex ? phtTable_6 : _GEN_5; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_7 = 7'h7 == predictIndex ? phtTable_7 : _GEN_6; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_8 = 7'h8 == predictIndex ? phtTable_8 : _GEN_7; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_9 = 7'h9 == predictIndex ? phtTable_9 : _GEN_8; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_10 = 7'ha == predictIndex ? phtTable_10 : _GEN_9; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_11 = 7'hb == predictIndex ? phtTable_11 : _GEN_10; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_12 = 7'hc == predictIndex ? phtTable_12 : _GEN_11; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_13 = 7'hd == predictIndex ? phtTable_13 : _GEN_12; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_14 = 7'he == predictIndex ? phtTable_14 : _GEN_13; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_15 = 7'hf == predictIndex ? phtTable_15 : _GEN_14; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_16 = 7'h10 == predictIndex ? phtTable_16 : _GEN_15; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_17 = 7'h11 == predictIndex ? phtTable_17 : _GEN_16; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_18 = 7'h12 == predictIndex ? phtTable_18 : _GEN_17; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_19 = 7'h13 == predictIndex ? phtTable_19 : _GEN_18; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_20 = 7'h14 == predictIndex ? phtTable_20 : _GEN_19; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_21 = 7'h15 == predictIndex ? phtTable_21 : _GEN_20; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_22 = 7'h16 == predictIndex ? phtTable_22 : _GEN_21; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_23 = 7'h17 == predictIndex ? phtTable_23 : _GEN_22; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_24 = 7'h18 == predictIndex ? phtTable_24 : _GEN_23; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_25 = 7'h19 == predictIndex ? phtTable_25 : _GEN_24; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_26 = 7'h1a == predictIndex ? phtTable_26 : _GEN_25; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_27 = 7'h1b == predictIndex ? phtTable_27 : _GEN_26; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_28 = 7'h1c == predictIndex ? phtTable_28 : _GEN_27; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_29 = 7'h1d == predictIndex ? phtTable_29 : _GEN_28; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_30 = 7'h1e == predictIndex ? phtTable_30 : _GEN_29; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_31 = 7'h1f == predictIndex ? phtTable_31 : _GEN_30; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_32 = 7'h20 == predictIndex ? phtTable_32 : _GEN_31; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_33 = 7'h21 == predictIndex ? phtTable_33 : _GEN_32; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_34 = 7'h22 == predictIndex ? phtTable_34 : _GEN_33; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_35 = 7'h23 == predictIndex ? phtTable_35 : _GEN_34; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_36 = 7'h24 == predictIndex ? phtTable_36 : _GEN_35; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_37 = 7'h25 == predictIndex ? phtTable_37 : _GEN_36; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_38 = 7'h26 == predictIndex ? phtTable_38 : _GEN_37; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_39 = 7'h27 == predictIndex ? phtTable_39 : _GEN_38; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_40 = 7'h28 == predictIndex ? phtTable_40 : _GEN_39; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_41 = 7'h29 == predictIndex ? phtTable_41 : _GEN_40; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_42 = 7'h2a == predictIndex ? phtTable_42 : _GEN_41; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_43 = 7'h2b == predictIndex ? phtTable_43 : _GEN_42; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_44 = 7'h2c == predictIndex ? phtTable_44 : _GEN_43; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_45 = 7'h2d == predictIndex ? phtTable_45 : _GEN_44; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_46 = 7'h2e == predictIndex ? phtTable_46 : _GEN_45; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_47 = 7'h2f == predictIndex ? phtTable_47 : _GEN_46; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_48 = 7'h30 == predictIndex ? phtTable_48 : _GEN_47; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_49 = 7'h31 == predictIndex ? phtTable_49 : _GEN_48; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_50 = 7'h32 == predictIndex ? phtTable_50 : _GEN_49; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_51 = 7'h33 == predictIndex ? phtTable_51 : _GEN_50; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_52 = 7'h34 == predictIndex ? phtTable_52 : _GEN_51; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_53 = 7'h35 == predictIndex ? phtTable_53 : _GEN_52; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_54 = 7'h36 == predictIndex ? phtTable_54 : _GEN_53; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_55 = 7'h37 == predictIndex ? phtTable_55 : _GEN_54; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_56 = 7'h38 == predictIndex ? phtTable_56 : _GEN_55; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_57 = 7'h39 == predictIndex ? phtTable_57 : _GEN_56; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_58 = 7'h3a == predictIndex ? phtTable_58 : _GEN_57; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_59 = 7'h3b == predictIndex ? phtTable_59 : _GEN_58; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_60 = 7'h3c == predictIndex ? phtTable_60 : _GEN_59; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_61 = 7'h3d == predictIndex ? phtTable_61 : _GEN_60; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_62 = 7'h3e == predictIndex ? phtTable_62 : _GEN_61; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_63 = 7'h3f == predictIndex ? phtTable_63 : _GEN_62; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_64 = 7'h40 == predictIndex ? phtTable_64 : _GEN_63; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_65 = 7'h41 == predictIndex ? phtTable_65 : _GEN_64; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_66 = 7'h42 == predictIndex ? phtTable_66 : _GEN_65; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_67 = 7'h43 == predictIndex ? phtTable_67 : _GEN_66; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_68 = 7'h44 == predictIndex ? phtTable_68 : _GEN_67; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_69 = 7'h45 == predictIndex ? phtTable_69 : _GEN_68; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_70 = 7'h46 == predictIndex ? phtTable_70 : _GEN_69; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_71 = 7'h47 == predictIndex ? phtTable_71 : _GEN_70; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_72 = 7'h48 == predictIndex ? phtTable_72 : _GEN_71; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_73 = 7'h49 == predictIndex ? phtTable_73 : _GEN_72; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_74 = 7'h4a == predictIndex ? phtTable_74 : _GEN_73; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_75 = 7'h4b == predictIndex ? phtTable_75 : _GEN_74; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_76 = 7'h4c == predictIndex ? phtTable_76 : _GEN_75; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_77 = 7'h4d == predictIndex ? phtTable_77 : _GEN_76; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_78 = 7'h4e == predictIndex ? phtTable_78 : _GEN_77; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_79 = 7'h4f == predictIndex ? phtTable_79 : _GEN_78; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_80 = 7'h50 == predictIndex ? phtTable_80 : _GEN_79; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_81 = 7'h51 == predictIndex ? phtTable_81 : _GEN_80; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_82 = 7'h52 == predictIndex ? phtTable_82 : _GEN_81; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_83 = 7'h53 == predictIndex ? phtTable_83 : _GEN_82; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_84 = 7'h54 == predictIndex ? phtTable_84 : _GEN_83; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_85 = 7'h55 == predictIndex ? phtTable_85 : _GEN_84; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_86 = 7'h56 == predictIndex ? phtTable_86 : _GEN_85; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_87 = 7'h57 == predictIndex ? phtTable_87 : _GEN_86; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_88 = 7'h58 == predictIndex ? phtTable_88 : _GEN_87; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_89 = 7'h59 == predictIndex ? phtTable_89 : _GEN_88; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_90 = 7'h5a == predictIndex ? phtTable_90 : _GEN_89; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_91 = 7'h5b == predictIndex ? phtTable_91 : _GEN_90; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_92 = 7'h5c == predictIndex ? phtTable_92 : _GEN_91; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_93 = 7'h5d == predictIndex ? phtTable_93 : _GEN_92; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_94 = 7'h5e == predictIndex ? phtTable_94 : _GEN_93; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_95 = 7'h5f == predictIndex ? phtTable_95 : _GEN_94; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_96 = 7'h60 == predictIndex ? phtTable_96 : _GEN_95; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_97 = 7'h61 == predictIndex ? phtTable_97 : _GEN_96; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_98 = 7'h62 == predictIndex ? phtTable_98 : _GEN_97; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_99 = 7'h63 == predictIndex ? phtTable_99 : _GEN_98; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_100 = 7'h64 == predictIndex ? phtTable_100 : _GEN_99; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_101 = 7'h65 == predictIndex ? phtTable_101 : _GEN_100; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_102 = 7'h66 == predictIndex ? phtTable_102 : _GEN_101; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_103 = 7'h67 == predictIndex ? phtTable_103 : _GEN_102; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_104 = 7'h68 == predictIndex ? phtTable_104 : _GEN_103; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_105 = 7'h69 == predictIndex ? phtTable_105 : _GEN_104; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_106 = 7'h6a == predictIndex ? phtTable_106 : _GEN_105; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_107 = 7'h6b == predictIndex ? phtTable_107 : _GEN_106; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_108 = 7'h6c == predictIndex ? phtTable_108 : _GEN_107; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_109 = 7'h6d == predictIndex ? phtTable_109 : _GEN_108; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_110 = 7'h6e == predictIndex ? phtTable_110 : _GEN_109; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_111 = 7'h6f == predictIndex ? phtTable_111 : _GEN_110; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_112 = 7'h70 == predictIndex ? phtTable_112 : _GEN_111; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_113 = 7'h71 == predictIndex ? phtTable_113 : _GEN_112; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_114 = 7'h72 == predictIndex ? phtTable_114 : _GEN_113; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_115 = 7'h73 == predictIndex ? phtTable_115 : _GEN_114; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_116 = 7'h74 == predictIndex ? phtTable_116 : _GEN_115; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_117 = 7'h75 == predictIndex ? phtTable_117 : _GEN_116; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_118 = 7'h76 == predictIndex ? phtTable_118 : _GEN_117; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_119 = 7'h77 == predictIndex ? phtTable_119 : _GEN_118; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_120 = 7'h78 == predictIndex ? phtTable_120 : _GEN_119; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_121 = 7'h79 == predictIndex ? phtTable_121 : _GEN_120; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_122 = 7'h7a == predictIndex ? phtTable_122 : _GEN_121; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_123 = 7'h7b == predictIndex ? phtTable_123 : _GEN_122; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_124 = 7'h7c == predictIndex ? phtTable_124 : _GEN_123; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_125 = 7'h7d == predictIndex ? phtTable_125 : _GEN_124; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_126 = 7'h7e == predictIndex ? phtTable_126 : _GEN_125; // @[dut.scala 27:{37,37}]
  wire [1:0] _GEN_127 = 7'h7f == predictIndex ? phtTable_127 : _GEN_126; // @[dut.scala 27:{37,37}]
  wire [7:0] _nextGHRPrediction_T = {ghr, 1'h0}; // @[dut.scala 29:32]
  wire [7:0] _GEN_898 = {{7'd0}, io_predict_taken}; // @[dut.scala 29:38]
  wire [7:0] nextGHRPrediction = _nextGHRPrediction_T | _GEN_898; // @[dut.scala 29:38]
  wire [6:0] trainIndex = io_train_pc ^ io_train_history; // @[dut.scala 32:32]
  wire [1:0] _GEN_129 = 7'h1 == trainIndex ? phtTable_1 : phtTable_0; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_130 = 7'h2 == trainIndex ? phtTable_2 : _GEN_129; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_131 = 7'h3 == trainIndex ? phtTable_3 : _GEN_130; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_132 = 7'h4 == trainIndex ? phtTable_4 : _GEN_131; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_133 = 7'h5 == trainIndex ? phtTable_5 : _GEN_132; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_134 = 7'h6 == trainIndex ? phtTable_6 : _GEN_133; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_135 = 7'h7 == trainIndex ? phtTable_7 : _GEN_134; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_136 = 7'h8 == trainIndex ? phtTable_8 : _GEN_135; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_137 = 7'h9 == trainIndex ? phtTable_9 : _GEN_136; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_138 = 7'ha == trainIndex ? phtTable_10 : _GEN_137; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_139 = 7'hb == trainIndex ? phtTable_11 : _GEN_138; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_140 = 7'hc == trainIndex ? phtTable_12 : _GEN_139; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_141 = 7'hd == trainIndex ? phtTable_13 : _GEN_140; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_142 = 7'he == trainIndex ? phtTable_14 : _GEN_141; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_143 = 7'hf == trainIndex ? phtTable_15 : _GEN_142; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_144 = 7'h10 == trainIndex ? phtTable_16 : _GEN_143; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_145 = 7'h11 == trainIndex ? phtTable_17 : _GEN_144; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_146 = 7'h12 == trainIndex ? phtTable_18 : _GEN_145; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_147 = 7'h13 == trainIndex ? phtTable_19 : _GEN_146; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_148 = 7'h14 == trainIndex ? phtTable_20 : _GEN_147; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_149 = 7'h15 == trainIndex ? phtTable_21 : _GEN_148; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_150 = 7'h16 == trainIndex ? phtTable_22 : _GEN_149; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_151 = 7'h17 == trainIndex ? phtTable_23 : _GEN_150; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_152 = 7'h18 == trainIndex ? phtTable_24 : _GEN_151; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_153 = 7'h19 == trainIndex ? phtTable_25 : _GEN_152; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_154 = 7'h1a == trainIndex ? phtTable_26 : _GEN_153; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_155 = 7'h1b == trainIndex ? phtTable_27 : _GEN_154; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_156 = 7'h1c == trainIndex ? phtTable_28 : _GEN_155; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_157 = 7'h1d == trainIndex ? phtTable_29 : _GEN_156; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_158 = 7'h1e == trainIndex ? phtTable_30 : _GEN_157; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_159 = 7'h1f == trainIndex ? phtTable_31 : _GEN_158; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_160 = 7'h20 == trainIndex ? phtTable_32 : _GEN_159; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_161 = 7'h21 == trainIndex ? phtTable_33 : _GEN_160; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_162 = 7'h22 == trainIndex ? phtTable_34 : _GEN_161; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_163 = 7'h23 == trainIndex ? phtTable_35 : _GEN_162; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_164 = 7'h24 == trainIndex ? phtTable_36 : _GEN_163; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_165 = 7'h25 == trainIndex ? phtTable_37 : _GEN_164; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_166 = 7'h26 == trainIndex ? phtTable_38 : _GEN_165; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_167 = 7'h27 == trainIndex ? phtTable_39 : _GEN_166; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_168 = 7'h28 == trainIndex ? phtTable_40 : _GEN_167; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_169 = 7'h29 == trainIndex ? phtTable_41 : _GEN_168; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_170 = 7'h2a == trainIndex ? phtTable_42 : _GEN_169; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_171 = 7'h2b == trainIndex ? phtTable_43 : _GEN_170; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_172 = 7'h2c == trainIndex ? phtTable_44 : _GEN_171; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_173 = 7'h2d == trainIndex ? phtTable_45 : _GEN_172; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_174 = 7'h2e == trainIndex ? phtTable_46 : _GEN_173; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_175 = 7'h2f == trainIndex ? phtTable_47 : _GEN_174; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_176 = 7'h30 == trainIndex ? phtTable_48 : _GEN_175; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_177 = 7'h31 == trainIndex ? phtTable_49 : _GEN_176; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_178 = 7'h32 == trainIndex ? phtTable_50 : _GEN_177; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_179 = 7'h33 == trainIndex ? phtTable_51 : _GEN_178; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_180 = 7'h34 == trainIndex ? phtTable_52 : _GEN_179; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_181 = 7'h35 == trainIndex ? phtTable_53 : _GEN_180; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_182 = 7'h36 == trainIndex ? phtTable_54 : _GEN_181; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_183 = 7'h37 == trainIndex ? phtTable_55 : _GEN_182; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_184 = 7'h38 == trainIndex ? phtTable_56 : _GEN_183; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_185 = 7'h39 == trainIndex ? phtTable_57 : _GEN_184; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_186 = 7'h3a == trainIndex ? phtTable_58 : _GEN_185; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_187 = 7'h3b == trainIndex ? phtTable_59 : _GEN_186; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_188 = 7'h3c == trainIndex ? phtTable_60 : _GEN_187; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_189 = 7'h3d == trainIndex ? phtTable_61 : _GEN_188; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_190 = 7'h3e == trainIndex ? phtTable_62 : _GEN_189; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_191 = 7'h3f == trainIndex ? phtTable_63 : _GEN_190; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_192 = 7'h40 == trainIndex ? phtTable_64 : _GEN_191; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_193 = 7'h41 == trainIndex ? phtTable_65 : _GEN_192; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_194 = 7'h42 == trainIndex ? phtTable_66 : _GEN_193; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_195 = 7'h43 == trainIndex ? phtTable_67 : _GEN_194; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_196 = 7'h44 == trainIndex ? phtTable_68 : _GEN_195; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_197 = 7'h45 == trainIndex ? phtTable_69 : _GEN_196; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_198 = 7'h46 == trainIndex ? phtTable_70 : _GEN_197; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_199 = 7'h47 == trainIndex ? phtTable_71 : _GEN_198; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_200 = 7'h48 == trainIndex ? phtTable_72 : _GEN_199; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_201 = 7'h49 == trainIndex ? phtTable_73 : _GEN_200; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_202 = 7'h4a == trainIndex ? phtTable_74 : _GEN_201; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_203 = 7'h4b == trainIndex ? phtTable_75 : _GEN_202; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_204 = 7'h4c == trainIndex ? phtTable_76 : _GEN_203; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_205 = 7'h4d == trainIndex ? phtTable_77 : _GEN_204; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_206 = 7'h4e == trainIndex ? phtTable_78 : _GEN_205; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_207 = 7'h4f == trainIndex ? phtTable_79 : _GEN_206; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_208 = 7'h50 == trainIndex ? phtTable_80 : _GEN_207; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_209 = 7'h51 == trainIndex ? phtTable_81 : _GEN_208; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_210 = 7'h52 == trainIndex ? phtTable_82 : _GEN_209; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_211 = 7'h53 == trainIndex ? phtTable_83 : _GEN_210; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_212 = 7'h54 == trainIndex ? phtTable_84 : _GEN_211; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_213 = 7'h55 == trainIndex ? phtTable_85 : _GEN_212; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_214 = 7'h56 == trainIndex ? phtTable_86 : _GEN_213; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_215 = 7'h57 == trainIndex ? phtTable_87 : _GEN_214; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_216 = 7'h58 == trainIndex ? phtTable_88 : _GEN_215; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_217 = 7'h59 == trainIndex ? phtTable_89 : _GEN_216; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_218 = 7'h5a == trainIndex ? phtTable_90 : _GEN_217; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_219 = 7'h5b == trainIndex ? phtTable_91 : _GEN_218; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_220 = 7'h5c == trainIndex ? phtTable_92 : _GEN_219; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_221 = 7'h5d == trainIndex ? phtTable_93 : _GEN_220; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_222 = 7'h5e == trainIndex ? phtTable_94 : _GEN_221; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_223 = 7'h5f == trainIndex ? phtTable_95 : _GEN_222; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_224 = 7'h60 == trainIndex ? phtTable_96 : _GEN_223; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_225 = 7'h61 == trainIndex ? phtTable_97 : _GEN_224; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_226 = 7'h62 == trainIndex ? phtTable_98 : _GEN_225; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_227 = 7'h63 == trainIndex ? phtTable_99 : _GEN_226; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_228 = 7'h64 == trainIndex ? phtTable_100 : _GEN_227; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_229 = 7'h65 == trainIndex ? phtTable_101 : _GEN_228; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_230 = 7'h66 == trainIndex ? phtTable_102 : _GEN_229; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_231 = 7'h67 == trainIndex ? phtTable_103 : _GEN_230; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_232 = 7'h68 == trainIndex ? phtTable_104 : _GEN_231; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_233 = 7'h69 == trainIndex ? phtTable_105 : _GEN_232; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_234 = 7'h6a == trainIndex ? phtTable_106 : _GEN_233; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_235 = 7'h6b == trainIndex ? phtTable_107 : _GEN_234; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_236 = 7'h6c == trainIndex ? phtTable_108 : _GEN_235; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_237 = 7'h6d == trainIndex ? phtTable_109 : _GEN_236; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_238 = 7'h6e == trainIndex ? phtTable_110 : _GEN_237; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_239 = 7'h6f == trainIndex ? phtTable_111 : _GEN_238; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_240 = 7'h70 == trainIndex ? phtTable_112 : _GEN_239; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_241 = 7'h71 == trainIndex ? phtTable_113 : _GEN_240; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_242 = 7'h72 == trainIndex ? phtTable_114 : _GEN_241; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_243 = 7'h73 == trainIndex ? phtTable_115 : _GEN_242; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_244 = 7'h74 == trainIndex ? phtTable_116 : _GEN_243; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_245 = 7'h75 == trainIndex ? phtTable_117 : _GEN_244; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_246 = 7'h76 == trainIndex ? phtTable_118 : _GEN_245; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_247 = 7'h77 == trainIndex ? phtTable_119 : _GEN_246; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_248 = 7'h78 == trainIndex ? phtTable_120 : _GEN_247; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_249 = 7'h79 == trainIndex ? phtTable_121 : _GEN_248; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_250 = 7'h7a == trainIndex ? phtTable_122 : _GEN_249; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_251 = 7'h7b == trainIndex ? phtTable_123 : _GEN_250; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_252 = 7'h7c == trainIndex ? phtTable_124 : _GEN_251; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_253 = 7'h7d == trainIndex ? phtTable_125 : _GEN_252; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_254 = 7'h7e == trainIndex ? phtTable_126 : _GEN_253; // @[dut.scala 38:{58,58}]
  wire [1:0] _GEN_255 = 7'h7f == trainIndex ? phtTable_127 : _GEN_254; // @[dut.scala 38:{58,58}]
  wire [1:0] _updatedPHT_T_2 = _GEN_255 + 2'h1; // @[dut.scala 38:93]
  wire [1:0] _updatedPHT_T_3 = _GEN_255 == 2'h3 ? 2'h3 : _updatedPHT_T_2; // @[dut.scala 38:36]
  wire [1:0] _GEN_256 = 7'h0 == trainIndex ? _updatedPHT_T_3 : phtTable_0; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_257 = 7'h1 == trainIndex ? _updatedPHT_T_3 : phtTable_1; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_258 = 7'h2 == trainIndex ? _updatedPHT_T_3 : phtTable_2; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_259 = 7'h3 == trainIndex ? _updatedPHT_T_3 : phtTable_3; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_260 = 7'h4 == trainIndex ? _updatedPHT_T_3 : phtTable_4; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_261 = 7'h5 == trainIndex ? _updatedPHT_T_3 : phtTable_5; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_262 = 7'h6 == trainIndex ? _updatedPHT_T_3 : phtTable_6; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_263 = 7'h7 == trainIndex ? _updatedPHT_T_3 : phtTable_7; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_264 = 7'h8 == trainIndex ? _updatedPHT_T_3 : phtTable_8; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_265 = 7'h9 == trainIndex ? _updatedPHT_T_3 : phtTable_9; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_266 = 7'ha == trainIndex ? _updatedPHT_T_3 : phtTable_10; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_267 = 7'hb == trainIndex ? _updatedPHT_T_3 : phtTable_11; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_268 = 7'hc == trainIndex ? _updatedPHT_T_3 : phtTable_12; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_269 = 7'hd == trainIndex ? _updatedPHT_T_3 : phtTable_13; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_270 = 7'he == trainIndex ? _updatedPHT_T_3 : phtTable_14; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_271 = 7'hf == trainIndex ? _updatedPHT_T_3 : phtTable_15; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_272 = 7'h10 == trainIndex ? _updatedPHT_T_3 : phtTable_16; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_273 = 7'h11 == trainIndex ? _updatedPHT_T_3 : phtTable_17; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_274 = 7'h12 == trainIndex ? _updatedPHT_T_3 : phtTable_18; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_275 = 7'h13 == trainIndex ? _updatedPHT_T_3 : phtTable_19; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_276 = 7'h14 == trainIndex ? _updatedPHT_T_3 : phtTable_20; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_277 = 7'h15 == trainIndex ? _updatedPHT_T_3 : phtTable_21; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_278 = 7'h16 == trainIndex ? _updatedPHT_T_3 : phtTable_22; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_279 = 7'h17 == trainIndex ? _updatedPHT_T_3 : phtTable_23; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_280 = 7'h18 == trainIndex ? _updatedPHT_T_3 : phtTable_24; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_281 = 7'h19 == trainIndex ? _updatedPHT_T_3 : phtTable_25; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_282 = 7'h1a == trainIndex ? _updatedPHT_T_3 : phtTable_26; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_283 = 7'h1b == trainIndex ? _updatedPHT_T_3 : phtTable_27; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_284 = 7'h1c == trainIndex ? _updatedPHT_T_3 : phtTable_28; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_285 = 7'h1d == trainIndex ? _updatedPHT_T_3 : phtTable_29; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_286 = 7'h1e == trainIndex ? _updatedPHT_T_3 : phtTable_30; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_287 = 7'h1f == trainIndex ? _updatedPHT_T_3 : phtTable_31; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_288 = 7'h20 == trainIndex ? _updatedPHT_T_3 : phtTable_32; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_289 = 7'h21 == trainIndex ? _updatedPHT_T_3 : phtTable_33; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_290 = 7'h22 == trainIndex ? _updatedPHT_T_3 : phtTable_34; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_291 = 7'h23 == trainIndex ? _updatedPHT_T_3 : phtTable_35; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_292 = 7'h24 == trainIndex ? _updatedPHT_T_3 : phtTable_36; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_293 = 7'h25 == trainIndex ? _updatedPHT_T_3 : phtTable_37; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_294 = 7'h26 == trainIndex ? _updatedPHT_T_3 : phtTable_38; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_295 = 7'h27 == trainIndex ? _updatedPHT_T_3 : phtTable_39; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_296 = 7'h28 == trainIndex ? _updatedPHT_T_3 : phtTable_40; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_297 = 7'h29 == trainIndex ? _updatedPHT_T_3 : phtTable_41; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_298 = 7'h2a == trainIndex ? _updatedPHT_T_3 : phtTable_42; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_299 = 7'h2b == trainIndex ? _updatedPHT_T_3 : phtTable_43; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_300 = 7'h2c == trainIndex ? _updatedPHT_T_3 : phtTable_44; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_301 = 7'h2d == trainIndex ? _updatedPHT_T_3 : phtTable_45; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_302 = 7'h2e == trainIndex ? _updatedPHT_T_3 : phtTable_46; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_303 = 7'h2f == trainIndex ? _updatedPHT_T_3 : phtTable_47; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_304 = 7'h30 == trainIndex ? _updatedPHT_T_3 : phtTable_48; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_305 = 7'h31 == trainIndex ? _updatedPHT_T_3 : phtTable_49; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_306 = 7'h32 == trainIndex ? _updatedPHT_T_3 : phtTable_50; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_307 = 7'h33 == trainIndex ? _updatedPHT_T_3 : phtTable_51; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_308 = 7'h34 == trainIndex ? _updatedPHT_T_3 : phtTable_52; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_309 = 7'h35 == trainIndex ? _updatedPHT_T_3 : phtTable_53; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_310 = 7'h36 == trainIndex ? _updatedPHT_T_3 : phtTable_54; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_311 = 7'h37 == trainIndex ? _updatedPHT_T_3 : phtTable_55; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_312 = 7'h38 == trainIndex ? _updatedPHT_T_3 : phtTable_56; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_313 = 7'h39 == trainIndex ? _updatedPHT_T_3 : phtTable_57; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_314 = 7'h3a == trainIndex ? _updatedPHT_T_3 : phtTable_58; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_315 = 7'h3b == trainIndex ? _updatedPHT_T_3 : phtTable_59; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_316 = 7'h3c == trainIndex ? _updatedPHT_T_3 : phtTable_60; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_317 = 7'h3d == trainIndex ? _updatedPHT_T_3 : phtTable_61; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_318 = 7'h3e == trainIndex ? _updatedPHT_T_3 : phtTable_62; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_319 = 7'h3f == trainIndex ? _updatedPHT_T_3 : phtTable_63; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_320 = 7'h40 == trainIndex ? _updatedPHT_T_3 : phtTable_64; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_321 = 7'h41 == trainIndex ? _updatedPHT_T_3 : phtTable_65; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_322 = 7'h42 == trainIndex ? _updatedPHT_T_3 : phtTable_66; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_323 = 7'h43 == trainIndex ? _updatedPHT_T_3 : phtTable_67; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_324 = 7'h44 == trainIndex ? _updatedPHT_T_3 : phtTable_68; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_325 = 7'h45 == trainIndex ? _updatedPHT_T_3 : phtTable_69; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_326 = 7'h46 == trainIndex ? _updatedPHT_T_3 : phtTable_70; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_327 = 7'h47 == trainIndex ? _updatedPHT_T_3 : phtTable_71; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_328 = 7'h48 == trainIndex ? _updatedPHT_T_3 : phtTable_72; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_329 = 7'h49 == trainIndex ? _updatedPHT_T_3 : phtTable_73; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_330 = 7'h4a == trainIndex ? _updatedPHT_T_3 : phtTable_74; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_331 = 7'h4b == trainIndex ? _updatedPHT_T_3 : phtTable_75; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_332 = 7'h4c == trainIndex ? _updatedPHT_T_3 : phtTable_76; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_333 = 7'h4d == trainIndex ? _updatedPHT_T_3 : phtTable_77; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_334 = 7'h4e == trainIndex ? _updatedPHT_T_3 : phtTable_78; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_335 = 7'h4f == trainIndex ? _updatedPHT_T_3 : phtTable_79; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_336 = 7'h50 == trainIndex ? _updatedPHT_T_3 : phtTable_80; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_337 = 7'h51 == trainIndex ? _updatedPHT_T_3 : phtTable_81; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_338 = 7'h52 == trainIndex ? _updatedPHT_T_3 : phtTable_82; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_339 = 7'h53 == trainIndex ? _updatedPHT_T_3 : phtTable_83; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_340 = 7'h54 == trainIndex ? _updatedPHT_T_3 : phtTable_84; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_341 = 7'h55 == trainIndex ? _updatedPHT_T_3 : phtTable_85; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_342 = 7'h56 == trainIndex ? _updatedPHT_T_3 : phtTable_86; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_343 = 7'h57 == trainIndex ? _updatedPHT_T_3 : phtTable_87; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_344 = 7'h58 == trainIndex ? _updatedPHT_T_3 : phtTable_88; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_345 = 7'h59 == trainIndex ? _updatedPHT_T_3 : phtTable_89; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_346 = 7'h5a == trainIndex ? _updatedPHT_T_3 : phtTable_90; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_347 = 7'h5b == trainIndex ? _updatedPHT_T_3 : phtTable_91; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_348 = 7'h5c == trainIndex ? _updatedPHT_T_3 : phtTable_92; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_349 = 7'h5d == trainIndex ? _updatedPHT_T_3 : phtTable_93; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_350 = 7'h5e == trainIndex ? _updatedPHT_T_3 : phtTable_94; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_351 = 7'h5f == trainIndex ? _updatedPHT_T_3 : phtTable_95; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_352 = 7'h60 == trainIndex ? _updatedPHT_T_3 : phtTable_96; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_353 = 7'h61 == trainIndex ? _updatedPHT_T_3 : phtTable_97; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_354 = 7'h62 == trainIndex ? _updatedPHT_T_3 : phtTable_98; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_355 = 7'h63 == trainIndex ? _updatedPHT_T_3 : phtTable_99; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_356 = 7'h64 == trainIndex ? _updatedPHT_T_3 : phtTable_100; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_357 = 7'h65 == trainIndex ? _updatedPHT_T_3 : phtTable_101; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_358 = 7'h66 == trainIndex ? _updatedPHT_T_3 : phtTable_102; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_359 = 7'h67 == trainIndex ? _updatedPHT_T_3 : phtTable_103; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_360 = 7'h68 == trainIndex ? _updatedPHT_T_3 : phtTable_104; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_361 = 7'h69 == trainIndex ? _updatedPHT_T_3 : phtTable_105; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_362 = 7'h6a == trainIndex ? _updatedPHT_T_3 : phtTable_106; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_363 = 7'h6b == trainIndex ? _updatedPHT_T_3 : phtTable_107; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_364 = 7'h6c == trainIndex ? _updatedPHT_T_3 : phtTable_108; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_365 = 7'h6d == trainIndex ? _updatedPHT_T_3 : phtTable_109; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_366 = 7'h6e == trainIndex ? _updatedPHT_T_3 : phtTable_110; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_367 = 7'h6f == trainIndex ? _updatedPHT_T_3 : phtTable_111; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_368 = 7'h70 == trainIndex ? _updatedPHT_T_3 : phtTable_112; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_369 = 7'h71 == trainIndex ? _updatedPHT_T_3 : phtTable_113; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_370 = 7'h72 == trainIndex ? _updatedPHT_T_3 : phtTable_114; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_371 = 7'h73 == trainIndex ? _updatedPHT_T_3 : phtTable_115; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_372 = 7'h74 == trainIndex ? _updatedPHT_T_3 : phtTable_116; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_373 = 7'h75 == trainIndex ? _updatedPHT_T_3 : phtTable_117; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_374 = 7'h76 == trainIndex ? _updatedPHT_T_3 : phtTable_118; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_375 = 7'h77 == trainIndex ? _updatedPHT_T_3 : phtTable_119; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_376 = 7'h78 == trainIndex ? _updatedPHT_T_3 : phtTable_120; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_377 = 7'h79 == trainIndex ? _updatedPHT_T_3 : phtTable_121; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_378 = 7'h7a == trainIndex ? _updatedPHT_T_3 : phtTable_122; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_379 = 7'h7b == trainIndex ? _updatedPHT_T_3 : phtTable_123; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_380 = 7'h7c == trainIndex ? _updatedPHT_T_3 : phtTable_124; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_381 = 7'h7d == trainIndex ? _updatedPHT_T_3 : phtTable_125; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_382 = 7'h7e == trainIndex ? _updatedPHT_T_3 : phtTable_126; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _GEN_383 = 7'h7f == trainIndex ? _updatedPHT_T_3 : phtTable_127; // @[dut.scala 33:28 38:{30,30}]
  wire [1:0] _updatedPHT_T_6 = _GEN_255 - 2'h1; // @[dut.scala 40:93]
  wire [1:0] _updatedPHT_T_7 = _GEN_255 == 2'h0 ? 2'h0 : _updatedPHT_T_6; // @[dut.scala 40:36]
  wire [1:0] _GEN_384 = 7'h0 == trainIndex ? _updatedPHT_T_7 : phtTable_0; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_385 = 7'h1 == trainIndex ? _updatedPHT_T_7 : phtTable_1; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_386 = 7'h2 == trainIndex ? _updatedPHT_T_7 : phtTable_2; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_387 = 7'h3 == trainIndex ? _updatedPHT_T_7 : phtTable_3; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_388 = 7'h4 == trainIndex ? _updatedPHT_T_7 : phtTable_4; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_389 = 7'h5 == trainIndex ? _updatedPHT_T_7 : phtTable_5; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_390 = 7'h6 == trainIndex ? _updatedPHT_T_7 : phtTable_6; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_391 = 7'h7 == trainIndex ? _updatedPHT_T_7 : phtTable_7; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_392 = 7'h8 == trainIndex ? _updatedPHT_T_7 : phtTable_8; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_393 = 7'h9 == trainIndex ? _updatedPHT_T_7 : phtTable_9; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_394 = 7'ha == trainIndex ? _updatedPHT_T_7 : phtTable_10; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_395 = 7'hb == trainIndex ? _updatedPHT_T_7 : phtTable_11; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_396 = 7'hc == trainIndex ? _updatedPHT_T_7 : phtTable_12; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_397 = 7'hd == trainIndex ? _updatedPHT_T_7 : phtTable_13; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_398 = 7'he == trainIndex ? _updatedPHT_T_7 : phtTable_14; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_399 = 7'hf == trainIndex ? _updatedPHT_T_7 : phtTable_15; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_400 = 7'h10 == trainIndex ? _updatedPHT_T_7 : phtTable_16; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_401 = 7'h11 == trainIndex ? _updatedPHT_T_7 : phtTable_17; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_402 = 7'h12 == trainIndex ? _updatedPHT_T_7 : phtTable_18; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_403 = 7'h13 == trainIndex ? _updatedPHT_T_7 : phtTable_19; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_404 = 7'h14 == trainIndex ? _updatedPHT_T_7 : phtTable_20; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_405 = 7'h15 == trainIndex ? _updatedPHT_T_7 : phtTable_21; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_406 = 7'h16 == trainIndex ? _updatedPHT_T_7 : phtTable_22; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_407 = 7'h17 == trainIndex ? _updatedPHT_T_7 : phtTable_23; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_408 = 7'h18 == trainIndex ? _updatedPHT_T_7 : phtTable_24; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_409 = 7'h19 == trainIndex ? _updatedPHT_T_7 : phtTable_25; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_410 = 7'h1a == trainIndex ? _updatedPHT_T_7 : phtTable_26; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_411 = 7'h1b == trainIndex ? _updatedPHT_T_7 : phtTable_27; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_412 = 7'h1c == trainIndex ? _updatedPHT_T_7 : phtTable_28; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_413 = 7'h1d == trainIndex ? _updatedPHT_T_7 : phtTable_29; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_414 = 7'h1e == trainIndex ? _updatedPHT_T_7 : phtTable_30; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_415 = 7'h1f == trainIndex ? _updatedPHT_T_7 : phtTable_31; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_416 = 7'h20 == trainIndex ? _updatedPHT_T_7 : phtTable_32; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_417 = 7'h21 == trainIndex ? _updatedPHT_T_7 : phtTable_33; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_418 = 7'h22 == trainIndex ? _updatedPHT_T_7 : phtTable_34; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_419 = 7'h23 == trainIndex ? _updatedPHT_T_7 : phtTable_35; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_420 = 7'h24 == trainIndex ? _updatedPHT_T_7 : phtTable_36; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_421 = 7'h25 == trainIndex ? _updatedPHT_T_7 : phtTable_37; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_422 = 7'h26 == trainIndex ? _updatedPHT_T_7 : phtTable_38; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_423 = 7'h27 == trainIndex ? _updatedPHT_T_7 : phtTable_39; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_424 = 7'h28 == trainIndex ? _updatedPHT_T_7 : phtTable_40; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_425 = 7'h29 == trainIndex ? _updatedPHT_T_7 : phtTable_41; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_426 = 7'h2a == trainIndex ? _updatedPHT_T_7 : phtTable_42; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_427 = 7'h2b == trainIndex ? _updatedPHT_T_7 : phtTable_43; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_428 = 7'h2c == trainIndex ? _updatedPHT_T_7 : phtTable_44; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_429 = 7'h2d == trainIndex ? _updatedPHT_T_7 : phtTable_45; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_430 = 7'h2e == trainIndex ? _updatedPHT_T_7 : phtTable_46; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_431 = 7'h2f == trainIndex ? _updatedPHT_T_7 : phtTable_47; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_432 = 7'h30 == trainIndex ? _updatedPHT_T_7 : phtTable_48; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_433 = 7'h31 == trainIndex ? _updatedPHT_T_7 : phtTable_49; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_434 = 7'h32 == trainIndex ? _updatedPHT_T_7 : phtTable_50; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_435 = 7'h33 == trainIndex ? _updatedPHT_T_7 : phtTable_51; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_436 = 7'h34 == trainIndex ? _updatedPHT_T_7 : phtTable_52; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_437 = 7'h35 == trainIndex ? _updatedPHT_T_7 : phtTable_53; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_438 = 7'h36 == trainIndex ? _updatedPHT_T_7 : phtTable_54; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_439 = 7'h37 == trainIndex ? _updatedPHT_T_7 : phtTable_55; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_440 = 7'h38 == trainIndex ? _updatedPHT_T_7 : phtTable_56; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_441 = 7'h39 == trainIndex ? _updatedPHT_T_7 : phtTable_57; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_442 = 7'h3a == trainIndex ? _updatedPHT_T_7 : phtTable_58; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_443 = 7'h3b == trainIndex ? _updatedPHT_T_7 : phtTable_59; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_444 = 7'h3c == trainIndex ? _updatedPHT_T_7 : phtTable_60; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_445 = 7'h3d == trainIndex ? _updatedPHT_T_7 : phtTable_61; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_446 = 7'h3e == trainIndex ? _updatedPHT_T_7 : phtTable_62; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_447 = 7'h3f == trainIndex ? _updatedPHT_T_7 : phtTable_63; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_448 = 7'h40 == trainIndex ? _updatedPHT_T_7 : phtTable_64; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_449 = 7'h41 == trainIndex ? _updatedPHT_T_7 : phtTable_65; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_450 = 7'h42 == trainIndex ? _updatedPHT_T_7 : phtTable_66; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_451 = 7'h43 == trainIndex ? _updatedPHT_T_7 : phtTable_67; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_452 = 7'h44 == trainIndex ? _updatedPHT_T_7 : phtTable_68; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_453 = 7'h45 == trainIndex ? _updatedPHT_T_7 : phtTable_69; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_454 = 7'h46 == trainIndex ? _updatedPHT_T_7 : phtTable_70; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_455 = 7'h47 == trainIndex ? _updatedPHT_T_7 : phtTable_71; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_456 = 7'h48 == trainIndex ? _updatedPHT_T_7 : phtTable_72; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_457 = 7'h49 == trainIndex ? _updatedPHT_T_7 : phtTable_73; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_458 = 7'h4a == trainIndex ? _updatedPHT_T_7 : phtTable_74; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_459 = 7'h4b == trainIndex ? _updatedPHT_T_7 : phtTable_75; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_460 = 7'h4c == trainIndex ? _updatedPHT_T_7 : phtTable_76; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_461 = 7'h4d == trainIndex ? _updatedPHT_T_7 : phtTable_77; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_462 = 7'h4e == trainIndex ? _updatedPHT_T_7 : phtTable_78; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_463 = 7'h4f == trainIndex ? _updatedPHT_T_7 : phtTable_79; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_464 = 7'h50 == trainIndex ? _updatedPHT_T_7 : phtTable_80; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_465 = 7'h51 == trainIndex ? _updatedPHT_T_7 : phtTable_81; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_466 = 7'h52 == trainIndex ? _updatedPHT_T_7 : phtTable_82; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_467 = 7'h53 == trainIndex ? _updatedPHT_T_7 : phtTable_83; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_468 = 7'h54 == trainIndex ? _updatedPHT_T_7 : phtTable_84; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_469 = 7'h55 == trainIndex ? _updatedPHT_T_7 : phtTable_85; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_470 = 7'h56 == trainIndex ? _updatedPHT_T_7 : phtTable_86; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_471 = 7'h57 == trainIndex ? _updatedPHT_T_7 : phtTable_87; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_472 = 7'h58 == trainIndex ? _updatedPHT_T_7 : phtTable_88; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_473 = 7'h59 == trainIndex ? _updatedPHT_T_7 : phtTable_89; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_474 = 7'h5a == trainIndex ? _updatedPHT_T_7 : phtTable_90; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_475 = 7'h5b == trainIndex ? _updatedPHT_T_7 : phtTable_91; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_476 = 7'h5c == trainIndex ? _updatedPHT_T_7 : phtTable_92; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_477 = 7'h5d == trainIndex ? _updatedPHT_T_7 : phtTable_93; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_478 = 7'h5e == trainIndex ? _updatedPHT_T_7 : phtTable_94; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_479 = 7'h5f == trainIndex ? _updatedPHT_T_7 : phtTable_95; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_480 = 7'h60 == trainIndex ? _updatedPHT_T_7 : phtTable_96; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_481 = 7'h61 == trainIndex ? _updatedPHT_T_7 : phtTable_97; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_482 = 7'h62 == trainIndex ? _updatedPHT_T_7 : phtTable_98; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_483 = 7'h63 == trainIndex ? _updatedPHT_T_7 : phtTable_99; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_484 = 7'h64 == trainIndex ? _updatedPHT_T_7 : phtTable_100; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_485 = 7'h65 == trainIndex ? _updatedPHT_T_7 : phtTable_101; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_486 = 7'h66 == trainIndex ? _updatedPHT_T_7 : phtTable_102; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_487 = 7'h67 == trainIndex ? _updatedPHT_T_7 : phtTable_103; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_488 = 7'h68 == trainIndex ? _updatedPHT_T_7 : phtTable_104; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_489 = 7'h69 == trainIndex ? _updatedPHT_T_7 : phtTable_105; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_490 = 7'h6a == trainIndex ? _updatedPHT_T_7 : phtTable_106; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_491 = 7'h6b == trainIndex ? _updatedPHT_T_7 : phtTable_107; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_492 = 7'h6c == trainIndex ? _updatedPHT_T_7 : phtTable_108; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_493 = 7'h6d == trainIndex ? _updatedPHT_T_7 : phtTable_109; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_494 = 7'h6e == trainIndex ? _updatedPHT_T_7 : phtTable_110; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_495 = 7'h6f == trainIndex ? _updatedPHT_T_7 : phtTable_111; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_496 = 7'h70 == trainIndex ? _updatedPHT_T_7 : phtTable_112; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_497 = 7'h71 == trainIndex ? _updatedPHT_T_7 : phtTable_113; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_498 = 7'h72 == trainIndex ? _updatedPHT_T_7 : phtTable_114; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_499 = 7'h73 == trainIndex ? _updatedPHT_T_7 : phtTable_115; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_500 = 7'h74 == trainIndex ? _updatedPHT_T_7 : phtTable_116; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_501 = 7'h75 == trainIndex ? _updatedPHT_T_7 : phtTable_117; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_502 = 7'h76 == trainIndex ? _updatedPHT_T_7 : phtTable_118; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_503 = 7'h77 == trainIndex ? _updatedPHT_T_7 : phtTable_119; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_504 = 7'h78 == trainIndex ? _updatedPHT_T_7 : phtTable_120; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_505 = 7'h79 == trainIndex ? _updatedPHT_T_7 : phtTable_121; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_506 = 7'h7a == trainIndex ? _updatedPHT_T_7 : phtTable_122; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_507 = 7'h7b == trainIndex ? _updatedPHT_T_7 : phtTable_123; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_508 = 7'h7c == trainIndex ? _updatedPHT_T_7 : phtTable_124; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_509 = 7'h7d == trainIndex ? _updatedPHT_T_7 : phtTable_125; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_510 = 7'h7e == trainIndex ? _updatedPHT_T_7 : phtTable_126; // @[dut.scala 33:28 40:{30,30}]
  wire [1:0] _GEN_511 = 7'h7f == trainIndex ? _updatedPHT_T_7 : phtTable_127; // @[dut.scala 33:28 40:{30,30}]
  wire [7:0] _correctedGHR_T = {io_train_history, 1'h0}; // @[dut.scala 44:40]
  wire [7:0] _GEN_899 = {{7'd0}, io_train_taken}; // @[dut.scala 44:46]
  wire [7:0] correctedGHR = _correctedGHR_T | _GEN_899; // @[dut.scala 44:46]
  wire [7:0] _GEN_768 = io_predict_valid ? nextGHRPrediction : {{1'd0}, ghr}; // @[dut.scala 50:11 53:32 54:13]
  wire [7:0] _GEN_769 = io_train_valid & io_train_mispredicted ? correctedGHR : _GEN_768; // @[dut.scala 51:49 52:13]
  wire [6:0] nextGHR = _GEN_769[6:0]; // @[dut.scala 49:21]
  assign io_predict_taken = _GEN_127[1]; // @[dut.scala 27:37]
  assign io_predict_history = ghr; // @[dut.scala 28:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:25]
      phtTable_0 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_0 <= _GEN_256;
        end else begin
          phtTable_0 <= _GEN_384;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_1 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_1 <= _GEN_257;
        end else begin
          phtTable_1 <= _GEN_385;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_2 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_2 <= _GEN_258;
        end else begin
          phtTable_2 <= _GEN_386;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_3 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_3 <= _GEN_259;
        end else begin
          phtTable_3 <= _GEN_387;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_4 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_4 <= _GEN_260;
        end else begin
          phtTable_4 <= _GEN_388;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_5 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_5 <= _GEN_261;
        end else begin
          phtTable_5 <= _GEN_389;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_6 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_6 <= _GEN_262;
        end else begin
          phtTable_6 <= _GEN_390;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_7 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_7 <= _GEN_263;
        end else begin
          phtTable_7 <= _GEN_391;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_8 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_8 <= _GEN_264;
        end else begin
          phtTable_8 <= _GEN_392;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_9 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_9 <= _GEN_265;
        end else begin
          phtTable_9 <= _GEN_393;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_10 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_10 <= _GEN_266;
        end else begin
          phtTable_10 <= _GEN_394;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_11 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_11 <= _GEN_267;
        end else begin
          phtTable_11 <= _GEN_395;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_12 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_12 <= _GEN_268;
        end else begin
          phtTable_12 <= _GEN_396;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_13 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_13 <= _GEN_269;
        end else begin
          phtTable_13 <= _GEN_397;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_14 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_14 <= _GEN_270;
        end else begin
          phtTable_14 <= _GEN_398;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_15 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_15 <= _GEN_271;
        end else begin
          phtTable_15 <= _GEN_399;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_16 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_16 <= _GEN_272;
        end else begin
          phtTable_16 <= _GEN_400;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_17 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_17 <= _GEN_273;
        end else begin
          phtTable_17 <= _GEN_401;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_18 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_18 <= _GEN_274;
        end else begin
          phtTable_18 <= _GEN_402;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_19 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_19 <= _GEN_275;
        end else begin
          phtTable_19 <= _GEN_403;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_20 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_20 <= _GEN_276;
        end else begin
          phtTable_20 <= _GEN_404;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_21 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_21 <= _GEN_277;
        end else begin
          phtTable_21 <= _GEN_405;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_22 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_22 <= _GEN_278;
        end else begin
          phtTable_22 <= _GEN_406;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_23 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_23 <= _GEN_279;
        end else begin
          phtTable_23 <= _GEN_407;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_24 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_24 <= _GEN_280;
        end else begin
          phtTable_24 <= _GEN_408;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_25 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_25 <= _GEN_281;
        end else begin
          phtTable_25 <= _GEN_409;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_26 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_26 <= _GEN_282;
        end else begin
          phtTable_26 <= _GEN_410;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_27 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_27 <= _GEN_283;
        end else begin
          phtTable_27 <= _GEN_411;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_28 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_28 <= _GEN_284;
        end else begin
          phtTable_28 <= _GEN_412;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_29 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_29 <= _GEN_285;
        end else begin
          phtTable_29 <= _GEN_413;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_30 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_30 <= _GEN_286;
        end else begin
          phtTable_30 <= _GEN_414;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_31 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_31 <= _GEN_287;
        end else begin
          phtTable_31 <= _GEN_415;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_32 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_32 <= _GEN_288;
        end else begin
          phtTable_32 <= _GEN_416;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_33 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_33 <= _GEN_289;
        end else begin
          phtTable_33 <= _GEN_417;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_34 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_34 <= _GEN_290;
        end else begin
          phtTable_34 <= _GEN_418;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_35 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_35 <= _GEN_291;
        end else begin
          phtTable_35 <= _GEN_419;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_36 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_36 <= _GEN_292;
        end else begin
          phtTable_36 <= _GEN_420;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_37 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_37 <= _GEN_293;
        end else begin
          phtTable_37 <= _GEN_421;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_38 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_38 <= _GEN_294;
        end else begin
          phtTable_38 <= _GEN_422;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_39 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_39 <= _GEN_295;
        end else begin
          phtTable_39 <= _GEN_423;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_40 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_40 <= _GEN_296;
        end else begin
          phtTable_40 <= _GEN_424;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_41 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_41 <= _GEN_297;
        end else begin
          phtTable_41 <= _GEN_425;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_42 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_42 <= _GEN_298;
        end else begin
          phtTable_42 <= _GEN_426;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_43 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_43 <= _GEN_299;
        end else begin
          phtTable_43 <= _GEN_427;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_44 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_44 <= _GEN_300;
        end else begin
          phtTable_44 <= _GEN_428;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_45 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_45 <= _GEN_301;
        end else begin
          phtTable_45 <= _GEN_429;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_46 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_46 <= _GEN_302;
        end else begin
          phtTable_46 <= _GEN_430;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_47 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_47 <= _GEN_303;
        end else begin
          phtTable_47 <= _GEN_431;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_48 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_48 <= _GEN_304;
        end else begin
          phtTable_48 <= _GEN_432;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_49 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_49 <= _GEN_305;
        end else begin
          phtTable_49 <= _GEN_433;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_50 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_50 <= _GEN_306;
        end else begin
          phtTable_50 <= _GEN_434;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_51 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_51 <= _GEN_307;
        end else begin
          phtTable_51 <= _GEN_435;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_52 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_52 <= _GEN_308;
        end else begin
          phtTable_52 <= _GEN_436;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_53 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_53 <= _GEN_309;
        end else begin
          phtTable_53 <= _GEN_437;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_54 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_54 <= _GEN_310;
        end else begin
          phtTable_54 <= _GEN_438;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_55 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_55 <= _GEN_311;
        end else begin
          phtTable_55 <= _GEN_439;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_56 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_56 <= _GEN_312;
        end else begin
          phtTable_56 <= _GEN_440;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_57 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_57 <= _GEN_313;
        end else begin
          phtTable_57 <= _GEN_441;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_58 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_58 <= _GEN_314;
        end else begin
          phtTable_58 <= _GEN_442;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_59 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_59 <= _GEN_315;
        end else begin
          phtTable_59 <= _GEN_443;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_60 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_60 <= _GEN_316;
        end else begin
          phtTable_60 <= _GEN_444;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_61 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_61 <= _GEN_317;
        end else begin
          phtTable_61 <= _GEN_445;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_62 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_62 <= _GEN_318;
        end else begin
          phtTable_62 <= _GEN_446;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_63 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_63 <= _GEN_319;
        end else begin
          phtTable_63 <= _GEN_447;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_64 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_64 <= _GEN_320;
        end else begin
          phtTable_64 <= _GEN_448;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_65 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_65 <= _GEN_321;
        end else begin
          phtTable_65 <= _GEN_449;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_66 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_66 <= _GEN_322;
        end else begin
          phtTable_66 <= _GEN_450;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_67 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_67 <= _GEN_323;
        end else begin
          phtTable_67 <= _GEN_451;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_68 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_68 <= _GEN_324;
        end else begin
          phtTable_68 <= _GEN_452;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_69 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_69 <= _GEN_325;
        end else begin
          phtTable_69 <= _GEN_453;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_70 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_70 <= _GEN_326;
        end else begin
          phtTable_70 <= _GEN_454;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_71 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_71 <= _GEN_327;
        end else begin
          phtTable_71 <= _GEN_455;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_72 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_72 <= _GEN_328;
        end else begin
          phtTable_72 <= _GEN_456;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_73 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_73 <= _GEN_329;
        end else begin
          phtTable_73 <= _GEN_457;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_74 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_74 <= _GEN_330;
        end else begin
          phtTable_74 <= _GEN_458;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_75 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_75 <= _GEN_331;
        end else begin
          phtTable_75 <= _GEN_459;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_76 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_76 <= _GEN_332;
        end else begin
          phtTable_76 <= _GEN_460;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_77 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_77 <= _GEN_333;
        end else begin
          phtTable_77 <= _GEN_461;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_78 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_78 <= _GEN_334;
        end else begin
          phtTable_78 <= _GEN_462;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_79 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_79 <= _GEN_335;
        end else begin
          phtTable_79 <= _GEN_463;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_80 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_80 <= _GEN_336;
        end else begin
          phtTable_80 <= _GEN_464;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_81 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_81 <= _GEN_337;
        end else begin
          phtTable_81 <= _GEN_465;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_82 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_82 <= _GEN_338;
        end else begin
          phtTable_82 <= _GEN_466;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_83 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_83 <= _GEN_339;
        end else begin
          phtTable_83 <= _GEN_467;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_84 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_84 <= _GEN_340;
        end else begin
          phtTable_84 <= _GEN_468;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_85 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_85 <= _GEN_341;
        end else begin
          phtTable_85 <= _GEN_469;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_86 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_86 <= _GEN_342;
        end else begin
          phtTable_86 <= _GEN_470;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_87 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_87 <= _GEN_343;
        end else begin
          phtTable_87 <= _GEN_471;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_88 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_88 <= _GEN_344;
        end else begin
          phtTable_88 <= _GEN_472;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_89 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_89 <= _GEN_345;
        end else begin
          phtTable_89 <= _GEN_473;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_90 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_90 <= _GEN_346;
        end else begin
          phtTable_90 <= _GEN_474;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_91 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_91 <= _GEN_347;
        end else begin
          phtTable_91 <= _GEN_475;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_92 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_92 <= _GEN_348;
        end else begin
          phtTable_92 <= _GEN_476;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_93 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_93 <= _GEN_349;
        end else begin
          phtTable_93 <= _GEN_477;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_94 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_94 <= _GEN_350;
        end else begin
          phtTable_94 <= _GEN_478;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_95 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_95 <= _GEN_351;
        end else begin
          phtTable_95 <= _GEN_479;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_96 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_96 <= _GEN_352;
        end else begin
          phtTable_96 <= _GEN_480;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_97 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_97 <= _GEN_353;
        end else begin
          phtTable_97 <= _GEN_481;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_98 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_98 <= _GEN_354;
        end else begin
          phtTable_98 <= _GEN_482;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_99 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_99 <= _GEN_355;
        end else begin
          phtTable_99 <= _GEN_483;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_100 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_100 <= _GEN_356;
        end else begin
          phtTable_100 <= _GEN_484;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_101 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_101 <= _GEN_357;
        end else begin
          phtTable_101 <= _GEN_485;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_102 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_102 <= _GEN_358;
        end else begin
          phtTable_102 <= _GEN_486;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_103 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_103 <= _GEN_359;
        end else begin
          phtTable_103 <= _GEN_487;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_104 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_104 <= _GEN_360;
        end else begin
          phtTable_104 <= _GEN_488;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_105 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_105 <= _GEN_361;
        end else begin
          phtTable_105 <= _GEN_489;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_106 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_106 <= _GEN_362;
        end else begin
          phtTable_106 <= _GEN_490;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_107 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_107 <= _GEN_363;
        end else begin
          phtTable_107 <= _GEN_491;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_108 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_108 <= _GEN_364;
        end else begin
          phtTable_108 <= _GEN_492;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_109 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_109 <= _GEN_365;
        end else begin
          phtTable_109 <= _GEN_493;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_110 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_110 <= _GEN_366;
        end else begin
          phtTable_110 <= _GEN_494;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_111 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_111 <= _GEN_367;
        end else begin
          phtTable_111 <= _GEN_495;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_112 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_112 <= _GEN_368;
        end else begin
          phtTable_112 <= _GEN_496;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_113 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_113 <= _GEN_369;
        end else begin
          phtTable_113 <= _GEN_497;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_114 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_114 <= _GEN_370;
        end else begin
          phtTable_114 <= _GEN_498;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_115 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_115 <= _GEN_371;
        end else begin
          phtTable_115 <= _GEN_499;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_116 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_116 <= _GEN_372;
        end else begin
          phtTable_116 <= _GEN_500;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_117 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_117 <= _GEN_373;
        end else begin
          phtTable_117 <= _GEN_501;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_118 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_118 <= _GEN_374;
        end else begin
          phtTable_118 <= _GEN_502;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_119 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_119 <= _GEN_375;
        end else begin
          phtTable_119 <= _GEN_503;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_120 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_120 <= _GEN_376;
        end else begin
          phtTable_120 <= _GEN_504;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_121 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_121 <= _GEN_377;
        end else begin
          phtTable_121 <= _GEN_505;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_122 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_122 <= _GEN_378;
        end else begin
          phtTable_122 <= _GEN_506;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_123 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_123 <= _GEN_379;
        end else begin
          phtTable_123 <= _GEN_507;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_124 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_124 <= _GEN_380;
        end else begin
          phtTable_124 <= _GEN_508;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_125 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_125 <= _GEN_381;
        end else begin
          phtTable_125 <= _GEN_509;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_126 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_126 <= _GEN_382;
        end else begin
          phtTable_126 <= _GEN_510;
        end
      end
    end
    if (reset) begin // @[dut.scala 21:25]
      phtTable_127 <= 2'h2; // @[dut.scala 21:25]
    end else if (io_train_valid) begin // @[dut.scala 58:24]
      if (io_train_valid) begin // @[dut.scala 35:24]
        if (io_train_taken) begin // @[dut.scala 37:26]
          phtTable_127 <= _GEN_383;
        end else begin
          phtTable_127 <= _GEN_511;
        end
      end
    end
    if (reset) begin // @[dut.scala 22:20]
      ghr <= 7'h0; // @[dut.scala 22:20]
    end else begin
      ghr <= nextGHR; // @[dut.scala 61:7]
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
  phtTable_0 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  phtTable_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  phtTable_2 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  phtTable_3 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  phtTable_4 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  phtTable_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  phtTable_6 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  phtTable_7 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  phtTable_8 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  phtTable_9 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  phtTable_10 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  phtTable_11 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  phtTable_12 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  phtTable_13 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  phtTable_14 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  phtTable_15 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  phtTable_16 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  phtTable_17 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  phtTable_18 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  phtTable_19 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  phtTable_20 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  phtTable_21 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  phtTable_22 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  phtTable_23 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  phtTable_24 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  phtTable_25 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  phtTable_26 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  phtTable_27 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  phtTable_28 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  phtTable_29 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  phtTable_30 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  phtTable_31 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  phtTable_32 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  phtTable_33 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  phtTable_34 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  phtTable_35 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  phtTable_36 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  phtTable_37 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  phtTable_38 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  phtTable_39 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  phtTable_40 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  phtTable_41 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  phtTable_42 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  phtTable_43 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  phtTable_44 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  phtTable_45 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  phtTable_46 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  phtTable_47 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  phtTable_48 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  phtTable_49 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  phtTable_50 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  phtTable_51 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  phtTable_52 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  phtTable_53 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  phtTable_54 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  phtTable_55 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  phtTable_56 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  phtTable_57 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  phtTable_58 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  phtTable_59 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  phtTable_60 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  phtTable_61 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  phtTable_62 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  phtTable_63 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  phtTable_64 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  phtTable_65 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  phtTable_66 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  phtTable_67 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  phtTable_68 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  phtTable_69 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  phtTable_70 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  phtTable_71 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  phtTable_72 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  phtTable_73 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  phtTable_74 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  phtTable_75 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  phtTable_76 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  phtTable_77 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  phtTable_78 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  phtTable_79 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  phtTable_80 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  phtTable_81 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  phtTable_82 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  phtTable_83 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  phtTable_84 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  phtTable_85 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  phtTable_86 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  phtTable_87 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  phtTable_88 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  phtTable_89 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  phtTable_90 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  phtTable_91 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  phtTable_92 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  phtTable_93 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  phtTable_94 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  phtTable_95 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  phtTable_96 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  phtTable_97 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  phtTable_98 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  phtTable_99 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  phtTable_100 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  phtTable_101 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  phtTable_102 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  phtTable_103 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  phtTable_104 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  phtTable_105 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  phtTable_106 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  phtTable_107 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  phtTable_108 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  phtTable_109 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  phtTable_110 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  phtTable_111 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  phtTable_112 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  phtTable_113 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  phtTable_114 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  phtTable_115 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  phtTable_116 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  phtTable_117 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  phtTable_118 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  phtTable_119 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  phtTable_120 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  phtTable_121 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  phtTable_122 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  phtTable_123 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  phtTable_124 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  phtTable_125 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  phtTable_126 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  phtTable_127 = _RAND_127[1:0];
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
