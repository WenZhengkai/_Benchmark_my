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
  reg [6:0] globalHistoryReg; // @[dut.scala 25:33]
  reg [1:0] PHT_0; // @[dut.scala 26:20]
  reg [1:0] PHT_1; // @[dut.scala 26:20]
  reg [1:0] PHT_2; // @[dut.scala 26:20]
  reg [1:0] PHT_3; // @[dut.scala 26:20]
  reg [1:0] PHT_4; // @[dut.scala 26:20]
  reg [1:0] PHT_5; // @[dut.scala 26:20]
  reg [1:0] PHT_6; // @[dut.scala 26:20]
  reg [1:0] PHT_7; // @[dut.scala 26:20]
  reg [1:0] PHT_8; // @[dut.scala 26:20]
  reg [1:0] PHT_9; // @[dut.scala 26:20]
  reg [1:0] PHT_10; // @[dut.scala 26:20]
  reg [1:0] PHT_11; // @[dut.scala 26:20]
  reg [1:0] PHT_12; // @[dut.scala 26:20]
  reg [1:0] PHT_13; // @[dut.scala 26:20]
  reg [1:0] PHT_14; // @[dut.scala 26:20]
  reg [1:0] PHT_15; // @[dut.scala 26:20]
  reg [1:0] PHT_16; // @[dut.scala 26:20]
  reg [1:0] PHT_17; // @[dut.scala 26:20]
  reg [1:0] PHT_18; // @[dut.scala 26:20]
  reg [1:0] PHT_19; // @[dut.scala 26:20]
  reg [1:0] PHT_20; // @[dut.scala 26:20]
  reg [1:0] PHT_21; // @[dut.scala 26:20]
  reg [1:0] PHT_22; // @[dut.scala 26:20]
  reg [1:0] PHT_23; // @[dut.scala 26:20]
  reg [1:0] PHT_24; // @[dut.scala 26:20]
  reg [1:0] PHT_25; // @[dut.scala 26:20]
  reg [1:0] PHT_26; // @[dut.scala 26:20]
  reg [1:0] PHT_27; // @[dut.scala 26:20]
  reg [1:0] PHT_28; // @[dut.scala 26:20]
  reg [1:0] PHT_29; // @[dut.scala 26:20]
  reg [1:0] PHT_30; // @[dut.scala 26:20]
  reg [1:0] PHT_31; // @[dut.scala 26:20]
  reg [1:0] PHT_32; // @[dut.scala 26:20]
  reg [1:0] PHT_33; // @[dut.scala 26:20]
  reg [1:0] PHT_34; // @[dut.scala 26:20]
  reg [1:0] PHT_35; // @[dut.scala 26:20]
  reg [1:0] PHT_36; // @[dut.scala 26:20]
  reg [1:0] PHT_37; // @[dut.scala 26:20]
  reg [1:0] PHT_38; // @[dut.scala 26:20]
  reg [1:0] PHT_39; // @[dut.scala 26:20]
  reg [1:0] PHT_40; // @[dut.scala 26:20]
  reg [1:0] PHT_41; // @[dut.scala 26:20]
  reg [1:0] PHT_42; // @[dut.scala 26:20]
  reg [1:0] PHT_43; // @[dut.scala 26:20]
  reg [1:0] PHT_44; // @[dut.scala 26:20]
  reg [1:0] PHT_45; // @[dut.scala 26:20]
  reg [1:0] PHT_46; // @[dut.scala 26:20]
  reg [1:0] PHT_47; // @[dut.scala 26:20]
  reg [1:0] PHT_48; // @[dut.scala 26:20]
  reg [1:0] PHT_49; // @[dut.scala 26:20]
  reg [1:0] PHT_50; // @[dut.scala 26:20]
  reg [1:0] PHT_51; // @[dut.scala 26:20]
  reg [1:0] PHT_52; // @[dut.scala 26:20]
  reg [1:0] PHT_53; // @[dut.scala 26:20]
  reg [1:0] PHT_54; // @[dut.scala 26:20]
  reg [1:0] PHT_55; // @[dut.scala 26:20]
  reg [1:0] PHT_56; // @[dut.scala 26:20]
  reg [1:0] PHT_57; // @[dut.scala 26:20]
  reg [1:0] PHT_58; // @[dut.scala 26:20]
  reg [1:0] PHT_59; // @[dut.scala 26:20]
  reg [1:0] PHT_60; // @[dut.scala 26:20]
  reg [1:0] PHT_61; // @[dut.scala 26:20]
  reg [1:0] PHT_62; // @[dut.scala 26:20]
  reg [1:0] PHT_63; // @[dut.scala 26:20]
  reg [1:0] PHT_64; // @[dut.scala 26:20]
  reg [1:0] PHT_65; // @[dut.scala 26:20]
  reg [1:0] PHT_66; // @[dut.scala 26:20]
  reg [1:0] PHT_67; // @[dut.scala 26:20]
  reg [1:0] PHT_68; // @[dut.scala 26:20]
  reg [1:0] PHT_69; // @[dut.scala 26:20]
  reg [1:0] PHT_70; // @[dut.scala 26:20]
  reg [1:0] PHT_71; // @[dut.scala 26:20]
  reg [1:0] PHT_72; // @[dut.scala 26:20]
  reg [1:0] PHT_73; // @[dut.scala 26:20]
  reg [1:0] PHT_74; // @[dut.scala 26:20]
  reg [1:0] PHT_75; // @[dut.scala 26:20]
  reg [1:0] PHT_76; // @[dut.scala 26:20]
  reg [1:0] PHT_77; // @[dut.scala 26:20]
  reg [1:0] PHT_78; // @[dut.scala 26:20]
  reg [1:0] PHT_79; // @[dut.scala 26:20]
  reg [1:0] PHT_80; // @[dut.scala 26:20]
  reg [1:0] PHT_81; // @[dut.scala 26:20]
  reg [1:0] PHT_82; // @[dut.scala 26:20]
  reg [1:0] PHT_83; // @[dut.scala 26:20]
  reg [1:0] PHT_84; // @[dut.scala 26:20]
  reg [1:0] PHT_85; // @[dut.scala 26:20]
  reg [1:0] PHT_86; // @[dut.scala 26:20]
  reg [1:0] PHT_87; // @[dut.scala 26:20]
  reg [1:0] PHT_88; // @[dut.scala 26:20]
  reg [1:0] PHT_89; // @[dut.scala 26:20]
  reg [1:0] PHT_90; // @[dut.scala 26:20]
  reg [1:0] PHT_91; // @[dut.scala 26:20]
  reg [1:0] PHT_92; // @[dut.scala 26:20]
  reg [1:0] PHT_93; // @[dut.scala 26:20]
  reg [1:0] PHT_94; // @[dut.scala 26:20]
  reg [1:0] PHT_95; // @[dut.scala 26:20]
  reg [1:0] PHT_96; // @[dut.scala 26:20]
  reg [1:0] PHT_97; // @[dut.scala 26:20]
  reg [1:0] PHT_98; // @[dut.scala 26:20]
  reg [1:0] PHT_99; // @[dut.scala 26:20]
  reg [1:0] PHT_100; // @[dut.scala 26:20]
  reg [1:0] PHT_101; // @[dut.scala 26:20]
  reg [1:0] PHT_102; // @[dut.scala 26:20]
  reg [1:0] PHT_103; // @[dut.scala 26:20]
  reg [1:0] PHT_104; // @[dut.scala 26:20]
  reg [1:0] PHT_105; // @[dut.scala 26:20]
  reg [1:0] PHT_106; // @[dut.scala 26:20]
  reg [1:0] PHT_107; // @[dut.scala 26:20]
  reg [1:0] PHT_108; // @[dut.scala 26:20]
  reg [1:0] PHT_109; // @[dut.scala 26:20]
  reg [1:0] PHT_110; // @[dut.scala 26:20]
  reg [1:0] PHT_111; // @[dut.scala 26:20]
  reg [1:0] PHT_112; // @[dut.scala 26:20]
  reg [1:0] PHT_113; // @[dut.scala 26:20]
  reg [1:0] PHT_114; // @[dut.scala 26:20]
  reg [1:0] PHT_115; // @[dut.scala 26:20]
  reg [1:0] PHT_116; // @[dut.scala 26:20]
  reg [1:0] PHT_117; // @[dut.scala 26:20]
  reg [1:0] PHT_118; // @[dut.scala 26:20]
  reg [1:0] PHT_119; // @[dut.scala 26:20]
  reg [1:0] PHT_120; // @[dut.scala 26:20]
  reg [1:0] PHT_121; // @[dut.scala 26:20]
  reg [1:0] PHT_122; // @[dut.scala 26:20]
  reg [1:0] PHT_123; // @[dut.scala 26:20]
  reg [1:0] PHT_124; // @[dut.scala 26:20]
  reg [1:0] PHT_125; // @[dut.scala 26:20]
  reg [1:0] PHT_126; // @[dut.scala 26:20]
  reg [1:0] PHT_127; // @[dut.scala 26:20]
  wire [6:0] predictIndex = io_predict_pc ^ globalHistoryReg; // @[dut.scala 30:8]
  wire [1:0] _GEN_1 = 7'h1 == predictIndex ? PHT_1 : PHT_0; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_2 = 7'h2 == predictIndex ? PHT_2 : _GEN_1; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_3 = 7'h3 == predictIndex ? PHT_3 : _GEN_2; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_4 = 7'h4 == predictIndex ? PHT_4 : _GEN_3; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_5 = 7'h5 == predictIndex ? PHT_5 : _GEN_4; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_6 = 7'h6 == predictIndex ? PHT_6 : _GEN_5; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_7 = 7'h7 == predictIndex ? PHT_7 : _GEN_6; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_8 = 7'h8 == predictIndex ? PHT_8 : _GEN_7; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_9 = 7'h9 == predictIndex ? PHT_9 : _GEN_8; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_10 = 7'ha == predictIndex ? PHT_10 : _GEN_9; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_11 = 7'hb == predictIndex ? PHT_11 : _GEN_10; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_12 = 7'hc == predictIndex ? PHT_12 : _GEN_11; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_13 = 7'hd == predictIndex ? PHT_13 : _GEN_12; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_14 = 7'he == predictIndex ? PHT_14 : _GEN_13; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_15 = 7'hf == predictIndex ? PHT_15 : _GEN_14; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_16 = 7'h10 == predictIndex ? PHT_16 : _GEN_15; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_17 = 7'h11 == predictIndex ? PHT_17 : _GEN_16; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_18 = 7'h12 == predictIndex ? PHT_18 : _GEN_17; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_19 = 7'h13 == predictIndex ? PHT_19 : _GEN_18; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_20 = 7'h14 == predictIndex ? PHT_20 : _GEN_19; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_21 = 7'h15 == predictIndex ? PHT_21 : _GEN_20; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_22 = 7'h16 == predictIndex ? PHT_22 : _GEN_21; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_23 = 7'h17 == predictIndex ? PHT_23 : _GEN_22; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_24 = 7'h18 == predictIndex ? PHT_24 : _GEN_23; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_25 = 7'h19 == predictIndex ? PHT_25 : _GEN_24; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_26 = 7'h1a == predictIndex ? PHT_26 : _GEN_25; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_27 = 7'h1b == predictIndex ? PHT_27 : _GEN_26; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_28 = 7'h1c == predictIndex ? PHT_28 : _GEN_27; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_29 = 7'h1d == predictIndex ? PHT_29 : _GEN_28; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_30 = 7'h1e == predictIndex ? PHT_30 : _GEN_29; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_31 = 7'h1f == predictIndex ? PHT_31 : _GEN_30; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_32 = 7'h20 == predictIndex ? PHT_32 : _GEN_31; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_33 = 7'h21 == predictIndex ? PHT_33 : _GEN_32; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_34 = 7'h22 == predictIndex ? PHT_34 : _GEN_33; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_35 = 7'h23 == predictIndex ? PHT_35 : _GEN_34; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_36 = 7'h24 == predictIndex ? PHT_36 : _GEN_35; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_37 = 7'h25 == predictIndex ? PHT_37 : _GEN_36; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_38 = 7'h26 == predictIndex ? PHT_38 : _GEN_37; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_39 = 7'h27 == predictIndex ? PHT_39 : _GEN_38; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_40 = 7'h28 == predictIndex ? PHT_40 : _GEN_39; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_41 = 7'h29 == predictIndex ? PHT_41 : _GEN_40; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_42 = 7'h2a == predictIndex ? PHT_42 : _GEN_41; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_43 = 7'h2b == predictIndex ? PHT_43 : _GEN_42; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_44 = 7'h2c == predictIndex ? PHT_44 : _GEN_43; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_45 = 7'h2d == predictIndex ? PHT_45 : _GEN_44; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_46 = 7'h2e == predictIndex ? PHT_46 : _GEN_45; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_47 = 7'h2f == predictIndex ? PHT_47 : _GEN_46; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_48 = 7'h30 == predictIndex ? PHT_48 : _GEN_47; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_49 = 7'h31 == predictIndex ? PHT_49 : _GEN_48; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_50 = 7'h32 == predictIndex ? PHT_50 : _GEN_49; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_51 = 7'h33 == predictIndex ? PHT_51 : _GEN_50; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_52 = 7'h34 == predictIndex ? PHT_52 : _GEN_51; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_53 = 7'h35 == predictIndex ? PHT_53 : _GEN_52; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_54 = 7'h36 == predictIndex ? PHT_54 : _GEN_53; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_55 = 7'h37 == predictIndex ? PHT_55 : _GEN_54; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_56 = 7'h38 == predictIndex ? PHT_56 : _GEN_55; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_57 = 7'h39 == predictIndex ? PHT_57 : _GEN_56; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_58 = 7'h3a == predictIndex ? PHT_58 : _GEN_57; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_59 = 7'h3b == predictIndex ? PHT_59 : _GEN_58; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_60 = 7'h3c == predictIndex ? PHT_60 : _GEN_59; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_61 = 7'h3d == predictIndex ? PHT_61 : _GEN_60; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_62 = 7'h3e == predictIndex ? PHT_62 : _GEN_61; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_63 = 7'h3f == predictIndex ? PHT_63 : _GEN_62; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_64 = 7'h40 == predictIndex ? PHT_64 : _GEN_63; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_65 = 7'h41 == predictIndex ? PHT_65 : _GEN_64; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_66 = 7'h42 == predictIndex ? PHT_66 : _GEN_65; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_67 = 7'h43 == predictIndex ? PHT_67 : _GEN_66; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_68 = 7'h44 == predictIndex ? PHT_68 : _GEN_67; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_69 = 7'h45 == predictIndex ? PHT_69 : _GEN_68; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_70 = 7'h46 == predictIndex ? PHT_70 : _GEN_69; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_71 = 7'h47 == predictIndex ? PHT_71 : _GEN_70; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_72 = 7'h48 == predictIndex ? PHT_72 : _GEN_71; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_73 = 7'h49 == predictIndex ? PHT_73 : _GEN_72; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_74 = 7'h4a == predictIndex ? PHT_74 : _GEN_73; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_75 = 7'h4b == predictIndex ? PHT_75 : _GEN_74; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_76 = 7'h4c == predictIndex ? PHT_76 : _GEN_75; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_77 = 7'h4d == predictIndex ? PHT_77 : _GEN_76; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_78 = 7'h4e == predictIndex ? PHT_78 : _GEN_77; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_79 = 7'h4f == predictIndex ? PHT_79 : _GEN_78; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_80 = 7'h50 == predictIndex ? PHT_80 : _GEN_79; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_81 = 7'h51 == predictIndex ? PHT_81 : _GEN_80; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_82 = 7'h52 == predictIndex ? PHT_82 : _GEN_81; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_83 = 7'h53 == predictIndex ? PHT_83 : _GEN_82; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_84 = 7'h54 == predictIndex ? PHT_84 : _GEN_83; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_85 = 7'h55 == predictIndex ? PHT_85 : _GEN_84; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_86 = 7'h56 == predictIndex ? PHT_86 : _GEN_85; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_87 = 7'h57 == predictIndex ? PHT_87 : _GEN_86; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_88 = 7'h58 == predictIndex ? PHT_88 : _GEN_87; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_89 = 7'h59 == predictIndex ? PHT_89 : _GEN_88; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_90 = 7'h5a == predictIndex ? PHT_90 : _GEN_89; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_91 = 7'h5b == predictIndex ? PHT_91 : _GEN_90; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_92 = 7'h5c == predictIndex ? PHT_92 : _GEN_91; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_93 = 7'h5d == predictIndex ? PHT_93 : _GEN_92; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_94 = 7'h5e == predictIndex ? PHT_94 : _GEN_93; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_95 = 7'h5f == predictIndex ? PHT_95 : _GEN_94; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_96 = 7'h60 == predictIndex ? PHT_96 : _GEN_95; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_97 = 7'h61 == predictIndex ? PHT_97 : _GEN_96; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_98 = 7'h62 == predictIndex ? PHT_98 : _GEN_97; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_99 = 7'h63 == predictIndex ? PHT_99 : _GEN_98; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_100 = 7'h64 == predictIndex ? PHT_100 : _GEN_99; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_101 = 7'h65 == predictIndex ? PHT_101 : _GEN_100; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_102 = 7'h66 == predictIndex ? PHT_102 : _GEN_101; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_103 = 7'h67 == predictIndex ? PHT_103 : _GEN_102; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_104 = 7'h68 == predictIndex ? PHT_104 : _GEN_103; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_105 = 7'h69 == predictIndex ? PHT_105 : _GEN_104; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_106 = 7'h6a == predictIndex ? PHT_106 : _GEN_105; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_107 = 7'h6b == predictIndex ? PHT_107 : _GEN_106; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_108 = 7'h6c == predictIndex ? PHT_108 : _GEN_107; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_109 = 7'h6d == predictIndex ? PHT_109 : _GEN_108; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_110 = 7'h6e == predictIndex ? PHT_110 : _GEN_109; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_111 = 7'h6f == predictIndex ? PHT_111 : _GEN_110; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_112 = 7'h70 == predictIndex ? PHT_112 : _GEN_111; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_113 = 7'h71 == predictIndex ? PHT_113 : _GEN_112; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_114 = 7'h72 == predictIndex ? PHT_114 : _GEN_113; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_115 = 7'h73 == predictIndex ? PHT_115 : _GEN_114; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_116 = 7'h74 == predictIndex ? PHT_116 : _GEN_115; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_117 = 7'h75 == predictIndex ? PHT_117 : _GEN_116; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_118 = 7'h76 == predictIndex ? PHT_118 : _GEN_117; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_119 = 7'h77 == predictIndex ? PHT_119 : _GEN_118; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_120 = 7'h78 == predictIndex ? PHT_120 : _GEN_119; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_121 = 7'h79 == predictIndex ? PHT_121 : _GEN_120; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_122 = 7'h7a == predictIndex ? PHT_122 : _GEN_121; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_123 = 7'h7b == predictIndex ? PHT_123 : _GEN_122; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_124 = 7'h7c == predictIndex ? PHT_124 : _GEN_123; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_125 = 7'h7d == predictIndex ? PHT_125 : _GEN_124; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_126 = 7'h7e == predictIndex ? PHT_126 : _GEN_125; // @[dut.scala 39:{40,40}]
  wire [1:0] _GEN_127 = 7'h7f == predictIndex ? PHT_127 : _GEN_126; // @[dut.scala 39:{40,40}]
  wire [6:0] trainIndex = io_train_pc ^ io_train_history; // @[dut.scala 30:8]
  wire [1:0] _GEN_131 = 7'h1 == trainIndex ? PHT_1 : PHT_0; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_132 = 7'h2 == trainIndex ? PHT_2 : _GEN_131; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_133 = 7'h3 == trainIndex ? PHT_3 : _GEN_132; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_134 = 7'h4 == trainIndex ? PHT_4 : _GEN_133; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_135 = 7'h5 == trainIndex ? PHT_5 : _GEN_134; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_136 = 7'h6 == trainIndex ? PHT_6 : _GEN_135; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_137 = 7'h7 == trainIndex ? PHT_7 : _GEN_136; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_138 = 7'h8 == trainIndex ? PHT_8 : _GEN_137; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_139 = 7'h9 == trainIndex ? PHT_9 : _GEN_138; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_140 = 7'ha == trainIndex ? PHT_10 : _GEN_139; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_141 = 7'hb == trainIndex ? PHT_11 : _GEN_140; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_142 = 7'hc == trainIndex ? PHT_12 : _GEN_141; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_143 = 7'hd == trainIndex ? PHT_13 : _GEN_142; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_144 = 7'he == trainIndex ? PHT_14 : _GEN_143; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_145 = 7'hf == trainIndex ? PHT_15 : _GEN_144; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_146 = 7'h10 == trainIndex ? PHT_16 : _GEN_145; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_147 = 7'h11 == trainIndex ? PHT_17 : _GEN_146; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_148 = 7'h12 == trainIndex ? PHT_18 : _GEN_147; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_149 = 7'h13 == trainIndex ? PHT_19 : _GEN_148; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_150 = 7'h14 == trainIndex ? PHT_20 : _GEN_149; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_151 = 7'h15 == trainIndex ? PHT_21 : _GEN_150; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_152 = 7'h16 == trainIndex ? PHT_22 : _GEN_151; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_153 = 7'h17 == trainIndex ? PHT_23 : _GEN_152; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_154 = 7'h18 == trainIndex ? PHT_24 : _GEN_153; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_155 = 7'h19 == trainIndex ? PHT_25 : _GEN_154; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_156 = 7'h1a == trainIndex ? PHT_26 : _GEN_155; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_157 = 7'h1b == trainIndex ? PHT_27 : _GEN_156; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_158 = 7'h1c == trainIndex ? PHT_28 : _GEN_157; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_159 = 7'h1d == trainIndex ? PHT_29 : _GEN_158; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_160 = 7'h1e == trainIndex ? PHT_30 : _GEN_159; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_161 = 7'h1f == trainIndex ? PHT_31 : _GEN_160; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_162 = 7'h20 == trainIndex ? PHT_32 : _GEN_161; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_163 = 7'h21 == trainIndex ? PHT_33 : _GEN_162; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_164 = 7'h22 == trainIndex ? PHT_34 : _GEN_163; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_165 = 7'h23 == trainIndex ? PHT_35 : _GEN_164; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_166 = 7'h24 == trainIndex ? PHT_36 : _GEN_165; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_167 = 7'h25 == trainIndex ? PHT_37 : _GEN_166; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_168 = 7'h26 == trainIndex ? PHT_38 : _GEN_167; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_169 = 7'h27 == trainIndex ? PHT_39 : _GEN_168; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_170 = 7'h28 == trainIndex ? PHT_40 : _GEN_169; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_171 = 7'h29 == trainIndex ? PHT_41 : _GEN_170; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_172 = 7'h2a == trainIndex ? PHT_42 : _GEN_171; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_173 = 7'h2b == trainIndex ? PHT_43 : _GEN_172; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_174 = 7'h2c == trainIndex ? PHT_44 : _GEN_173; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_175 = 7'h2d == trainIndex ? PHT_45 : _GEN_174; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_176 = 7'h2e == trainIndex ? PHT_46 : _GEN_175; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_177 = 7'h2f == trainIndex ? PHT_47 : _GEN_176; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_178 = 7'h30 == trainIndex ? PHT_48 : _GEN_177; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_179 = 7'h31 == trainIndex ? PHT_49 : _GEN_178; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_180 = 7'h32 == trainIndex ? PHT_50 : _GEN_179; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_181 = 7'h33 == trainIndex ? PHT_51 : _GEN_180; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_182 = 7'h34 == trainIndex ? PHT_52 : _GEN_181; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_183 = 7'h35 == trainIndex ? PHT_53 : _GEN_182; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_184 = 7'h36 == trainIndex ? PHT_54 : _GEN_183; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_185 = 7'h37 == trainIndex ? PHT_55 : _GEN_184; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_186 = 7'h38 == trainIndex ? PHT_56 : _GEN_185; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_187 = 7'h39 == trainIndex ? PHT_57 : _GEN_186; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_188 = 7'h3a == trainIndex ? PHT_58 : _GEN_187; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_189 = 7'h3b == trainIndex ? PHT_59 : _GEN_188; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_190 = 7'h3c == trainIndex ? PHT_60 : _GEN_189; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_191 = 7'h3d == trainIndex ? PHT_61 : _GEN_190; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_192 = 7'h3e == trainIndex ? PHT_62 : _GEN_191; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_193 = 7'h3f == trainIndex ? PHT_63 : _GEN_192; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_194 = 7'h40 == trainIndex ? PHT_64 : _GEN_193; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_195 = 7'h41 == trainIndex ? PHT_65 : _GEN_194; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_196 = 7'h42 == trainIndex ? PHT_66 : _GEN_195; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_197 = 7'h43 == trainIndex ? PHT_67 : _GEN_196; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_198 = 7'h44 == trainIndex ? PHT_68 : _GEN_197; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_199 = 7'h45 == trainIndex ? PHT_69 : _GEN_198; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_200 = 7'h46 == trainIndex ? PHT_70 : _GEN_199; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_201 = 7'h47 == trainIndex ? PHT_71 : _GEN_200; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_202 = 7'h48 == trainIndex ? PHT_72 : _GEN_201; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_203 = 7'h49 == trainIndex ? PHT_73 : _GEN_202; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_204 = 7'h4a == trainIndex ? PHT_74 : _GEN_203; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_205 = 7'h4b == trainIndex ? PHT_75 : _GEN_204; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_206 = 7'h4c == trainIndex ? PHT_76 : _GEN_205; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_207 = 7'h4d == trainIndex ? PHT_77 : _GEN_206; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_208 = 7'h4e == trainIndex ? PHT_78 : _GEN_207; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_209 = 7'h4f == trainIndex ? PHT_79 : _GEN_208; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_210 = 7'h50 == trainIndex ? PHT_80 : _GEN_209; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_211 = 7'h51 == trainIndex ? PHT_81 : _GEN_210; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_212 = 7'h52 == trainIndex ? PHT_82 : _GEN_211; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_213 = 7'h53 == trainIndex ? PHT_83 : _GEN_212; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_214 = 7'h54 == trainIndex ? PHT_84 : _GEN_213; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_215 = 7'h55 == trainIndex ? PHT_85 : _GEN_214; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_216 = 7'h56 == trainIndex ? PHT_86 : _GEN_215; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_217 = 7'h57 == trainIndex ? PHT_87 : _GEN_216; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_218 = 7'h58 == trainIndex ? PHT_88 : _GEN_217; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_219 = 7'h59 == trainIndex ? PHT_89 : _GEN_218; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_220 = 7'h5a == trainIndex ? PHT_90 : _GEN_219; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_221 = 7'h5b == trainIndex ? PHT_91 : _GEN_220; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_222 = 7'h5c == trainIndex ? PHT_92 : _GEN_221; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_223 = 7'h5d == trainIndex ? PHT_93 : _GEN_222; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_224 = 7'h5e == trainIndex ? PHT_94 : _GEN_223; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_225 = 7'h5f == trainIndex ? PHT_95 : _GEN_224; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_226 = 7'h60 == trainIndex ? PHT_96 : _GEN_225; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_227 = 7'h61 == trainIndex ? PHT_97 : _GEN_226; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_228 = 7'h62 == trainIndex ? PHT_98 : _GEN_227; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_229 = 7'h63 == trainIndex ? PHT_99 : _GEN_228; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_230 = 7'h64 == trainIndex ? PHT_100 : _GEN_229; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_231 = 7'h65 == trainIndex ? PHT_101 : _GEN_230; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_232 = 7'h66 == trainIndex ? PHT_102 : _GEN_231; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_233 = 7'h67 == trainIndex ? PHT_103 : _GEN_232; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_234 = 7'h68 == trainIndex ? PHT_104 : _GEN_233; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_235 = 7'h69 == trainIndex ? PHT_105 : _GEN_234; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_236 = 7'h6a == trainIndex ? PHT_106 : _GEN_235; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_237 = 7'h6b == trainIndex ? PHT_107 : _GEN_236; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_238 = 7'h6c == trainIndex ? PHT_108 : _GEN_237; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_239 = 7'h6d == trainIndex ? PHT_109 : _GEN_238; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_240 = 7'h6e == trainIndex ? PHT_110 : _GEN_239; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_241 = 7'h6f == trainIndex ? PHT_111 : _GEN_240; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_242 = 7'h70 == trainIndex ? PHT_112 : _GEN_241; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_243 = 7'h71 == trainIndex ? PHT_113 : _GEN_242; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_244 = 7'h72 == trainIndex ? PHT_114 : _GEN_243; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_245 = 7'h73 == trainIndex ? PHT_115 : _GEN_244; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_246 = 7'h74 == trainIndex ? PHT_116 : _GEN_245; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_247 = 7'h75 == trainIndex ? PHT_117 : _GEN_246; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_248 = 7'h76 == trainIndex ? PHT_118 : _GEN_247; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_249 = 7'h77 == trainIndex ? PHT_119 : _GEN_248; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_250 = 7'h78 == trainIndex ? PHT_120 : _GEN_249; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_251 = 7'h79 == trainIndex ? PHT_121 : _GEN_250; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_252 = 7'h7a == trainIndex ? PHT_122 : _GEN_251; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_253 = 7'h7b == trainIndex ? PHT_123 : _GEN_252; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_254 = 7'h7c == trainIndex ? PHT_124 : _GEN_253; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_255 = 7'h7d == trainIndex ? PHT_125 : _GEN_254; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_256 = 7'h7e == trainIndex ? PHT_126 : _GEN_255; // @[dut.scala 53:{26,26}]
  wire [1:0] _GEN_257 = 7'h7f == trainIndex ? PHT_127 : _GEN_256; // @[dut.scala 53:{26,26}]
  wire [1:0] _PHT_T_1 = _GEN_257 + 2'h1; // @[dut.scala 54:41]
  wire [1:0] _GEN_258 = 7'h0 == trainIndex ? _PHT_T_1 : PHT_0; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_259 = 7'h1 == trainIndex ? _PHT_T_1 : PHT_1; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_260 = 7'h2 == trainIndex ? _PHT_T_1 : PHT_2; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_261 = 7'h3 == trainIndex ? _PHT_T_1 : PHT_3; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_262 = 7'h4 == trainIndex ? _PHT_T_1 : PHT_4; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_263 = 7'h5 == trainIndex ? _PHT_T_1 : PHT_5; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_264 = 7'h6 == trainIndex ? _PHT_T_1 : PHT_6; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_265 = 7'h7 == trainIndex ? _PHT_T_1 : PHT_7; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_266 = 7'h8 == trainIndex ? _PHT_T_1 : PHT_8; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_267 = 7'h9 == trainIndex ? _PHT_T_1 : PHT_9; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_268 = 7'ha == trainIndex ? _PHT_T_1 : PHT_10; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_269 = 7'hb == trainIndex ? _PHT_T_1 : PHT_11; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_270 = 7'hc == trainIndex ? _PHT_T_1 : PHT_12; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_271 = 7'hd == trainIndex ? _PHT_T_1 : PHT_13; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_272 = 7'he == trainIndex ? _PHT_T_1 : PHT_14; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_273 = 7'hf == trainIndex ? _PHT_T_1 : PHT_15; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_274 = 7'h10 == trainIndex ? _PHT_T_1 : PHT_16; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_275 = 7'h11 == trainIndex ? _PHT_T_1 : PHT_17; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_276 = 7'h12 == trainIndex ? _PHT_T_1 : PHT_18; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_277 = 7'h13 == trainIndex ? _PHT_T_1 : PHT_19; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_278 = 7'h14 == trainIndex ? _PHT_T_1 : PHT_20; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_279 = 7'h15 == trainIndex ? _PHT_T_1 : PHT_21; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_280 = 7'h16 == trainIndex ? _PHT_T_1 : PHT_22; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_281 = 7'h17 == trainIndex ? _PHT_T_1 : PHT_23; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_282 = 7'h18 == trainIndex ? _PHT_T_1 : PHT_24; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_283 = 7'h19 == trainIndex ? _PHT_T_1 : PHT_25; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_284 = 7'h1a == trainIndex ? _PHT_T_1 : PHT_26; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_285 = 7'h1b == trainIndex ? _PHT_T_1 : PHT_27; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_286 = 7'h1c == trainIndex ? _PHT_T_1 : PHT_28; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_287 = 7'h1d == trainIndex ? _PHT_T_1 : PHT_29; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_288 = 7'h1e == trainIndex ? _PHT_T_1 : PHT_30; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_289 = 7'h1f == trainIndex ? _PHT_T_1 : PHT_31; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_290 = 7'h20 == trainIndex ? _PHT_T_1 : PHT_32; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_291 = 7'h21 == trainIndex ? _PHT_T_1 : PHT_33; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_292 = 7'h22 == trainIndex ? _PHT_T_1 : PHT_34; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_293 = 7'h23 == trainIndex ? _PHT_T_1 : PHT_35; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_294 = 7'h24 == trainIndex ? _PHT_T_1 : PHT_36; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_295 = 7'h25 == trainIndex ? _PHT_T_1 : PHT_37; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_296 = 7'h26 == trainIndex ? _PHT_T_1 : PHT_38; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_297 = 7'h27 == trainIndex ? _PHT_T_1 : PHT_39; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_298 = 7'h28 == trainIndex ? _PHT_T_1 : PHT_40; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_299 = 7'h29 == trainIndex ? _PHT_T_1 : PHT_41; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_300 = 7'h2a == trainIndex ? _PHT_T_1 : PHT_42; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_301 = 7'h2b == trainIndex ? _PHT_T_1 : PHT_43; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_302 = 7'h2c == trainIndex ? _PHT_T_1 : PHT_44; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_303 = 7'h2d == trainIndex ? _PHT_T_1 : PHT_45; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_304 = 7'h2e == trainIndex ? _PHT_T_1 : PHT_46; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_305 = 7'h2f == trainIndex ? _PHT_T_1 : PHT_47; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_306 = 7'h30 == trainIndex ? _PHT_T_1 : PHT_48; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_307 = 7'h31 == trainIndex ? _PHT_T_1 : PHT_49; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_308 = 7'h32 == trainIndex ? _PHT_T_1 : PHT_50; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_309 = 7'h33 == trainIndex ? _PHT_T_1 : PHT_51; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_310 = 7'h34 == trainIndex ? _PHT_T_1 : PHT_52; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_311 = 7'h35 == trainIndex ? _PHT_T_1 : PHT_53; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_312 = 7'h36 == trainIndex ? _PHT_T_1 : PHT_54; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_313 = 7'h37 == trainIndex ? _PHT_T_1 : PHT_55; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_314 = 7'h38 == trainIndex ? _PHT_T_1 : PHT_56; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_315 = 7'h39 == trainIndex ? _PHT_T_1 : PHT_57; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_316 = 7'h3a == trainIndex ? _PHT_T_1 : PHT_58; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_317 = 7'h3b == trainIndex ? _PHT_T_1 : PHT_59; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_318 = 7'h3c == trainIndex ? _PHT_T_1 : PHT_60; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_319 = 7'h3d == trainIndex ? _PHT_T_1 : PHT_61; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_320 = 7'h3e == trainIndex ? _PHT_T_1 : PHT_62; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_321 = 7'h3f == trainIndex ? _PHT_T_1 : PHT_63; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_322 = 7'h40 == trainIndex ? _PHT_T_1 : PHT_64; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_323 = 7'h41 == trainIndex ? _PHT_T_1 : PHT_65; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_324 = 7'h42 == trainIndex ? _PHT_T_1 : PHT_66; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_325 = 7'h43 == trainIndex ? _PHT_T_1 : PHT_67; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_326 = 7'h44 == trainIndex ? _PHT_T_1 : PHT_68; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_327 = 7'h45 == trainIndex ? _PHT_T_1 : PHT_69; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_328 = 7'h46 == trainIndex ? _PHT_T_1 : PHT_70; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_329 = 7'h47 == trainIndex ? _PHT_T_1 : PHT_71; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_330 = 7'h48 == trainIndex ? _PHT_T_1 : PHT_72; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_331 = 7'h49 == trainIndex ? _PHT_T_1 : PHT_73; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_332 = 7'h4a == trainIndex ? _PHT_T_1 : PHT_74; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_333 = 7'h4b == trainIndex ? _PHT_T_1 : PHT_75; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_334 = 7'h4c == trainIndex ? _PHT_T_1 : PHT_76; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_335 = 7'h4d == trainIndex ? _PHT_T_1 : PHT_77; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_336 = 7'h4e == trainIndex ? _PHT_T_1 : PHT_78; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_337 = 7'h4f == trainIndex ? _PHT_T_1 : PHT_79; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_338 = 7'h50 == trainIndex ? _PHT_T_1 : PHT_80; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_339 = 7'h51 == trainIndex ? _PHT_T_1 : PHT_81; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_340 = 7'h52 == trainIndex ? _PHT_T_1 : PHT_82; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_341 = 7'h53 == trainIndex ? _PHT_T_1 : PHT_83; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_342 = 7'h54 == trainIndex ? _PHT_T_1 : PHT_84; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_343 = 7'h55 == trainIndex ? _PHT_T_1 : PHT_85; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_344 = 7'h56 == trainIndex ? _PHT_T_1 : PHT_86; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_345 = 7'h57 == trainIndex ? _PHT_T_1 : PHT_87; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_346 = 7'h58 == trainIndex ? _PHT_T_1 : PHT_88; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_347 = 7'h59 == trainIndex ? _PHT_T_1 : PHT_89; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_348 = 7'h5a == trainIndex ? _PHT_T_1 : PHT_90; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_349 = 7'h5b == trainIndex ? _PHT_T_1 : PHT_91; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_350 = 7'h5c == trainIndex ? _PHT_T_1 : PHT_92; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_351 = 7'h5d == trainIndex ? _PHT_T_1 : PHT_93; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_352 = 7'h5e == trainIndex ? _PHT_T_1 : PHT_94; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_353 = 7'h5f == trainIndex ? _PHT_T_1 : PHT_95; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_354 = 7'h60 == trainIndex ? _PHT_T_1 : PHT_96; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_355 = 7'h61 == trainIndex ? _PHT_T_1 : PHT_97; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_356 = 7'h62 == trainIndex ? _PHT_T_1 : PHT_98; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_357 = 7'h63 == trainIndex ? _PHT_T_1 : PHT_99; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_358 = 7'h64 == trainIndex ? _PHT_T_1 : PHT_100; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_359 = 7'h65 == trainIndex ? _PHT_T_1 : PHT_101; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_360 = 7'h66 == trainIndex ? _PHT_T_1 : PHT_102; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_361 = 7'h67 == trainIndex ? _PHT_T_1 : PHT_103; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_362 = 7'h68 == trainIndex ? _PHT_T_1 : PHT_104; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_363 = 7'h69 == trainIndex ? _PHT_T_1 : PHT_105; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_364 = 7'h6a == trainIndex ? _PHT_T_1 : PHT_106; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_365 = 7'h6b == trainIndex ? _PHT_T_1 : PHT_107; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_366 = 7'h6c == trainIndex ? _PHT_T_1 : PHT_108; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_367 = 7'h6d == trainIndex ? _PHT_T_1 : PHT_109; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_368 = 7'h6e == trainIndex ? _PHT_T_1 : PHT_110; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_369 = 7'h6f == trainIndex ? _PHT_T_1 : PHT_111; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_370 = 7'h70 == trainIndex ? _PHT_T_1 : PHT_112; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_371 = 7'h71 == trainIndex ? _PHT_T_1 : PHT_113; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_372 = 7'h72 == trainIndex ? _PHT_T_1 : PHT_114; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_373 = 7'h73 == trainIndex ? _PHT_T_1 : PHT_115; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_374 = 7'h74 == trainIndex ? _PHT_T_1 : PHT_116; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_375 = 7'h75 == trainIndex ? _PHT_T_1 : PHT_117; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_376 = 7'h76 == trainIndex ? _PHT_T_1 : PHT_118; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_377 = 7'h77 == trainIndex ? _PHT_T_1 : PHT_119; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_378 = 7'h78 == trainIndex ? _PHT_T_1 : PHT_120; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_379 = 7'h79 == trainIndex ? _PHT_T_1 : PHT_121; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_380 = 7'h7a == trainIndex ? _PHT_T_1 : PHT_122; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_381 = 7'h7b == trainIndex ? _PHT_T_1 : PHT_123; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_382 = 7'h7c == trainIndex ? _PHT_T_1 : PHT_124; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_383 = 7'h7d == trainIndex ? _PHT_T_1 : PHT_125; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_384 = 7'h7e == trainIndex ? _PHT_T_1 : PHT_126; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_385 = 7'h7f == trainIndex ? _PHT_T_1 : PHT_127; // @[dut.scala 26:20 54:{25,25}]
  wire [1:0] _GEN_386 = _GEN_257 != 2'h3 ? _GEN_258 : PHT_0; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_387 = _GEN_257 != 2'h3 ? _GEN_259 : PHT_1; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_388 = _GEN_257 != 2'h3 ? _GEN_260 : PHT_2; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_389 = _GEN_257 != 2'h3 ? _GEN_261 : PHT_3; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_390 = _GEN_257 != 2'h3 ? _GEN_262 : PHT_4; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_391 = _GEN_257 != 2'h3 ? _GEN_263 : PHT_5; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_392 = _GEN_257 != 2'h3 ? _GEN_264 : PHT_6; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_393 = _GEN_257 != 2'h3 ? _GEN_265 : PHT_7; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_394 = _GEN_257 != 2'h3 ? _GEN_266 : PHT_8; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_395 = _GEN_257 != 2'h3 ? _GEN_267 : PHT_9; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_396 = _GEN_257 != 2'h3 ? _GEN_268 : PHT_10; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_397 = _GEN_257 != 2'h3 ? _GEN_269 : PHT_11; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_398 = _GEN_257 != 2'h3 ? _GEN_270 : PHT_12; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_399 = _GEN_257 != 2'h3 ? _GEN_271 : PHT_13; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_400 = _GEN_257 != 2'h3 ? _GEN_272 : PHT_14; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_401 = _GEN_257 != 2'h3 ? _GEN_273 : PHT_15; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_402 = _GEN_257 != 2'h3 ? _GEN_274 : PHT_16; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_403 = _GEN_257 != 2'h3 ? _GEN_275 : PHT_17; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_404 = _GEN_257 != 2'h3 ? _GEN_276 : PHT_18; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_405 = _GEN_257 != 2'h3 ? _GEN_277 : PHT_19; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_406 = _GEN_257 != 2'h3 ? _GEN_278 : PHT_20; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_407 = _GEN_257 != 2'h3 ? _GEN_279 : PHT_21; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_408 = _GEN_257 != 2'h3 ? _GEN_280 : PHT_22; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_409 = _GEN_257 != 2'h3 ? _GEN_281 : PHT_23; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_410 = _GEN_257 != 2'h3 ? _GEN_282 : PHT_24; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_411 = _GEN_257 != 2'h3 ? _GEN_283 : PHT_25; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_412 = _GEN_257 != 2'h3 ? _GEN_284 : PHT_26; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_413 = _GEN_257 != 2'h3 ? _GEN_285 : PHT_27; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_414 = _GEN_257 != 2'h3 ? _GEN_286 : PHT_28; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_415 = _GEN_257 != 2'h3 ? _GEN_287 : PHT_29; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_416 = _GEN_257 != 2'h3 ? _GEN_288 : PHT_30; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_417 = _GEN_257 != 2'h3 ? _GEN_289 : PHT_31; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_418 = _GEN_257 != 2'h3 ? _GEN_290 : PHT_32; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_419 = _GEN_257 != 2'h3 ? _GEN_291 : PHT_33; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_420 = _GEN_257 != 2'h3 ? _GEN_292 : PHT_34; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_421 = _GEN_257 != 2'h3 ? _GEN_293 : PHT_35; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_422 = _GEN_257 != 2'h3 ? _GEN_294 : PHT_36; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_423 = _GEN_257 != 2'h3 ? _GEN_295 : PHT_37; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_424 = _GEN_257 != 2'h3 ? _GEN_296 : PHT_38; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_425 = _GEN_257 != 2'h3 ? _GEN_297 : PHT_39; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_426 = _GEN_257 != 2'h3 ? _GEN_298 : PHT_40; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_427 = _GEN_257 != 2'h3 ? _GEN_299 : PHT_41; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_428 = _GEN_257 != 2'h3 ? _GEN_300 : PHT_42; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_429 = _GEN_257 != 2'h3 ? _GEN_301 : PHT_43; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_430 = _GEN_257 != 2'h3 ? _GEN_302 : PHT_44; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_431 = _GEN_257 != 2'h3 ? _GEN_303 : PHT_45; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_432 = _GEN_257 != 2'h3 ? _GEN_304 : PHT_46; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_433 = _GEN_257 != 2'h3 ? _GEN_305 : PHT_47; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_434 = _GEN_257 != 2'h3 ? _GEN_306 : PHT_48; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_435 = _GEN_257 != 2'h3 ? _GEN_307 : PHT_49; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_436 = _GEN_257 != 2'h3 ? _GEN_308 : PHT_50; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_437 = _GEN_257 != 2'h3 ? _GEN_309 : PHT_51; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_438 = _GEN_257 != 2'h3 ? _GEN_310 : PHT_52; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_439 = _GEN_257 != 2'h3 ? _GEN_311 : PHT_53; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_440 = _GEN_257 != 2'h3 ? _GEN_312 : PHT_54; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_441 = _GEN_257 != 2'h3 ? _GEN_313 : PHT_55; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_442 = _GEN_257 != 2'h3 ? _GEN_314 : PHT_56; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_443 = _GEN_257 != 2'h3 ? _GEN_315 : PHT_57; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_444 = _GEN_257 != 2'h3 ? _GEN_316 : PHT_58; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_445 = _GEN_257 != 2'h3 ? _GEN_317 : PHT_59; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_446 = _GEN_257 != 2'h3 ? _GEN_318 : PHT_60; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_447 = _GEN_257 != 2'h3 ? _GEN_319 : PHT_61; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_448 = _GEN_257 != 2'h3 ? _GEN_320 : PHT_62; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_449 = _GEN_257 != 2'h3 ? _GEN_321 : PHT_63; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_450 = _GEN_257 != 2'h3 ? _GEN_322 : PHT_64; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_451 = _GEN_257 != 2'h3 ? _GEN_323 : PHT_65; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_452 = _GEN_257 != 2'h3 ? _GEN_324 : PHT_66; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_453 = _GEN_257 != 2'h3 ? _GEN_325 : PHT_67; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_454 = _GEN_257 != 2'h3 ? _GEN_326 : PHT_68; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_455 = _GEN_257 != 2'h3 ? _GEN_327 : PHT_69; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_456 = _GEN_257 != 2'h3 ? _GEN_328 : PHT_70; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_457 = _GEN_257 != 2'h3 ? _GEN_329 : PHT_71; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_458 = _GEN_257 != 2'h3 ? _GEN_330 : PHT_72; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_459 = _GEN_257 != 2'h3 ? _GEN_331 : PHT_73; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_460 = _GEN_257 != 2'h3 ? _GEN_332 : PHT_74; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_461 = _GEN_257 != 2'h3 ? _GEN_333 : PHT_75; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_462 = _GEN_257 != 2'h3 ? _GEN_334 : PHT_76; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_463 = _GEN_257 != 2'h3 ? _GEN_335 : PHT_77; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_464 = _GEN_257 != 2'h3 ? _GEN_336 : PHT_78; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_465 = _GEN_257 != 2'h3 ? _GEN_337 : PHT_79; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_466 = _GEN_257 != 2'h3 ? _GEN_338 : PHT_80; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_467 = _GEN_257 != 2'h3 ? _GEN_339 : PHT_81; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_468 = _GEN_257 != 2'h3 ? _GEN_340 : PHT_82; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_469 = _GEN_257 != 2'h3 ? _GEN_341 : PHT_83; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_470 = _GEN_257 != 2'h3 ? _GEN_342 : PHT_84; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_471 = _GEN_257 != 2'h3 ? _GEN_343 : PHT_85; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_472 = _GEN_257 != 2'h3 ? _GEN_344 : PHT_86; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_473 = _GEN_257 != 2'h3 ? _GEN_345 : PHT_87; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_474 = _GEN_257 != 2'h3 ? _GEN_346 : PHT_88; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_475 = _GEN_257 != 2'h3 ? _GEN_347 : PHT_89; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_476 = _GEN_257 != 2'h3 ? _GEN_348 : PHT_90; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_477 = _GEN_257 != 2'h3 ? _GEN_349 : PHT_91; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_478 = _GEN_257 != 2'h3 ? _GEN_350 : PHT_92; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_479 = _GEN_257 != 2'h3 ? _GEN_351 : PHT_93; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_480 = _GEN_257 != 2'h3 ? _GEN_352 : PHT_94; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_481 = _GEN_257 != 2'h3 ? _GEN_353 : PHT_95; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_482 = _GEN_257 != 2'h3 ? _GEN_354 : PHT_96; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_483 = _GEN_257 != 2'h3 ? _GEN_355 : PHT_97; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_484 = _GEN_257 != 2'h3 ? _GEN_356 : PHT_98; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_485 = _GEN_257 != 2'h3 ? _GEN_357 : PHT_99; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_486 = _GEN_257 != 2'h3 ? _GEN_358 : PHT_100; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_487 = _GEN_257 != 2'h3 ? _GEN_359 : PHT_101; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_488 = _GEN_257 != 2'h3 ? _GEN_360 : PHT_102; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_489 = _GEN_257 != 2'h3 ? _GEN_361 : PHT_103; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_490 = _GEN_257 != 2'h3 ? _GEN_362 : PHT_104; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_491 = _GEN_257 != 2'h3 ? _GEN_363 : PHT_105; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_492 = _GEN_257 != 2'h3 ? _GEN_364 : PHT_106; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_493 = _GEN_257 != 2'h3 ? _GEN_365 : PHT_107; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_494 = _GEN_257 != 2'h3 ? _GEN_366 : PHT_108; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_495 = _GEN_257 != 2'h3 ? _GEN_367 : PHT_109; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_496 = _GEN_257 != 2'h3 ? _GEN_368 : PHT_110; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_497 = _GEN_257 != 2'h3 ? _GEN_369 : PHT_111; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_498 = _GEN_257 != 2'h3 ? _GEN_370 : PHT_112; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_499 = _GEN_257 != 2'h3 ? _GEN_371 : PHT_113; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_500 = _GEN_257 != 2'h3 ? _GEN_372 : PHT_114; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_501 = _GEN_257 != 2'h3 ? _GEN_373 : PHT_115; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_502 = _GEN_257 != 2'h3 ? _GEN_374 : PHT_116; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_503 = _GEN_257 != 2'h3 ? _GEN_375 : PHT_117; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_504 = _GEN_257 != 2'h3 ? _GEN_376 : PHT_118; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_505 = _GEN_257 != 2'h3 ? _GEN_377 : PHT_119; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_506 = _GEN_257 != 2'h3 ? _GEN_378 : PHT_120; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_507 = _GEN_257 != 2'h3 ? _GEN_379 : PHT_121; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_508 = _GEN_257 != 2'h3 ? _GEN_380 : PHT_122; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_509 = _GEN_257 != 2'h3 ? _GEN_381 : PHT_123; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_510 = _GEN_257 != 2'h3 ? _GEN_382 : PHT_124; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_511 = _GEN_257 != 2'h3 ? _GEN_383 : PHT_125; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_512 = _GEN_257 != 2'h3 ? _GEN_384 : PHT_126; // @[dut.scala 26:20 53:35]
  wire [1:0] _GEN_513 = _GEN_257 != 2'h3 ? _GEN_385 : PHT_127; // @[dut.scala 26:20 53:35]
  wire [1:0] _PHT_T_3 = _GEN_257 - 2'h1; // @[dut.scala 58:41]
  wire [1:0] _GEN_514 = 7'h0 == trainIndex ? _PHT_T_3 : PHT_0; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_515 = 7'h1 == trainIndex ? _PHT_T_3 : PHT_1; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_516 = 7'h2 == trainIndex ? _PHT_T_3 : PHT_2; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_517 = 7'h3 == trainIndex ? _PHT_T_3 : PHT_3; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_518 = 7'h4 == trainIndex ? _PHT_T_3 : PHT_4; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_519 = 7'h5 == trainIndex ? _PHT_T_3 : PHT_5; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_520 = 7'h6 == trainIndex ? _PHT_T_3 : PHT_6; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_521 = 7'h7 == trainIndex ? _PHT_T_3 : PHT_7; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_522 = 7'h8 == trainIndex ? _PHT_T_3 : PHT_8; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_523 = 7'h9 == trainIndex ? _PHT_T_3 : PHT_9; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_524 = 7'ha == trainIndex ? _PHT_T_3 : PHT_10; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_525 = 7'hb == trainIndex ? _PHT_T_3 : PHT_11; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_526 = 7'hc == trainIndex ? _PHT_T_3 : PHT_12; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_527 = 7'hd == trainIndex ? _PHT_T_3 : PHT_13; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_528 = 7'he == trainIndex ? _PHT_T_3 : PHT_14; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_529 = 7'hf == trainIndex ? _PHT_T_3 : PHT_15; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_530 = 7'h10 == trainIndex ? _PHT_T_3 : PHT_16; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_531 = 7'h11 == trainIndex ? _PHT_T_3 : PHT_17; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_532 = 7'h12 == trainIndex ? _PHT_T_3 : PHT_18; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_533 = 7'h13 == trainIndex ? _PHT_T_3 : PHT_19; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_534 = 7'h14 == trainIndex ? _PHT_T_3 : PHT_20; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_535 = 7'h15 == trainIndex ? _PHT_T_3 : PHT_21; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_536 = 7'h16 == trainIndex ? _PHT_T_3 : PHT_22; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_537 = 7'h17 == trainIndex ? _PHT_T_3 : PHT_23; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_538 = 7'h18 == trainIndex ? _PHT_T_3 : PHT_24; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_539 = 7'h19 == trainIndex ? _PHT_T_3 : PHT_25; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_540 = 7'h1a == trainIndex ? _PHT_T_3 : PHT_26; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_541 = 7'h1b == trainIndex ? _PHT_T_3 : PHT_27; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_542 = 7'h1c == trainIndex ? _PHT_T_3 : PHT_28; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_543 = 7'h1d == trainIndex ? _PHT_T_3 : PHT_29; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_544 = 7'h1e == trainIndex ? _PHT_T_3 : PHT_30; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_545 = 7'h1f == trainIndex ? _PHT_T_3 : PHT_31; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_546 = 7'h20 == trainIndex ? _PHT_T_3 : PHT_32; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_547 = 7'h21 == trainIndex ? _PHT_T_3 : PHT_33; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_548 = 7'h22 == trainIndex ? _PHT_T_3 : PHT_34; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_549 = 7'h23 == trainIndex ? _PHT_T_3 : PHT_35; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_550 = 7'h24 == trainIndex ? _PHT_T_3 : PHT_36; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_551 = 7'h25 == trainIndex ? _PHT_T_3 : PHT_37; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_552 = 7'h26 == trainIndex ? _PHT_T_3 : PHT_38; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_553 = 7'h27 == trainIndex ? _PHT_T_3 : PHT_39; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_554 = 7'h28 == trainIndex ? _PHT_T_3 : PHT_40; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_555 = 7'h29 == trainIndex ? _PHT_T_3 : PHT_41; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_556 = 7'h2a == trainIndex ? _PHT_T_3 : PHT_42; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_557 = 7'h2b == trainIndex ? _PHT_T_3 : PHT_43; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_558 = 7'h2c == trainIndex ? _PHT_T_3 : PHT_44; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_559 = 7'h2d == trainIndex ? _PHT_T_3 : PHT_45; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_560 = 7'h2e == trainIndex ? _PHT_T_3 : PHT_46; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_561 = 7'h2f == trainIndex ? _PHT_T_3 : PHT_47; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_562 = 7'h30 == trainIndex ? _PHT_T_3 : PHT_48; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_563 = 7'h31 == trainIndex ? _PHT_T_3 : PHT_49; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_564 = 7'h32 == trainIndex ? _PHT_T_3 : PHT_50; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_565 = 7'h33 == trainIndex ? _PHT_T_3 : PHT_51; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_566 = 7'h34 == trainIndex ? _PHT_T_3 : PHT_52; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_567 = 7'h35 == trainIndex ? _PHT_T_3 : PHT_53; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_568 = 7'h36 == trainIndex ? _PHT_T_3 : PHT_54; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_569 = 7'h37 == trainIndex ? _PHT_T_3 : PHT_55; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_570 = 7'h38 == trainIndex ? _PHT_T_3 : PHT_56; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_571 = 7'h39 == trainIndex ? _PHT_T_3 : PHT_57; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_572 = 7'h3a == trainIndex ? _PHT_T_3 : PHT_58; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_573 = 7'h3b == trainIndex ? _PHT_T_3 : PHT_59; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_574 = 7'h3c == trainIndex ? _PHT_T_3 : PHT_60; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_575 = 7'h3d == trainIndex ? _PHT_T_3 : PHT_61; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_576 = 7'h3e == trainIndex ? _PHT_T_3 : PHT_62; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_577 = 7'h3f == trainIndex ? _PHT_T_3 : PHT_63; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_578 = 7'h40 == trainIndex ? _PHT_T_3 : PHT_64; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_579 = 7'h41 == trainIndex ? _PHT_T_3 : PHT_65; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_580 = 7'h42 == trainIndex ? _PHT_T_3 : PHT_66; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_581 = 7'h43 == trainIndex ? _PHT_T_3 : PHT_67; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_582 = 7'h44 == trainIndex ? _PHT_T_3 : PHT_68; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_583 = 7'h45 == trainIndex ? _PHT_T_3 : PHT_69; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_584 = 7'h46 == trainIndex ? _PHT_T_3 : PHT_70; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_585 = 7'h47 == trainIndex ? _PHT_T_3 : PHT_71; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_586 = 7'h48 == trainIndex ? _PHT_T_3 : PHT_72; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_587 = 7'h49 == trainIndex ? _PHT_T_3 : PHT_73; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_588 = 7'h4a == trainIndex ? _PHT_T_3 : PHT_74; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_589 = 7'h4b == trainIndex ? _PHT_T_3 : PHT_75; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_590 = 7'h4c == trainIndex ? _PHT_T_3 : PHT_76; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_591 = 7'h4d == trainIndex ? _PHT_T_3 : PHT_77; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_592 = 7'h4e == trainIndex ? _PHT_T_3 : PHT_78; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_593 = 7'h4f == trainIndex ? _PHT_T_3 : PHT_79; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_594 = 7'h50 == trainIndex ? _PHT_T_3 : PHT_80; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_595 = 7'h51 == trainIndex ? _PHT_T_3 : PHT_81; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_596 = 7'h52 == trainIndex ? _PHT_T_3 : PHT_82; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_597 = 7'h53 == trainIndex ? _PHT_T_3 : PHT_83; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_598 = 7'h54 == trainIndex ? _PHT_T_3 : PHT_84; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_599 = 7'h55 == trainIndex ? _PHT_T_3 : PHT_85; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_600 = 7'h56 == trainIndex ? _PHT_T_3 : PHT_86; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_601 = 7'h57 == trainIndex ? _PHT_T_3 : PHT_87; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_602 = 7'h58 == trainIndex ? _PHT_T_3 : PHT_88; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_603 = 7'h59 == trainIndex ? _PHT_T_3 : PHT_89; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_604 = 7'h5a == trainIndex ? _PHT_T_3 : PHT_90; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_605 = 7'h5b == trainIndex ? _PHT_T_3 : PHT_91; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_606 = 7'h5c == trainIndex ? _PHT_T_3 : PHT_92; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_607 = 7'h5d == trainIndex ? _PHT_T_3 : PHT_93; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_608 = 7'h5e == trainIndex ? _PHT_T_3 : PHT_94; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_609 = 7'h5f == trainIndex ? _PHT_T_3 : PHT_95; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_610 = 7'h60 == trainIndex ? _PHT_T_3 : PHT_96; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_611 = 7'h61 == trainIndex ? _PHT_T_3 : PHT_97; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_612 = 7'h62 == trainIndex ? _PHT_T_3 : PHT_98; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_613 = 7'h63 == trainIndex ? _PHT_T_3 : PHT_99; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_614 = 7'h64 == trainIndex ? _PHT_T_3 : PHT_100; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_615 = 7'h65 == trainIndex ? _PHT_T_3 : PHT_101; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_616 = 7'h66 == trainIndex ? _PHT_T_3 : PHT_102; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_617 = 7'h67 == trainIndex ? _PHT_T_3 : PHT_103; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_618 = 7'h68 == trainIndex ? _PHT_T_3 : PHT_104; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_619 = 7'h69 == trainIndex ? _PHT_T_3 : PHT_105; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_620 = 7'h6a == trainIndex ? _PHT_T_3 : PHT_106; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_621 = 7'h6b == trainIndex ? _PHT_T_3 : PHT_107; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_622 = 7'h6c == trainIndex ? _PHT_T_3 : PHT_108; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_623 = 7'h6d == trainIndex ? _PHT_T_3 : PHT_109; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_624 = 7'h6e == trainIndex ? _PHT_T_3 : PHT_110; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_625 = 7'h6f == trainIndex ? _PHT_T_3 : PHT_111; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_626 = 7'h70 == trainIndex ? _PHT_T_3 : PHT_112; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_627 = 7'h71 == trainIndex ? _PHT_T_3 : PHT_113; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_628 = 7'h72 == trainIndex ? _PHT_T_3 : PHT_114; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_629 = 7'h73 == trainIndex ? _PHT_T_3 : PHT_115; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_630 = 7'h74 == trainIndex ? _PHT_T_3 : PHT_116; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_631 = 7'h75 == trainIndex ? _PHT_T_3 : PHT_117; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_632 = 7'h76 == trainIndex ? _PHT_T_3 : PHT_118; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_633 = 7'h77 == trainIndex ? _PHT_T_3 : PHT_119; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_634 = 7'h78 == trainIndex ? _PHT_T_3 : PHT_120; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_635 = 7'h79 == trainIndex ? _PHT_T_3 : PHT_121; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_636 = 7'h7a == trainIndex ? _PHT_T_3 : PHT_122; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_637 = 7'h7b == trainIndex ? _PHT_T_3 : PHT_123; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_638 = 7'h7c == trainIndex ? _PHT_T_3 : PHT_124; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_639 = 7'h7d == trainIndex ? _PHT_T_3 : PHT_125; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_640 = 7'h7e == trainIndex ? _PHT_T_3 : PHT_126; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_641 = 7'h7f == trainIndex ? _PHT_T_3 : PHT_127; // @[dut.scala 26:20 58:{25,25}]
  wire [1:0] _GEN_642 = _GEN_257 != 2'h0 ? _GEN_514 : PHT_0; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_643 = _GEN_257 != 2'h0 ? _GEN_515 : PHT_1; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_644 = _GEN_257 != 2'h0 ? _GEN_516 : PHT_2; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_645 = _GEN_257 != 2'h0 ? _GEN_517 : PHT_3; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_646 = _GEN_257 != 2'h0 ? _GEN_518 : PHT_4; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_647 = _GEN_257 != 2'h0 ? _GEN_519 : PHT_5; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_648 = _GEN_257 != 2'h0 ? _GEN_520 : PHT_6; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_649 = _GEN_257 != 2'h0 ? _GEN_521 : PHT_7; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_650 = _GEN_257 != 2'h0 ? _GEN_522 : PHT_8; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_651 = _GEN_257 != 2'h0 ? _GEN_523 : PHT_9; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_652 = _GEN_257 != 2'h0 ? _GEN_524 : PHT_10; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_653 = _GEN_257 != 2'h0 ? _GEN_525 : PHT_11; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_654 = _GEN_257 != 2'h0 ? _GEN_526 : PHT_12; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_655 = _GEN_257 != 2'h0 ? _GEN_527 : PHT_13; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_656 = _GEN_257 != 2'h0 ? _GEN_528 : PHT_14; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_657 = _GEN_257 != 2'h0 ? _GEN_529 : PHT_15; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_658 = _GEN_257 != 2'h0 ? _GEN_530 : PHT_16; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_659 = _GEN_257 != 2'h0 ? _GEN_531 : PHT_17; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_660 = _GEN_257 != 2'h0 ? _GEN_532 : PHT_18; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_661 = _GEN_257 != 2'h0 ? _GEN_533 : PHT_19; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_662 = _GEN_257 != 2'h0 ? _GEN_534 : PHT_20; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_663 = _GEN_257 != 2'h0 ? _GEN_535 : PHT_21; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_664 = _GEN_257 != 2'h0 ? _GEN_536 : PHT_22; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_665 = _GEN_257 != 2'h0 ? _GEN_537 : PHT_23; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_666 = _GEN_257 != 2'h0 ? _GEN_538 : PHT_24; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_667 = _GEN_257 != 2'h0 ? _GEN_539 : PHT_25; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_668 = _GEN_257 != 2'h0 ? _GEN_540 : PHT_26; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_669 = _GEN_257 != 2'h0 ? _GEN_541 : PHT_27; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_670 = _GEN_257 != 2'h0 ? _GEN_542 : PHT_28; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_671 = _GEN_257 != 2'h0 ? _GEN_543 : PHT_29; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_672 = _GEN_257 != 2'h0 ? _GEN_544 : PHT_30; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_673 = _GEN_257 != 2'h0 ? _GEN_545 : PHT_31; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_674 = _GEN_257 != 2'h0 ? _GEN_546 : PHT_32; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_675 = _GEN_257 != 2'h0 ? _GEN_547 : PHT_33; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_676 = _GEN_257 != 2'h0 ? _GEN_548 : PHT_34; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_677 = _GEN_257 != 2'h0 ? _GEN_549 : PHT_35; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_678 = _GEN_257 != 2'h0 ? _GEN_550 : PHT_36; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_679 = _GEN_257 != 2'h0 ? _GEN_551 : PHT_37; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_680 = _GEN_257 != 2'h0 ? _GEN_552 : PHT_38; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_681 = _GEN_257 != 2'h0 ? _GEN_553 : PHT_39; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_682 = _GEN_257 != 2'h0 ? _GEN_554 : PHT_40; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_683 = _GEN_257 != 2'h0 ? _GEN_555 : PHT_41; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_684 = _GEN_257 != 2'h0 ? _GEN_556 : PHT_42; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_685 = _GEN_257 != 2'h0 ? _GEN_557 : PHT_43; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_686 = _GEN_257 != 2'h0 ? _GEN_558 : PHT_44; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_687 = _GEN_257 != 2'h0 ? _GEN_559 : PHT_45; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_688 = _GEN_257 != 2'h0 ? _GEN_560 : PHT_46; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_689 = _GEN_257 != 2'h0 ? _GEN_561 : PHT_47; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_690 = _GEN_257 != 2'h0 ? _GEN_562 : PHT_48; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_691 = _GEN_257 != 2'h0 ? _GEN_563 : PHT_49; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_692 = _GEN_257 != 2'h0 ? _GEN_564 : PHT_50; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_693 = _GEN_257 != 2'h0 ? _GEN_565 : PHT_51; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_694 = _GEN_257 != 2'h0 ? _GEN_566 : PHT_52; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_695 = _GEN_257 != 2'h0 ? _GEN_567 : PHT_53; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_696 = _GEN_257 != 2'h0 ? _GEN_568 : PHT_54; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_697 = _GEN_257 != 2'h0 ? _GEN_569 : PHT_55; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_698 = _GEN_257 != 2'h0 ? _GEN_570 : PHT_56; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_699 = _GEN_257 != 2'h0 ? _GEN_571 : PHT_57; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_700 = _GEN_257 != 2'h0 ? _GEN_572 : PHT_58; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_701 = _GEN_257 != 2'h0 ? _GEN_573 : PHT_59; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_702 = _GEN_257 != 2'h0 ? _GEN_574 : PHT_60; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_703 = _GEN_257 != 2'h0 ? _GEN_575 : PHT_61; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_704 = _GEN_257 != 2'h0 ? _GEN_576 : PHT_62; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_705 = _GEN_257 != 2'h0 ? _GEN_577 : PHT_63; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_706 = _GEN_257 != 2'h0 ? _GEN_578 : PHT_64; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_707 = _GEN_257 != 2'h0 ? _GEN_579 : PHT_65; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_708 = _GEN_257 != 2'h0 ? _GEN_580 : PHT_66; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_709 = _GEN_257 != 2'h0 ? _GEN_581 : PHT_67; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_710 = _GEN_257 != 2'h0 ? _GEN_582 : PHT_68; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_711 = _GEN_257 != 2'h0 ? _GEN_583 : PHT_69; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_712 = _GEN_257 != 2'h0 ? _GEN_584 : PHT_70; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_713 = _GEN_257 != 2'h0 ? _GEN_585 : PHT_71; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_714 = _GEN_257 != 2'h0 ? _GEN_586 : PHT_72; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_715 = _GEN_257 != 2'h0 ? _GEN_587 : PHT_73; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_716 = _GEN_257 != 2'h0 ? _GEN_588 : PHT_74; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_717 = _GEN_257 != 2'h0 ? _GEN_589 : PHT_75; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_718 = _GEN_257 != 2'h0 ? _GEN_590 : PHT_76; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_719 = _GEN_257 != 2'h0 ? _GEN_591 : PHT_77; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_720 = _GEN_257 != 2'h0 ? _GEN_592 : PHT_78; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_721 = _GEN_257 != 2'h0 ? _GEN_593 : PHT_79; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_722 = _GEN_257 != 2'h0 ? _GEN_594 : PHT_80; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_723 = _GEN_257 != 2'h0 ? _GEN_595 : PHT_81; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_724 = _GEN_257 != 2'h0 ? _GEN_596 : PHT_82; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_725 = _GEN_257 != 2'h0 ? _GEN_597 : PHT_83; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_726 = _GEN_257 != 2'h0 ? _GEN_598 : PHT_84; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_727 = _GEN_257 != 2'h0 ? _GEN_599 : PHT_85; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_728 = _GEN_257 != 2'h0 ? _GEN_600 : PHT_86; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_729 = _GEN_257 != 2'h0 ? _GEN_601 : PHT_87; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_730 = _GEN_257 != 2'h0 ? _GEN_602 : PHT_88; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_731 = _GEN_257 != 2'h0 ? _GEN_603 : PHT_89; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_732 = _GEN_257 != 2'h0 ? _GEN_604 : PHT_90; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_733 = _GEN_257 != 2'h0 ? _GEN_605 : PHT_91; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_734 = _GEN_257 != 2'h0 ? _GEN_606 : PHT_92; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_735 = _GEN_257 != 2'h0 ? _GEN_607 : PHT_93; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_736 = _GEN_257 != 2'h0 ? _GEN_608 : PHT_94; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_737 = _GEN_257 != 2'h0 ? _GEN_609 : PHT_95; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_738 = _GEN_257 != 2'h0 ? _GEN_610 : PHT_96; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_739 = _GEN_257 != 2'h0 ? _GEN_611 : PHT_97; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_740 = _GEN_257 != 2'h0 ? _GEN_612 : PHT_98; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_741 = _GEN_257 != 2'h0 ? _GEN_613 : PHT_99; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_742 = _GEN_257 != 2'h0 ? _GEN_614 : PHT_100; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_743 = _GEN_257 != 2'h0 ? _GEN_615 : PHT_101; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_744 = _GEN_257 != 2'h0 ? _GEN_616 : PHT_102; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_745 = _GEN_257 != 2'h0 ? _GEN_617 : PHT_103; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_746 = _GEN_257 != 2'h0 ? _GEN_618 : PHT_104; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_747 = _GEN_257 != 2'h0 ? _GEN_619 : PHT_105; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_748 = _GEN_257 != 2'h0 ? _GEN_620 : PHT_106; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_749 = _GEN_257 != 2'h0 ? _GEN_621 : PHT_107; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_750 = _GEN_257 != 2'h0 ? _GEN_622 : PHT_108; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_751 = _GEN_257 != 2'h0 ? _GEN_623 : PHT_109; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_752 = _GEN_257 != 2'h0 ? _GEN_624 : PHT_110; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_753 = _GEN_257 != 2'h0 ? _GEN_625 : PHT_111; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_754 = _GEN_257 != 2'h0 ? _GEN_626 : PHT_112; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_755 = _GEN_257 != 2'h0 ? _GEN_627 : PHT_113; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_756 = _GEN_257 != 2'h0 ? _GEN_628 : PHT_114; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_757 = _GEN_257 != 2'h0 ? _GEN_629 : PHT_115; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_758 = _GEN_257 != 2'h0 ? _GEN_630 : PHT_116; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_759 = _GEN_257 != 2'h0 ? _GEN_631 : PHT_117; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_760 = _GEN_257 != 2'h0 ? _GEN_632 : PHT_118; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_761 = _GEN_257 != 2'h0 ? _GEN_633 : PHT_119; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_762 = _GEN_257 != 2'h0 ? _GEN_634 : PHT_120; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_763 = _GEN_257 != 2'h0 ? _GEN_635 : PHT_121; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_764 = _GEN_257 != 2'h0 ? _GEN_636 : PHT_122; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_765 = _GEN_257 != 2'h0 ? _GEN_637 : PHT_123; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_766 = _GEN_257 != 2'h0 ? _GEN_638 : PHT_124; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_767 = _GEN_257 != 2'h0 ? _GEN_639 : PHT_125; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_768 = _GEN_257 != 2'h0 ? _GEN_640 : PHT_126; // @[dut.scala 26:20 57:35]
  wire [1:0] _GEN_769 = _GEN_257 != 2'h0 ? _GEN_641 : PHT_127; // @[dut.scala 26:20 57:35]
  wire [6:0] _globalHistoryReg_T_1 = {globalHistoryReg[6:1],io_predict_taken}; // @[Cat.scala 33:92]
  assign io_predict_taken = io_predict_valid & _GEN_127 >= 2'h2; // @[dut.scala 38:27 39:22 42:22]
  assign io_predict_history = io_predict_valid ? globalHistoryReg : 7'h0; // @[dut.scala 38:27 40:24 43:24]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:33]
      globalHistoryReg <= 7'h0; // @[dut.scala 25:33]
    end else if (io_reset) begin // @[dut.scala 73:19]
      globalHistoryReg <= 7'h0; // @[dut.scala 74:22]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      globalHistoryReg <= io_train_history;
    end else if (io_predict_valid) begin // @[dut.scala 68:34]
      globalHistoryReg <= _globalHistoryReg_T_1; // @[dut.scala 69:22]
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_0 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_0 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_0 <= _GEN_386;
      end else begin
        PHT_0 <= _GEN_642;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_1 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_1 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_1 <= _GEN_387;
      end else begin
        PHT_1 <= _GEN_643;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_2 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_2 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_2 <= _GEN_388;
      end else begin
        PHT_2 <= _GEN_644;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_3 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_3 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_3 <= _GEN_389;
      end else begin
        PHT_3 <= _GEN_645;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_4 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_4 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_4 <= _GEN_390;
      end else begin
        PHT_4 <= _GEN_646;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_5 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_5 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_5 <= _GEN_391;
      end else begin
        PHT_5 <= _GEN_647;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_6 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_6 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_6 <= _GEN_392;
      end else begin
        PHT_6 <= _GEN_648;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_7 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_7 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_7 <= _GEN_393;
      end else begin
        PHT_7 <= _GEN_649;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_8 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_8 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_8 <= _GEN_394;
      end else begin
        PHT_8 <= _GEN_650;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_9 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_9 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_9 <= _GEN_395;
      end else begin
        PHT_9 <= _GEN_651;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_10 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_10 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_10 <= _GEN_396;
      end else begin
        PHT_10 <= _GEN_652;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_11 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_11 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_11 <= _GEN_397;
      end else begin
        PHT_11 <= _GEN_653;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_12 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_12 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_12 <= _GEN_398;
      end else begin
        PHT_12 <= _GEN_654;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_13 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_13 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_13 <= _GEN_399;
      end else begin
        PHT_13 <= _GEN_655;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_14 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_14 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_14 <= _GEN_400;
      end else begin
        PHT_14 <= _GEN_656;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_15 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_15 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_15 <= _GEN_401;
      end else begin
        PHT_15 <= _GEN_657;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_16 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_16 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_16 <= _GEN_402;
      end else begin
        PHT_16 <= _GEN_658;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_17 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_17 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_17 <= _GEN_403;
      end else begin
        PHT_17 <= _GEN_659;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_18 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_18 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_18 <= _GEN_404;
      end else begin
        PHT_18 <= _GEN_660;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_19 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_19 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_19 <= _GEN_405;
      end else begin
        PHT_19 <= _GEN_661;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_20 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_20 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_20 <= _GEN_406;
      end else begin
        PHT_20 <= _GEN_662;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_21 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_21 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_21 <= _GEN_407;
      end else begin
        PHT_21 <= _GEN_663;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_22 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_22 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_22 <= _GEN_408;
      end else begin
        PHT_22 <= _GEN_664;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_23 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_23 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_23 <= _GEN_409;
      end else begin
        PHT_23 <= _GEN_665;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_24 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_24 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_24 <= _GEN_410;
      end else begin
        PHT_24 <= _GEN_666;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_25 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_25 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_25 <= _GEN_411;
      end else begin
        PHT_25 <= _GEN_667;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_26 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_26 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_26 <= _GEN_412;
      end else begin
        PHT_26 <= _GEN_668;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_27 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_27 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_27 <= _GEN_413;
      end else begin
        PHT_27 <= _GEN_669;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_28 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_28 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_28 <= _GEN_414;
      end else begin
        PHT_28 <= _GEN_670;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_29 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_29 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_29 <= _GEN_415;
      end else begin
        PHT_29 <= _GEN_671;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_30 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_30 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_30 <= _GEN_416;
      end else begin
        PHT_30 <= _GEN_672;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_31 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_31 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_31 <= _GEN_417;
      end else begin
        PHT_31 <= _GEN_673;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_32 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_32 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_32 <= _GEN_418;
      end else begin
        PHT_32 <= _GEN_674;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_33 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_33 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_33 <= _GEN_419;
      end else begin
        PHT_33 <= _GEN_675;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_34 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_34 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_34 <= _GEN_420;
      end else begin
        PHT_34 <= _GEN_676;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_35 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_35 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_35 <= _GEN_421;
      end else begin
        PHT_35 <= _GEN_677;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_36 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_36 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_36 <= _GEN_422;
      end else begin
        PHT_36 <= _GEN_678;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_37 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_37 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_37 <= _GEN_423;
      end else begin
        PHT_37 <= _GEN_679;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_38 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_38 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_38 <= _GEN_424;
      end else begin
        PHT_38 <= _GEN_680;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_39 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_39 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_39 <= _GEN_425;
      end else begin
        PHT_39 <= _GEN_681;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_40 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_40 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_40 <= _GEN_426;
      end else begin
        PHT_40 <= _GEN_682;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_41 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_41 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_41 <= _GEN_427;
      end else begin
        PHT_41 <= _GEN_683;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_42 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_42 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_42 <= _GEN_428;
      end else begin
        PHT_42 <= _GEN_684;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_43 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_43 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_43 <= _GEN_429;
      end else begin
        PHT_43 <= _GEN_685;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_44 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_44 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_44 <= _GEN_430;
      end else begin
        PHT_44 <= _GEN_686;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_45 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_45 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_45 <= _GEN_431;
      end else begin
        PHT_45 <= _GEN_687;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_46 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_46 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_46 <= _GEN_432;
      end else begin
        PHT_46 <= _GEN_688;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_47 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_47 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_47 <= _GEN_433;
      end else begin
        PHT_47 <= _GEN_689;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_48 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_48 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_48 <= _GEN_434;
      end else begin
        PHT_48 <= _GEN_690;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_49 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_49 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_49 <= _GEN_435;
      end else begin
        PHT_49 <= _GEN_691;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_50 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_50 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_50 <= _GEN_436;
      end else begin
        PHT_50 <= _GEN_692;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_51 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_51 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_51 <= _GEN_437;
      end else begin
        PHT_51 <= _GEN_693;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_52 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_52 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_52 <= _GEN_438;
      end else begin
        PHT_52 <= _GEN_694;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_53 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_53 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_53 <= _GEN_439;
      end else begin
        PHT_53 <= _GEN_695;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_54 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_54 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_54 <= _GEN_440;
      end else begin
        PHT_54 <= _GEN_696;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_55 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_55 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_55 <= _GEN_441;
      end else begin
        PHT_55 <= _GEN_697;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_56 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_56 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_56 <= _GEN_442;
      end else begin
        PHT_56 <= _GEN_698;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_57 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_57 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_57 <= _GEN_443;
      end else begin
        PHT_57 <= _GEN_699;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_58 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_58 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_58 <= _GEN_444;
      end else begin
        PHT_58 <= _GEN_700;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_59 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_59 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_59 <= _GEN_445;
      end else begin
        PHT_59 <= _GEN_701;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_60 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_60 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_60 <= _GEN_446;
      end else begin
        PHT_60 <= _GEN_702;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_61 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_61 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_61 <= _GEN_447;
      end else begin
        PHT_61 <= _GEN_703;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_62 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_62 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_62 <= _GEN_448;
      end else begin
        PHT_62 <= _GEN_704;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_63 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_63 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_63 <= _GEN_449;
      end else begin
        PHT_63 <= _GEN_705;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_64 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_64 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_64 <= _GEN_450;
      end else begin
        PHT_64 <= _GEN_706;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_65 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_65 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_65 <= _GEN_451;
      end else begin
        PHT_65 <= _GEN_707;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_66 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_66 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_66 <= _GEN_452;
      end else begin
        PHT_66 <= _GEN_708;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_67 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_67 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_67 <= _GEN_453;
      end else begin
        PHT_67 <= _GEN_709;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_68 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_68 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_68 <= _GEN_454;
      end else begin
        PHT_68 <= _GEN_710;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_69 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_69 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_69 <= _GEN_455;
      end else begin
        PHT_69 <= _GEN_711;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_70 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_70 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_70 <= _GEN_456;
      end else begin
        PHT_70 <= _GEN_712;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_71 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_71 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_71 <= _GEN_457;
      end else begin
        PHT_71 <= _GEN_713;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_72 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_72 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_72 <= _GEN_458;
      end else begin
        PHT_72 <= _GEN_714;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_73 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_73 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_73 <= _GEN_459;
      end else begin
        PHT_73 <= _GEN_715;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_74 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_74 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_74 <= _GEN_460;
      end else begin
        PHT_74 <= _GEN_716;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_75 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_75 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_75 <= _GEN_461;
      end else begin
        PHT_75 <= _GEN_717;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_76 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_76 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_76 <= _GEN_462;
      end else begin
        PHT_76 <= _GEN_718;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_77 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_77 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_77 <= _GEN_463;
      end else begin
        PHT_77 <= _GEN_719;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_78 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_78 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_78 <= _GEN_464;
      end else begin
        PHT_78 <= _GEN_720;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_79 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_79 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_79 <= _GEN_465;
      end else begin
        PHT_79 <= _GEN_721;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_80 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_80 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_80 <= _GEN_466;
      end else begin
        PHT_80 <= _GEN_722;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_81 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_81 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_81 <= _GEN_467;
      end else begin
        PHT_81 <= _GEN_723;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_82 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_82 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_82 <= _GEN_468;
      end else begin
        PHT_82 <= _GEN_724;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_83 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_83 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_83 <= _GEN_469;
      end else begin
        PHT_83 <= _GEN_725;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_84 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_84 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_84 <= _GEN_470;
      end else begin
        PHT_84 <= _GEN_726;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_85 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_85 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_85 <= _GEN_471;
      end else begin
        PHT_85 <= _GEN_727;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_86 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_86 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_86 <= _GEN_472;
      end else begin
        PHT_86 <= _GEN_728;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_87 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_87 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_87 <= _GEN_473;
      end else begin
        PHT_87 <= _GEN_729;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_88 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_88 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_88 <= _GEN_474;
      end else begin
        PHT_88 <= _GEN_730;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_89 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_89 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_89 <= _GEN_475;
      end else begin
        PHT_89 <= _GEN_731;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_90 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_90 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_90 <= _GEN_476;
      end else begin
        PHT_90 <= _GEN_732;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_91 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_91 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_91 <= _GEN_477;
      end else begin
        PHT_91 <= _GEN_733;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_92 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_92 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_92 <= _GEN_478;
      end else begin
        PHT_92 <= _GEN_734;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_93 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_93 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_93 <= _GEN_479;
      end else begin
        PHT_93 <= _GEN_735;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_94 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_94 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_94 <= _GEN_480;
      end else begin
        PHT_94 <= _GEN_736;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_95 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_95 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_95 <= _GEN_481;
      end else begin
        PHT_95 <= _GEN_737;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_96 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_96 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_96 <= _GEN_482;
      end else begin
        PHT_96 <= _GEN_738;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_97 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_97 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_97 <= _GEN_483;
      end else begin
        PHT_97 <= _GEN_739;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_98 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_98 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_98 <= _GEN_484;
      end else begin
        PHT_98 <= _GEN_740;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_99 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_99 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_99 <= _GEN_485;
      end else begin
        PHT_99 <= _GEN_741;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_100 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_100 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_100 <= _GEN_486;
      end else begin
        PHT_100 <= _GEN_742;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_101 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_101 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_101 <= _GEN_487;
      end else begin
        PHT_101 <= _GEN_743;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_102 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_102 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_102 <= _GEN_488;
      end else begin
        PHT_102 <= _GEN_744;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_103 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_103 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_103 <= _GEN_489;
      end else begin
        PHT_103 <= _GEN_745;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_104 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_104 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_104 <= _GEN_490;
      end else begin
        PHT_104 <= _GEN_746;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_105 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_105 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_105 <= _GEN_491;
      end else begin
        PHT_105 <= _GEN_747;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_106 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_106 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_106 <= _GEN_492;
      end else begin
        PHT_106 <= _GEN_748;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_107 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_107 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_107 <= _GEN_493;
      end else begin
        PHT_107 <= _GEN_749;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_108 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_108 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_108 <= _GEN_494;
      end else begin
        PHT_108 <= _GEN_750;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_109 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_109 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_109 <= _GEN_495;
      end else begin
        PHT_109 <= _GEN_751;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_110 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_110 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_110 <= _GEN_496;
      end else begin
        PHT_110 <= _GEN_752;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_111 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_111 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_111 <= _GEN_497;
      end else begin
        PHT_111 <= _GEN_753;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_112 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_112 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_112 <= _GEN_498;
      end else begin
        PHT_112 <= _GEN_754;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_113 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_113 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_113 <= _GEN_499;
      end else begin
        PHT_113 <= _GEN_755;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_114 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_114 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_114 <= _GEN_500;
      end else begin
        PHT_114 <= _GEN_756;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_115 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_115 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_115 <= _GEN_501;
      end else begin
        PHT_115 <= _GEN_757;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_116 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_116 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_116 <= _GEN_502;
      end else begin
        PHT_116 <= _GEN_758;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_117 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_117 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_117 <= _GEN_503;
      end else begin
        PHT_117 <= _GEN_759;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_118 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_118 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_118 <= _GEN_504;
      end else begin
        PHT_118 <= _GEN_760;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_119 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_119 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_119 <= _GEN_505;
      end else begin
        PHT_119 <= _GEN_761;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_120 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_120 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_120 <= _GEN_506;
      end else begin
        PHT_120 <= _GEN_762;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_121 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_121 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_121 <= _GEN_507;
      end else begin
        PHT_121 <= _GEN_763;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_122 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_122 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_122 <= _GEN_508;
      end else begin
        PHT_122 <= _GEN_764;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_123 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_123 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_123 <= _GEN_509;
      end else begin
        PHT_123 <= _GEN_765;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_124 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_124 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_124 <= _GEN_510;
      end else begin
        PHT_124 <= _GEN_766;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_125 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_125 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_125 <= _GEN_511;
      end else begin
        PHT_125 <= _GEN_767;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_126 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_126 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_126 <= _GEN_512;
      end else begin
        PHT_126 <= _GEN_768;
      end
    end
    if (reset) begin // @[dut.scala 26:20]
      PHT_127 <= 2'h2; // @[dut.scala 26:20]
    end else if (io_reset) begin // @[dut.scala 73:19]
      PHT_127 <= 2'h2; // @[dut.scala 76:14]
    end else if (io_train_valid) begin // @[dut.scala 47:25]
      if (io_train_taken) begin // @[dut.scala 52:27]
        PHT_127 <= _GEN_513;
      end else begin
        PHT_127 <= _GEN_769;
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
  PHT_0 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  PHT_1 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  PHT_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  PHT_3 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  PHT_4 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  PHT_5 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  PHT_6 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  PHT_7 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  PHT_8 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  PHT_9 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  PHT_10 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  PHT_11 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  PHT_12 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  PHT_13 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  PHT_14 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  PHT_15 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  PHT_16 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  PHT_17 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  PHT_18 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  PHT_19 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  PHT_20 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  PHT_21 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  PHT_22 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  PHT_23 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  PHT_24 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  PHT_25 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  PHT_26 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  PHT_27 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  PHT_28 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  PHT_29 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  PHT_30 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  PHT_31 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  PHT_32 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  PHT_33 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  PHT_34 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  PHT_35 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  PHT_36 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  PHT_37 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  PHT_38 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  PHT_39 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  PHT_40 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  PHT_41 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  PHT_42 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  PHT_43 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  PHT_44 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  PHT_45 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  PHT_46 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  PHT_47 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  PHT_48 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  PHT_49 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  PHT_50 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  PHT_51 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  PHT_52 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  PHT_53 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  PHT_54 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  PHT_55 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  PHT_56 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  PHT_57 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  PHT_58 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  PHT_59 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  PHT_60 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  PHT_61 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  PHT_62 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  PHT_63 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  PHT_64 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  PHT_65 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  PHT_66 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  PHT_67 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  PHT_68 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  PHT_69 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  PHT_70 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  PHT_71 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  PHT_72 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  PHT_73 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  PHT_74 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  PHT_75 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  PHT_76 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  PHT_77 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  PHT_78 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  PHT_79 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  PHT_80 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  PHT_81 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  PHT_82 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  PHT_83 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  PHT_84 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  PHT_85 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  PHT_86 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  PHT_87 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  PHT_88 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  PHT_89 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  PHT_90 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  PHT_91 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  PHT_92 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  PHT_93 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  PHT_94 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  PHT_95 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  PHT_96 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  PHT_97 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  PHT_98 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  PHT_99 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  PHT_100 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  PHT_101 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  PHT_102 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  PHT_103 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  PHT_104 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  PHT_105 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  PHT_106 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  PHT_107 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  PHT_108 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  PHT_109 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  PHT_110 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  PHT_111 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  PHT_112 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  PHT_113 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  PHT_114 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  PHT_115 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  PHT_116 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  PHT_117 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  PHT_118 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  PHT_119 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  PHT_120 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  PHT_121 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  PHT_122 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  PHT_123 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  PHT_124 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  PHT_125 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  PHT_126 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  PHT_127 = _RAND_128[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
