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
  reg [1:0] PHT_0; // @[dut.scala 23:20]
  reg [1:0] PHT_1; // @[dut.scala 23:20]
  reg [1:0] PHT_2; // @[dut.scala 23:20]
  reg [1:0] PHT_3; // @[dut.scala 23:20]
  reg [1:0] PHT_4; // @[dut.scala 23:20]
  reg [1:0] PHT_5; // @[dut.scala 23:20]
  reg [1:0] PHT_6; // @[dut.scala 23:20]
  reg [1:0] PHT_7; // @[dut.scala 23:20]
  reg [1:0] PHT_8; // @[dut.scala 23:20]
  reg [1:0] PHT_9; // @[dut.scala 23:20]
  reg [1:0] PHT_10; // @[dut.scala 23:20]
  reg [1:0] PHT_11; // @[dut.scala 23:20]
  reg [1:0] PHT_12; // @[dut.scala 23:20]
  reg [1:0] PHT_13; // @[dut.scala 23:20]
  reg [1:0] PHT_14; // @[dut.scala 23:20]
  reg [1:0] PHT_15; // @[dut.scala 23:20]
  reg [1:0] PHT_16; // @[dut.scala 23:20]
  reg [1:0] PHT_17; // @[dut.scala 23:20]
  reg [1:0] PHT_18; // @[dut.scala 23:20]
  reg [1:0] PHT_19; // @[dut.scala 23:20]
  reg [1:0] PHT_20; // @[dut.scala 23:20]
  reg [1:0] PHT_21; // @[dut.scala 23:20]
  reg [1:0] PHT_22; // @[dut.scala 23:20]
  reg [1:0] PHT_23; // @[dut.scala 23:20]
  reg [1:0] PHT_24; // @[dut.scala 23:20]
  reg [1:0] PHT_25; // @[dut.scala 23:20]
  reg [1:0] PHT_26; // @[dut.scala 23:20]
  reg [1:0] PHT_27; // @[dut.scala 23:20]
  reg [1:0] PHT_28; // @[dut.scala 23:20]
  reg [1:0] PHT_29; // @[dut.scala 23:20]
  reg [1:0] PHT_30; // @[dut.scala 23:20]
  reg [1:0] PHT_31; // @[dut.scala 23:20]
  reg [1:0] PHT_32; // @[dut.scala 23:20]
  reg [1:0] PHT_33; // @[dut.scala 23:20]
  reg [1:0] PHT_34; // @[dut.scala 23:20]
  reg [1:0] PHT_35; // @[dut.scala 23:20]
  reg [1:0] PHT_36; // @[dut.scala 23:20]
  reg [1:0] PHT_37; // @[dut.scala 23:20]
  reg [1:0] PHT_38; // @[dut.scala 23:20]
  reg [1:0] PHT_39; // @[dut.scala 23:20]
  reg [1:0] PHT_40; // @[dut.scala 23:20]
  reg [1:0] PHT_41; // @[dut.scala 23:20]
  reg [1:0] PHT_42; // @[dut.scala 23:20]
  reg [1:0] PHT_43; // @[dut.scala 23:20]
  reg [1:0] PHT_44; // @[dut.scala 23:20]
  reg [1:0] PHT_45; // @[dut.scala 23:20]
  reg [1:0] PHT_46; // @[dut.scala 23:20]
  reg [1:0] PHT_47; // @[dut.scala 23:20]
  reg [1:0] PHT_48; // @[dut.scala 23:20]
  reg [1:0] PHT_49; // @[dut.scala 23:20]
  reg [1:0] PHT_50; // @[dut.scala 23:20]
  reg [1:0] PHT_51; // @[dut.scala 23:20]
  reg [1:0] PHT_52; // @[dut.scala 23:20]
  reg [1:0] PHT_53; // @[dut.scala 23:20]
  reg [1:0] PHT_54; // @[dut.scala 23:20]
  reg [1:0] PHT_55; // @[dut.scala 23:20]
  reg [1:0] PHT_56; // @[dut.scala 23:20]
  reg [1:0] PHT_57; // @[dut.scala 23:20]
  reg [1:0] PHT_58; // @[dut.scala 23:20]
  reg [1:0] PHT_59; // @[dut.scala 23:20]
  reg [1:0] PHT_60; // @[dut.scala 23:20]
  reg [1:0] PHT_61; // @[dut.scala 23:20]
  reg [1:0] PHT_62; // @[dut.scala 23:20]
  reg [1:0] PHT_63; // @[dut.scala 23:20]
  reg [1:0] PHT_64; // @[dut.scala 23:20]
  reg [1:0] PHT_65; // @[dut.scala 23:20]
  reg [1:0] PHT_66; // @[dut.scala 23:20]
  reg [1:0] PHT_67; // @[dut.scala 23:20]
  reg [1:0] PHT_68; // @[dut.scala 23:20]
  reg [1:0] PHT_69; // @[dut.scala 23:20]
  reg [1:0] PHT_70; // @[dut.scala 23:20]
  reg [1:0] PHT_71; // @[dut.scala 23:20]
  reg [1:0] PHT_72; // @[dut.scala 23:20]
  reg [1:0] PHT_73; // @[dut.scala 23:20]
  reg [1:0] PHT_74; // @[dut.scala 23:20]
  reg [1:0] PHT_75; // @[dut.scala 23:20]
  reg [1:0] PHT_76; // @[dut.scala 23:20]
  reg [1:0] PHT_77; // @[dut.scala 23:20]
  reg [1:0] PHT_78; // @[dut.scala 23:20]
  reg [1:0] PHT_79; // @[dut.scala 23:20]
  reg [1:0] PHT_80; // @[dut.scala 23:20]
  reg [1:0] PHT_81; // @[dut.scala 23:20]
  reg [1:0] PHT_82; // @[dut.scala 23:20]
  reg [1:0] PHT_83; // @[dut.scala 23:20]
  reg [1:0] PHT_84; // @[dut.scala 23:20]
  reg [1:0] PHT_85; // @[dut.scala 23:20]
  reg [1:0] PHT_86; // @[dut.scala 23:20]
  reg [1:0] PHT_87; // @[dut.scala 23:20]
  reg [1:0] PHT_88; // @[dut.scala 23:20]
  reg [1:0] PHT_89; // @[dut.scala 23:20]
  reg [1:0] PHT_90; // @[dut.scala 23:20]
  reg [1:0] PHT_91; // @[dut.scala 23:20]
  reg [1:0] PHT_92; // @[dut.scala 23:20]
  reg [1:0] PHT_93; // @[dut.scala 23:20]
  reg [1:0] PHT_94; // @[dut.scala 23:20]
  reg [1:0] PHT_95; // @[dut.scala 23:20]
  reg [1:0] PHT_96; // @[dut.scala 23:20]
  reg [1:0] PHT_97; // @[dut.scala 23:20]
  reg [1:0] PHT_98; // @[dut.scala 23:20]
  reg [1:0] PHT_99; // @[dut.scala 23:20]
  reg [1:0] PHT_100; // @[dut.scala 23:20]
  reg [1:0] PHT_101; // @[dut.scala 23:20]
  reg [1:0] PHT_102; // @[dut.scala 23:20]
  reg [1:0] PHT_103; // @[dut.scala 23:20]
  reg [1:0] PHT_104; // @[dut.scala 23:20]
  reg [1:0] PHT_105; // @[dut.scala 23:20]
  reg [1:0] PHT_106; // @[dut.scala 23:20]
  reg [1:0] PHT_107; // @[dut.scala 23:20]
  reg [1:0] PHT_108; // @[dut.scala 23:20]
  reg [1:0] PHT_109; // @[dut.scala 23:20]
  reg [1:0] PHT_110; // @[dut.scala 23:20]
  reg [1:0] PHT_111; // @[dut.scala 23:20]
  reg [1:0] PHT_112; // @[dut.scala 23:20]
  reg [1:0] PHT_113; // @[dut.scala 23:20]
  reg [1:0] PHT_114; // @[dut.scala 23:20]
  reg [1:0] PHT_115; // @[dut.scala 23:20]
  reg [1:0] PHT_116; // @[dut.scala 23:20]
  reg [1:0] PHT_117; // @[dut.scala 23:20]
  reg [1:0] PHT_118; // @[dut.scala 23:20]
  reg [1:0] PHT_119; // @[dut.scala 23:20]
  reg [1:0] PHT_120; // @[dut.scala 23:20]
  reg [1:0] PHT_121; // @[dut.scala 23:20]
  reg [1:0] PHT_122; // @[dut.scala 23:20]
  reg [1:0] PHT_123; // @[dut.scala 23:20]
  reg [1:0] PHT_124; // @[dut.scala 23:20]
  reg [1:0] PHT_125; // @[dut.scala 23:20]
  reg [1:0] PHT_126; // @[dut.scala 23:20]
  reg [1:0] PHT_127; // @[dut.scala 23:20]
  reg [6:0] globalHistory; // @[dut.scala 24:30]
  wire [1:0] _GEN_1 = io_reset ? 2'h0 : PHT_0; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_2 = io_reset ? 2'h0 : PHT_1; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_3 = io_reset ? 2'h0 : PHT_2; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_4 = io_reset ? 2'h0 : PHT_3; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_5 = io_reset ? 2'h0 : PHT_4; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_6 = io_reset ? 2'h0 : PHT_5; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_7 = io_reset ? 2'h0 : PHT_6; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_8 = io_reset ? 2'h0 : PHT_7; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_9 = io_reset ? 2'h0 : PHT_8; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_10 = io_reset ? 2'h0 : PHT_9; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_11 = io_reset ? 2'h0 : PHT_10; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_12 = io_reset ? 2'h0 : PHT_11; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_13 = io_reset ? 2'h0 : PHT_12; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_14 = io_reset ? 2'h0 : PHT_13; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_15 = io_reset ? 2'h0 : PHT_14; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_16 = io_reset ? 2'h0 : PHT_15; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_17 = io_reset ? 2'h0 : PHT_16; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_18 = io_reset ? 2'h0 : PHT_17; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_19 = io_reset ? 2'h0 : PHT_18; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_20 = io_reset ? 2'h0 : PHT_19; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_21 = io_reset ? 2'h0 : PHT_20; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_22 = io_reset ? 2'h0 : PHT_21; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_23 = io_reset ? 2'h0 : PHT_22; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_24 = io_reset ? 2'h0 : PHT_23; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_25 = io_reset ? 2'h0 : PHT_24; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_26 = io_reset ? 2'h0 : PHT_25; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_27 = io_reset ? 2'h0 : PHT_26; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_28 = io_reset ? 2'h0 : PHT_27; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_29 = io_reset ? 2'h0 : PHT_28; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_30 = io_reset ? 2'h0 : PHT_29; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_31 = io_reset ? 2'h0 : PHT_30; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_32 = io_reset ? 2'h0 : PHT_31; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_33 = io_reset ? 2'h0 : PHT_32; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_34 = io_reset ? 2'h0 : PHT_33; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_35 = io_reset ? 2'h0 : PHT_34; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_36 = io_reset ? 2'h0 : PHT_35; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_37 = io_reset ? 2'h0 : PHT_36; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_38 = io_reset ? 2'h0 : PHT_37; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_39 = io_reset ? 2'h0 : PHT_38; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_40 = io_reset ? 2'h0 : PHT_39; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_41 = io_reset ? 2'h0 : PHT_40; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_42 = io_reset ? 2'h0 : PHT_41; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_43 = io_reset ? 2'h0 : PHT_42; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_44 = io_reset ? 2'h0 : PHT_43; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_45 = io_reset ? 2'h0 : PHT_44; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_46 = io_reset ? 2'h0 : PHT_45; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_47 = io_reset ? 2'h0 : PHT_46; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_48 = io_reset ? 2'h0 : PHT_47; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_49 = io_reset ? 2'h0 : PHT_48; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_50 = io_reset ? 2'h0 : PHT_49; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_51 = io_reset ? 2'h0 : PHT_50; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_52 = io_reset ? 2'h0 : PHT_51; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_53 = io_reset ? 2'h0 : PHT_52; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_54 = io_reset ? 2'h0 : PHT_53; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_55 = io_reset ? 2'h0 : PHT_54; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_56 = io_reset ? 2'h0 : PHT_55; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_57 = io_reset ? 2'h0 : PHT_56; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_58 = io_reset ? 2'h0 : PHT_57; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_59 = io_reset ? 2'h0 : PHT_58; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_60 = io_reset ? 2'h0 : PHT_59; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_61 = io_reset ? 2'h0 : PHT_60; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_62 = io_reset ? 2'h0 : PHT_61; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_63 = io_reset ? 2'h0 : PHT_62; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_64 = io_reset ? 2'h0 : PHT_63; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_65 = io_reset ? 2'h0 : PHT_64; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_66 = io_reset ? 2'h0 : PHT_65; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_67 = io_reset ? 2'h0 : PHT_66; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_68 = io_reset ? 2'h0 : PHT_67; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_69 = io_reset ? 2'h0 : PHT_68; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_70 = io_reset ? 2'h0 : PHT_69; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_71 = io_reset ? 2'h0 : PHT_70; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_72 = io_reset ? 2'h0 : PHT_71; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_73 = io_reset ? 2'h0 : PHT_72; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_74 = io_reset ? 2'h0 : PHT_73; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_75 = io_reset ? 2'h0 : PHT_74; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_76 = io_reset ? 2'h0 : PHT_75; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_77 = io_reset ? 2'h0 : PHT_76; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_78 = io_reset ? 2'h0 : PHT_77; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_79 = io_reset ? 2'h0 : PHT_78; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_80 = io_reset ? 2'h0 : PHT_79; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_81 = io_reset ? 2'h0 : PHT_80; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_82 = io_reset ? 2'h0 : PHT_81; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_83 = io_reset ? 2'h0 : PHT_82; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_84 = io_reset ? 2'h0 : PHT_83; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_85 = io_reset ? 2'h0 : PHT_84; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_86 = io_reset ? 2'h0 : PHT_85; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_87 = io_reset ? 2'h0 : PHT_86; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_88 = io_reset ? 2'h0 : PHT_87; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_89 = io_reset ? 2'h0 : PHT_88; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_90 = io_reset ? 2'h0 : PHT_89; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_91 = io_reset ? 2'h0 : PHT_90; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_92 = io_reset ? 2'h0 : PHT_91; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_93 = io_reset ? 2'h0 : PHT_92; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_94 = io_reset ? 2'h0 : PHT_93; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_95 = io_reset ? 2'h0 : PHT_94; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_96 = io_reset ? 2'h0 : PHT_95; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_97 = io_reset ? 2'h0 : PHT_96; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_98 = io_reset ? 2'h0 : PHT_97; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_99 = io_reset ? 2'h0 : PHT_98; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_100 = io_reset ? 2'h0 : PHT_99; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_101 = io_reset ? 2'h0 : PHT_100; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_102 = io_reset ? 2'h0 : PHT_101; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_103 = io_reset ? 2'h0 : PHT_102; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_104 = io_reset ? 2'h0 : PHT_103; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_105 = io_reset ? 2'h0 : PHT_104; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_106 = io_reset ? 2'h0 : PHT_105; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_107 = io_reset ? 2'h0 : PHT_106; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_108 = io_reset ? 2'h0 : PHT_107; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_109 = io_reset ? 2'h0 : PHT_108; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_110 = io_reset ? 2'h0 : PHT_109; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_111 = io_reset ? 2'h0 : PHT_110; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_112 = io_reset ? 2'h0 : PHT_111; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_113 = io_reset ? 2'h0 : PHT_112; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_114 = io_reset ? 2'h0 : PHT_113; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_115 = io_reset ? 2'h0 : PHT_114; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_116 = io_reset ? 2'h0 : PHT_115; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_117 = io_reset ? 2'h0 : PHT_116; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_118 = io_reset ? 2'h0 : PHT_117; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_119 = io_reset ? 2'h0 : PHT_118; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_120 = io_reset ? 2'h0 : PHT_119; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_121 = io_reset ? 2'h0 : PHT_120; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_122 = io_reset ? 2'h0 : PHT_121; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_123 = io_reset ? 2'h0 : PHT_122; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_124 = io_reset ? 2'h0 : PHT_123; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_125 = io_reset ? 2'h0 : PHT_124; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_126 = io_reset ? 2'h0 : PHT_125; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_127 = io_reset ? 2'h0 : PHT_126; // @[dut.scala 27:18 23:20 29:36]
  wire [1:0] _GEN_128 = io_reset ? 2'h0 : PHT_127; // @[dut.scala 27:18 23:20 29:36]
  wire [6:0] predict_index = io_predict_pc ^ globalHistory; // @[dut.scala 34:8]
  wire [1:0] _GEN_130 = 7'h1 == predict_index ? PHT_1 : PHT_0; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_131 = 7'h2 == predict_index ? PHT_2 : _GEN_130; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_132 = 7'h3 == predict_index ? PHT_3 : _GEN_131; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_133 = 7'h4 == predict_index ? PHT_4 : _GEN_132; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_134 = 7'h5 == predict_index ? PHT_5 : _GEN_133; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_135 = 7'h6 == predict_index ? PHT_6 : _GEN_134; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_136 = 7'h7 == predict_index ? PHT_7 : _GEN_135; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_137 = 7'h8 == predict_index ? PHT_8 : _GEN_136; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_138 = 7'h9 == predict_index ? PHT_9 : _GEN_137; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_139 = 7'ha == predict_index ? PHT_10 : _GEN_138; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_140 = 7'hb == predict_index ? PHT_11 : _GEN_139; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_141 = 7'hc == predict_index ? PHT_12 : _GEN_140; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_142 = 7'hd == predict_index ? PHT_13 : _GEN_141; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_143 = 7'he == predict_index ? PHT_14 : _GEN_142; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_144 = 7'hf == predict_index ? PHT_15 : _GEN_143; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_145 = 7'h10 == predict_index ? PHT_16 : _GEN_144; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_146 = 7'h11 == predict_index ? PHT_17 : _GEN_145; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_147 = 7'h12 == predict_index ? PHT_18 : _GEN_146; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_148 = 7'h13 == predict_index ? PHT_19 : _GEN_147; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_149 = 7'h14 == predict_index ? PHT_20 : _GEN_148; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_150 = 7'h15 == predict_index ? PHT_21 : _GEN_149; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_151 = 7'h16 == predict_index ? PHT_22 : _GEN_150; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_152 = 7'h17 == predict_index ? PHT_23 : _GEN_151; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_153 = 7'h18 == predict_index ? PHT_24 : _GEN_152; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_154 = 7'h19 == predict_index ? PHT_25 : _GEN_153; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_155 = 7'h1a == predict_index ? PHT_26 : _GEN_154; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_156 = 7'h1b == predict_index ? PHT_27 : _GEN_155; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_157 = 7'h1c == predict_index ? PHT_28 : _GEN_156; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_158 = 7'h1d == predict_index ? PHT_29 : _GEN_157; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_159 = 7'h1e == predict_index ? PHT_30 : _GEN_158; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_160 = 7'h1f == predict_index ? PHT_31 : _GEN_159; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_161 = 7'h20 == predict_index ? PHT_32 : _GEN_160; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_162 = 7'h21 == predict_index ? PHT_33 : _GEN_161; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_163 = 7'h22 == predict_index ? PHT_34 : _GEN_162; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_164 = 7'h23 == predict_index ? PHT_35 : _GEN_163; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_165 = 7'h24 == predict_index ? PHT_36 : _GEN_164; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_166 = 7'h25 == predict_index ? PHT_37 : _GEN_165; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_167 = 7'h26 == predict_index ? PHT_38 : _GEN_166; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_168 = 7'h27 == predict_index ? PHT_39 : _GEN_167; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_169 = 7'h28 == predict_index ? PHT_40 : _GEN_168; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_170 = 7'h29 == predict_index ? PHT_41 : _GEN_169; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_171 = 7'h2a == predict_index ? PHT_42 : _GEN_170; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_172 = 7'h2b == predict_index ? PHT_43 : _GEN_171; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_173 = 7'h2c == predict_index ? PHT_44 : _GEN_172; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_174 = 7'h2d == predict_index ? PHT_45 : _GEN_173; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_175 = 7'h2e == predict_index ? PHT_46 : _GEN_174; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_176 = 7'h2f == predict_index ? PHT_47 : _GEN_175; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_177 = 7'h30 == predict_index ? PHT_48 : _GEN_176; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_178 = 7'h31 == predict_index ? PHT_49 : _GEN_177; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_179 = 7'h32 == predict_index ? PHT_50 : _GEN_178; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_180 = 7'h33 == predict_index ? PHT_51 : _GEN_179; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_181 = 7'h34 == predict_index ? PHT_52 : _GEN_180; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_182 = 7'h35 == predict_index ? PHT_53 : _GEN_181; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_183 = 7'h36 == predict_index ? PHT_54 : _GEN_182; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_184 = 7'h37 == predict_index ? PHT_55 : _GEN_183; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_185 = 7'h38 == predict_index ? PHT_56 : _GEN_184; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_186 = 7'h39 == predict_index ? PHT_57 : _GEN_185; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_187 = 7'h3a == predict_index ? PHT_58 : _GEN_186; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_188 = 7'h3b == predict_index ? PHT_59 : _GEN_187; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_189 = 7'h3c == predict_index ? PHT_60 : _GEN_188; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_190 = 7'h3d == predict_index ? PHT_61 : _GEN_189; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_191 = 7'h3e == predict_index ? PHT_62 : _GEN_190; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_192 = 7'h3f == predict_index ? PHT_63 : _GEN_191; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_193 = 7'h40 == predict_index ? PHT_64 : _GEN_192; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_194 = 7'h41 == predict_index ? PHT_65 : _GEN_193; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_195 = 7'h42 == predict_index ? PHT_66 : _GEN_194; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_196 = 7'h43 == predict_index ? PHT_67 : _GEN_195; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_197 = 7'h44 == predict_index ? PHT_68 : _GEN_196; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_198 = 7'h45 == predict_index ? PHT_69 : _GEN_197; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_199 = 7'h46 == predict_index ? PHT_70 : _GEN_198; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_200 = 7'h47 == predict_index ? PHT_71 : _GEN_199; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_201 = 7'h48 == predict_index ? PHT_72 : _GEN_200; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_202 = 7'h49 == predict_index ? PHT_73 : _GEN_201; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_203 = 7'h4a == predict_index ? PHT_74 : _GEN_202; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_204 = 7'h4b == predict_index ? PHT_75 : _GEN_203; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_205 = 7'h4c == predict_index ? PHT_76 : _GEN_204; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_206 = 7'h4d == predict_index ? PHT_77 : _GEN_205; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_207 = 7'h4e == predict_index ? PHT_78 : _GEN_206; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_208 = 7'h4f == predict_index ? PHT_79 : _GEN_207; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_209 = 7'h50 == predict_index ? PHT_80 : _GEN_208; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_210 = 7'h51 == predict_index ? PHT_81 : _GEN_209; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_211 = 7'h52 == predict_index ? PHT_82 : _GEN_210; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_212 = 7'h53 == predict_index ? PHT_83 : _GEN_211; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_213 = 7'h54 == predict_index ? PHT_84 : _GEN_212; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_214 = 7'h55 == predict_index ? PHT_85 : _GEN_213; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_215 = 7'h56 == predict_index ? PHT_86 : _GEN_214; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_216 = 7'h57 == predict_index ? PHT_87 : _GEN_215; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_217 = 7'h58 == predict_index ? PHT_88 : _GEN_216; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_218 = 7'h59 == predict_index ? PHT_89 : _GEN_217; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_219 = 7'h5a == predict_index ? PHT_90 : _GEN_218; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_220 = 7'h5b == predict_index ? PHT_91 : _GEN_219; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_221 = 7'h5c == predict_index ? PHT_92 : _GEN_220; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_222 = 7'h5d == predict_index ? PHT_93 : _GEN_221; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_223 = 7'h5e == predict_index ? PHT_94 : _GEN_222; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_224 = 7'h5f == predict_index ? PHT_95 : _GEN_223; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_225 = 7'h60 == predict_index ? PHT_96 : _GEN_224; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_226 = 7'h61 == predict_index ? PHT_97 : _GEN_225; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_227 = 7'h62 == predict_index ? PHT_98 : _GEN_226; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_228 = 7'h63 == predict_index ? PHT_99 : _GEN_227; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_229 = 7'h64 == predict_index ? PHT_100 : _GEN_228; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_230 = 7'h65 == predict_index ? PHT_101 : _GEN_229; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_231 = 7'h66 == predict_index ? PHT_102 : _GEN_230; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_232 = 7'h67 == predict_index ? PHT_103 : _GEN_231; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_233 = 7'h68 == predict_index ? PHT_104 : _GEN_232; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_234 = 7'h69 == predict_index ? PHT_105 : _GEN_233; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_235 = 7'h6a == predict_index ? PHT_106 : _GEN_234; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_236 = 7'h6b == predict_index ? PHT_107 : _GEN_235; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_237 = 7'h6c == predict_index ? PHT_108 : _GEN_236; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_238 = 7'h6d == predict_index ? PHT_109 : _GEN_237; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_239 = 7'h6e == predict_index ? PHT_110 : _GEN_238; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_240 = 7'h6f == predict_index ? PHT_111 : _GEN_239; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_241 = 7'h70 == predict_index ? PHT_112 : _GEN_240; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_242 = 7'h71 == predict_index ? PHT_113 : _GEN_241; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_243 = 7'h72 == predict_index ? PHT_114 : _GEN_242; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_244 = 7'h73 == predict_index ? PHT_115 : _GEN_243; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_245 = 7'h74 == predict_index ? PHT_116 : _GEN_244; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_246 = 7'h75 == predict_index ? PHT_117 : _GEN_245; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_247 = 7'h76 == predict_index ? PHT_118 : _GEN_246; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_248 = 7'h77 == predict_index ? PHT_119 : _GEN_247; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_249 = 7'h78 == predict_index ? PHT_120 : _GEN_248; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_250 = 7'h79 == predict_index ? PHT_121 : _GEN_249; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_251 = 7'h7a == predict_index ? PHT_122 : _GEN_250; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_252 = 7'h7b == predict_index ? PHT_123 : _GEN_251; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_253 = 7'h7c == predict_index ? PHT_124 : _GEN_252; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_254 = 7'h7d == predict_index ? PHT_125 : _GEN_253; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_255 = 7'h7e == predict_index ? PHT_126 : _GEN_254; // @[dut.scala 42:{39,39}]
  wire [1:0] _GEN_256 = 7'h7f == predict_index ? PHT_127 : _GEN_255; // @[dut.scala 42:{39,39}]
  wire [6:0] train_index = io_train_pc ^ io_train_history; // @[dut.scala 34:8]
  wire [1:0] _GEN_258 = 7'h1 == train_index ? PHT_1 : PHT_0; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_259 = 7'h2 == train_index ? PHT_2 : _GEN_258; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_260 = 7'h3 == train_index ? PHT_3 : _GEN_259; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_261 = 7'h4 == train_index ? PHT_4 : _GEN_260; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_262 = 7'h5 == train_index ? PHT_5 : _GEN_261; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_263 = 7'h6 == train_index ? PHT_6 : _GEN_262; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_264 = 7'h7 == train_index ? PHT_7 : _GEN_263; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_265 = 7'h8 == train_index ? PHT_8 : _GEN_264; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_266 = 7'h9 == train_index ? PHT_9 : _GEN_265; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_267 = 7'ha == train_index ? PHT_10 : _GEN_266; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_268 = 7'hb == train_index ? PHT_11 : _GEN_267; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_269 = 7'hc == train_index ? PHT_12 : _GEN_268; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_270 = 7'hd == train_index ? PHT_13 : _GEN_269; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_271 = 7'he == train_index ? PHT_14 : _GEN_270; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_272 = 7'hf == train_index ? PHT_15 : _GEN_271; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_273 = 7'h10 == train_index ? PHT_16 : _GEN_272; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_274 = 7'h11 == train_index ? PHT_17 : _GEN_273; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_275 = 7'h12 == train_index ? PHT_18 : _GEN_274; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_276 = 7'h13 == train_index ? PHT_19 : _GEN_275; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_277 = 7'h14 == train_index ? PHT_20 : _GEN_276; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_278 = 7'h15 == train_index ? PHT_21 : _GEN_277; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_279 = 7'h16 == train_index ? PHT_22 : _GEN_278; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_280 = 7'h17 == train_index ? PHT_23 : _GEN_279; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_281 = 7'h18 == train_index ? PHT_24 : _GEN_280; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_282 = 7'h19 == train_index ? PHT_25 : _GEN_281; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_283 = 7'h1a == train_index ? PHT_26 : _GEN_282; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_284 = 7'h1b == train_index ? PHT_27 : _GEN_283; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_285 = 7'h1c == train_index ? PHT_28 : _GEN_284; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_286 = 7'h1d == train_index ? PHT_29 : _GEN_285; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_287 = 7'h1e == train_index ? PHT_30 : _GEN_286; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_288 = 7'h1f == train_index ? PHT_31 : _GEN_287; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_289 = 7'h20 == train_index ? PHT_32 : _GEN_288; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_290 = 7'h21 == train_index ? PHT_33 : _GEN_289; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_291 = 7'h22 == train_index ? PHT_34 : _GEN_290; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_292 = 7'h23 == train_index ? PHT_35 : _GEN_291; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_293 = 7'h24 == train_index ? PHT_36 : _GEN_292; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_294 = 7'h25 == train_index ? PHT_37 : _GEN_293; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_295 = 7'h26 == train_index ? PHT_38 : _GEN_294; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_296 = 7'h27 == train_index ? PHT_39 : _GEN_295; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_297 = 7'h28 == train_index ? PHT_40 : _GEN_296; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_298 = 7'h29 == train_index ? PHT_41 : _GEN_297; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_299 = 7'h2a == train_index ? PHT_42 : _GEN_298; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_300 = 7'h2b == train_index ? PHT_43 : _GEN_299; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_301 = 7'h2c == train_index ? PHT_44 : _GEN_300; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_302 = 7'h2d == train_index ? PHT_45 : _GEN_301; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_303 = 7'h2e == train_index ? PHT_46 : _GEN_302; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_304 = 7'h2f == train_index ? PHT_47 : _GEN_303; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_305 = 7'h30 == train_index ? PHT_48 : _GEN_304; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_306 = 7'h31 == train_index ? PHT_49 : _GEN_305; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_307 = 7'h32 == train_index ? PHT_50 : _GEN_306; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_308 = 7'h33 == train_index ? PHT_51 : _GEN_307; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_309 = 7'h34 == train_index ? PHT_52 : _GEN_308; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_310 = 7'h35 == train_index ? PHT_53 : _GEN_309; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_311 = 7'h36 == train_index ? PHT_54 : _GEN_310; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_312 = 7'h37 == train_index ? PHT_55 : _GEN_311; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_313 = 7'h38 == train_index ? PHT_56 : _GEN_312; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_314 = 7'h39 == train_index ? PHT_57 : _GEN_313; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_315 = 7'h3a == train_index ? PHT_58 : _GEN_314; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_316 = 7'h3b == train_index ? PHT_59 : _GEN_315; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_317 = 7'h3c == train_index ? PHT_60 : _GEN_316; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_318 = 7'h3d == train_index ? PHT_61 : _GEN_317; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_319 = 7'h3e == train_index ? PHT_62 : _GEN_318; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_320 = 7'h3f == train_index ? PHT_63 : _GEN_319; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_321 = 7'h40 == train_index ? PHT_64 : _GEN_320; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_322 = 7'h41 == train_index ? PHT_65 : _GEN_321; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_323 = 7'h42 == train_index ? PHT_66 : _GEN_322; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_324 = 7'h43 == train_index ? PHT_67 : _GEN_323; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_325 = 7'h44 == train_index ? PHT_68 : _GEN_324; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_326 = 7'h45 == train_index ? PHT_69 : _GEN_325; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_327 = 7'h46 == train_index ? PHT_70 : _GEN_326; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_328 = 7'h47 == train_index ? PHT_71 : _GEN_327; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_329 = 7'h48 == train_index ? PHT_72 : _GEN_328; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_330 = 7'h49 == train_index ? PHT_73 : _GEN_329; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_331 = 7'h4a == train_index ? PHT_74 : _GEN_330; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_332 = 7'h4b == train_index ? PHT_75 : _GEN_331; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_333 = 7'h4c == train_index ? PHT_76 : _GEN_332; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_334 = 7'h4d == train_index ? PHT_77 : _GEN_333; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_335 = 7'h4e == train_index ? PHT_78 : _GEN_334; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_336 = 7'h4f == train_index ? PHT_79 : _GEN_335; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_337 = 7'h50 == train_index ? PHT_80 : _GEN_336; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_338 = 7'h51 == train_index ? PHT_81 : _GEN_337; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_339 = 7'h52 == train_index ? PHT_82 : _GEN_338; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_340 = 7'h53 == train_index ? PHT_83 : _GEN_339; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_341 = 7'h54 == train_index ? PHT_84 : _GEN_340; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_342 = 7'h55 == train_index ? PHT_85 : _GEN_341; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_343 = 7'h56 == train_index ? PHT_86 : _GEN_342; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_344 = 7'h57 == train_index ? PHT_87 : _GEN_343; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_345 = 7'h58 == train_index ? PHT_88 : _GEN_344; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_346 = 7'h59 == train_index ? PHT_89 : _GEN_345; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_347 = 7'h5a == train_index ? PHT_90 : _GEN_346; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_348 = 7'h5b == train_index ? PHT_91 : _GEN_347; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_349 = 7'h5c == train_index ? PHT_92 : _GEN_348; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_350 = 7'h5d == train_index ? PHT_93 : _GEN_349; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_351 = 7'h5e == train_index ? PHT_94 : _GEN_350; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_352 = 7'h5f == train_index ? PHT_95 : _GEN_351; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_353 = 7'h60 == train_index ? PHT_96 : _GEN_352; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_354 = 7'h61 == train_index ? PHT_97 : _GEN_353; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_355 = 7'h62 == train_index ? PHT_98 : _GEN_354; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_356 = 7'h63 == train_index ? PHT_99 : _GEN_355; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_357 = 7'h64 == train_index ? PHT_100 : _GEN_356; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_358 = 7'h65 == train_index ? PHT_101 : _GEN_357; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_359 = 7'h66 == train_index ? PHT_102 : _GEN_358; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_360 = 7'h67 == train_index ? PHT_103 : _GEN_359; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_361 = 7'h68 == train_index ? PHT_104 : _GEN_360; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_362 = 7'h69 == train_index ? PHT_105 : _GEN_361; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_363 = 7'h6a == train_index ? PHT_106 : _GEN_362; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_364 = 7'h6b == train_index ? PHT_107 : _GEN_363; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_365 = 7'h6c == train_index ? PHT_108 : _GEN_364; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_366 = 7'h6d == train_index ? PHT_109 : _GEN_365; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_367 = 7'h6e == train_index ? PHT_110 : _GEN_366; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_368 = 7'h6f == train_index ? PHT_111 : _GEN_367; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_369 = 7'h70 == train_index ? PHT_112 : _GEN_368; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_370 = 7'h71 == train_index ? PHT_113 : _GEN_369; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_371 = 7'h72 == train_index ? PHT_114 : _GEN_370; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_372 = 7'h73 == train_index ? PHT_115 : _GEN_371; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_373 = 7'h74 == train_index ? PHT_116 : _GEN_372; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_374 = 7'h75 == train_index ? PHT_117 : _GEN_373; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_375 = 7'h76 == train_index ? PHT_118 : _GEN_374; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_376 = 7'h77 == train_index ? PHT_119 : _GEN_375; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_377 = 7'h78 == train_index ? PHT_120 : _GEN_376; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_378 = 7'h79 == train_index ? PHT_121 : _GEN_377; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_379 = 7'h7a == train_index ? PHT_122 : _GEN_378; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_380 = 7'h7b == train_index ? PHT_123 : _GEN_379; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_381 = 7'h7c == train_index ? PHT_124 : _GEN_380; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_382 = 7'h7d == train_index ? PHT_125 : _GEN_381; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_383 = 7'h7e == train_index ? PHT_126 : _GEN_382; // @[dut.scala 51:{29,29}]
  wire [1:0] _GEN_384 = 7'h7f == train_index ? PHT_127 : _GEN_383; // @[dut.scala 51:{29,29}]
  wire [1:0] _PHT_T_1 = _GEN_384 + 2'h1; // @[dut.scala 52:46]
  wire [1:0] _GEN_385 = 7'h0 == train_index ? _PHT_T_1 : _GEN_1; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_386 = 7'h1 == train_index ? _PHT_T_1 : _GEN_2; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_387 = 7'h2 == train_index ? _PHT_T_1 : _GEN_3; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_388 = 7'h3 == train_index ? _PHT_T_1 : _GEN_4; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_389 = 7'h4 == train_index ? _PHT_T_1 : _GEN_5; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_390 = 7'h5 == train_index ? _PHT_T_1 : _GEN_6; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_391 = 7'h6 == train_index ? _PHT_T_1 : _GEN_7; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_392 = 7'h7 == train_index ? _PHT_T_1 : _GEN_8; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_393 = 7'h8 == train_index ? _PHT_T_1 : _GEN_9; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_394 = 7'h9 == train_index ? _PHT_T_1 : _GEN_10; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_395 = 7'ha == train_index ? _PHT_T_1 : _GEN_11; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_396 = 7'hb == train_index ? _PHT_T_1 : _GEN_12; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_397 = 7'hc == train_index ? _PHT_T_1 : _GEN_13; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_398 = 7'hd == train_index ? _PHT_T_1 : _GEN_14; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_399 = 7'he == train_index ? _PHT_T_1 : _GEN_15; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_400 = 7'hf == train_index ? _PHT_T_1 : _GEN_16; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_401 = 7'h10 == train_index ? _PHT_T_1 : _GEN_17; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_402 = 7'h11 == train_index ? _PHT_T_1 : _GEN_18; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_403 = 7'h12 == train_index ? _PHT_T_1 : _GEN_19; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_404 = 7'h13 == train_index ? _PHT_T_1 : _GEN_20; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_405 = 7'h14 == train_index ? _PHT_T_1 : _GEN_21; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_406 = 7'h15 == train_index ? _PHT_T_1 : _GEN_22; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_407 = 7'h16 == train_index ? _PHT_T_1 : _GEN_23; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_408 = 7'h17 == train_index ? _PHT_T_1 : _GEN_24; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_409 = 7'h18 == train_index ? _PHT_T_1 : _GEN_25; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_410 = 7'h19 == train_index ? _PHT_T_1 : _GEN_26; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_411 = 7'h1a == train_index ? _PHT_T_1 : _GEN_27; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_412 = 7'h1b == train_index ? _PHT_T_1 : _GEN_28; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_413 = 7'h1c == train_index ? _PHT_T_1 : _GEN_29; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_414 = 7'h1d == train_index ? _PHT_T_1 : _GEN_30; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_415 = 7'h1e == train_index ? _PHT_T_1 : _GEN_31; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_416 = 7'h1f == train_index ? _PHT_T_1 : _GEN_32; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_417 = 7'h20 == train_index ? _PHT_T_1 : _GEN_33; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_418 = 7'h21 == train_index ? _PHT_T_1 : _GEN_34; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_419 = 7'h22 == train_index ? _PHT_T_1 : _GEN_35; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_420 = 7'h23 == train_index ? _PHT_T_1 : _GEN_36; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_421 = 7'h24 == train_index ? _PHT_T_1 : _GEN_37; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_422 = 7'h25 == train_index ? _PHT_T_1 : _GEN_38; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_423 = 7'h26 == train_index ? _PHT_T_1 : _GEN_39; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_424 = 7'h27 == train_index ? _PHT_T_1 : _GEN_40; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_425 = 7'h28 == train_index ? _PHT_T_1 : _GEN_41; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_426 = 7'h29 == train_index ? _PHT_T_1 : _GEN_42; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_427 = 7'h2a == train_index ? _PHT_T_1 : _GEN_43; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_428 = 7'h2b == train_index ? _PHT_T_1 : _GEN_44; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_429 = 7'h2c == train_index ? _PHT_T_1 : _GEN_45; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_430 = 7'h2d == train_index ? _PHT_T_1 : _GEN_46; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_431 = 7'h2e == train_index ? _PHT_T_1 : _GEN_47; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_432 = 7'h2f == train_index ? _PHT_T_1 : _GEN_48; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_433 = 7'h30 == train_index ? _PHT_T_1 : _GEN_49; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_434 = 7'h31 == train_index ? _PHT_T_1 : _GEN_50; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_435 = 7'h32 == train_index ? _PHT_T_1 : _GEN_51; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_436 = 7'h33 == train_index ? _PHT_T_1 : _GEN_52; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_437 = 7'h34 == train_index ? _PHT_T_1 : _GEN_53; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_438 = 7'h35 == train_index ? _PHT_T_1 : _GEN_54; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_439 = 7'h36 == train_index ? _PHT_T_1 : _GEN_55; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_440 = 7'h37 == train_index ? _PHT_T_1 : _GEN_56; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_441 = 7'h38 == train_index ? _PHT_T_1 : _GEN_57; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_442 = 7'h39 == train_index ? _PHT_T_1 : _GEN_58; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_443 = 7'h3a == train_index ? _PHT_T_1 : _GEN_59; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_444 = 7'h3b == train_index ? _PHT_T_1 : _GEN_60; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_445 = 7'h3c == train_index ? _PHT_T_1 : _GEN_61; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_446 = 7'h3d == train_index ? _PHT_T_1 : _GEN_62; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_447 = 7'h3e == train_index ? _PHT_T_1 : _GEN_63; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_448 = 7'h3f == train_index ? _PHT_T_1 : _GEN_64; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_449 = 7'h40 == train_index ? _PHT_T_1 : _GEN_65; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_450 = 7'h41 == train_index ? _PHT_T_1 : _GEN_66; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_451 = 7'h42 == train_index ? _PHT_T_1 : _GEN_67; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_452 = 7'h43 == train_index ? _PHT_T_1 : _GEN_68; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_453 = 7'h44 == train_index ? _PHT_T_1 : _GEN_69; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_454 = 7'h45 == train_index ? _PHT_T_1 : _GEN_70; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_455 = 7'h46 == train_index ? _PHT_T_1 : _GEN_71; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_456 = 7'h47 == train_index ? _PHT_T_1 : _GEN_72; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_457 = 7'h48 == train_index ? _PHT_T_1 : _GEN_73; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_458 = 7'h49 == train_index ? _PHT_T_1 : _GEN_74; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_459 = 7'h4a == train_index ? _PHT_T_1 : _GEN_75; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_460 = 7'h4b == train_index ? _PHT_T_1 : _GEN_76; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_461 = 7'h4c == train_index ? _PHT_T_1 : _GEN_77; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_462 = 7'h4d == train_index ? _PHT_T_1 : _GEN_78; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_463 = 7'h4e == train_index ? _PHT_T_1 : _GEN_79; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_464 = 7'h4f == train_index ? _PHT_T_1 : _GEN_80; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_465 = 7'h50 == train_index ? _PHT_T_1 : _GEN_81; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_466 = 7'h51 == train_index ? _PHT_T_1 : _GEN_82; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_467 = 7'h52 == train_index ? _PHT_T_1 : _GEN_83; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_468 = 7'h53 == train_index ? _PHT_T_1 : _GEN_84; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_469 = 7'h54 == train_index ? _PHT_T_1 : _GEN_85; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_470 = 7'h55 == train_index ? _PHT_T_1 : _GEN_86; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_471 = 7'h56 == train_index ? _PHT_T_1 : _GEN_87; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_472 = 7'h57 == train_index ? _PHT_T_1 : _GEN_88; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_473 = 7'h58 == train_index ? _PHT_T_1 : _GEN_89; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_474 = 7'h59 == train_index ? _PHT_T_1 : _GEN_90; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_475 = 7'h5a == train_index ? _PHT_T_1 : _GEN_91; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_476 = 7'h5b == train_index ? _PHT_T_1 : _GEN_92; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_477 = 7'h5c == train_index ? _PHT_T_1 : _GEN_93; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_478 = 7'h5d == train_index ? _PHT_T_1 : _GEN_94; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_479 = 7'h5e == train_index ? _PHT_T_1 : _GEN_95; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_480 = 7'h5f == train_index ? _PHT_T_1 : _GEN_96; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_481 = 7'h60 == train_index ? _PHT_T_1 : _GEN_97; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_482 = 7'h61 == train_index ? _PHT_T_1 : _GEN_98; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_483 = 7'h62 == train_index ? _PHT_T_1 : _GEN_99; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_484 = 7'h63 == train_index ? _PHT_T_1 : _GEN_100; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_485 = 7'h64 == train_index ? _PHT_T_1 : _GEN_101; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_486 = 7'h65 == train_index ? _PHT_T_1 : _GEN_102; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_487 = 7'h66 == train_index ? _PHT_T_1 : _GEN_103; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_488 = 7'h67 == train_index ? _PHT_T_1 : _GEN_104; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_489 = 7'h68 == train_index ? _PHT_T_1 : _GEN_105; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_490 = 7'h69 == train_index ? _PHT_T_1 : _GEN_106; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_491 = 7'h6a == train_index ? _PHT_T_1 : _GEN_107; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_492 = 7'h6b == train_index ? _PHT_T_1 : _GEN_108; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_493 = 7'h6c == train_index ? _PHT_T_1 : _GEN_109; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_494 = 7'h6d == train_index ? _PHT_T_1 : _GEN_110; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_495 = 7'h6e == train_index ? _PHT_T_1 : _GEN_111; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_496 = 7'h6f == train_index ? _PHT_T_1 : _GEN_112; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_497 = 7'h70 == train_index ? _PHT_T_1 : _GEN_113; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_498 = 7'h71 == train_index ? _PHT_T_1 : _GEN_114; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_499 = 7'h72 == train_index ? _PHT_T_1 : _GEN_115; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_500 = 7'h73 == train_index ? _PHT_T_1 : _GEN_116; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_501 = 7'h74 == train_index ? _PHT_T_1 : _GEN_117; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_502 = 7'h75 == train_index ? _PHT_T_1 : _GEN_118; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_503 = 7'h76 == train_index ? _PHT_T_1 : _GEN_119; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_504 = 7'h77 == train_index ? _PHT_T_1 : _GEN_120; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_505 = 7'h78 == train_index ? _PHT_T_1 : _GEN_121; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_506 = 7'h79 == train_index ? _PHT_T_1 : _GEN_122; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_507 = 7'h7a == train_index ? _PHT_T_1 : _GEN_123; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_508 = 7'h7b == train_index ? _PHT_T_1 : _GEN_124; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_509 = 7'h7c == train_index ? _PHT_T_1 : _GEN_125; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_510 = 7'h7d == train_index ? _PHT_T_1 : _GEN_126; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_511 = 7'h7e == train_index ? _PHT_T_1 : _GEN_127; // @[dut.scala 52:{26,26}]
  wire [1:0] _GEN_512 = 7'h7f == train_index ? _PHT_T_1 : _GEN_128; // @[dut.scala 52:{26,26}]
  wire [1:0] _PHT_T_3 = _GEN_384 - 2'h1; // @[dut.scala 56:46]
  wire [1:0] _GEN_641 = 7'h0 == train_index ? _PHT_T_3 : _GEN_1; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_642 = 7'h1 == train_index ? _PHT_T_3 : _GEN_2; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_643 = 7'h2 == train_index ? _PHT_T_3 : _GEN_3; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_644 = 7'h3 == train_index ? _PHT_T_3 : _GEN_4; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_645 = 7'h4 == train_index ? _PHT_T_3 : _GEN_5; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_646 = 7'h5 == train_index ? _PHT_T_3 : _GEN_6; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_647 = 7'h6 == train_index ? _PHT_T_3 : _GEN_7; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_648 = 7'h7 == train_index ? _PHT_T_3 : _GEN_8; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_649 = 7'h8 == train_index ? _PHT_T_3 : _GEN_9; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_650 = 7'h9 == train_index ? _PHT_T_3 : _GEN_10; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_651 = 7'ha == train_index ? _PHT_T_3 : _GEN_11; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_652 = 7'hb == train_index ? _PHT_T_3 : _GEN_12; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_653 = 7'hc == train_index ? _PHT_T_3 : _GEN_13; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_654 = 7'hd == train_index ? _PHT_T_3 : _GEN_14; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_655 = 7'he == train_index ? _PHT_T_3 : _GEN_15; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_656 = 7'hf == train_index ? _PHT_T_3 : _GEN_16; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_657 = 7'h10 == train_index ? _PHT_T_3 : _GEN_17; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_658 = 7'h11 == train_index ? _PHT_T_3 : _GEN_18; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_659 = 7'h12 == train_index ? _PHT_T_3 : _GEN_19; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_660 = 7'h13 == train_index ? _PHT_T_3 : _GEN_20; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_661 = 7'h14 == train_index ? _PHT_T_3 : _GEN_21; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_662 = 7'h15 == train_index ? _PHT_T_3 : _GEN_22; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_663 = 7'h16 == train_index ? _PHT_T_3 : _GEN_23; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_664 = 7'h17 == train_index ? _PHT_T_3 : _GEN_24; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_665 = 7'h18 == train_index ? _PHT_T_3 : _GEN_25; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_666 = 7'h19 == train_index ? _PHT_T_3 : _GEN_26; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_667 = 7'h1a == train_index ? _PHT_T_3 : _GEN_27; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_668 = 7'h1b == train_index ? _PHT_T_3 : _GEN_28; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_669 = 7'h1c == train_index ? _PHT_T_3 : _GEN_29; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_670 = 7'h1d == train_index ? _PHT_T_3 : _GEN_30; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_671 = 7'h1e == train_index ? _PHT_T_3 : _GEN_31; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_672 = 7'h1f == train_index ? _PHT_T_3 : _GEN_32; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_673 = 7'h20 == train_index ? _PHT_T_3 : _GEN_33; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_674 = 7'h21 == train_index ? _PHT_T_3 : _GEN_34; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_675 = 7'h22 == train_index ? _PHT_T_3 : _GEN_35; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_676 = 7'h23 == train_index ? _PHT_T_3 : _GEN_36; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_677 = 7'h24 == train_index ? _PHT_T_3 : _GEN_37; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_678 = 7'h25 == train_index ? _PHT_T_3 : _GEN_38; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_679 = 7'h26 == train_index ? _PHT_T_3 : _GEN_39; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_680 = 7'h27 == train_index ? _PHT_T_3 : _GEN_40; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_681 = 7'h28 == train_index ? _PHT_T_3 : _GEN_41; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_682 = 7'h29 == train_index ? _PHT_T_3 : _GEN_42; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_683 = 7'h2a == train_index ? _PHT_T_3 : _GEN_43; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_684 = 7'h2b == train_index ? _PHT_T_3 : _GEN_44; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_685 = 7'h2c == train_index ? _PHT_T_3 : _GEN_45; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_686 = 7'h2d == train_index ? _PHT_T_3 : _GEN_46; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_687 = 7'h2e == train_index ? _PHT_T_3 : _GEN_47; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_688 = 7'h2f == train_index ? _PHT_T_3 : _GEN_48; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_689 = 7'h30 == train_index ? _PHT_T_3 : _GEN_49; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_690 = 7'h31 == train_index ? _PHT_T_3 : _GEN_50; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_691 = 7'h32 == train_index ? _PHT_T_3 : _GEN_51; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_692 = 7'h33 == train_index ? _PHT_T_3 : _GEN_52; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_693 = 7'h34 == train_index ? _PHT_T_3 : _GEN_53; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_694 = 7'h35 == train_index ? _PHT_T_3 : _GEN_54; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_695 = 7'h36 == train_index ? _PHT_T_3 : _GEN_55; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_696 = 7'h37 == train_index ? _PHT_T_3 : _GEN_56; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_697 = 7'h38 == train_index ? _PHT_T_3 : _GEN_57; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_698 = 7'h39 == train_index ? _PHT_T_3 : _GEN_58; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_699 = 7'h3a == train_index ? _PHT_T_3 : _GEN_59; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_700 = 7'h3b == train_index ? _PHT_T_3 : _GEN_60; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_701 = 7'h3c == train_index ? _PHT_T_3 : _GEN_61; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_702 = 7'h3d == train_index ? _PHT_T_3 : _GEN_62; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_703 = 7'h3e == train_index ? _PHT_T_3 : _GEN_63; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_704 = 7'h3f == train_index ? _PHT_T_3 : _GEN_64; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_705 = 7'h40 == train_index ? _PHT_T_3 : _GEN_65; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_706 = 7'h41 == train_index ? _PHT_T_3 : _GEN_66; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_707 = 7'h42 == train_index ? _PHT_T_3 : _GEN_67; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_708 = 7'h43 == train_index ? _PHT_T_3 : _GEN_68; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_709 = 7'h44 == train_index ? _PHT_T_3 : _GEN_69; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_710 = 7'h45 == train_index ? _PHT_T_3 : _GEN_70; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_711 = 7'h46 == train_index ? _PHT_T_3 : _GEN_71; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_712 = 7'h47 == train_index ? _PHT_T_3 : _GEN_72; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_713 = 7'h48 == train_index ? _PHT_T_3 : _GEN_73; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_714 = 7'h49 == train_index ? _PHT_T_3 : _GEN_74; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_715 = 7'h4a == train_index ? _PHT_T_3 : _GEN_75; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_716 = 7'h4b == train_index ? _PHT_T_3 : _GEN_76; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_717 = 7'h4c == train_index ? _PHT_T_3 : _GEN_77; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_718 = 7'h4d == train_index ? _PHT_T_3 : _GEN_78; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_719 = 7'h4e == train_index ? _PHT_T_3 : _GEN_79; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_720 = 7'h4f == train_index ? _PHT_T_3 : _GEN_80; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_721 = 7'h50 == train_index ? _PHT_T_3 : _GEN_81; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_722 = 7'h51 == train_index ? _PHT_T_3 : _GEN_82; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_723 = 7'h52 == train_index ? _PHT_T_3 : _GEN_83; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_724 = 7'h53 == train_index ? _PHT_T_3 : _GEN_84; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_725 = 7'h54 == train_index ? _PHT_T_3 : _GEN_85; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_726 = 7'h55 == train_index ? _PHT_T_3 : _GEN_86; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_727 = 7'h56 == train_index ? _PHT_T_3 : _GEN_87; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_728 = 7'h57 == train_index ? _PHT_T_3 : _GEN_88; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_729 = 7'h58 == train_index ? _PHT_T_3 : _GEN_89; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_730 = 7'h59 == train_index ? _PHT_T_3 : _GEN_90; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_731 = 7'h5a == train_index ? _PHT_T_3 : _GEN_91; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_732 = 7'h5b == train_index ? _PHT_T_3 : _GEN_92; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_733 = 7'h5c == train_index ? _PHT_T_3 : _GEN_93; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_734 = 7'h5d == train_index ? _PHT_T_3 : _GEN_94; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_735 = 7'h5e == train_index ? _PHT_T_3 : _GEN_95; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_736 = 7'h5f == train_index ? _PHT_T_3 : _GEN_96; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_737 = 7'h60 == train_index ? _PHT_T_3 : _GEN_97; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_738 = 7'h61 == train_index ? _PHT_T_3 : _GEN_98; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_739 = 7'h62 == train_index ? _PHT_T_3 : _GEN_99; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_740 = 7'h63 == train_index ? _PHT_T_3 : _GEN_100; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_741 = 7'h64 == train_index ? _PHT_T_3 : _GEN_101; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_742 = 7'h65 == train_index ? _PHT_T_3 : _GEN_102; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_743 = 7'h66 == train_index ? _PHT_T_3 : _GEN_103; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_744 = 7'h67 == train_index ? _PHT_T_3 : _GEN_104; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_745 = 7'h68 == train_index ? _PHT_T_3 : _GEN_105; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_746 = 7'h69 == train_index ? _PHT_T_3 : _GEN_106; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_747 = 7'h6a == train_index ? _PHT_T_3 : _GEN_107; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_748 = 7'h6b == train_index ? _PHT_T_3 : _GEN_108; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_749 = 7'h6c == train_index ? _PHT_T_3 : _GEN_109; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_750 = 7'h6d == train_index ? _PHT_T_3 : _GEN_110; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_751 = 7'h6e == train_index ? _PHT_T_3 : _GEN_111; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_752 = 7'h6f == train_index ? _PHT_T_3 : _GEN_112; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_753 = 7'h70 == train_index ? _PHT_T_3 : _GEN_113; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_754 = 7'h71 == train_index ? _PHT_T_3 : _GEN_114; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_755 = 7'h72 == train_index ? _PHT_T_3 : _GEN_115; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_756 = 7'h73 == train_index ? _PHT_T_3 : _GEN_116; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_757 = 7'h74 == train_index ? _PHT_T_3 : _GEN_117; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_758 = 7'h75 == train_index ? _PHT_T_3 : _GEN_118; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_759 = 7'h76 == train_index ? _PHT_T_3 : _GEN_119; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_760 = 7'h77 == train_index ? _PHT_T_3 : _GEN_120; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_761 = 7'h78 == train_index ? _PHT_T_3 : _GEN_121; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_762 = 7'h79 == train_index ? _PHT_T_3 : _GEN_122; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_763 = 7'h7a == train_index ? _PHT_T_3 : _GEN_123; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_764 = 7'h7b == train_index ? _PHT_T_3 : _GEN_124; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_765 = 7'h7c == train_index ? _PHT_T_3 : _GEN_125; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_766 = 7'h7d == train_index ? _PHT_T_3 : _GEN_126; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_767 = 7'h7e == train_index ? _PHT_T_3 : _GEN_127; // @[dut.scala 56:{26,26}]
  wire [1:0] _GEN_768 = 7'h7f == train_index ? _PHT_T_3 : _GEN_128; // @[dut.scala 56:{26,26}]
  wire [6:0] _globalHistory_T_1 = {globalHistory[5:0],io_train_taken}; // @[Cat.scala 33:92]
  wire [6:0] _globalHistory_T_3 = {globalHistory[5:0],io_predict_taken}; // @[Cat.scala 33:92]
  assign io_predict_taken = _GEN_256 >= 2'h2; // @[dut.scala 42:39]
  assign io_predict_history = globalHistory; // @[dut.scala 43:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 23:20]
      PHT_0 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_0 <= _GEN_385;
        end else begin
          PHT_0 <= _GEN_1;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_0 <= _GEN_641;
      end else begin
        PHT_0 <= _GEN_1;
      end
    end else begin
      PHT_0 <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_1 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_1 <= _GEN_386;
        end else begin
          PHT_1 <= _GEN_2;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_1 <= _GEN_642;
      end else begin
        PHT_1 <= _GEN_2;
      end
    end else begin
      PHT_1 <= _GEN_2;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_2 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_2 <= _GEN_387;
        end else begin
          PHT_2 <= _GEN_3;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_2 <= _GEN_643;
      end else begin
        PHT_2 <= _GEN_3;
      end
    end else begin
      PHT_2 <= _GEN_3;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_3 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_3 <= _GEN_388;
        end else begin
          PHT_3 <= _GEN_4;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_3 <= _GEN_644;
      end else begin
        PHT_3 <= _GEN_4;
      end
    end else begin
      PHT_3 <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_4 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_4 <= _GEN_389;
        end else begin
          PHT_4 <= _GEN_5;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_4 <= _GEN_645;
      end else begin
        PHT_4 <= _GEN_5;
      end
    end else begin
      PHT_4 <= _GEN_5;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_5 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_5 <= _GEN_390;
        end else begin
          PHT_5 <= _GEN_6;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_5 <= _GEN_646;
      end else begin
        PHT_5 <= _GEN_6;
      end
    end else begin
      PHT_5 <= _GEN_6;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_6 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_6 <= _GEN_391;
        end else begin
          PHT_6 <= _GEN_7;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_6 <= _GEN_647;
      end else begin
        PHT_6 <= _GEN_7;
      end
    end else begin
      PHT_6 <= _GEN_7;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_7 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_7 <= _GEN_392;
        end else begin
          PHT_7 <= _GEN_8;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_7 <= _GEN_648;
      end else begin
        PHT_7 <= _GEN_8;
      end
    end else begin
      PHT_7 <= _GEN_8;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_8 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_8 <= _GEN_393;
        end else begin
          PHT_8 <= _GEN_9;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_8 <= _GEN_649;
      end else begin
        PHT_8 <= _GEN_9;
      end
    end else begin
      PHT_8 <= _GEN_9;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_9 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_9 <= _GEN_394;
        end else begin
          PHT_9 <= _GEN_10;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_9 <= _GEN_650;
      end else begin
        PHT_9 <= _GEN_10;
      end
    end else begin
      PHT_9 <= _GEN_10;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_10 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_10 <= _GEN_395;
        end else begin
          PHT_10 <= _GEN_11;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_10 <= _GEN_651;
      end else begin
        PHT_10 <= _GEN_11;
      end
    end else begin
      PHT_10 <= _GEN_11;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_11 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_11 <= _GEN_396;
        end else begin
          PHT_11 <= _GEN_12;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_11 <= _GEN_652;
      end else begin
        PHT_11 <= _GEN_12;
      end
    end else begin
      PHT_11 <= _GEN_12;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_12 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_12 <= _GEN_397;
        end else begin
          PHT_12 <= _GEN_13;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_12 <= _GEN_653;
      end else begin
        PHT_12 <= _GEN_13;
      end
    end else begin
      PHT_12 <= _GEN_13;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_13 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_13 <= _GEN_398;
        end else begin
          PHT_13 <= _GEN_14;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_13 <= _GEN_654;
      end else begin
        PHT_13 <= _GEN_14;
      end
    end else begin
      PHT_13 <= _GEN_14;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_14 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_14 <= _GEN_399;
        end else begin
          PHT_14 <= _GEN_15;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_14 <= _GEN_655;
      end else begin
        PHT_14 <= _GEN_15;
      end
    end else begin
      PHT_14 <= _GEN_15;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_15 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_15 <= _GEN_400;
        end else begin
          PHT_15 <= _GEN_16;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_15 <= _GEN_656;
      end else begin
        PHT_15 <= _GEN_16;
      end
    end else begin
      PHT_15 <= _GEN_16;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_16 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_16 <= _GEN_401;
        end else begin
          PHT_16 <= _GEN_17;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_16 <= _GEN_657;
      end else begin
        PHT_16 <= _GEN_17;
      end
    end else begin
      PHT_16 <= _GEN_17;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_17 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_17 <= _GEN_402;
        end else begin
          PHT_17 <= _GEN_18;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_17 <= _GEN_658;
      end else begin
        PHT_17 <= _GEN_18;
      end
    end else begin
      PHT_17 <= _GEN_18;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_18 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_18 <= _GEN_403;
        end else begin
          PHT_18 <= _GEN_19;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_18 <= _GEN_659;
      end else begin
        PHT_18 <= _GEN_19;
      end
    end else begin
      PHT_18 <= _GEN_19;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_19 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_19 <= _GEN_404;
        end else begin
          PHT_19 <= _GEN_20;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_19 <= _GEN_660;
      end else begin
        PHT_19 <= _GEN_20;
      end
    end else begin
      PHT_19 <= _GEN_20;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_20 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_20 <= _GEN_405;
        end else begin
          PHT_20 <= _GEN_21;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_20 <= _GEN_661;
      end else begin
        PHT_20 <= _GEN_21;
      end
    end else begin
      PHT_20 <= _GEN_21;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_21 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_21 <= _GEN_406;
        end else begin
          PHT_21 <= _GEN_22;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_21 <= _GEN_662;
      end else begin
        PHT_21 <= _GEN_22;
      end
    end else begin
      PHT_21 <= _GEN_22;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_22 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_22 <= _GEN_407;
        end else begin
          PHT_22 <= _GEN_23;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_22 <= _GEN_663;
      end else begin
        PHT_22 <= _GEN_23;
      end
    end else begin
      PHT_22 <= _GEN_23;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_23 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_23 <= _GEN_408;
        end else begin
          PHT_23 <= _GEN_24;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_23 <= _GEN_664;
      end else begin
        PHT_23 <= _GEN_24;
      end
    end else begin
      PHT_23 <= _GEN_24;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_24 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_24 <= _GEN_409;
        end else begin
          PHT_24 <= _GEN_25;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_24 <= _GEN_665;
      end else begin
        PHT_24 <= _GEN_25;
      end
    end else begin
      PHT_24 <= _GEN_25;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_25 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_25 <= _GEN_410;
        end else begin
          PHT_25 <= _GEN_26;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_25 <= _GEN_666;
      end else begin
        PHT_25 <= _GEN_26;
      end
    end else begin
      PHT_25 <= _GEN_26;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_26 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_26 <= _GEN_411;
        end else begin
          PHT_26 <= _GEN_27;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_26 <= _GEN_667;
      end else begin
        PHT_26 <= _GEN_27;
      end
    end else begin
      PHT_26 <= _GEN_27;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_27 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_27 <= _GEN_412;
        end else begin
          PHT_27 <= _GEN_28;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_27 <= _GEN_668;
      end else begin
        PHT_27 <= _GEN_28;
      end
    end else begin
      PHT_27 <= _GEN_28;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_28 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_28 <= _GEN_413;
        end else begin
          PHT_28 <= _GEN_29;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_28 <= _GEN_669;
      end else begin
        PHT_28 <= _GEN_29;
      end
    end else begin
      PHT_28 <= _GEN_29;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_29 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_29 <= _GEN_414;
        end else begin
          PHT_29 <= _GEN_30;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_29 <= _GEN_670;
      end else begin
        PHT_29 <= _GEN_30;
      end
    end else begin
      PHT_29 <= _GEN_30;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_30 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_30 <= _GEN_415;
        end else begin
          PHT_30 <= _GEN_31;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_30 <= _GEN_671;
      end else begin
        PHT_30 <= _GEN_31;
      end
    end else begin
      PHT_30 <= _GEN_31;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_31 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_31 <= _GEN_416;
        end else begin
          PHT_31 <= _GEN_32;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_31 <= _GEN_672;
      end else begin
        PHT_31 <= _GEN_32;
      end
    end else begin
      PHT_31 <= _GEN_32;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_32 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_32 <= _GEN_417;
        end else begin
          PHT_32 <= _GEN_33;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_32 <= _GEN_673;
      end else begin
        PHT_32 <= _GEN_33;
      end
    end else begin
      PHT_32 <= _GEN_33;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_33 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_33 <= _GEN_418;
        end else begin
          PHT_33 <= _GEN_34;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_33 <= _GEN_674;
      end else begin
        PHT_33 <= _GEN_34;
      end
    end else begin
      PHT_33 <= _GEN_34;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_34 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_34 <= _GEN_419;
        end else begin
          PHT_34 <= _GEN_35;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_34 <= _GEN_675;
      end else begin
        PHT_34 <= _GEN_35;
      end
    end else begin
      PHT_34 <= _GEN_35;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_35 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_35 <= _GEN_420;
        end else begin
          PHT_35 <= _GEN_36;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_35 <= _GEN_676;
      end else begin
        PHT_35 <= _GEN_36;
      end
    end else begin
      PHT_35 <= _GEN_36;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_36 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_36 <= _GEN_421;
        end else begin
          PHT_36 <= _GEN_37;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_36 <= _GEN_677;
      end else begin
        PHT_36 <= _GEN_37;
      end
    end else begin
      PHT_36 <= _GEN_37;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_37 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_37 <= _GEN_422;
        end else begin
          PHT_37 <= _GEN_38;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_37 <= _GEN_678;
      end else begin
        PHT_37 <= _GEN_38;
      end
    end else begin
      PHT_37 <= _GEN_38;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_38 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_38 <= _GEN_423;
        end else begin
          PHT_38 <= _GEN_39;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_38 <= _GEN_679;
      end else begin
        PHT_38 <= _GEN_39;
      end
    end else begin
      PHT_38 <= _GEN_39;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_39 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_39 <= _GEN_424;
        end else begin
          PHT_39 <= _GEN_40;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_39 <= _GEN_680;
      end else begin
        PHT_39 <= _GEN_40;
      end
    end else begin
      PHT_39 <= _GEN_40;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_40 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_40 <= _GEN_425;
        end else begin
          PHT_40 <= _GEN_41;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_40 <= _GEN_681;
      end else begin
        PHT_40 <= _GEN_41;
      end
    end else begin
      PHT_40 <= _GEN_41;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_41 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_41 <= _GEN_426;
        end else begin
          PHT_41 <= _GEN_42;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_41 <= _GEN_682;
      end else begin
        PHT_41 <= _GEN_42;
      end
    end else begin
      PHT_41 <= _GEN_42;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_42 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_42 <= _GEN_427;
        end else begin
          PHT_42 <= _GEN_43;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_42 <= _GEN_683;
      end else begin
        PHT_42 <= _GEN_43;
      end
    end else begin
      PHT_42 <= _GEN_43;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_43 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_43 <= _GEN_428;
        end else begin
          PHT_43 <= _GEN_44;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_43 <= _GEN_684;
      end else begin
        PHT_43 <= _GEN_44;
      end
    end else begin
      PHT_43 <= _GEN_44;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_44 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_44 <= _GEN_429;
        end else begin
          PHT_44 <= _GEN_45;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_44 <= _GEN_685;
      end else begin
        PHT_44 <= _GEN_45;
      end
    end else begin
      PHT_44 <= _GEN_45;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_45 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_45 <= _GEN_430;
        end else begin
          PHT_45 <= _GEN_46;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_45 <= _GEN_686;
      end else begin
        PHT_45 <= _GEN_46;
      end
    end else begin
      PHT_45 <= _GEN_46;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_46 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_46 <= _GEN_431;
        end else begin
          PHT_46 <= _GEN_47;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_46 <= _GEN_687;
      end else begin
        PHT_46 <= _GEN_47;
      end
    end else begin
      PHT_46 <= _GEN_47;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_47 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_47 <= _GEN_432;
        end else begin
          PHT_47 <= _GEN_48;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_47 <= _GEN_688;
      end else begin
        PHT_47 <= _GEN_48;
      end
    end else begin
      PHT_47 <= _GEN_48;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_48 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_48 <= _GEN_433;
        end else begin
          PHT_48 <= _GEN_49;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_48 <= _GEN_689;
      end else begin
        PHT_48 <= _GEN_49;
      end
    end else begin
      PHT_48 <= _GEN_49;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_49 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_49 <= _GEN_434;
        end else begin
          PHT_49 <= _GEN_50;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_49 <= _GEN_690;
      end else begin
        PHT_49 <= _GEN_50;
      end
    end else begin
      PHT_49 <= _GEN_50;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_50 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_50 <= _GEN_435;
        end else begin
          PHT_50 <= _GEN_51;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_50 <= _GEN_691;
      end else begin
        PHT_50 <= _GEN_51;
      end
    end else begin
      PHT_50 <= _GEN_51;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_51 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_51 <= _GEN_436;
        end else begin
          PHT_51 <= _GEN_52;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_51 <= _GEN_692;
      end else begin
        PHT_51 <= _GEN_52;
      end
    end else begin
      PHT_51 <= _GEN_52;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_52 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_52 <= _GEN_437;
        end else begin
          PHT_52 <= _GEN_53;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_52 <= _GEN_693;
      end else begin
        PHT_52 <= _GEN_53;
      end
    end else begin
      PHT_52 <= _GEN_53;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_53 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_53 <= _GEN_438;
        end else begin
          PHT_53 <= _GEN_54;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_53 <= _GEN_694;
      end else begin
        PHT_53 <= _GEN_54;
      end
    end else begin
      PHT_53 <= _GEN_54;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_54 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_54 <= _GEN_439;
        end else begin
          PHT_54 <= _GEN_55;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_54 <= _GEN_695;
      end else begin
        PHT_54 <= _GEN_55;
      end
    end else begin
      PHT_54 <= _GEN_55;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_55 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_55 <= _GEN_440;
        end else begin
          PHT_55 <= _GEN_56;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_55 <= _GEN_696;
      end else begin
        PHT_55 <= _GEN_56;
      end
    end else begin
      PHT_55 <= _GEN_56;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_56 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_56 <= _GEN_441;
        end else begin
          PHT_56 <= _GEN_57;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_56 <= _GEN_697;
      end else begin
        PHT_56 <= _GEN_57;
      end
    end else begin
      PHT_56 <= _GEN_57;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_57 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_57 <= _GEN_442;
        end else begin
          PHT_57 <= _GEN_58;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_57 <= _GEN_698;
      end else begin
        PHT_57 <= _GEN_58;
      end
    end else begin
      PHT_57 <= _GEN_58;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_58 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_58 <= _GEN_443;
        end else begin
          PHT_58 <= _GEN_59;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_58 <= _GEN_699;
      end else begin
        PHT_58 <= _GEN_59;
      end
    end else begin
      PHT_58 <= _GEN_59;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_59 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_59 <= _GEN_444;
        end else begin
          PHT_59 <= _GEN_60;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_59 <= _GEN_700;
      end else begin
        PHT_59 <= _GEN_60;
      end
    end else begin
      PHT_59 <= _GEN_60;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_60 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_60 <= _GEN_445;
        end else begin
          PHT_60 <= _GEN_61;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_60 <= _GEN_701;
      end else begin
        PHT_60 <= _GEN_61;
      end
    end else begin
      PHT_60 <= _GEN_61;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_61 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_61 <= _GEN_446;
        end else begin
          PHT_61 <= _GEN_62;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_61 <= _GEN_702;
      end else begin
        PHT_61 <= _GEN_62;
      end
    end else begin
      PHT_61 <= _GEN_62;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_62 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_62 <= _GEN_447;
        end else begin
          PHT_62 <= _GEN_63;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_62 <= _GEN_703;
      end else begin
        PHT_62 <= _GEN_63;
      end
    end else begin
      PHT_62 <= _GEN_63;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_63 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_63 <= _GEN_448;
        end else begin
          PHT_63 <= _GEN_64;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_63 <= _GEN_704;
      end else begin
        PHT_63 <= _GEN_64;
      end
    end else begin
      PHT_63 <= _GEN_64;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_64 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_64 <= _GEN_449;
        end else begin
          PHT_64 <= _GEN_65;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_64 <= _GEN_705;
      end else begin
        PHT_64 <= _GEN_65;
      end
    end else begin
      PHT_64 <= _GEN_65;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_65 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_65 <= _GEN_450;
        end else begin
          PHT_65 <= _GEN_66;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_65 <= _GEN_706;
      end else begin
        PHT_65 <= _GEN_66;
      end
    end else begin
      PHT_65 <= _GEN_66;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_66 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_66 <= _GEN_451;
        end else begin
          PHT_66 <= _GEN_67;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_66 <= _GEN_707;
      end else begin
        PHT_66 <= _GEN_67;
      end
    end else begin
      PHT_66 <= _GEN_67;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_67 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_67 <= _GEN_452;
        end else begin
          PHT_67 <= _GEN_68;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_67 <= _GEN_708;
      end else begin
        PHT_67 <= _GEN_68;
      end
    end else begin
      PHT_67 <= _GEN_68;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_68 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_68 <= _GEN_453;
        end else begin
          PHT_68 <= _GEN_69;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_68 <= _GEN_709;
      end else begin
        PHT_68 <= _GEN_69;
      end
    end else begin
      PHT_68 <= _GEN_69;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_69 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_69 <= _GEN_454;
        end else begin
          PHT_69 <= _GEN_70;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_69 <= _GEN_710;
      end else begin
        PHT_69 <= _GEN_70;
      end
    end else begin
      PHT_69 <= _GEN_70;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_70 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_70 <= _GEN_455;
        end else begin
          PHT_70 <= _GEN_71;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_70 <= _GEN_711;
      end else begin
        PHT_70 <= _GEN_71;
      end
    end else begin
      PHT_70 <= _GEN_71;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_71 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_71 <= _GEN_456;
        end else begin
          PHT_71 <= _GEN_72;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_71 <= _GEN_712;
      end else begin
        PHT_71 <= _GEN_72;
      end
    end else begin
      PHT_71 <= _GEN_72;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_72 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_72 <= _GEN_457;
        end else begin
          PHT_72 <= _GEN_73;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_72 <= _GEN_713;
      end else begin
        PHT_72 <= _GEN_73;
      end
    end else begin
      PHT_72 <= _GEN_73;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_73 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_73 <= _GEN_458;
        end else begin
          PHT_73 <= _GEN_74;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_73 <= _GEN_714;
      end else begin
        PHT_73 <= _GEN_74;
      end
    end else begin
      PHT_73 <= _GEN_74;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_74 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_74 <= _GEN_459;
        end else begin
          PHT_74 <= _GEN_75;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_74 <= _GEN_715;
      end else begin
        PHT_74 <= _GEN_75;
      end
    end else begin
      PHT_74 <= _GEN_75;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_75 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_75 <= _GEN_460;
        end else begin
          PHT_75 <= _GEN_76;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_75 <= _GEN_716;
      end else begin
        PHT_75 <= _GEN_76;
      end
    end else begin
      PHT_75 <= _GEN_76;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_76 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_76 <= _GEN_461;
        end else begin
          PHT_76 <= _GEN_77;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_76 <= _GEN_717;
      end else begin
        PHT_76 <= _GEN_77;
      end
    end else begin
      PHT_76 <= _GEN_77;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_77 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_77 <= _GEN_462;
        end else begin
          PHT_77 <= _GEN_78;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_77 <= _GEN_718;
      end else begin
        PHT_77 <= _GEN_78;
      end
    end else begin
      PHT_77 <= _GEN_78;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_78 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_78 <= _GEN_463;
        end else begin
          PHT_78 <= _GEN_79;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_78 <= _GEN_719;
      end else begin
        PHT_78 <= _GEN_79;
      end
    end else begin
      PHT_78 <= _GEN_79;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_79 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_79 <= _GEN_464;
        end else begin
          PHT_79 <= _GEN_80;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_79 <= _GEN_720;
      end else begin
        PHT_79 <= _GEN_80;
      end
    end else begin
      PHT_79 <= _GEN_80;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_80 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_80 <= _GEN_465;
        end else begin
          PHT_80 <= _GEN_81;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_80 <= _GEN_721;
      end else begin
        PHT_80 <= _GEN_81;
      end
    end else begin
      PHT_80 <= _GEN_81;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_81 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_81 <= _GEN_466;
        end else begin
          PHT_81 <= _GEN_82;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_81 <= _GEN_722;
      end else begin
        PHT_81 <= _GEN_82;
      end
    end else begin
      PHT_81 <= _GEN_82;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_82 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_82 <= _GEN_467;
        end else begin
          PHT_82 <= _GEN_83;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_82 <= _GEN_723;
      end else begin
        PHT_82 <= _GEN_83;
      end
    end else begin
      PHT_82 <= _GEN_83;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_83 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_83 <= _GEN_468;
        end else begin
          PHT_83 <= _GEN_84;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_83 <= _GEN_724;
      end else begin
        PHT_83 <= _GEN_84;
      end
    end else begin
      PHT_83 <= _GEN_84;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_84 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_84 <= _GEN_469;
        end else begin
          PHT_84 <= _GEN_85;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_84 <= _GEN_725;
      end else begin
        PHT_84 <= _GEN_85;
      end
    end else begin
      PHT_84 <= _GEN_85;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_85 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_85 <= _GEN_470;
        end else begin
          PHT_85 <= _GEN_86;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_85 <= _GEN_726;
      end else begin
        PHT_85 <= _GEN_86;
      end
    end else begin
      PHT_85 <= _GEN_86;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_86 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_86 <= _GEN_471;
        end else begin
          PHT_86 <= _GEN_87;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_86 <= _GEN_727;
      end else begin
        PHT_86 <= _GEN_87;
      end
    end else begin
      PHT_86 <= _GEN_87;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_87 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_87 <= _GEN_472;
        end else begin
          PHT_87 <= _GEN_88;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_87 <= _GEN_728;
      end else begin
        PHT_87 <= _GEN_88;
      end
    end else begin
      PHT_87 <= _GEN_88;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_88 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_88 <= _GEN_473;
        end else begin
          PHT_88 <= _GEN_89;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_88 <= _GEN_729;
      end else begin
        PHT_88 <= _GEN_89;
      end
    end else begin
      PHT_88 <= _GEN_89;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_89 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_89 <= _GEN_474;
        end else begin
          PHT_89 <= _GEN_90;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_89 <= _GEN_730;
      end else begin
        PHT_89 <= _GEN_90;
      end
    end else begin
      PHT_89 <= _GEN_90;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_90 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_90 <= _GEN_475;
        end else begin
          PHT_90 <= _GEN_91;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_90 <= _GEN_731;
      end else begin
        PHT_90 <= _GEN_91;
      end
    end else begin
      PHT_90 <= _GEN_91;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_91 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_91 <= _GEN_476;
        end else begin
          PHT_91 <= _GEN_92;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_91 <= _GEN_732;
      end else begin
        PHT_91 <= _GEN_92;
      end
    end else begin
      PHT_91 <= _GEN_92;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_92 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_92 <= _GEN_477;
        end else begin
          PHT_92 <= _GEN_93;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_92 <= _GEN_733;
      end else begin
        PHT_92 <= _GEN_93;
      end
    end else begin
      PHT_92 <= _GEN_93;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_93 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_93 <= _GEN_478;
        end else begin
          PHT_93 <= _GEN_94;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_93 <= _GEN_734;
      end else begin
        PHT_93 <= _GEN_94;
      end
    end else begin
      PHT_93 <= _GEN_94;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_94 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_94 <= _GEN_479;
        end else begin
          PHT_94 <= _GEN_95;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_94 <= _GEN_735;
      end else begin
        PHT_94 <= _GEN_95;
      end
    end else begin
      PHT_94 <= _GEN_95;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_95 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_95 <= _GEN_480;
        end else begin
          PHT_95 <= _GEN_96;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_95 <= _GEN_736;
      end else begin
        PHT_95 <= _GEN_96;
      end
    end else begin
      PHT_95 <= _GEN_96;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_96 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_96 <= _GEN_481;
        end else begin
          PHT_96 <= _GEN_97;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_96 <= _GEN_737;
      end else begin
        PHT_96 <= _GEN_97;
      end
    end else begin
      PHT_96 <= _GEN_97;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_97 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_97 <= _GEN_482;
        end else begin
          PHT_97 <= _GEN_98;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_97 <= _GEN_738;
      end else begin
        PHT_97 <= _GEN_98;
      end
    end else begin
      PHT_97 <= _GEN_98;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_98 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_98 <= _GEN_483;
        end else begin
          PHT_98 <= _GEN_99;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_98 <= _GEN_739;
      end else begin
        PHT_98 <= _GEN_99;
      end
    end else begin
      PHT_98 <= _GEN_99;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_99 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_99 <= _GEN_484;
        end else begin
          PHT_99 <= _GEN_100;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_99 <= _GEN_740;
      end else begin
        PHT_99 <= _GEN_100;
      end
    end else begin
      PHT_99 <= _GEN_100;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_100 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_100 <= _GEN_485;
        end else begin
          PHT_100 <= _GEN_101;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_100 <= _GEN_741;
      end else begin
        PHT_100 <= _GEN_101;
      end
    end else begin
      PHT_100 <= _GEN_101;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_101 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_101 <= _GEN_486;
        end else begin
          PHT_101 <= _GEN_102;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_101 <= _GEN_742;
      end else begin
        PHT_101 <= _GEN_102;
      end
    end else begin
      PHT_101 <= _GEN_102;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_102 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_102 <= _GEN_487;
        end else begin
          PHT_102 <= _GEN_103;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_102 <= _GEN_743;
      end else begin
        PHT_102 <= _GEN_103;
      end
    end else begin
      PHT_102 <= _GEN_103;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_103 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_103 <= _GEN_488;
        end else begin
          PHT_103 <= _GEN_104;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_103 <= _GEN_744;
      end else begin
        PHT_103 <= _GEN_104;
      end
    end else begin
      PHT_103 <= _GEN_104;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_104 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_104 <= _GEN_489;
        end else begin
          PHT_104 <= _GEN_105;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_104 <= _GEN_745;
      end else begin
        PHT_104 <= _GEN_105;
      end
    end else begin
      PHT_104 <= _GEN_105;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_105 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_105 <= _GEN_490;
        end else begin
          PHT_105 <= _GEN_106;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_105 <= _GEN_746;
      end else begin
        PHT_105 <= _GEN_106;
      end
    end else begin
      PHT_105 <= _GEN_106;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_106 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_106 <= _GEN_491;
        end else begin
          PHT_106 <= _GEN_107;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_106 <= _GEN_747;
      end else begin
        PHT_106 <= _GEN_107;
      end
    end else begin
      PHT_106 <= _GEN_107;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_107 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_107 <= _GEN_492;
        end else begin
          PHT_107 <= _GEN_108;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_107 <= _GEN_748;
      end else begin
        PHT_107 <= _GEN_108;
      end
    end else begin
      PHT_107 <= _GEN_108;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_108 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_108 <= _GEN_493;
        end else begin
          PHT_108 <= _GEN_109;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_108 <= _GEN_749;
      end else begin
        PHT_108 <= _GEN_109;
      end
    end else begin
      PHT_108 <= _GEN_109;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_109 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_109 <= _GEN_494;
        end else begin
          PHT_109 <= _GEN_110;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_109 <= _GEN_750;
      end else begin
        PHT_109 <= _GEN_110;
      end
    end else begin
      PHT_109 <= _GEN_110;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_110 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_110 <= _GEN_495;
        end else begin
          PHT_110 <= _GEN_111;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_110 <= _GEN_751;
      end else begin
        PHT_110 <= _GEN_111;
      end
    end else begin
      PHT_110 <= _GEN_111;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_111 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_111 <= _GEN_496;
        end else begin
          PHT_111 <= _GEN_112;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_111 <= _GEN_752;
      end else begin
        PHT_111 <= _GEN_112;
      end
    end else begin
      PHT_111 <= _GEN_112;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_112 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_112 <= _GEN_497;
        end else begin
          PHT_112 <= _GEN_113;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_112 <= _GEN_753;
      end else begin
        PHT_112 <= _GEN_113;
      end
    end else begin
      PHT_112 <= _GEN_113;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_113 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_113 <= _GEN_498;
        end else begin
          PHT_113 <= _GEN_114;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_113 <= _GEN_754;
      end else begin
        PHT_113 <= _GEN_114;
      end
    end else begin
      PHT_113 <= _GEN_114;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_114 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_114 <= _GEN_499;
        end else begin
          PHT_114 <= _GEN_115;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_114 <= _GEN_755;
      end else begin
        PHT_114 <= _GEN_115;
      end
    end else begin
      PHT_114 <= _GEN_115;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_115 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_115 <= _GEN_500;
        end else begin
          PHT_115 <= _GEN_116;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_115 <= _GEN_756;
      end else begin
        PHT_115 <= _GEN_116;
      end
    end else begin
      PHT_115 <= _GEN_116;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_116 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_116 <= _GEN_501;
        end else begin
          PHT_116 <= _GEN_117;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_116 <= _GEN_757;
      end else begin
        PHT_116 <= _GEN_117;
      end
    end else begin
      PHT_116 <= _GEN_117;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_117 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_117 <= _GEN_502;
        end else begin
          PHT_117 <= _GEN_118;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_117 <= _GEN_758;
      end else begin
        PHT_117 <= _GEN_118;
      end
    end else begin
      PHT_117 <= _GEN_118;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_118 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_118 <= _GEN_503;
        end else begin
          PHT_118 <= _GEN_119;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_118 <= _GEN_759;
      end else begin
        PHT_118 <= _GEN_119;
      end
    end else begin
      PHT_118 <= _GEN_119;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_119 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_119 <= _GEN_504;
        end else begin
          PHT_119 <= _GEN_120;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_119 <= _GEN_760;
      end else begin
        PHT_119 <= _GEN_120;
      end
    end else begin
      PHT_119 <= _GEN_120;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_120 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_120 <= _GEN_505;
        end else begin
          PHT_120 <= _GEN_121;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_120 <= _GEN_761;
      end else begin
        PHT_120 <= _GEN_121;
      end
    end else begin
      PHT_120 <= _GEN_121;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_121 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_121 <= _GEN_506;
        end else begin
          PHT_121 <= _GEN_122;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_121 <= _GEN_762;
      end else begin
        PHT_121 <= _GEN_122;
      end
    end else begin
      PHT_121 <= _GEN_122;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_122 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_122 <= _GEN_507;
        end else begin
          PHT_122 <= _GEN_123;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_122 <= _GEN_763;
      end else begin
        PHT_122 <= _GEN_123;
      end
    end else begin
      PHT_122 <= _GEN_123;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_123 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_123 <= _GEN_508;
        end else begin
          PHT_123 <= _GEN_124;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_123 <= _GEN_764;
      end else begin
        PHT_123 <= _GEN_124;
      end
    end else begin
      PHT_123 <= _GEN_124;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_124 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_124 <= _GEN_509;
        end else begin
          PHT_124 <= _GEN_125;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_124 <= _GEN_765;
      end else begin
        PHT_124 <= _GEN_125;
      end
    end else begin
      PHT_124 <= _GEN_125;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_125 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_125 <= _GEN_510;
        end else begin
          PHT_125 <= _GEN_126;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_125 <= _GEN_766;
      end else begin
        PHT_125 <= _GEN_126;
      end
    end else begin
      PHT_125 <= _GEN_126;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_126 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_126 <= _GEN_511;
        end else begin
          PHT_126 <= _GEN_127;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_126 <= _GEN_767;
      end else begin
        PHT_126 <= _GEN_127;
      end
    end else begin
      PHT_126 <= _GEN_127;
    end
    if (reset) begin // @[dut.scala 23:20]
      PHT_127 <= 2'h0; // @[dut.scala 23:20]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_taken) begin // @[dut.scala 50:26]
        if (_GEN_384 != 2'h3) begin // @[dut.scala 51:38]
          PHT_127 <= _GEN_512;
        end else begin
          PHT_127 <= _GEN_128;
        end
      end else if (_GEN_384 != 2'h0) begin // @[dut.scala 55:38]
        PHT_127 <= _GEN_768;
      end else begin
        PHT_127 <= _GEN_128;
      end
    end else begin
      PHT_127 <= _GEN_128;
    end
    if (reset) begin // @[dut.scala 24:30]
      globalHistory <= 7'h0; // @[dut.scala 24:30]
    end else if (io_train_valid) begin // @[dut.scala 46:24]
      if (io_train_mispredicted) begin // @[dut.scala 61:33]
        globalHistory <= io_train_history; // @[dut.scala 62:21]
      end else begin
        globalHistory <= _globalHistory_T_1; // @[dut.scala 65:21]
      end
    end else if (io_predict_valid) begin // @[dut.scala 67:32]
      globalHistory <= _globalHistory_T_3; // @[dut.scala 69:19]
    end else if (io_reset) begin // @[dut.scala 27:18]
      globalHistory <= 7'h0; // @[dut.scala 28:19]
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
  PHT_0 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  PHT_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  PHT_2 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  PHT_3 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  PHT_4 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  PHT_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  PHT_6 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  PHT_7 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  PHT_8 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  PHT_9 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  PHT_10 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  PHT_11 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  PHT_12 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  PHT_13 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  PHT_14 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  PHT_15 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  PHT_16 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  PHT_17 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  PHT_18 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  PHT_19 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  PHT_20 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  PHT_21 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  PHT_22 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  PHT_23 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  PHT_24 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  PHT_25 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  PHT_26 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  PHT_27 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  PHT_28 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  PHT_29 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  PHT_30 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  PHT_31 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  PHT_32 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  PHT_33 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  PHT_34 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  PHT_35 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  PHT_36 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  PHT_37 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  PHT_38 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  PHT_39 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  PHT_40 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  PHT_41 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  PHT_42 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  PHT_43 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  PHT_44 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  PHT_45 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  PHT_46 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  PHT_47 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  PHT_48 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  PHT_49 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  PHT_50 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  PHT_51 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  PHT_52 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  PHT_53 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  PHT_54 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  PHT_55 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  PHT_56 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  PHT_57 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  PHT_58 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  PHT_59 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  PHT_60 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  PHT_61 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  PHT_62 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  PHT_63 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  PHT_64 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  PHT_65 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  PHT_66 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  PHT_67 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  PHT_68 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  PHT_69 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  PHT_70 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  PHT_71 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  PHT_72 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  PHT_73 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  PHT_74 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  PHT_75 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  PHT_76 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  PHT_77 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  PHT_78 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  PHT_79 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  PHT_80 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  PHT_81 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  PHT_82 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  PHT_83 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  PHT_84 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  PHT_85 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  PHT_86 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  PHT_87 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  PHT_88 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  PHT_89 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  PHT_90 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  PHT_91 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  PHT_92 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  PHT_93 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  PHT_94 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  PHT_95 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  PHT_96 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  PHT_97 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  PHT_98 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  PHT_99 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  PHT_100 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  PHT_101 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  PHT_102 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  PHT_103 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  PHT_104 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  PHT_105 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  PHT_106 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  PHT_107 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  PHT_108 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  PHT_109 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  PHT_110 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  PHT_111 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  PHT_112 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  PHT_113 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  PHT_114 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  PHT_115 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  PHT_116 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  PHT_117 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  PHT_118 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  PHT_119 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  PHT_120 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  PHT_121 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  PHT_122 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  PHT_123 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  PHT_124 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  PHT_125 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  PHT_126 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  PHT_127 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  globalHistory = _RAND_128[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
