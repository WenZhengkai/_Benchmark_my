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
  reg [6:0] globalHistory; // @[dut.scala 29:30]
  reg [1:0] saturatingCounters_0; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_1; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_2; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_3; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_4; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_5; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_6; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_7; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_8; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_9; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_10; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_11; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_12; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_13; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_14; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_15; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_16; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_17; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_18; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_19; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_20; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_21; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_22; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_23; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_24; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_25; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_26; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_27; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_28; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_29; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_30; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_31; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_32; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_33; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_34; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_35; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_36; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_37; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_38; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_39; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_40; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_41; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_42; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_43; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_44; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_45; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_46; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_47; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_48; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_49; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_50; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_51; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_52; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_53; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_54; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_55; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_56; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_57; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_58; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_59; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_60; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_61; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_62; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_63; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_64; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_65; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_66; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_67; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_68; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_69; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_70; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_71; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_72; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_73; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_74; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_75; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_76; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_77; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_78; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_79; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_80; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_81; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_82; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_83; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_84; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_85; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_86; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_87; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_88; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_89; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_90; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_91; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_92; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_93; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_94; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_95; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_96; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_97; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_98; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_99; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_100; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_101; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_102; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_103; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_104; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_105; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_106; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_107; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_108; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_109; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_110; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_111; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_112; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_113; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_114; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_115; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_116; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_117; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_118; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_119; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_120; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_121; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_122; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_123; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_124; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_125; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_126; // @[dut.scala 30:35]
  reg [1:0] saturatingCounters_127; // @[dut.scala 30:35]
  wire [6:0] predictIndex = io_predict_pc ^ globalHistory; // @[dut.scala 33:48]
  wire [1:0] _io_predict_taken_T = 2'h3 / 2'h2; // @[dut.scala 38:53]
  wire [1:0] _GEN_1 = 7'h1 == predictIndex ? saturatingCounters_1 : saturatingCounters_0; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_2 = 7'h2 == predictIndex ? saturatingCounters_2 : _GEN_1; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_3 = 7'h3 == predictIndex ? saturatingCounters_3 : _GEN_2; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_4 = 7'h4 == predictIndex ? saturatingCounters_4 : _GEN_3; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_5 = 7'h5 == predictIndex ? saturatingCounters_5 : _GEN_4; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_6 = 7'h6 == predictIndex ? saturatingCounters_6 : _GEN_5; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_7 = 7'h7 == predictIndex ? saturatingCounters_7 : _GEN_6; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_8 = 7'h8 == predictIndex ? saturatingCounters_8 : _GEN_7; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_9 = 7'h9 == predictIndex ? saturatingCounters_9 : _GEN_8; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_10 = 7'ha == predictIndex ? saturatingCounters_10 : _GEN_9; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_11 = 7'hb == predictIndex ? saturatingCounters_11 : _GEN_10; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_12 = 7'hc == predictIndex ? saturatingCounters_12 : _GEN_11; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_13 = 7'hd == predictIndex ? saturatingCounters_13 : _GEN_12; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_14 = 7'he == predictIndex ? saturatingCounters_14 : _GEN_13; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_15 = 7'hf == predictIndex ? saturatingCounters_15 : _GEN_14; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_16 = 7'h10 == predictIndex ? saturatingCounters_16 : _GEN_15; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_17 = 7'h11 == predictIndex ? saturatingCounters_17 : _GEN_16; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_18 = 7'h12 == predictIndex ? saturatingCounters_18 : _GEN_17; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_19 = 7'h13 == predictIndex ? saturatingCounters_19 : _GEN_18; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_20 = 7'h14 == predictIndex ? saturatingCounters_20 : _GEN_19; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_21 = 7'h15 == predictIndex ? saturatingCounters_21 : _GEN_20; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_22 = 7'h16 == predictIndex ? saturatingCounters_22 : _GEN_21; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_23 = 7'h17 == predictIndex ? saturatingCounters_23 : _GEN_22; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_24 = 7'h18 == predictIndex ? saturatingCounters_24 : _GEN_23; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_25 = 7'h19 == predictIndex ? saturatingCounters_25 : _GEN_24; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_26 = 7'h1a == predictIndex ? saturatingCounters_26 : _GEN_25; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_27 = 7'h1b == predictIndex ? saturatingCounters_27 : _GEN_26; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_28 = 7'h1c == predictIndex ? saturatingCounters_28 : _GEN_27; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_29 = 7'h1d == predictIndex ? saturatingCounters_29 : _GEN_28; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_30 = 7'h1e == predictIndex ? saturatingCounters_30 : _GEN_29; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_31 = 7'h1f == predictIndex ? saturatingCounters_31 : _GEN_30; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_32 = 7'h20 == predictIndex ? saturatingCounters_32 : _GEN_31; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_33 = 7'h21 == predictIndex ? saturatingCounters_33 : _GEN_32; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_34 = 7'h22 == predictIndex ? saturatingCounters_34 : _GEN_33; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_35 = 7'h23 == predictIndex ? saturatingCounters_35 : _GEN_34; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_36 = 7'h24 == predictIndex ? saturatingCounters_36 : _GEN_35; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_37 = 7'h25 == predictIndex ? saturatingCounters_37 : _GEN_36; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_38 = 7'h26 == predictIndex ? saturatingCounters_38 : _GEN_37; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_39 = 7'h27 == predictIndex ? saturatingCounters_39 : _GEN_38; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_40 = 7'h28 == predictIndex ? saturatingCounters_40 : _GEN_39; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_41 = 7'h29 == predictIndex ? saturatingCounters_41 : _GEN_40; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_42 = 7'h2a == predictIndex ? saturatingCounters_42 : _GEN_41; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_43 = 7'h2b == predictIndex ? saturatingCounters_43 : _GEN_42; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_44 = 7'h2c == predictIndex ? saturatingCounters_44 : _GEN_43; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_45 = 7'h2d == predictIndex ? saturatingCounters_45 : _GEN_44; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_46 = 7'h2e == predictIndex ? saturatingCounters_46 : _GEN_45; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_47 = 7'h2f == predictIndex ? saturatingCounters_47 : _GEN_46; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_48 = 7'h30 == predictIndex ? saturatingCounters_48 : _GEN_47; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_49 = 7'h31 == predictIndex ? saturatingCounters_49 : _GEN_48; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_50 = 7'h32 == predictIndex ? saturatingCounters_50 : _GEN_49; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_51 = 7'h33 == predictIndex ? saturatingCounters_51 : _GEN_50; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_52 = 7'h34 == predictIndex ? saturatingCounters_52 : _GEN_51; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_53 = 7'h35 == predictIndex ? saturatingCounters_53 : _GEN_52; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_54 = 7'h36 == predictIndex ? saturatingCounters_54 : _GEN_53; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_55 = 7'h37 == predictIndex ? saturatingCounters_55 : _GEN_54; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_56 = 7'h38 == predictIndex ? saturatingCounters_56 : _GEN_55; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_57 = 7'h39 == predictIndex ? saturatingCounters_57 : _GEN_56; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_58 = 7'h3a == predictIndex ? saturatingCounters_58 : _GEN_57; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_59 = 7'h3b == predictIndex ? saturatingCounters_59 : _GEN_58; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_60 = 7'h3c == predictIndex ? saturatingCounters_60 : _GEN_59; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_61 = 7'h3d == predictIndex ? saturatingCounters_61 : _GEN_60; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_62 = 7'h3e == predictIndex ? saturatingCounters_62 : _GEN_61; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_63 = 7'h3f == predictIndex ? saturatingCounters_63 : _GEN_62; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_64 = 7'h40 == predictIndex ? saturatingCounters_64 : _GEN_63; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_65 = 7'h41 == predictIndex ? saturatingCounters_65 : _GEN_64; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_66 = 7'h42 == predictIndex ? saturatingCounters_66 : _GEN_65; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_67 = 7'h43 == predictIndex ? saturatingCounters_67 : _GEN_66; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_68 = 7'h44 == predictIndex ? saturatingCounters_68 : _GEN_67; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_69 = 7'h45 == predictIndex ? saturatingCounters_69 : _GEN_68; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_70 = 7'h46 == predictIndex ? saturatingCounters_70 : _GEN_69; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_71 = 7'h47 == predictIndex ? saturatingCounters_71 : _GEN_70; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_72 = 7'h48 == predictIndex ? saturatingCounters_72 : _GEN_71; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_73 = 7'h49 == predictIndex ? saturatingCounters_73 : _GEN_72; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_74 = 7'h4a == predictIndex ? saturatingCounters_74 : _GEN_73; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_75 = 7'h4b == predictIndex ? saturatingCounters_75 : _GEN_74; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_76 = 7'h4c == predictIndex ? saturatingCounters_76 : _GEN_75; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_77 = 7'h4d == predictIndex ? saturatingCounters_77 : _GEN_76; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_78 = 7'h4e == predictIndex ? saturatingCounters_78 : _GEN_77; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_79 = 7'h4f == predictIndex ? saturatingCounters_79 : _GEN_78; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_80 = 7'h50 == predictIndex ? saturatingCounters_80 : _GEN_79; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_81 = 7'h51 == predictIndex ? saturatingCounters_81 : _GEN_80; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_82 = 7'h52 == predictIndex ? saturatingCounters_82 : _GEN_81; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_83 = 7'h53 == predictIndex ? saturatingCounters_83 : _GEN_82; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_84 = 7'h54 == predictIndex ? saturatingCounters_84 : _GEN_83; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_85 = 7'h55 == predictIndex ? saturatingCounters_85 : _GEN_84; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_86 = 7'h56 == predictIndex ? saturatingCounters_86 : _GEN_85; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_87 = 7'h57 == predictIndex ? saturatingCounters_87 : _GEN_86; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_88 = 7'h58 == predictIndex ? saturatingCounters_88 : _GEN_87; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_89 = 7'h59 == predictIndex ? saturatingCounters_89 : _GEN_88; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_90 = 7'h5a == predictIndex ? saturatingCounters_90 : _GEN_89; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_91 = 7'h5b == predictIndex ? saturatingCounters_91 : _GEN_90; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_92 = 7'h5c == predictIndex ? saturatingCounters_92 : _GEN_91; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_93 = 7'h5d == predictIndex ? saturatingCounters_93 : _GEN_92; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_94 = 7'h5e == predictIndex ? saturatingCounters_94 : _GEN_93; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_95 = 7'h5f == predictIndex ? saturatingCounters_95 : _GEN_94; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_96 = 7'h60 == predictIndex ? saturatingCounters_96 : _GEN_95; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_97 = 7'h61 == predictIndex ? saturatingCounters_97 : _GEN_96; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_98 = 7'h62 == predictIndex ? saturatingCounters_98 : _GEN_97; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_99 = 7'h63 == predictIndex ? saturatingCounters_99 : _GEN_98; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_100 = 7'h64 == predictIndex ? saturatingCounters_100 : _GEN_99; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_101 = 7'h65 == predictIndex ? saturatingCounters_101 : _GEN_100; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_102 = 7'h66 == predictIndex ? saturatingCounters_102 : _GEN_101; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_103 = 7'h67 == predictIndex ? saturatingCounters_103 : _GEN_102; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_104 = 7'h68 == predictIndex ? saturatingCounters_104 : _GEN_103; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_105 = 7'h69 == predictIndex ? saturatingCounters_105 : _GEN_104; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_106 = 7'h6a == predictIndex ? saturatingCounters_106 : _GEN_105; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_107 = 7'h6b == predictIndex ? saturatingCounters_107 : _GEN_106; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_108 = 7'h6c == predictIndex ? saturatingCounters_108 : _GEN_107; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_109 = 7'h6d == predictIndex ? saturatingCounters_109 : _GEN_108; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_110 = 7'h6e == predictIndex ? saturatingCounters_110 : _GEN_109; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_111 = 7'h6f == predictIndex ? saturatingCounters_111 : _GEN_110; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_112 = 7'h70 == predictIndex ? saturatingCounters_112 : _GEN_111; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_113 = 7'h71 == predictIndex ? saturatingCounters_113 : _GEN_112; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_114 = 7'h72 == predictIndex ? saturatingCounters_114 : _GEN_113; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_115 = 7'h73 == predictIndex ? saturatingCounters_115 : _GEN_114; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_116 = 7'h74 == predictIndex ? saturatingCounters_116 : _GEN_115; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_117 = 7'h75 == predictIndex ? saturatingCounters_117 : _GEN_116; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_118 = 7'h76 == predictIndex ? saturatingCounters_118 : _GEN_117; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_119 = 7'h77 == predictIndex ? saturatingCounters_119 : _GEN_118; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_120 = 7'h78 == predictIndex ? saturatingCounters_120 : _GEN_119; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_121 = 7'h79 == predictIndex ? saturatingCounters_121 : _GEN_120; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_122 = 7'h7a == predictIndex ? saturatingCounters_122 : _GEN_121; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_123 = 7'h7b == predictIndex ? saturatingCounters_123 : _GEN_122; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_124 = 7'h7c == predictIndex ? saturatingCounters_124 : _GEN_123; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_125 = 7'h7d == predictIndex ? saturatingCounters_125 : _GEN_124; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_126 = 7'h7e == predictIndex ? saturatingCounters_126 : _GEN_125; // @[dut.scala 38:{38,38}]
  wire [1:0] _GEN_127 = 7'h7f == predictIndex ? saturatingCounters_127 : _GEN_126; // @[dut.scala 38:{38,38}]
  wire [6:0] trainIndex = io_train_pc ^ io_train_history; // @[dut.scala 33:48]
  wire [6:0] _globalHistory_T_1 = {globalHistory[5:0],io_train_taken}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_130 = 7'h1 == trainIndex ? saturatingCounters_1 : saturatingCounters_0; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_131 = 7'h2 == trainIndex ? saturatingCounters_2 : _GEN_130; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_132 = 7'h3 == trainIndex ? saturatingCounters_3 : _GEN_131; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_133 = 7'h4 == trainIndex ? saturatingCounters_4 : _GEN_132; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_134 = 7'h5 == trainIndex ? saturatingCounters_5 : _GEN_133; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_135 = 7'h6 == trainIndex ? saturatingCounters_6 : _GEN_134; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_136 = 7'h7 == trainIndex ? saturatingCounters_7 : _GEN_135; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_137 = 7'h8 == trainIndex ? saturatingCounters_8 : _GEN_136; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_138 = 7'h9 == trainIndex ? saturatingCounters_9 : _GEN_137; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_139 = 7'ha == trainIndex ? saturatingCounters_10 : _GEN_138; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_140 = 7'hb == trainIndex ? saturatingCounters_11 : _GEN_139; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_141 = 7'hc == trainIndex ? saturatingCounters_12 : _GEN_140; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_142 = 7'hd == trainIndex ? saturatingCounters_13 : _GEN_141; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_143 = 7'he == trainIndex ? saturatingCounters_14 : _GEN_142; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_144 = 7'hf == trainIndex ? saturatingCounters_15 : _GEN_143; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_145 = 7'h10 == trainIndex ? saturatingCounters_16 : _GEN_144; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_146 = 7'h11 == trainIndex ? saturatingCounters_17 : _GEN_145; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_147 = 7'h12 == trainIndex ? saturatingCounters_18 : _GEN_146; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_148 = 7'h13 == trainIndex ? saturatingCounters_19 : _GEN_147; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_149 = 7'h14 == trainIndex ? saturatingCounters_20 : _GEN_148; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_150 = 7'h15 == trainIndex ? saturatingCounters_21 : _GEN_149; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_151 = 7'h16 == trainIndex ? saturatingCounters_22 : _GEN_150; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_152 = 7'h17 == trainIndex ? saturatingCounters_23 : _GEN_151; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_153 = 7'h18 == trainIndex ? saturatingCounters_24 : _GEN_152; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_154 = 7'h19 == trainIndex ? saturatingCounters_25 : _GEN_153; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_155 = 7'h1a == trainIndex ? saturatingCounters_26 : _GEN_154; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_156 = 7'h1b == trainIndex ? saturatingCounters_27 : _GEN_155; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_157 = 7'h1c == trainIndex ? saturatingCounters_28 : _GEN_156; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_158 = 7'h1d == trainIndex ? saturatingCounters_29 : _GEN_157; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_159 = 7'h1e == trainIndex ? saturatingCounters_30 : _GEN_158; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_160 = 7'h1f == trainIndex ? saturatingCounters_31 : _GEN_159; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_161 = 7'h20 == trainIndex ? saturatingCounters_32 : _GEN_160; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_162 = 7'h21 == trainIndex ? saturatingCounters_33 : _GEN_161; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_163 = 7'h22 == trainIndex ? saturatingCounters_34 : _GEN_162; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_164 = 7'h23 == trainIndex ? saturatingCounters_35 : _GEN_163; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_165 = 7'h24 == trainIndex ? saturatingCounters_36 : _GEN_164; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_166 = 7'h25 == trainIndex ? saturatingCounters_37 : _GEN_165; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_167 = 7'h26 == trainIndex ? saturatingCounters_38 : _GEN_166; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_168 = 7'h27 == trainIndex ? saturatingCounters_39 : _GEN_167; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_169 = 7'h28 == trainIndex ? saturatingCounters_40 : _GEN_168; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_170 = 7'h29 == trainIndex ? saturatingCounters_41 : _GEN_169; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_171 = 7'h2a == trainIndex ? saturatingCounters_42 : _GEN_170; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_172 = 7'h2b == trainIndex ? saturatingCounters_43 : _GEN_171; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_173 = 7'h2c == trainIndex ? saturatingCounters_44 : _GEN_172; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_174 = 7'h2d == trainIndex ? saturatingCounters_45 : _GEN_173; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_175 = 7'h2e == trainIndex ? saturatingCounters_46 : _GEN_174; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_176 = 7'h2f == trainIndex ? saturatingCounters_47 : _GEN_175; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_177 = 7'h30 == trainIndex ? saturatingCounters_48 : _GEN_176; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_178 = 7'h31 == trainIndex ? saturatingCounters_49 : _GEN_177; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_179 = 7'h32 == trainIndex ? saturatingCounters_50 : _GEN_178; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_180 = 7'h33 == trainIndex ? saturatingCounters_51 : _GEN_179; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_181 = 7'h34 == trainIndex ? saturatingCounters_52 : _GEN_180; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_182 = 7'h35 == trainIndex ? saturatingCounters_53 : _GEN_181; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_183 = 7'h36 == trainIndex ? saturatingCounters_54 : _GEN_182; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_184 = 7'h37 == trainIndex ? saturatingCounters_55 : _GEN_183; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_185 = 7'h38 == trainIndex ? saturatingCounters_56 : _GEN_184; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_186 = 7'h39 == trainIndex ? saturatingCounters_57 : _GEN_185; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_187 = 7'h3a == trainIndex ? saturatingCounters_58 : _GEN_186; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_188 = 7'h3b == trainIndex ? saturatingCounters_59 : _GEN_187; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_189 = 7'h3c == trainIndex ? saturatingCounters_60 : _GEN_188; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_190 = 7'h3d == trainIndex ? saturatingCounters_61 : _GEN_189; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_191 = 7'h3e == trainIndex ? saturatingCounters_62 : _GEN_190; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_192 = 7'h3f == trainIndex ? saturatingCounters_63 : _GEN_191; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_193 = 7'h40 == trainIndex ? saturatingCounters_64 : _GEN_192; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_194 = 7'h41 == trainIndex ? saturatingCounters_65 : _GEN_193; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_195 = 7'h42 == trainIndex ? saturatingCounters_66 : _GEN_194; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_196 = 7'h43 == trainIndex ? saturatingCounters_67 : _GEN_195; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_197 = 7'h44 == trainIndex ? saturatingCounters_68 : _GEN_196; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_198 = 7'h45 == trainIndex ? saturatingCounters_69 : _GEN_197; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_199 = 7'h46 == trainIndex ? saturatingCounters_70 : _GEN_198; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_200 = 7'h47 == trainIndex ? saturatingCounters_71 : _GEN_199; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_201 = 7'h48 == trainIndex ? saturatingCounters_72 : _GEN_200; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_202 = 7'h49 == trainIndex ? saturatingCounters_73 : _GEN_201; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_203 = 7'h4a == trainIndex ? saturatingCounters_74 : _GEN_202; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_204 = 7'h4b == trainIndex ? saturatingCounters_75 : _GEN_203; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_205 = 7'h4c == trainIndex ? saturatingCounters_76 : _GEN_204; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_206 = 7'h4d == trainIndex ? saturatingCounters_77 : _GEN_205; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_207 = 7'h4e == trainIndex ? saturatingCounters_78 : _GEN_206; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_208 = 7'h4f == trainIndex ? saturatingCounters_79 : _GEN_207; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_209 = 7'h50 == trainIndex ? saturatingCounters_80 : _GEN_208; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_210 = 7'h51 == trainIndex ? saturatingCounters_81 : _GEN_209; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_211 = 7'h52 == trainIndex ? saturatingCounters_82 : _GEN_210; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_212 = 7'h53 == trainIndex ? saturatingCounters_83 : _GEN_211; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_213 = 7'h54 == trainIndex ? saturatingCounters_84 : _GEN_212; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_214 = 7'h55 == trainIndex ? saturatingCounters_85 : _GEN_213; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_215 = 7'h56 == trainIndex ? saturatingCounters_86 : _GEN_214; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_216 = 7'h57 == trainIndex ? saturatingCounters_87 : _GEN_215; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_217 = 7'h58 == trainIndex ? saturatingCounters_88 : _GEN_216; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_218 = 7'h59 == trainIndex ? saturatingCounters_89 : _GEN_217; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_219 = 7'h5a == trainIndex ? saturatingCounters_90 : _GEN_218; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_220 = 7'h5b == trainIndex ? saturatingCounters_91 : _GEN_219; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_221 = 7'h5c == trainIndex ? saturatingCounters_92 : _GEN_220; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_222 = 7'h5d == trainIndex ? saturatingCounters_93 : _GEN_221; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_223 = 7'h5e == trainIndex ? saturatingCounters_94 : _GEN_222; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_224 = 7'h5f == trainIndex ? saturatingCounters_95 : _GEN_223; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_225 = 7'h60 == trainIndex ? saturatingCounters_96 : _GEN_224; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_226 = 7'h61 == trainIndex ? saturatingCounters_97 : _GEN_225; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_227 = 7'h62 == trainIndex ? saturatingCounters_98 : _GEN_226; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_228 = 7'h63 == trainIndex ? saturatingCounters_99 : _GEN_227; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_229 = 7'h64 == trainIndex ? saturatingCounters_100 : _GEN_228; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_230 = 7'h65 == trainIndex ? saturatingCounters_101 : _GEN_229; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_231 = 7'h66 == trainIndex ? saturatingCounters_102 : _GEN_230; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_232 = 7'h67 == trainIndex ? saturatingCounters_103 : _GEN_231; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_233 = 7'h68 == trainIndex ? saturatingCounters_104 : _GEN_232; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_234 = 7'h69 == trainIndex ? saturatingCounters_105 : _GEN_233; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_235 = 7'h6a == trainIndex ? saturatingCounters_106 : _GEN_234; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_236 = 7'h6b == trainIndex ? saturatingCounters_107 : _GEN_235; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_237 = 7'h6c == trainIndex ? saturatingCounters_108 : _GEN_236; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_238 = 7'h6d == trainIndex ? saturatingCounters_109 : _GEN_237; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_239 = 7'h6e == trainIndex ? saturatingCounters_110 : _GEN_238; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_240 = 7'h6f == trainIndex ? saturatingCounters_111 : _GEN_239; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_241 = 7'h70 == trainIndex ? saturatingCounters_112 : _GEN_240; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_242 = 7'h71 == trainIndex ? saturatingCounters_113 : _GEN_241; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_243 = 7'h72 == trainIndex ? saturatingCounters_114 : _GEN_242; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_244 = 7'h73 == trainIndex ? saturatingCounters_115 : _GEN_243; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_245 = 7'h74 == trainIndex ? saturatingCounters_116 : _GEN_244; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_246 = 7'h75 == trainIndex ? saturatingCounters_117 : _GEN_245; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_247 = 7'h76 == trainIndex ? saturatingCounters_118 : _GEN_246; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_248 = 7'h77 == trainIndex ? saturatingCounters_119 : _GEN_247; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_249 = 7'h78 == trainIndex ? saturatingCounters_120 : _GEN_248; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_250 = 7'h79 == trainIndex ? saturatingCounters_121 : _GEN_249; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_251 = 7'h7a == trainIndex ? saturatingCounters_122 : _GEN_250; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_252 = 7'h7b == trainIndex ? saturatingCounters_123 : _GEN_251; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_253 = 7'h7c == trainIndex ? saturatingCounters_124 : _GEN_252; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_254 = 7'h7d == trainIndex ? saturatingCounters_125 : _GEN_253; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_255 = 7'h7e == trainIndex ? saturatingCounters_126 : _GEN_254; // @[dut.scala 56:{40,40}]
  wire [1:0] _GEN_256 = 7'h7f == trainIndex ? saturatingCounters_127 : _GEN_255; // @[dut.scala 56:{40,40}]
  wire  _saturatingCounters_T = _GEN_256 < 2'h3; // @[dut.scala 56:40]
  wire [1:0] _saturatingCounters_T_2 = _GEN_256 + 2'h1; // @[dut.scala 57:40]
  wire [1:0] _saturatingCounters_T_3 = _saturatingCounters_T ? _saturatingCounters_T_2 : 2'h3; // @[dut.scala 55:44]
  wire [1:0] _GEN_257 = 7'h0 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_0; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_258 = 7'h1 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_1; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_259 = 7'h2 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_2; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_260 = 7'h3 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_3; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_261 = 7'h4 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_4; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_262 = 7'h5 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_5; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_263 = 7'h6 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_6; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_264 = 7'h7 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_7; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_265 = 7'h8 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_8; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_266 = 7'h9 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_9; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_267 = 7'ha == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_10; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_268 = 7'hb == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_11; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_269 = 7'hc == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_12; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_270 = 7'hd == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_13; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_271 = 7'he == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_14; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_272 = 7'hf == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_15; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_273 = 7'h10 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_16; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_274 = 7'h11 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_17; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_275 = 7'h12 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_18; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_276 = 7'h13 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_19; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_277 = 7'h14 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_20; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_278 = 7'h15 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_21; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_279 = 7'h16 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_22; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_280 = 7'h17 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_23; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_281 = 7'h18 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_24; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_282 = 7'h19 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_25; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_283 = 7'h1a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_26; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_284 = 7'h1b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_27; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_285 = 7'h1c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_28; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_286 = 7'h1d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_29; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_287 = 7'h1e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_30; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_288 = 7'h1f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_31; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_289 = 7'h20 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_32; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_290 = 7'h21 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_33; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_291 = 7'h22 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_34; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_292 = 7'h23 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_35; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_293 = 7'h24 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_36; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_294 = 7'h25 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_37; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_295 = 7'h26 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_38; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_296 = 7'h27 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_39; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_297 = 7'h28 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_40; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_298 = 7'h29 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_41; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_299 = 7'h2a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_42; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_300 = 7'h2b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_43; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_301 = 7'h2c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_44; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_302 = 7'h2d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_45; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_303 = 7'h2e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_46; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_304 = 7'h2f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_47; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_305 = 7'h30 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_48; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_306 = 7'h31 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_49; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_307 = 7'h32 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_50; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_308 = 7'h33 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_51; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_309 = 7'h34 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_52; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_310 = 7'h35 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_53; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_311 = 7'h36 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_54; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_312 = 7'h37 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_55; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_313 = 7'h38 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_56; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_314 = 7'h39 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_57; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_315 = 7'h3a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_58; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_316 = 7'h3b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_59; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_317 = 7'h3c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_60; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_318 = 7'h3d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_61; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_319 = 7'h3e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_62; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_320 = 7'h3f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_63; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_321 = 7'h40 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_64; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_322 = 7'h41 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_65; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_323 = 7'h42 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_66; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_324 = 7'h43 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_67; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_325 = 7'h44 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_68; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_326 = 7'h45 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_69; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_327 = 7'h46 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_70; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_328 = 7'h47 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_71; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_329 = 7'h48 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_72; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_330 = 7'h49 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_73; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_331 = 7'h4a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_74; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_332 = 7'h4b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_75; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_333 = 7'h4c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_76; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_334 = 7'h4d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_77; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_335 = 7'h4e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_78; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_336 = 7'h4f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_79; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_337 = 7'h50 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_80; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_338 = 7'h51 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_81; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_339 = 7'h52 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_82; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_340 = 7'h53 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_83; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_341 = 7'h54 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_84; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_342 = 7'h55 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_85; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_343 = 7'h56 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_86; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_344 = 7'h57 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_87; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_345 = 7'h58 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_88; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_346 = 7'h59 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_89; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_347 = 7'h5a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_90; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_348 = 7'h5b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_91; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_349 = 7'h5c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_92; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_350 = 7'h5d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_93; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_351 = 7'h5e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_94; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_352 = 7'h5f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_95; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_353 = 7'h60 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_96; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_354 = 7'h61 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_97; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_355 = 7'h62 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_98; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_356 = 7'h63 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_99; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_357 = 7'h64 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_100; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_358 = 7'h65 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_101; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_359 = 7'h66 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_102; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_360 = 7'h67 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_103; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_361 = 7'h68 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_104; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_362 = 7'h69 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_105; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_363 = 7'h6a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_106; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_364 = 7'h6b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_107; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_365 = 7'h6c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_108; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_366 = 7'h6d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_109; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_367 = 7'h6e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_110; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_368 = 7'h6f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_111; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_369 = 7'h70 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_112; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_370 = 7'h71 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_113; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_371 = 7'h72 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_114; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_372 = 7'h73 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_115; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_373 = 7'h74 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_116; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_374 = 7'h75 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_117; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_375 = 7'h76 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_118; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_376 = 7'h77 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_119; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_377 = 7'h78 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_120; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_378 = 7'h79 == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_121; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_379 = 7'h7a == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_122; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_380 = 7'h7b == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_123; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_381 = 7'h7c == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_124; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_382 = 7'h7d == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_125; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_383 = 7'h7e == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_126; // @[dut.scala 30:35 55:{38,38}]
  wire [1:0] _GEN_384 = 7'h7f == trainIndex ? _saturatingCounters_T_3 : saturatingCounters_127; // @[dut.scala 30:35 55:{38,38}]
  wire  _saturatingCounters_T_4 = _GEN_256 > 2'h0; // @[dut.scala 62:40]
  wire [1:0] _saturatingCounters_T_6 = _GEN_256 - 2'h1; // @[dut.scala 63:40]
  wire [1:0] _saturatingCounters_T_7 = _saturatingCounters_T_4 ? _saturatingCounters_T_6 : 2'h0; // @[dut.scala 61:44]
  wire [1:0] _GEN_385 = 7'h0 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_0; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_386 = 7'h1 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_1; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_387 = 7'h2 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_2; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_388 = 7'h3 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_3; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_389 = 7'h4 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_4; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_390 = 7'h5 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_5; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_391 = 7'h6 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_6; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_392 = 7'h7 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_7; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_393 = 7'h8 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_8; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_394 = 7'h9 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_9; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_395 = 7'ha == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_10; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_396 = 7'hb == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_11; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_397 = 7'hc == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_12; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_398 = 7'hd == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_13; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_399 = 7'he == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_14; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_400 = 7'hf == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_15; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_401 = 7'h10 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_16; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_402 = 7'h11 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_17; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_403 = 7'h12 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_18; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_404 = 7'h13 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_19; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_405 = 7'h14 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_20; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_406 = 7'h15 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_21; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_407 = 7'h16 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_22; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_408 = 7'h17 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_23; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_409 = 7'h18 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_24; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_410 = 7'h19 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_25; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_411 = 7'h1a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_26; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_412 = 7'h1b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_27; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_413 = 7'h1c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_28; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_414 = 7'h1d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_29; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_415 = 7'h1e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_30; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_416 = 7'h1f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_31; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_417 = 7'h20 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_32; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_418 = 7'h21 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_33; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_419 = 7'h22 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_34; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_420 = 7'h23 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_35; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_421 = 7'h24 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_36; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_422 = 7'h25 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_37; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_423 = 7'h26 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_38; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_424 = 7'h27 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_39; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_425 = 7'h28 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_40; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_426 = 7'h29 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_41; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_427 = 7'h2a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_42; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_428 = 7'h2b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_43; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_429 = 7'h2c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_44; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_430 = 7'h2d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_45; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_431 = 7'h2e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_46; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_432 = 7'h2f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_47; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_433 = 7'h30 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_48; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_434 = 7'h31 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_49; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_435 = 7'h32 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_50; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_436 = 7'h33 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_51; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_437 = 7'h34 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_52; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_438 = 7'h35 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_53; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_439 = 7'h36 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_54; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_440 = 7'h37 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_55; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_441 = 7'h38 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_56; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_442 = 7'h39 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_57; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_443 = 7'h3a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_58; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_444 = 7'h3b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_59; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_445 = 7'h3c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_60; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_446 = 7'h3d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_61; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_447 = 7'h3e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_62; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_448 = 7'h3f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_63; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_449 = 7'h40 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_64; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_450 = 7'h41 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_65; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_451 = 7'h42 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_66; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_452 = 7'h43 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_67; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_453 = 7'h44 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_68; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_454 = 7'h45 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_69; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_455 = 7'h46 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_70; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_456 = 7'h47 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_71; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_457 = 7'h48 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_72; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_458 = 7'h49 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_73; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_459 = 7'h4a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_74; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_460 = 7'h4b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_75; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_461 = 7'h4c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_76; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_462 = 7'h4d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_77; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_463 = 7'h4e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_78; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_464 = 7'h4f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_79; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_465 = 7'h50 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_80; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_466 = 7'h51 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_81; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_467 = 7'h52 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_82; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_468 = 7'h53 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_83; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_469 = 7'h54 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_84; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_470 = 7'h55 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_85; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_471 = 7'h56 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_86; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_472 = 7'h57 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_87; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_473 = 7'h58 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_88; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_474 = 7'h59 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_89; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_475 = 7'h5a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_90; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_476 = 7'h5b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_91; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_477 = 7'h5c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_92; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_478 = 7'h5d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_93; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_479 = 7'h5e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_94; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_480 = 7'h5f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_95; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_481 = 7'h60 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_96; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_482 = 7'h61 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_97; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_483 = 7'h62 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_98; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_484 = 7'h63 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_99; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_485 = 7'h64 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_100; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_486 = 7'h65 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_101; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_487 = 7'h66 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_102; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_488 = 7'h67 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_103; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_489 = 7'h68 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_104; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_490 = 7'h69 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_105; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_491 = 7'h6a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_106; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_492 = 7'h6b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_107; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_493 = 7'h6c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_108; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_494 = 7'h6d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_109; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_495 = 7'h6e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_110; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_496 = 7'h6f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_111; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_497 = 7'h70 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_112; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_498 = 7'h71 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_113; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_499 = 7'h72 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_114; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_500 = 7'h73 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_115; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_501 = 7'h74 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_116; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_502 = 7'h75 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_117; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_503 = 7'h76 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_118; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_504 = 7'h77 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_119; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_505 = 7'h78 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_120; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_506 = 7'h79 == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_121; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_507 = 7'h7a == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_122; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_508 = 7'h7b == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_123; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_509 = 7'h7c == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_124; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_510 = 7'h7d == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_125; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_511 = 7'h7e == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_126; // @[dut.scala 30:35 61:{38,38}]
  wire [1:0] _GEN_512 = 7'h7f == trainIndex ? _saturatingCounters_T_7 : saturatingCounters_127; // @[dut.scala 30:35 61:{38,38}]
  assign io_predict_taken = _GEN_127 >= _io_predict_taken_T; // @[dut.scala 38:38]
  assign io_predict_history = globalHistory; // @[dut.scala 39:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 29:30]
      globalHistory <= 7'h0; // @[dut.scala 29:30]
    end else if (io_reset) begin // @[dut.scala 70:19]
      globalHistory <= 7'h0; // @[dut.scala 71:19]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_mispredicted) begin // @[dut.scala 46:34]
        globalHistory <= io_train_history; // @[dut.scala 47:21]
      end else begin
        globalHistory <= _globalHistory_T_1; // @[dut.scala 50:21]
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_0 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_0 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_0 <= _GEN_257;
      end else begin
        saturatingCounters_0 <= _GEN_385;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_1 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_1 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_1 <= _GEN_258;
      end else begin
        saturatingCounters_1 <= _GEN_386;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_2 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_2 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_2 <= _GEN_259;
      end else begin
        saturatingCounters_2 <= _GEN_387;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_3 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_3 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_3 <= _GEN_260;
      end else begin
        saturatingCounters_3 <= _GEN_388;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_4 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_4 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_4 <= _GEN_261;
      end else begin
        saturatingCounters_4 <= _GEN_389;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_5 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_5 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_5 <= _GEN_262;
      end else begin
        saturatingCounters_5 <= _GEN_390;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_6 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_6 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_6 <= _GEN_263;
      end else begin
        saturatingCounters_6 <= _GEN_391;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_7 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_7 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_7 <= _GEN_264;
      end else begin
        saturatingCounters_7 <= _GEN_392;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_8 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_8 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_8 <= _GEN_265;
      end else begin
        saturatingCounters_8 <= _GEN_393;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_9 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_9 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_9 <= _GEN_266;
      end else begin
        saturatingCounters_9 <= _GEN_394;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_10 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_10 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_10 <= _GEN_267;
      end else begin
        saturatingCounters_10 <= _GEN_395;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_11 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_11 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_11 <= _GEN_268;
      end else begin
        saturatingCounters_11 <= _GEN_396;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_12 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_12 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_12 <= _GEN_269;
      end else begin
        saturatingCounters_12 <= _GEN_397;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_13 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_13 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_13 <= _GEN_270;
      end else begin
        saturatingCounters_13 <= _GEN_398;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_14 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_14 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_14 <= _GEN_271;
      end else begin
        saturatingCounters_14 <= _GEN_399;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_15 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_15 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_15 <= _GEN_272;
      end else begin
        saturatingCounters_15 <= _GEN_400;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_16 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_16 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_16 <= _GEN_273;
      end else begin
        saturatingCounters_16 <= _GEN_401;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_17 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_17 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_17 <= _GEN_274;
      end else begin
        saturatingCounters_17 <= _GEN_402;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_18 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_18 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_18 <= _GEN_275;
      end else begin
        saturatingCounters_18 <= _GEN_403;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_19 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_19 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_19 <= _GEN_276;
      end else begin
        saturatingCounters_19 <= _GEN_404;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_20 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_20 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_20 <= _GEN_277;
      end else begin
        saturatingCounters_20 <= _GEN_405;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_21 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_21 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_21 <= _GEN_278;
      end else begin
        saturatingCounters_21 <= _GEN_406;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_22 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_22 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_22 <= _GEN_279;
      end else begin
        saturatingCounters_22 <= _GEN_407;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_23 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_23 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_23 <= _GEN_280;
      end else begin
        saturatingCounters_23 <= _GEN_408;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_24 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_24 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_24 <= _GEN_281;
      end else begin
        saturatingCounters_24 <= _GEN_409;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_25 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_25 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_25 <= _GEN_282;
      end else begin
        saturatingCounters_25 <= _GEN_410;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_26 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_26 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_26 <= _GEN_283;
      end else begin
        saturatingCounters_26 <= _GEN_411;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_27 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_27 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_27 <= _GEN_284;
      end else begin
        saturatingCounters_27 <= _GEN_412;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_28 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_28 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_28 <= _GEN_285;
      end else begin
        saturatingCounters_28 <= _GEN_413;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_29 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_29 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_29 <= _GEN_286;
      end else begin
        saturatingCounters_29 <= _GEN_414;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_30 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_30 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_30 <= _GEN_287;
      end else begin
        saturatingCounters_30 <= _GEN_415;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_31 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_31 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_31 <= _GEN_288;
      end else begin
        saturatingCounters_31 <= _GEN_416;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_32 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_32 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_32 <= _GEN_289;
      end else begin
        saturatingCounters_32 <= _GEN_417;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_33 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_33 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_33 <= _GEN_290;
      end else begin
        saturatingCounters_33 <= _GEN_418;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_34 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_34 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_34 <= _GEN_291;
      end else begin
        saturatingCounters_34 <= _GEN_419;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_35 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_35 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_35 <= _GEN_292;
      end else begin
        saturatingCounters_35 <= _GEN_420;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_36 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_36 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_36 <= _GEN_293;
      end else begin
        saturatingCounters_36 <= _GEN_421;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_37 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_37 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_37 <= _GEN_294;
      end else begin
        saturatingCounters_37 <= _GEN_422;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_38 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_38 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_38 <= _GEN_295;
      end else begin
        saturatingCounters_38 <= _GEN_423;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_39 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_39 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_39 <= _GEN_296;
      end else begin
        saturatingCounters_39 <= _GEN_424;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_40 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_40 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_40 <= _GEN_297;
      end else begin
        saturatingCounters_40 <= _GEN_425;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_41 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_41 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_41 <= _GEN_298;
      end else begin
        saturatingCounters_41 <= _GEN_426;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_42 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_42 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_42 <= _GEN_299;
      end else begin
        saturatingCounters_42 <= _GEN_427;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_43 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_43 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_43 <= _GEN_300;
      end else begin
        saturatingCounters_43 <= _GEN_428;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_44 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_44 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_44 <= _GEN_301;
      end else begin
        saturatingCounters_44 <= _GEN_429;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_45 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_45 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_45 <= _GEN_302;
      end else begin
        saturatingCounters_45 <= _GEN_430;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_46 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_46 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_46 <= _GEN_303;
      end else begin
        saturatingCounters_46 <= _GEN_431;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_47 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_47 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_47 <= _GEN_304;
      end else begin
        saturatingCounters_47 <= _GEN_432;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_48 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_48 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_48 <= _GEN_305;
      end else begin
        saturatingCounters_48 <= _GEN_433;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_49 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_49 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_49 <= _GEN_306;
      end else begin
        saturatingCounters_49 <= _GEN_434;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_50 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_50 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_50 <= _GEN_307;
      end else begin
        saturatingCounters_50 <= _GEN_435;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_51 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_51 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_51 <= _GEN_308;
      end else begin
        saturatingCounters_51 <= _GEN_436;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_52 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_52 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_52 <= _GEN_309;
      end else begin
        saturatingCounters_52 <= _GEN_437;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_53 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_53 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_53 <= _GEN_310;
      end else begin
        saturatingCounters_53 <= _GEN_438;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_54 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_54 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_54 <= _GEN_311;
      end else begin
        saturatingCounters_54 <= _GEN_439;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_55 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_55 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_55 <= _GEN_312;
      end else begin
        saturatingCounters_55 <= _GEN_440;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_56 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_56 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_56 <= _GEN_313;
      end else begin
        saturatingCounters_56 <= _GEN_441;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_57 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_57 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_57 <= _GEN_314;
      end else begin
        saturatingCounters_57 <= _GEN_442;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_58 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_58 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_58 <= _GEN_315;
      end else begin
        saturatingCounters_58 <= _GEN_443;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_59 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_59 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_59 <= _GEN_316;
      end else begin
        saturatingCounters_59 <= _GEN_444;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_60 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_60 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_60 <= _GEN_317;
      end else begin
        saturatingCounters_60 <= _GEN_445;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_61 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_61 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_61 <= _GEN_318;
      end else begin
        saturatingCounters_61 <= _GEN_446;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_62 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_62 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_62 <= _GEN_319;
      end else begin
        saturatingCounters_62 <= _GEN_447;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_63 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_63 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_63 <= _GEN_320;
      end else begin
        saturatingCounters_63 <= _GEN_448;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_64 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_64 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_64 <= _GEN_321;
      end else begin
        saturatingCounters_64 <= _GEN_449;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_65 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_65 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_65 <= _GEN_322;
      end else begin
        saturatingCounters_65 <= _GEN_450;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_66 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_66 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_66 <= _GEN_323;
      end else begin
        saturatingCounters_66 <= _GEN_451;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_67 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_67 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_67 <= _GEN_324;
      end else begin
        saturatingCounters_67 <= _GEN_452;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_68 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_68 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_68 <= _GEN_325;
      end else begin
        saturatingCounters_68 <= _GEN_453;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_69 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_69 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_69 <= _GEN_326;
      end else begin
        saturatingCounters_69 <= _GEN_454;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_70 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_70 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_70 <= _GEN_327;
      end else begin
        saturatingCounters_70 <= _GEN_455;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_71 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_71 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_71 <= _GEN_328;
      end else begin
        saturatingCounters_71 <= _GEN_456;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_72 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_72 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_72 <= _GEN_329;
      end else begin
        saturatingCounters_72 <= _GEN_457;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_73 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_73 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_73 <= _GEN_330;
      end else begin
        saturatingCounters_73 <= _GEN_458;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_74 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_74 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_74 <= _GEN_331;
      end else begin
        saturatingCounters_74 <= _GEN_459;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_75 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_75 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_75 <= _GEN_332;
      end else begin
        saturatingCounters_75 <= _GEN_460;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_76 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_76 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_76 <= _GEN_333;
      end else begin
        saturatingCounters_76 <= _GEN_461;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_77 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_77 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_77 <= _GEN_334;
      end else begin
        saturatingCounters_77 <= _GEN_462;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_78 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_78 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_78 <= _GEN_335;
      end else begin
        saturatingCounters_78 <= _GEN_463;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_79 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_79 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_79 <= _GEN_336;
      end else begin
        saturatingCounters_79 <= _GEN_464;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_80 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_80 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_80 <= _GEN_337;
      end else begin
        saturatingCounters_80 <= _GEN_465;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_81 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_81 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_81 <= _GEN_338;
      end else begin
        saturatingCounters_81 <= _GEN_466;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_82 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_82 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_82 <= _GEN_339;
      end else begin
        saturatingCounters_82 <= _GEN_467;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_83 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_83 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_83 <= _GEN_340;
      end else begin
        saturatingCounters_83 <= _GEN_468;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_84 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_84 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_84 <= _GEN_341;
      end else begin
        saturatingCounters_84 <= _GEN_469;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_85 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_85 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_85 <= _GEN_342;
      end else begin
        saturatingCounters_85 <= _GEN_470;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_86 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_86 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_86 <= _GEN_343;
      end else begin
        saturatingCounters_86 <= _GEN_471;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_87 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_87 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_87 <= _GEN_344;
      end else begin
        saturatingCounters_87 <= _GEN_472;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_88 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_88 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_88 <= _GEN_345;
      end else begin
        saturatingCounters_88 <= _GEN_473;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_89 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_89 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_89 <= _GEN_346;
      end else begin
        saturatingCounters_89 <= _GEN_474;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_90 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_90 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_90 <= _GEN_347;
      end else begin
        saturatingCounters_90 <= _GEN_475;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_91 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_91 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_91 <= _GEN_348;
      end else begin
        saturatingCounters_91 <= _GEN_476;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_92 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_92 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_92 <= _GEN_349;
      end else begin
        saturatingCounters_92 <= _GEN_477;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_93 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_93 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_93 <= _GEN_350;
      end else begin
        saturatingCounters_93 <= _GEN_478;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_94 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_94 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_94 <= _GEN_351;
      end else begin
        saturatingCounters_94 <= _GEN_479;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_95 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_95 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_95 <= _GEN_352;
      end else begin
        saturatingCounters_95 <= _GEN_480;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_96 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_96 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_96 <= _GEN_353;
      end else begin
        saturatingCounters_96 <= _GEN_481;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_97 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_97 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_97 <= _GEN_354;
      end else begin
        saturatingCounters_97 <= _GEN_482;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_98 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_98 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_98 <= _GEN_355;
      end else begin
        saturatingCounters_98 <= _GEN_483;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_99 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_99 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_99 <= _GEN_356;
      end else begin
        saturatingCounters_99 <= _GEN_484;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_100 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_100 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_100 <= _GEN_357;
      end else begin
        saturatingCounters_100 <= _GEN_485;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_101 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_101 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_101 <= _GEN_358;
      end else begin
        saturatingCounters_101 <= _GEN_486;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_102 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_102 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_102 <= _GEN_359;
      end else begin
        saturatingCounters_102 <= _GEN_487;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_103 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_103 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_103 <= _GEN_360;
      end else begin
        saturatingCounters_103 <= _GEN_488;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_104 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_104 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_104 <= _GEN_361;
      end else begin
        saturatingCounters_104 <= _GEN_489;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_105 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_105 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_105 <= _GEN_362;
      end else begin
        saturatingCounters_105 <= _GEN_490;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_106 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_106 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_106 <= _GEN_363;
      end else begin
        saturatingCounters_106 <= _GEN_491;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_107 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_107 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_107 <= _GEN_364;
      end else begin
        saturatingCounters_107 <= _GEN_492;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_108 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_108 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_108 <= _GEN_365;
      end else begin
        saturatingCounters_108 <= _GEN_493;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_109 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_109 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_109 <= _GEN_366;
      end else begin
        saturatingCounters_109 <= _GEN_494;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_110 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_110 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_110 <= _GEN_367;
      end else begin
        saturatingCounters_110 <= _GEN_495;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_111 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_111 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_111 <= _GEN_368;
      end else begin
        saturatingCounters_111 <= _GEN_496;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_112 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_112 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_112 <= _GEN_369;
      end else begin
        saturatingCounters_112 <= _GEN_497;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_113 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_113 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_113 <= _GEN_370;
      end else begin
        saturatingCounters_113 <= _GEN_498;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_114 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_114 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_114 <= _GEN_371;
      end else begin
        saturatingCounters_114 <= _GEN_499;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_115 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_115 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_115 <= _GEN_372;
      end else begin
        saturatingCounters_115 <= _GEN_500;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_116 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_116 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_116 <= _GEN_373;
      end else begin
        saturatingCounters_116 <= _GEN_501;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_117 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_117 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_117 <= _GEN_374;
      end else begin
        saturatingCounters_117 <= _GEN_502;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_118 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_118 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_118 <= _GEN_375;
      end else begin
        saturatingCounters_118 <= _GEN_503;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_119 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_119 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_119 <= _GEN_376;
      end else begin
        saturatingCounters_119 <= _GEN_504;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_120 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_120 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_120 <= _GEN_377;
      end else begin
        saturatingCounters_120 <= _GEN_505;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_121 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_121 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_121 <= _GEN_378;
      end else begin
        saturatingCounters_121 <= _GEN_506;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_122 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_122 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_122 <= _GEN_379;
      end else begin
        saturatingCounters_122 <= _GEN_507;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_123 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_123 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_123 <= _GEN_380;
      end else begin
        saturatingCounters_123 <= _GEN_508;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_124 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_124 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_124 <= _GEN_381;
      end else begin
        saturatingCounters_124 <= _GEN_509;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_125 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_125 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_125 <= _GEN_382;
      end else begin
        saturatingCounters_125 <= _GEN_510;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_126 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_126 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_126 <= _GEN_383;
      end else begin
        saturatingCounters_126 <= _GEN_511;
      end
    end
    if (reset) begin // @[dut.scala 30:35]
      saturatingCounters_127 <= 2'h2; // @[dut.scala 30:35]
    end else if (io_reset) begin // @[dut.scala 70:19]
      saturatingCounters_127 <= 2'h2; // @[dut.scala 72:51]
    end else if (io_train_valid) begin // @[dut.scala 42:25]
      if (io_train_taken) begin // @[dut.scala 54:27]
        saturatingCounters_127 <= _GEN_384;
      end else begin
        saturatingCounters_127 <= _GEN_512;
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
  saturatingCounters_0 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  saturatingCounters_1 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  saturatingCounters_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  saturatingCounters_3 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  saturatingCounters_4 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  saturatingCounters_5 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  saturatingCounters_6 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  saturatingCounters_7 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  saturatingCounters_8 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  saturatingCounters_9 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  saturatingCounters_10 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  saturatingCounters_11 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  saturatingCounters_12 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  saturatingCounters_13 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  saturatingCounters_14 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  saturatingCounters_15 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  saturatingCounters_16 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  saturatingCounters_17 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  saturatingCounters_18 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  saturatingCounters_19 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  saturatingCounters_20 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  saturatingCounters_21 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  saturatingCounters_22 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  saturatingCounters_23 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  saturatingCounters_24 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  saturatingCounters_25 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  saturatingCounters_26 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  saturatingCounters_27 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  saturatingCounters_28 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  saturatingCounters_29 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  saturatingCounters_30 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  saturatingCounters_31 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  saturatingCounters_32 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  saturatingCounters_33 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  saturatingCounters_34 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  saturatingCounters_35 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  saturatingCounters_36 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  saturatingCounters_37 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  saturatingCounters_38 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  saturatingCounters_39 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  saturatingCounters_40 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  saturatingCounters_41 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  saturatingCounters_42 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  saturatingCounters_43 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  saturatingCounters_44 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  saturatingCounters_45 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  saturatingCounters_46 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  saturatingCounters_47 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  saturatingCounters_48 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  saturatingCounters_49 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  saturatingCounters_50 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  saturatingCounters_51 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  saturatingCounters_52 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  saturatingCounters_53 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  saturatingCounters_54 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  saturatingCounters_55 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  saturatingCounters_56 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  saturatingCounters_57 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  saturatingCounters_58 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  saturatingCounters_59 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  saturatingCounters_60 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  saturatingCounters_61 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  saturatingCounters_62 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  saturatingCounters_63 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  saturatingCounters_64 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  saturatingCounters_65 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  saturatingCounters_66 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  saturatingCounters_67 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  saturatingCounters_68 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  saturatingCounters_69 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  saturatingCounters_70 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  saturatingCounters_71 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  saturatingCounters_72 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  saturatingCounters_73 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  saturatingCounters_74 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  saturatingCounters_75 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  saturatingCounters_76 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  saturatingCounters_77 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  saturatingCounters_78 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  saturatingCounters_79 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  saturatingCounters_80 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  saturatingCounters_81 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  saturatingCounters_82 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  saturatingCounters_83 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  saturatingCounters_84 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  saturatingCounters_85 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  saturatingCounters_86 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  saturatingCounters_87 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  saturatingCounters_88 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  saturatingCounters_89 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  saturatingCounters_90 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  saturatingCounters_91 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  saturatingCounters_92 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  saturatingCounters_93 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  saturatingCounters_94 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  saturatingCounters_95 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  saturatingCounters_96 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  saturatingCounters_97 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  saturatingCounters_98 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  saturatingCounters_99 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  saturatingCounters_100 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  saturatingCounters_101 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  saturatingCounters_102 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  saturatingCounters_103 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  saturatingCounters_104 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  saturatingCounters_105 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  saturatingCounters_106 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  saturatingCounters_107 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  saturatingCounters_108 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  saturatingCounters_109 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  saturatingCounters_110 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  saturatingCounters_111 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  saturatingCounters_112 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  saturatingCounters_113 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  saturatingCounters_114 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  saturatingCounters_115 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  saturatingCounters_116 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  saturatingCounters_117 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  saturatingCounters_118 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  saturatingCounters_119 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  saturatingCounters_120 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  saturatingCounters_121 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  saturatingCounters_122 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  saturatingCounters_123 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  saturatingCounters_124 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  saturatingCounters_125 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  saturatingCounters_126 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  saturatingCounters_127 = _RAND_128[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
