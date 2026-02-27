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
  reg [1:0] pht_0; // @[dut.scala 29:20]
  reg [1:0] pht_1; // @[dut.scala 29:20]
  reg [1:0] pht_2; // @[dut.scala 29:20]
  reg [1:0] pht_3; // @[dut.scala 29:20]
  reg [1:0] pht_4; // @[dut.scala 29:20]
  reg [1:0] pht_5; // @[dut.scala 29:20]
  reg [1:0] pht_6; // @[dut.scala 29:20]
  reg [1:0] pht_7; // @[dut.scala 29:20]
  reg [1:0] pht_8; // @[dut.scala 29:20]
  reg [1:0] pht_9; // @[dut.scala 29:20]
  reg [1:0] pht_10; // @[dut.scala 29:20]
  reg [1:0] pht_11; // @[dut.scala 29:20]
  reg [1:0] pht_12; // @[dut.scala 29:20]
  reg [1:0] pht_13; // @[dut.scala 29:20]
  reg [1:0] pht_14; // @[dut.scala 29:20]
  reg [1:0] pht_15; // @[dut.scala 29:20]
  reg [1:0] pht_16; // @[dut.scala 29:20]
  reg [1:0] pht_17; // @[dut.scala 29:20]
  reg [1:0] pht_18; // @[dut.scala 29:20]
  reg [1:0] pht_19; // @[dut.scala 29:20]
  reg [1:0] pht_20; // @[dut.scala 29:20]
  reg [1:0] pht_21; // @[dut.scala 29:20]
  reg [1:0] pht_22; // @[dut.scala 29:20]
  reg [1:0] pht_23; // @[dut.scala 29:20]
  reg [1:0] pht_24; // @[dut.scala 29:20]
  reg [1:0] pht_25; // @[dut.scala 29:20]
  reg [1:0] pht_26; // @[dut.scala 29:20]
  reg [1:0] pht_27; // @[dut.scala 29:20]
  reg [1:0] pht_28; // @[dut.scala 29:20]
  reg [1:0] pht_29; // @[dut.scala 29:20]
  reg [1:0] pht_30; // @[dut.scala 29:20]
  reg [1:0] pht_31; // @[dut.scala 29:20]
  reg [1:0] pht_32; // @[dut.scala 29:20]
  reg [1:0] pht_33; // @[dut.scala 29:20]
  reg [1:0] pht_34; // @[dut.scala 29:20]
  reg [1:0] pht_35; // @[dut.scala 29:20]
  reg [1:0] pht_36; // @[dut.scala 29:20]
  reg [1:0] pht_37; // @[dut.scala 29:20]
  reg [1:0] pht_38; // @[dut.scala 29:20]
  reg [1:0] pht_39; // @[dut.scala 29:20]
  reg [1:0] pht_40; // @[dut.scala 29:20]
  reg [1:0] pht_41; // @[dut.scala 29:20]
  reg [1:0] pht_42; // @[dut.scala 29:20]
  reg [1:0] pht_43; // @[dut.scala 29:20]
  reg [1:0] pht_44; // @[dut.scala 29:20]
  reg [1:0] pht_45; // @[dut.scala 29:20]
  reg [1:0] pht_46; // @[dut.scala 29:20]
  reg [1:0] pht_47; // @[dut.scala 29:20]
  reg [1:0] pht_48; // @[dut.scala 29:20]
  reg [1:0] pht_49; // @[dut.scala 29:20]
  reg [1:0] pht_50; // @[dut.scala 29:20]
  reg [1:0] pht_51; // @[dut.scala 29:20]
  reg [1:0] pht_52; // @[dut.scala 29:20]
  reg [1:0] pht_53; // @[dut.scala 29:20]
  reg [1:0] pht_54; // @[dut.scala 29:20]
  reg [1:0] pht_55; // @[dut.scala 29:20]
  reg [1:0] pht_56; // @[dut.scala 29:20]
  reg [1:0] pht_57; // @[dut.scala 29:20]
  reg [1:0] pht_58; // @[dut.scala 29:20]
  reg [1:0] pht_59; // @[dut.scala 29:20]
  reg [1:0] pht_60; // @[dut.scala 29:20]
  reg [1:0] pht_61; // @[dut.scala 29:20]
  reg [1:0] pht_62; // @[dut.scala 29:20]
  reg [1:0] pht_63; // @[dut.scala 29:20]
  reg [1:0] pht_64; // @[dut.scala 29:20]
  reg [1:0] pht_65; // @[dut.scala 29:20]
  reg [1:0] pht_66; // @[dut.scala 29:20]
  reg [1:0] pht_67; // @[dut.scala 29:20]
  reg [1:0] pht_68; // @[dut.scala 29:20]
  reg [1:0] pht_69; // @[dut.scala 29:20]
  reg [1:0] pht_70; // @[dut.scala 29:20]
  reg [1:0] pht_71; // @[dut.scala 29:20]
  reg [1:0] pht_72; // @[dut.scala 29:20]
  reg [1:0] pht_73; // @[dut.scala 29:20]
  reg [1:0] pht_74; // @[dut.scala 29:20]
  reg [1:0] pht_75; // @[dut.scala 29:20]
  reg [1:0] pht_76; // @[dut.scala 29:20]
  reg [1:0] pht_77; // @[dut.scala 29:20]
  reg [1:0] pht_78; // @[dut.scala 29:20]
  reg [1:0] pht_79; // @[dut.scala 29:20]
  reg [1:0] pht_80; // @[dut.scala 29:20]
  reg [1:0] pht_81; // @[dut.scala 29:20]
  reg [1:0] pht_82; // @[dut.scala 29:20]
  reg [1:0] pht_83; // @[dut.scala 29:20]
  reg [1:0] pht_84; // @[dut.scala 29:20]
  reg [1:0] pht_85; // @[dut.scala 29:20]
  reg [1:0] pht_86; // @[dut.scala 29:20]
  reg [1:0] pht_87; // @[dut.scala 29:20]
  reg [1:0] pht_88; // @[dut.scala 29:20]
  reg [1:0] pht_89; // @[dut.scala 29:20]
  reg [1:0] pht_90; // @[dut.scala 29:20]
  reg [1:0] pht_91; // @[dut.scala 29:20]
  reg [1:0] pht_92; // @[dut.scala 29:20]
  reg [1:0] pht_93; // @[dut.scala 29:20]
  reg [1:0] pht_94; // @[dut.scala 29:20]
  reg [1:0] pht_95; // @[dut.scala 29:20]
  reg [1:0] pht_96; // @[dut.scala 29:20]
  reg [1:0] pht_97; // @[dut.scala 29:20]
  reg [1:0] pht_98; // @[dut.scala 29:20]
  reg [1:0] pht_99; // @[dut.scala 29:20]
  reg [1:0] pht_100; // @[dut.scala 29:20]
  reg [1:0] pht_101; // @[dut.scala 29:20]
  reg [1:0] pht_102; // @[dut.scala 29:20]
  reg [1:0] pht_103; // @[dut.scala 29:20]
  reg [1:0] pht_104; // @[dut.scala 29:20]
  reg [1:0] pht_105; // @[dut.scala 29:20]
  reg [1:0] pht_106; // @[dut.scala 29:20]
  reg [1:0] pht_107; // @[dut.scala 29:20]
  reg [1:0] pht_108; // @[dut.scala 29:20]
  reg [1:0] pht_109; // @[dut.scala 29:20]
  reg [1:0] pht_110; // @[dut.scala 29:20]
  reg [1:0] pht_111; // @[dut.scala 29:20]
  reg [1:0] pht_112; // @[dut.scala 29:20]
  reg [1:0] pht_113; // @[dut.scala 29:20]
  reg [1:0] pht_114; // @[dut.scala 29:20]
  reg [1:0] pht_115; // @[dut.scala 29:20]
  reg [1:0] pht_116; // @[dut.scala 29:20]
  reg [1:0] pht_117; // @[dut.scala 29:20]
  reg [1:0] pht_118; // @[dut.scala 29:20]
  reg [1:0] pht_119; // @[dut.scala 29:20]
  reg [1:0] pht_120; // @[dut.scala 29:20]
  reg [1:0] pht_121; // @[dut.scala 29:20]
  reg [1:0] pht_122; // @[dut.scala 29:20]
  reg [1:0] pht_123; // @[dut.scala 29:20]
  reg [1:0] pht_124; // @[dut.scala 29:20]
  reg [1:0] pht_125; // @[dut.scala 29:20]
  reg [1:0] pht_126; // @[dut.scala 29:20]
  reg [1:0] pht_127; // @[dut.scala 29:20]
  reg [6:0] global_history; // @[dut.scala 30:31]
  wire [6:0] predict_index = io_predict_pc ^ global_history; // @[dut.scala 33:37]
  wire [1:0] _GEN_1 = 7'h1 == predict_index ? pht_1 : pht_0; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_2 = 7'h2 == predict_index ? pht_2 : _GEN_1; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_3 = 7'h3 == predict_index ? pht_3 : _GEN_2; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_4 = 7'h4 == predict_index ? pht_4 : _GEN_3; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_5 = 7'h5 == predict_index ? pht_5 : _GEN_4; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_6 = 7'h6 == predict_index ? pht_6 : _GEN_5; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_7 = 7'h7 == predict_index ? pht_7 : _GEN_6; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_8 = 7'h8 == predict_index ? pht_8 : _GEN_7; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_9 = 7'h9 == predict_index ? pht_9 : _GEN_8; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_10 = 7'ha == predict_index ? pht_10 : _GEN_9; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_11 = 7'hb == predict_index ? pht_11 : _GEN_10; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_12 = 7'hc == predict_index ? pht_12 : _GEN_11; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_13 = 7'hd == predict_index ? pht_13 : _GEN_12; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_14 = 7'he == predict_index ? pht_14 : _GEN_13; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_15 = 7'hf == predict_index ? pht_15 : _GEN_14; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_16 = 7'h10 == predict_index ? pht_16 : _GEN_15; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_17 = 7'h11 == predict_index ? pht_17 : _GEN_16; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_18 = 7'h12 == predict_index ? pht_18 : _GEN_17; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_19 = 7'h13 == predict_index ? pht_19 : _GEN_18; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_20 = 7'h14 == predict_index ? pht_20 : _GEN_19; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_21 = 7'h15 == predict_index ? pht_21 : _GEN_20; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_22 = 7'h16 == predict_index ? pht_22 : _GEN_21; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_23 = 7'h17 == predict_index ? pht_23 : _GEN_22; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_24 = 7'h18 == predict_index ? pht_24 : _GEN_23; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_25 = 7'h19 == predict_index ? pht_25 : _GEN_24; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_26 = 7'h1a == predict_index ? pht_26 : _GEN_25; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_27 = 7'h1b == predict_index ? pht_27 : _GEN_26; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_28 = 7'h1c == predict_index ? pht_28 : _GEN_27; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_29 = 7'h1d == predict_index ? pht_29 : _GEN_28; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_30 = 7'h1e == predict_index ? pht_30 : _GEN_29; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_31 = 7'h1f == predict_index ? pht_31 : _GEN_30; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_32 = 7'h20 == predict_index ? pht_32 : _GEN_31; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_33 = 7'h21 == predict_index ? pht_33 : _GEN_32; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_34 = 7'h22 == predict_index ? pht_34 : _GEN_33; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_35 = 7'h23 == predict_index ? pht_35 : _GEN_34; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_36 = 7'h24 == predict_index ? pht_36 : _GEN_35; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_37 = 7'h25 == predict_index ? pht_37 : _GEN_36; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_38 = 7'h26 == predict_index ? pht_38 : _GEN_37; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_39 = 7'h27 == predict_index ? pht_39 : _GEN_38; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_40 = 7'h28 == predict_index ? pht_40 : _GEN_39; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_41 = 7'h29 == predict_index ? pht_41 : _GEN_40; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_42 = 7'h2a == predict_index ? pht_42 : _GEN_41; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_43 = 7'h2b == predict_index ? pht_43 : _GEN_42; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_44 = 7'h2c == predict_index ? pht_44 : _GEN_43; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_45 = 7'h2d == predict_index ? pht_45 : _GEN_44; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_46 = 7'h2e == predict_index ? pht_46 : _GEN_45; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_47 = 7'h2f == predict_index ? pht_47 : _GEN_46; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_48 = 7'h30 == predict_index ? pht_48 : _GEN_47; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_49 = 7'h31 == predict_index ? pht_49 : _GEN_48; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_50 = 7'h32 == predict_index ? pht_50 : _GEN_49; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_51 = 7'h33 == predict_index ? pht_51 : _GEN_50; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_52 = 7'h34 == predict_index ? pht_52 : _GEN_51; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_53 = 7'h35 == predict_index ? pht_53 : _GEN_52; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_54 = 7'h36 == predict_index ? pht_54 : _GEN_53; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_55 = 7'h37 == predict_index ? pht_55 : _GEN_54; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_56 = 7'h38 == predict_index ? pht_56 : _GEN_55; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_57 = 7'h39 == predict_index ? pht_57 : _GEN_56; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_58 = 7'h3a == predict_index ? pht_58 : _GEN_57; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_59 = 7'h3b == predict_index ? pht_59 : _GEN_58; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_60 = 7'h3c == predict_index ? pht_60 : _GEN_59; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_61 = 7'h3d == predict_index ? pht_61 : _GEN_60; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_62 = 7'h3e == predict_index ? pht_62 : _GEN_61; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_63 = 7'h3f == predict_index ? pht_63 : _GEN_62; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_64 = 7'h40 == predict_index ? pht_64 : _GEN_63; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_65 = 7'h41 == predict_index ? pht_65 : _GEN_64; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_66 = 7'h42 == predict_index ? pht_66 : _GEN_65; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_67 = 7'h43 == predict_index ? pht_67 : _GEN_66; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_68 = 7'h44 == predict_index ? pht_68 : _GEN_67; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_69 = 7'h45 == predict_index ? pht_69 : _GEN_68; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_70 = 7'h46 == predict_index ? pht_70 : _GEN_69; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_71 = 7'h47 == predict_index ? pht_71 : _GEN_70; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_72 = 7'h48 == predict_index ? pht_72 : _GEN_71; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_73 = 7'h49 == predict_index ? pht_73 : _GEN_72; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_74 = 7'h4a == predict_index ? pht_74 : _GEN_73; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_75 = 7'h4b == predict_index ? pht_75 : _GEN_74; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_76 = 7'h4c == predict_index ? pht_76 : _GEN_75; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_77 = 7'h4d == predict_index ? pht_77 : _GEN_76; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_78 = 7'h4e == predict_index ? pht_78 : _GEN_77; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_79 = 7'h4f == predict_index ? pht_79 : _GEN_78; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_80 = 7'h50 == predict_index ? pht_80 : _GEN_79; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_81 = 7'h51 == predict_index ? pht_81 : _GEN_80; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_82 = 7'h52 == predict_index ? pht_82 : _GEN_81; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_83 = 7'h53 == predict_index ? pht_83 : _GEN_82; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_84 = 7'h54 == predict_index ? pht_84 : _GEN_83; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_85 = 7'h55 == predict_index ? pht_85 : _GEN_84; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_86 = 7'h56 == predict_index ? pht_86 : _GEN_85; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_87 = 7'h57 == predict_index ? pht_87 : _GEN_86; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_88 = 7'h58 == predict_index ? pht_88 : _GEN_87; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_89 = 7'h59 == predict_index ? pht_89 : _GEN_88; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_90 = 7'h5a == predict_index ? pht_90 : _GEN_89; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_91 = 7'h5b == predict_index ? pht_91 : _GEN_90; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_92 = 7'h5c == predict_index ? pht_92 : _GEN_91; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_93 = 7'h5d == predict_index ? pht_93 : _GEN_92; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_94 = 7'h5e == predict_index ? pht_94 : _GEN_93; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_95 = 7'h5f == predict_index ? pht_95 : _GEN_94; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_96 = 7'h60 == predict_index ? pht_96 : _GEN_95; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_97 = 7'h61 == predict_index ? pht_97 : _GEN_96; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_98 = 7'h62 == predict_index ? pht_98 : _GEN_97; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_99 = 7'h63 == predict_index ? pht_99 : _GEN_98; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_100 = 7'h64 == predict_index ? pht_100 : _GEN_99; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_101 = 7'h65 == predict_index ? pht_101 : _GEN_100; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_102 = 7'h66 == predict_index ? pht_102 : _GEN_101; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_103 = 7'h67 == predict_index ? pht_103 : _GEN_102; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_104 = 7'h68 == predict_index ? pht_104 : _GEN_103; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_105 = 7'h69 == predict_index ? pht_105 : _GEN_104; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_106 = 7'h6a == predict_index ? pht_106 : _GEN_105; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_107 = 7'h6b == predict_index ? pht_107 : _GEN_106; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_108 = 7'h6c == predict_index ? pht_108 : _GEN_107; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_109 = 7'h6d == predict_index ? pht_109 : _GEN_108; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_110 = 7'h6e == predict_index ? pht_110 : _GEN_109; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_111 = 7'h6f == predict_index ? pht_111 : _GEN_110; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_112 = 7'h70 == predict_index ? pht_112 : _GEN_111; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_113 = 7'h71 == predict_index ? pht_113 : _GEN_112; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_114 = 7'h72 == predict_index ? pht_114 : _GEN_113; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_115 = 7'h73 == predict_index ? pht_115 : _GEN_114; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_116 = 7'h74 == predict_index ? pht_116 : _GEN_115; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_117 = 7'h75 == predict_index ? pht_117 : _GEN_116; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_118 = 7'h76 == predict_index ? pht_118 : _GEN_117; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_119 = 7'h77 == predict_index ? pht_119 : _GEN_118; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_120 = 7'h78 == predict_index ? pht_120 : _GEN_119; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_121 = 7'h79 == predict_index ? pht_121 : _GEN_120; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_122 = 7'h7a == predict_index ? pht_122 : _GEN_121; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_123 = 7'h7b == predict_index ? pht_123 : _GEN_122; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_124 = 7'h7c == predict_index ? pht_124 : _GEN_123; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_125 = 7'h7d == predict_index ? pht_125 : _GEN_124; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_126 = 7'h7e == predict_index ? pht_126 : _GEN_125; // @[dut.scala 35:{39,39}]
  wire [1:0] _GEN_127 = 7'h7f == predict_index ? pht_127 : _GEN_126; // @[dut.scala 35:{39,39}]
  wire  predict_taken = _GEN_127 >= 2'h2; // @[dut.scala 35:39]
  wire [6:0] train_index = io_train_pc ^ io_train_history; // @[dut.scala 41:35]
  wire [1:0] _GEN_129 = 7'h1 == train_index ? pht_1 : pht_0; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_130 = 7'h2 == train_index ? pht_2 : _GEN_129; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_131 = 7'h3 == train_index ? pht_3 : _GEN_130; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_132 = 7'h4 == train_index ? pht_4 : _GEN_131; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_133 = 7'h5 == train_index ? pht_5 : _GEN_132; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_134 = 7'h6 == train_index ? pht_6 : _GEN_133; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_135 = 7'h7 == train_index ? pht_7 : _GEN_134; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_136 = 7'h8 == train_index ? pht_8 : _GEN_135; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_137 = 7'h9 == train_index ? pht_9 : _GEN_136; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_138 = 7'ha == train_index ? pht_10 : _GEN_137; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_139 = 7'hb == train_index ? pht_11 : _GEN_138; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_140 = 7'hc == train_index ? pht_12 : _GEN_139; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_141 = 7'hd == train_index ? pht_13 : _GEN_140; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_142 = 7'he == train_index ? pht_14 : _GEN_141; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_143 = 7'hf == train_index ? pht_15 : _GEN_142; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_144 = 7'h10 == train_index ? pht_16 : _GEN_143; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_145 = 7'h11 == train_index ? pht_17 : _GEN_144; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_146 = 7'h12 == train_index ? pht_18 : _GEN_145; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_147 = 7'h13 == train_index ? pht_19 : _GEN_146; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_148 = 7'h14 == train_index ? pht_20 : _GEN_147; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_149 = 7'h15 == train_index ? pht_21 : _GEN_148; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_150 = 7'h16 == train_index ? pht_22 : _GEN_149; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_151 = 7'h17 == train_index ? pht_23 : _GEN_150; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_152 = 7'h18 == train_index ? pht_24 : _GEN_151; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_153 = 7'h19 == train_index ? pht_25 : _GEN_152; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_154 = 7'h1a == train_index ? pht_26 : _GEN_153; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_155 = 7'h1b == train_index ? pht_27 : _GEN_154; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_156 = 7'h1c == train_index ? pht_28 : _GEN_155; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_157 = 7'h1d == train_index ? pht_29 : _GEN_156; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_158 = 7'h1e == train_index ? pht_30 : _GEN_157; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_159 = 7'h1f == train_index ? pht_31 : _GEN_158; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_160 = 7'h20 == train_index ? pht_32 : _GEN_159; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_161 = 7'h21 == train_index ? pht_33 : _GEN_160; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_162 = 7'h22 == train_index ? pht_34 : _GEN_161; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_163 = 7'h23 == train_index ? pht_35 : _GEN_162; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_164 = 7'h24 == train_index ? pht_36 : _GEN_163; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_165 = 7'h25 == train_index ? pht_37 : _GEN_164; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_166 = 7'h26 == train_index ? pht_38 : _GEN_165; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_167 = 7'h27 == train_index ? pht_39 : _GEN_166; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_168 = 7'h28 == train_index ? pht_40 : _GEN_167; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_169 = 7'h29 == train_index ? pht_41 : _GEN_168; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_170 = 7'h2a == train_index ? pht_42 : _GEN_169; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_171 = 7'h2b == train_index ? pht_43 : _GEN_170; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_172 = 7'h2c == train_index ? pht_44 : _GEN_171; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_173 = 7'h2d == train_index ? pht_45 : _GEN_172; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_174 = 7'h2e == train_index ? pht_46 : _GEN_173; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_175 = 7'h2f == train_index ? pht_47 : _GEN_174; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_176 = 7'h30 == train_index ? pht_48 : _GEN_175; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_177 = 7'h31 == train_index ? pht_49 : _GEN_176; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_178 = 7'h32 == train_index ? pht_50 : _GEN_177; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_179 = 7'h33 == train_index ? pht_51 : _GEN_178; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_180 = 7'h34 == train_index ? pht_52 : _GEN_179; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_181 = 7'h35 == train_index ? pht_53 : _GEN_180; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_182 = 7'h36 == train_index ? pht_54 : _GEN_181; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_183 = 7'h37 == train_index ? pht_55 : _GEN_182; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_184 = 7'h38 == train_index ? pht_56 : _GEN_183; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_185 = 7'h39 == train_index ? pht_57 : _GEN_184; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_186 = 7'h3a == train_index ? pht_58 : _GEN_185; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_187 = 7'h3b == train_index ? pht_59 : _GEN_186; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_188 = 7'h3c == train_index ? pht_60 : _GEN_187; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_189 = 7'h3d == train_index ? pht_61 : _GEN_188; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_190 = 7'h3e == train_index ? pht_62 : _GEN_189; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_191 = 7'h3f == train_index ? pht_63 : _GEN_190; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_192 = 7'h40 == train_index ? pht_64 : _GEN_191; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_193 = 7'h41 == train_index ? pht_65 : _GEN_192; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_194 = 7'h42 == train_index ? pht_66 : _GEN_193; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_195 = 7'h43 == train_index ? pht_67 : _GEN_194; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_196 = 7'h44 == train_index ? pht_68 : _GEN_195; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_197 = 7'h45 == train_index ? pht_69 : _GEN_196; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_198 = 7'h46 == train_index ? pht_70 : _GEN_197; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_199 = 7'h47 == train_index ? pht_71 : _GEN_198; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_200 = 7'h48 == train_index ? pht_72 : _GEN_199; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_201 = 7'h49 == train_index ? pht_73 : _GEN_200; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_202 = 7'h4a == train_index ? pht_74 : _GEN_201; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_203 = 7'h4b == train_index ? pht_75 : _GEN_202; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_204 = 7'h4c == train_index ? pht_76 : _GEN_203; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_205 = 7'h4d == train_index ? pht_77 : _GEN_204; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_206 = 7'h4e == train_index ? pht_78 : _GEN_205; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_207 = 7'h4f == train_index ? pht_79 : _GEN_206; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_208 = 7'h50 == train_index ? pht_80 : _GEN_207; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_209 = 7'h51 == train_index ? pht_81 : _GEN_208; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_210 = 7'h52 == train_index ? pht_82 : _GEN_209; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_211 = 7'h53 == train_index ? pht_83 : _GEN_210; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_212 = 7'h54 == train_index ? pht_84 : _GEN_211; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_213 = 7'h55 == train_index ? pht_85 : _GEN_212; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_214 = 7'h56 == train_index ? pht_86 : _GEN_213; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_215 = 7'h57 == train_index ? pht_87 : _GEN_214; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_216 = 7'h58 == train_index ? pht_88 : _GEN_215; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_217 = 7'h59 == train_index ? pht_89 : _GEN_216; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_218 = 7'h5a == train_index ? pht_90 : _GEN_217; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_219 = 7'h5b == train_index ? pht_91 : _GEN_218; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_220 = 7'h5c == train_index ? pht_92 : _GEN_219; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_221 = 7'h5d == train_index ? pht_93 : _GEN_220; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_222 = 7'h5e == train_index ? pht_94 : _GEN_221; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_223 = 7'h5f == train_index ? pht_95 : _GEN_222; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_224 = 7'h60 == train_index ? pht_96 : _GEN_223; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_225 = 7'h61 == train_index ? pht_97 : _GEN_224; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_226 = 7'h62 == train_index ? pht_98 : _GEN_225; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_227 = 7'h63 == train_index ? pht_99 : _GEN_226; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_228 = 7'h64 == train_index ? pht_100 : _GEN_227; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_229 = 7'h65 == train_index ? pht_101 : _GEN_228; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_230 = 7'h66 == train_index ? pht_102 : _GEN_229; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_231 = 7'h67 == train_index ? pht_103 : _GEN_230; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_232 = 7'h68 == train_index ? pht_104 : _GEN_231; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_233 = 7'h69 == train_index ? pht_105 : _GEN_232; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_234 = 7'h6a == train_index ? pht_106 : _GEN_233; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_235 = 7'h6b == train_index ? pht_107 : _GEN_234; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_236 = 7'h6c == train_index ? pht_108 : _GEN_235; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_237 = 7'h6d == train_index ? pht_109 : _GEN_236; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_238 = 7'h6e == train_index ? pht_110 : _GEN_237; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_239 = 7'h6f == train_index ? pht_111 : _GEN_238; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_240 = 7'h70 == train_index ? pht_112 : _GEN_239; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_241 = 7'h71 == train_index ? pht_113 : _GEN_240; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_242 = 7'h72 == train_index ? pht_114 : _GEN_241; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_243 = 7'h73 == train_index ? pht_115 : _GEN_242; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_244 = 7'h74 == train_index ? pht_116 : _GEN_243; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_245 = 7'h75 == train_index ? pht_117 : _GEN_244; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_246 = 7'h76 == train_index ? pht_118 : _GEN_245; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_247 = 7'h77 == train_index ? pht_119 : _GEN_246; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_248 = 7'h78 == train_index ? pht_120 : _GEN_247; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_249 = 7'h79 == train_index ? pht_121 : _GEN_248; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_250 = 7'h7a == train_index ? pht_122 : _GEN_249; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_251 = 7'h7b == train_index ? pht_123 : _GEN_250; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_252 = 7'h7c == train_index ? pht_124 : _GEN_251; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_253 = 7'h7d == train_index ? pht_125 : _GEN_252; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_254 = 7'h7e == train_index ? pht_126 : _GEN_253; // @[dut.scala 46:{45,45}]
  wire [1:0] _GEN_255 = 7'h7f == train_index ? pht_127 : _GEN_254; // @[dut.scala 46:{45,45}]
  wire [1:0] _pht_T_2 = _GEN_255 + 2'h1; // @[dut.scala 46:89]
  wire [1:0] _pht_T_3 = _GEN_255 == 2'h3 ? 2'h3 : _pht_T_2; // @[dut.scala 46:30]
  wire [1:0] _GEN_256 = 7'h0 == train_index ? _pht_T_3 : pht_0; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_257 = 7'h1 == train_index ? _pht_T_3 : pht_1; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_258 = 7'h2 == train_index ? _pht_T_3 : pht_2; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_259 = 7'h3 == train_index ? _pht_T_3 : pht_3; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_260 = 7'h4 == train_index ? _pht_T_3 : pht_4; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_261 = 7'h5 == train_index ? _pht_T_3 : pht_5; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_262 = 7'h6 == train_index ? _pht_T_3 : pht_6; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_263 = 7'h7 == train_index ? _pht_T_3 : pht_7; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_264 = 7'h8 == train_index ? _pht_T_3 : pht_8; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_265 = 7'h9 == train_index ? _pht_T_3 : pht_9; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_266 = 7'ha == train_index ? _pht_T_3 : pht_10; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_267 = 7'hb == train_index ? _pht_T_3 : pht_11; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_268 = 7'hc == train_index ? _pht_T_3 : pht_12; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_269 = 7'hd == train_index ? _pht_T_3 : pht_13; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_270 = 7'he == train_index ? _pht_T_3 : pht_14; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_271 = 7'hf == train_index ? _pht_T_3 : pht_15; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_272 = 7'h10 == train_index ? _pht_T_3 : pht_16; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_273 = 7'h11 == train_index ? _pht_T_3 : pht_17; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_274 = 7'h12 == train_index ? _pht_T_3 : pht_18; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_275 = 7'h13 == train_index ? _pht_T_3 : pht_19; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_276 = 7'h14 == train_index ? _pht_T_3 : pht_20; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_277 = 7'h15 == train_index ? _pht_T_3 : pht_21; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_278 = 7'h16 == train_index ? _pht_T_3 : pht_22; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_279 = 7'h17 == train_index ? _pht_T_3 : pht_23; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_280 = 7'h18 == train_index ? _pht_T_3 : pht_24; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_281 = 7'h19 == train_index ? _pht_T_3 : pht_25; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_282 = 7'h1a == train_index ? _pht_T_3 : pht_26; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_283 = 7'h1b == train_index ? _pht_T_3 : pht_27; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_284 = 7'h1c == train_index ? _pht_T_3 : pht_28; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_285 = 7'h1d == train_index ? _pht_T_3 : pht_29; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_286 = 7'h1e == train_index ? _pht_T_3 : pht_30; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_287 = 7'h1f == train_index ? _pht_T_3 : pht_31; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_288 = 7'h20 == train_index ? _pht_T_3 : pht_32; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_289 = 7'h21 == train_index ? _pht_T_3 : pht_33; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_290 = 7'h22 == train_index ? _pht_T_3 : pht_34; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_291 = 7'h23 == train_index ? _pht_T_3 : pht_35; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_292 = 7'h24 == train_index ? _pht_T_3 : pht_36; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_293 = 7'h25 == train_index ? _pht_T_3 : pht_37; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_294 = 7'h26 == train_index ? _pht_T_3 : pht_38; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_295 = 7'h27 == train_index ? _pht_T_3 : pht_39; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_296 = 7'h28 == train_index ? _pht_T_3 : pht_40; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_297 = 7'h29 == train_index ? _pht_T_3 : pht_41; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_298 = 7'h2a == train_index ? _pht_T_3 : pht_42; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_299 = 7'h2b == train_index ? _pht_T_3 : pht_43; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_300 = 7'h2c == train_index ? _pht_T_3 : pht_44; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_301 = 7'h2d == train_index ? _pht_T_3 : pht_45; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_302 = 7'h2e == train_index ? _pht_T_3 : pht_46; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_303 = 7'h2f == train_index ? _pht_T_3 : pht_47; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_304 = 7'h30 == train_index ? _pht_T_3 : pht_48; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_305 = 7'h31 == train_index ? _pht_T_3 : pht_49; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_306 = 7'h32 == train_index ? _pht_T_3 : pht_50; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_307 = 7'h33 == train_index ? _pht_T_3 : pht_51; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_308 = 7'h34 == train_index ? _pht_T_3 : pht_52; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_309 = 7'h35 == train_index ? _pht_T_3 : pht_53; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_310 = 7'h36 == train_index ? _pht_T_3 : pht_54; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_311 = 7'h37 == train_index ? _pht_T_3 : pht_55; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_312 = 7'h38 == train_index ? _pht_T_3 : pht_56; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_313 = 7'h39 == train_index ? _pht_T_3 : pht_57; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_314 = 7'h3a == train_index ? _pht_T_3 : pht_58; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_315 = 7'h3b == train_index ? _pht_T_3 : pht_59; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_316 = 7'h3c == train_index ? _pht_T_3 : pht_60; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_317 = 7'h3d == train_index ? _pht_T_3 : pht_61; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_318 = 7'h3e == train_index ? _pht_T_3 : pht_62; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_319 = 7'h3f == train_index ? _pht_T_3 : pht_63; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_320 = 7'h40 == train_index ? _pht_T_3 : pht_64; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_321 = 7'h41 == train_index ? _pht_T_3 : pht_65; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_322 = 7'h42 == train_index ? _pht_T_3 : pht_66; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_323 = 7'h43 == train_index ? _pht_T_3 : pht_67; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_324 = 7'h44 == train_index ? _pht_T_3 : pht_68; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_325 = 7'h45 == train_index ? _pht_T_3 : pht_69; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_326 = 7'h46 == train_index ? _pht_T_3 : pht_70; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_327 = 7'h47 == train_index ? _pht_T_3 : pht_71; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_328 = 7'h48 == train_index ? _pht_T_3 : pht_72; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_329 = 7'h49 == train_index ? _pht_T_3 : pht_73; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_330 = 7'h4a == train_index ? _pht_T_3 : pht_74; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_331 = 7'h4b == train_index ? _pht_T_3 : pht_75; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_332 = 7'h4c == train_index ? _pht_T_3 : pht_76; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_333 = 7'h4d == train_index ? _pht_T_3 : pht_77; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_334 = 7'h4e == train_index ? _pht_T_3 : pht_78; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_335 = 7'h4f == train_index ? _pht_T_3 : pht_79; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_336 = 7'h50 == train_index ? _pht_T_3 : pht_80; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_337 = 7'h51 == train_index ? _pht_T_3 : pht_81; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_338 = 7'h52 == train_index ? _pht_T_3 : pht_82; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_339 = 7'h53 == train_index ? _pht_T_3 : pht_83; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_340 = 7'h54 == train_index ? _pht_T_3 : pht_84; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_341 = 7'h55 == train_index ? _pht_T_3 : pht_85; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_342 = 7'h56 == train_index ? _pht_T_3 : pht_86; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_343 = 7'h57 == train_index ? _pht_T_3 : pht_87; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_344 = 7'h58 == train_index ? _pht_T_3 : pht_88; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_345 = 7'h59 == train_index ? _pht_T_3 : pht_89; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_346 = 7'h5a == train_index ? _pht_T_3 : pht_90; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_347 = 7'h5b == train_index ? _pht_T_3 : pht_91; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_348 = 7'h5c == train_index ? _pht_T_3 : pht_92; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_349 = 7'h5d == train_index ? _pht_T_3 : pht_93; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_350 = 7'h5e == train_index ? _pht_T_3 : pht_94; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_351 = 7'h5f == train_index ? _pht_T_3 : pht_95; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_352 = 7'h60 == train_index ? _pht_T_3 : pht_96; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_353 = 7'h61 == train_index ? _pht_T_3 : pht_97; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_354 = 7'h62 == train_index ? _pht_T_3 : pht_98; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_355 = 7'h63 == train_index ? _pht_T_3 : pht_99; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_356 = 7'h64 == train_index ? _pht_T_3 : pht_100; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_357 = 7'h65 == train_index ? _pht_T_3 : pht_101; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_358 = 7'h66 == train_index ? _pht_T_3 : pht_102; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_359 = 7'h67 == train_index ? _pht_T_3 : pht_103; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_360 = 7'h68 == train_index ? _pht_T_3 : pht_104; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_361 = 7'h69 == train_index ? _pht_T_3 : pht_105; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_362 = 7'h6a == train_index ? _pht_T_3 : pht_106; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_363 = 7'h6b == train_index ? _pht_T_3 : pht_107; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_364 = 7'h6c == train_index ? _pht_T_3 : pht_108; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_365 = 7'h6d == train_index ? _pht_T_3 : pht_109; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_366 = 7'h6e == train_index ? _pht_T_3 : pht_110; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_367 = 7'h6f == train_index ? _pht_T_3 : pht_111; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_368 = 7'h70 == train_index ? _pht_T_3 : pht_112; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_369 = 7'h71 == train_index ? _pht_T_3 : pht_113; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_370 = 7'h72 == train_index ? _pht_T_3 : pht_114; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_371 = 7'h73 == train_index ? _pht_T_3 : pht_115; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_372 = 7'h74 == train_index ? _pht_T_3 : pht_116; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_373 = 7'h75 == train_index ? _pht_T_3 : pht_117; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_374 = 7'h76 == train_index ? _pht_T_3 : pht_118; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_375 = 7'h77 == train_index ? _pht_T_3 : pht_119; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_376 = 7'h78 == train_index ? _pht_T_3 : pht_120; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_377 = 7'h79 == train_index ? _pht_T_3 : pht_121; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_378 = 7'h7a == train_index ? _pht_T_3 : pht_122; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_379 = 7'h7b == train_index ? _pht_T_3 : pht_123; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_380 = 7'h7c == train_index ? _pht_T_3 : pht_124; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_381 = 7'h7d == train_index ? _pht_T_3 : pht_125; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_382 = 7'h7e == train_index ? _pht_T_3 : pht_126; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _GEN_383 = 7'h7f == train_index ? _pht_T_3 : pht_127; // @[dut.scala 29:20 46:{24,24}]
  wire [1:0] _pht_T_6 = _GEN_255 - 2'h1; // @[dut.scala 48:89]
  wire [1:0] _pht_T_7 = _GEN_255 == 2'h0 ? 2'h0 : _pht_T_6; // @[dut.scala 48:30]
  wire [1:0] _GEN_384 = 7'h0 == train_index ? _pht_T_7 : pht_0; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_385 = 7'h1 == train_index ? _pht_T_7 : pht_1; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_386 = 7'h2 == train_index ? _pht_T_7 : pht_2; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_387 = 7'h3 == train_index ? _pht_T_7 : pht_3; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_388 = 7'h4 == train_index ? _pht_T_7 : pht_4; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_389 = 7'h5 == train_index ? _pht_T_7 : pht_5; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_390 = 7'h6 == train_index ? _pht_T_7 : pht_6; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_391 = 7'h7 == train_index ? _pht_T_7 : pht_7; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_392 = 7'h8 == train_index ? _pht_T_7 : pht_8; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_393 = 7'h9 == train_index ? _pht_T_7 : pht_9; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_394 = 7'ha == train_index ? _pht_T_7 : pht_10; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_395 = 7'hb == train_index ? _pht_T_7 : pht_11; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_396 = 7'hc == train_index ? _pht_T_7 : pht_12; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_397 = 7'hd == train_index ? _pht_T_7 : pht_13; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_398 = 7'he == train_index ? _pht_T_7 : pht_14; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_399 = 7'hf == train_index ? _pht_T_7 : pht_15; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_400 = 7'h10 == train_index ? _pht_T_7 : pht_16; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_401 = 7'h11 == train_index ? _pht_T_7 : pht_17; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_402 = 7'h12 == train_index ? _pht_T_7 : pht_18; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_403 = 7'h13 == train_index ? _pht_T_7 : pht_19; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_404 = 7'h14 == train_index ? _pht_T_7 : pht_20; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_405 = 7'h15 == train_index ? _pht_T_7 : pht_21; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_406 = 7'h16 == train_index ? _pht_T_7 : pht_22; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_407 = 7'h17 == train_index ? _pht_T_7 : pht_23; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_408 = 7'h18 == train_index ? _pht_T_7 : pht_24; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_409 = 7'h19 == train_index ? _pht_T_7 : pht_25; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_410 = 7'h1a == train_index ? _pht_T_7 : pht_26; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_411 = 7'h1b == train_index ? _pht_T_7 : pht_27; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_412 = 7'h1c == train_index ? _pht_T_7 : pht_28; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_413 = 7'h1d == train_index ? _pht_T_7 : pht_29; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_414 = 7'h1e == train_index ? _pht_T_7 : pht_30; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_415 = 7'h1f == train_index ? _pht_T_7 : pht_31; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_416 = 7'h20 == train_index ? _pht_T_7 : pht_32; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_417 = 7'h21 == train_index ? _pht_T_7 : pht_33; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_418 = 7'h22 == train_index ? _pht_T_7 : pht_34; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_419 = 7'h23 == train_index ? _pht_T_7 : pht_35; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_420 = 7'h24 == train_index ? _pht_T_7 : pht_36; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_421 = 7'h25 == train_index ? _pht_T_7 : pht_37; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_422 = 7'h26 == train_index ? _pht_T_7 : pht_38; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_423 = 7'h27 == train_index ? _pht_T_7 : pht_39; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_424 = 7'h28 == train_index ? _pht_T_7 : pht_40; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_425 = 7'h29 == train_index ? _pht_T_7 : pht_41; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_426 = 7'h2a == train_index ? _pht_T_7 : pht_42; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_427 = 7'h2b == train_index ? _pht_T_7 : pht_43; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_428 = 7'h2c == train_index ? _pht_T_7 : pht_44; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_429 = 7'h2d == train_index ? _pht_T_7 : pht_45; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_430 = 7'h2e == train_index ? _pht_T_7 : pht_46; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_431 = 7'h2f == train_index ? _pht_T_7 : pht_47; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_432 = 7'h30 == train_index ? _pht_T_7 : pht_48; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_433 = 7'h31 == train_index ? _pht_T_7 : pht_49; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_434 = 7'h32 == train_index ? _pht_T_7 : pht_50; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_435 = 7'h33 == train_index ? _pht_T_7 : pht_51; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_436 = 7'h34 == train_index ? _pht_T_7 : pht_52; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_437 = 7'h35 == train_index ? _pht_T_7 : pht_53; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_438 = 7'h36 == train_index ? _pht_T_7 : pht_54; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_439 = 7'h37 == train_index ? _pht_T_7 : pht_55; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_440 = 7'h38 == train_index ? _pht_T_7 : pht_56; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_441 = 7'h39 == train_index ? _pht_T_7 : pht_57; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_442 = 7'h3a == train_index ? _pht_T_7 : pht_58; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_443 = 7'h3b == train_index ? _pht_T_7 : pht_59; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_444 = 7'h3c == train_index ? _pht_T_7 : pht_60; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_445 = 7'h3d == train_index ? _pht_T_7 : pht_61; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_446 = 7'h3e == train_index ? _pht_T_7 : pht_62; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_447 = 7'h3f == train_index ? _pht_T_7 : pht_63; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_448 = 7'h40 == train_index ? _pht_T_7 : pht_64; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_449 = 7'h41 == train_index ? _pht_T_7 : pht_65; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_450 = 7'h42 == train_index ? _pht_T_7 : pht_66; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_451 = 7'h43 == train_index ? _pht_T_7 : pht_67; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_452 = 7'h44 == train_index ? _pht_T_7 : pht_68; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_453 = 7'h45 == train_index ? _pht_T_7 : pht_69; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_454 = 7'h46 == train_index ? _pht_T_7 : pht_70; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_455 = 7'h47 == train_index ? _pht_T_7 : pht_71; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_456 = 7'h48 == train_index ? _pht_T_7 : pht_72; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_457 = 7'h49 == train_index ? _pht_T_7 : pht_73; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_458 = 7'h4a == train_index ? _pht_T_7 : pht_74; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_459 = 7'h4b == train_index ? _pht_T_7 : pht_75; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_460 = 7'h4c == train_index ? _pht_T_7 : pht_76; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_461 = 7'h4d == train_index ? _pht_T_7 : pht_77; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_462 = 7'h4e == train_index ? _pht_T_7 : pht_78; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_463 = 7'h4f == train_index ? _pht_T_7 : pht_79; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_464 = 7'h50 == train_index ? _pht_T_7 : pht_80; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_465 = 7'h51 == train_index ? _pht_T_7 : pht_81; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_466 = 7'h52 == train_index ? _pht_T_7 : pht_82; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_467 = 7'h53 == train_index ? _pht_T_7 : pht_83; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_468 = 7'h54 == train_index ? _pht_T_7 : pht_84; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_469 = 7'h55 == train_index ? _pht_T_7 : pht_85; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_470 = 7'h56 == train_index ? _pht_T_7 : pht_86; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_471 = 7'h57 == train_index ? _pht_T_7 : pht_87; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_472 = 7'h58 == train_index ? _pht_T_7 : pht_88; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_473 = 7'h59 == train_index ? _pht_T_7 : pht_89; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_474 = 7'h5a == train_index ? _pht_T_7 : pht_90; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_475 = 7'h5b == train_index ? _pht_T_7 : pht_91; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_476 = 7'h5c == train_index ? _pht_T_7 : pht_92; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_477 = 7'h5d == train_index ? _pht_T_7 : pht_93; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_478 = 7'h5e == train_index ? _pht_T_7 : pht_94; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_479 = 7'h5f == train_index ? _pht_T_7 : pht_95; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_480 = 7'h60 == train_index ? _pht_T_7 : pht_96; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_481 = 7'h61 == train_index ? _pht_T_7 : pht_97; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_482 = 7'h62 == train_index ? _pht_T_7 : pht_98; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_483 = 7'h63 == train_index ? _pht_T_7 : pht_99; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_484 = 7'h64 == train_index ? _pht_T_7 : pht_100; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_485 = 7'h65 == train_index ? _pht_T_7 : pht_101; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_486 = 7'h66 == train_index ? _pht_T_7 : pht_102; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_487 = 7'h67 == train_index ? _pht_T_7 : pht_103; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_488 = 7'h68 == train_index ? _pht_T_7 : pht_104; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_489 = 7'h69 == train_index ? _pht_T_7 : pht_105; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_490 = 7'h6a == train_index ? _pht_T_7 : pht_106; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_491 = 7'h6b == train_index ? _pht_T_7 : pht_107; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_492 = 7'h6c == train_index ? _pht_T_7 : pht_108; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_493 = 7'h6d == train_index ? _pht_T_7 : pht_109; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_494 = 7'h6e == train_index ? _pht_T_7 : pht_110; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_495 = 7'h6f == train_index ? _pht_T_7 : pht_111; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_496 = 7'h70 == train_index ? _pht_T_7 : pht_112; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_497 = 7'h71 == train_index ? _pht_T_7 : pht_113; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_498 = 7'h72 == train_index ? _pht_T_7 : pht_114; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_499 = 7'h73 == train_index ? _pht_T_7 : pht_115; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_500 = 7'h74 == train_index ? _pht_T_7 : pht_116; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_501 = 7'h75 == train_index ? _pht_T_7 : pht_117; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_502 = 7'h76 == train_index ? _pht_T_7 : pht_118; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_503 = 7'h77 == train_index ? _pht_T_7 : pht_119; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_504 = 7'h78 == train_index ? _pht_T_7 : pht_120; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_505 = 7'h79 == train_index ? _pht_T_7 : pht_121; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_506 = 7'h7a == train_index ? _pht_T_7 : pht_122; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_507 = 7'h7b == train_index ? _pht_T_7 : pht_123; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_508 = 7'h7c == train_index ? _pht_T_7 : pht_124; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_509 = 7'h7d == train_index ? _pht_T_7 : pht_125; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_510 = 7'h7e == train_index ? _pht_T_7 : pht_126; // @[dut.scala 29:20 48:{24,24}]
  wire [1:0] _GEN_511 = 7'h7f == train_index ? _pht_T_7 : pht_127; // @[dut.scala 29:20 48:{24,24}]
  wire [6:0] _GEN_640 = io_train_mispredicted ? io_train_history : global_history; // @[dut.scala 52:33 53:22 30:31]
  wire [6:0] _global_history_T_1 = {global_history[5:0],predict_taken}; // @[Cat.scala 33:92]
  assign io_predict_taken = _GEN_127 >= 2'h2; // @[dut.scala 35:39]
  assign io_predict_history = global_history; // @[dut.scala 37:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 29:20]
      pht_0 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_0 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_0 <= _GEN_256;
      end else begin
        pht_0 <= _GEN_384;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_1 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_1 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_1 <= _GEN_257;
      end else begin
        pht_1 <= _GEN_385;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_2 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_2 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_2 <= _GEN_258;
      end else begin
        pht_2 <= _GEN_386;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_3 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_3 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_3 <= _GEN_259;
      end else begin
        pht_3 <= _GEN_387;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_4 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_4 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_4 <= _GEN_260;
      end else begin
        pht_4 <= _GEN_388;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_5 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_5 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_5 <= _GEN_261;
      end else begin
        pht_5 <= _GEN_389;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_6 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_6 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_6 <= _GEN_262;
      end else begin
        pht_6 <= _GEN_390;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_7 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_7 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_7 <= _GEN_263;
      end else begin
        pht_7 <= _GEN_391;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_8 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_8 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_8 <= _GEN_264;
      end else begin
        pht_8 <= _GEN_392;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_9 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_9 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_9 <= _GEN_265;
      end else begin
        pht_9 <= _GEN_393;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_10 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_10 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_10 <= _GEN_266;
      end else begin
        pht_10 <= _GEN_394;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_11 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_11 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_11 <= _GEN_267;
      end else begin
        pht_11 <= _GEN_395;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_12 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_12 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_12 <= _GEN_268;
      end else begin
        pht_12 <= _GEN_396;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_13 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_13 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_13 <= _GEN_269;
      end else begin
        pht_13 <= _GEN_397;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_14 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_14 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_14 <= _GEN_270;
      end else begin
        pht_14 <= _GEN_398;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_15 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_15 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_15 <= _GEN_271;
      end else begin
        pht_15 <= _GEN_399;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_16 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_16 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_16 <= _GEN_272;
      end else begin
        pht_16 <= _GEN_400;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_17 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_17 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_17 <= _GEN_273;
      end else begin
        pht_17 <= _GEN_401;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_18 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_18 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_18 <= _GEN_274;
      end else begin
        pht_18 <= _GEN_402;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_19 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_19 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_19 <= _GEN_275;
      end else begin
        pht_19 <= _GEN_403;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_20 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_20 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_20 <= _GEN_276;
      end else begin
        pht_20 <= _GEN_404;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_21 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_21 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_21 <= _GEN_277;
      end else begin
        pht_21 <= _GEN_405;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_22 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_22 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_22 <= _GEN_278;
      end else begin
        pht_22 <= _GEN_406;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_23 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_23 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_23 <= _GEN_279;
      end else begin
        pht_23 <= _GEN_407;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_24 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_24 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_24 <= _GEN_280;
      end else begin
        pht_24 <= _GEN_408;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_25 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_25 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_25 <= _GEN_281;
      end else begin
        pht_25 <= _GEN_409;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_26 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_26 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_26 <= _GEN_282;
      end else begin
        pht_26 <= _GEN_410;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_27 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_27 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_27 <= _GEN_283;
      end else begin
        pht_27 <= _GEN_411;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_28 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_28 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_28 <= _GEN_284;
      end else begin
        pht_28 <= _GEN_412;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_29 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_29 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_29 <= _GEN_285;
      end else begin
        pht_29 <= _GEN_413;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_30 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_30 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_30 <= _GEN_286;
      end else begin
        pht_30 <= _GEN_414;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_31 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_31 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_31 <= _GEN_287;
      end else begin
        pht_31 <= _GEN_415;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_32 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_32 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_32 <= _GEN_288;
      end else begin
        pht_32 <= _GEN_416;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_33 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_33 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_33 <= _GEN_289;
      end else begin
        pht_33 <= _GEN_417;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_34 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_34 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_34 <= _GEN_290;
      end else begin
        pht_34 <= _GEN_418;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_35 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_35 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_35 <= _GEN_291;
      end else begin
        pht_35 <= _GEN_419;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_36 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_36 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_36 <= _GEN_292;
      end else begin
        pht_36 <= _GEN_420;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_37 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_37 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_37 <= _GEN_293;
      end else begin
        pht_37 <= _GEN_421;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_38 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_38 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_38 <= _GEN_294;
      end else begin
        pht_38 <= _GEN_422;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_39 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_39 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_39 <= _GEN_295;
      end else begin
        pht_39 <= _GEN_423;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_40 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_40 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_40 <= _GEN_296;
      end else begin
        pht_40 <= _GEN_424;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_41 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_41 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_41 <= _GEN_297;
      end else begin
        pht_41 <= _GEN_425;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_42 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_42 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_42 <= _GEN_298;
      end else begin
        pht_42 <= _GEN_426;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_43 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_43 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_43 <= _GEN_299;
      end else begin
        pht_43 <= _GEN_427;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_44 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_44 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_44 <= _GEN_300;
      end else begin
        pht_44 <= _GEN_428;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_45 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_45 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_45 <= _GEN_301;
      end else begin
        pht_45 <= _GEN_429;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_46 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_46 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_46 <= _GEN_302;
      end else begin
        pht_46 <= _GEN_430;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_47 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_47 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_47 <= _GEN_303;
      end else begin
        pht_47 <= _GEN_431;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_48 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_48 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_48 <= _GEN_304;
      end else begin
        pht_48 <= _GEN_432;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_49 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_49 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_49 <= _GEN_305;
      end else begin
        pht_49 <= _GEN_433;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_50 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_50 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_50 <= _GEN_306;
      end else begin
        pht_50 <= _GEN_434;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_51 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_51 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_51 <= _GEN_307;
      end else begin
        pht_51 <= _GEN_435;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_52 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_52 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_52 <= _GEN_308;
      end else begin
        pht_52 <= _GEN_436;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_53 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_53 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_53 <= _GEN_309;
      end else begin
        pht_53 <= _GEN_437;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_54 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_54 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_54 <= _GEN_310;
      end else begin
        pht_54 <= _GEN_438;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_55 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_55 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_55 <= _GEN_311;
      end else begin
        pht_55 <= _GEN_439;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_56 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_56 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_56 <= _GEN_312;
      end else begin
        pht_56 <= _GEN_440;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_57 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_57 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_57 <= _GEN_313;
      end else begin
        pht_57 <= _GEN_441;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_58 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_58 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_58 <= _GEN_314;
      end else begin
        pht_58 <= _GEN_442;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_59 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_59 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_59 <= _GEN_315;
      end else begin
        pht_59 <= _GEN_443;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_60 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_60 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_60 <= _GEN_316;
      end else begin
        pht_60 <= _GEN_444;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_61 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_61 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_61 <= _GEN_317;
      end else begin
        pht_61 <= _GEN_445;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_62 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_62 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_62 <= _GEN_318;
      end else begin
        pht_62 <= _GEN_446;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_63 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_63 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_63 <= _GEN_319;
      end else begin
        pht_63 <= _GEN_447;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_64 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_64 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_64 <= _GEN_320;
      end else begin
        pht_64 <= _GEN_448;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_65 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_65 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_65 <= _GEN_321;
      end else begin
        pht_65 <= _GEN_449;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_66 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_66 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_66 <= _GEN_322;
      end else begin
        pht_66 <= _GEN_450;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_67 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_67 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_67 <= _GEN_323;
      end else begin
        pht_67 <= _GEN_451;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_68 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_68 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_68 <= _GEN_324;
      end else begin
        pht_68 <= _GEN_452;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_69 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_69 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_69 <= _GEN_325;
      end else begin
        pht_69 <= _GEN_453;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_70 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_70 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_70 <= _GEN_326;
      end else begin
        pht_70 <= _GEN_454;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_71 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_71 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_71 <= _GEN_327;
      end else begin
        pht_71 <= _GEN_455;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_72 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_72 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_72 <= _GEN_328;
      end else begin
        pht_72 <= _GEN_456;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_73 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_73 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_73 <= _GEN_329;
      end else begin
        pht_73 <= _GEN_457;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_74 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_74 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_74 <= _GEN_330;
      end else begin
        pht_74 <= _GEN_458;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_75 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_75 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_75 <= _GEN_331;
      end else begin
        pht_75 <= _GEN_459;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_76 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_76 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_76 <= _GEN_332;
      end else begin
        pht_76 <= _GEN_460;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_77 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_77 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_77 <= _GEN_333;
      end else begin
        pht_77 <= _GEN_461;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_78 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_78 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_78 <= _GEN_334;
      end else begin
        pht_78 <= _GEN_462;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_79 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_79 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_79 <= _GEN_335;
      end else begin
        pht_79 <= _GEN_463;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_80 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_80 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_80 <= _GEN_336;
      end else begin
        pht_80 <= _GEN_464;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_81 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_81 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_81 <= _GEN_337;
      end else begin
        pht_81 <= _GEN_465;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_82 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_82 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_82 <= _GEN_338;
      end else begin
        pht_82 <= _GEN_466;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_83 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_83 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_83 <= _GEN_339;
      end else begin
        pht_83 <= _GEN_467;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_84 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_84 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_84 <= _GEN_340;
      end else begin
        pht_84 <= _GEN_468;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_85 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_85 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_85 <= _GEN_341;
      end else begin
        pht_85 <= _GEN_469;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_86 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_86 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_86 <= _GEN_342;
      end else begin
        pht_86 <= _GEN_470;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_87 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_87 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_87 <= _GEN_343;
      end else begin
        pht_87 <= _GEN_471;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_88 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_88 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_88 <= _GEN_344;
      end else begin
        pht_88 <= _GEN_472;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_89 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_89 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_89 <= _GEN_345;
      end else begin
        pht_89 <= _GEN_473;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_90 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_90 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_90 <= _GEN_346;
      end else begin
        pht_90 <= _GEN_474;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_91 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_91 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_91 <= _GEN_347;
      end else begin
        pht_91 <= _GEN_475;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_92 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_92 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_92 <= _GEN_348;
      end else begin
        pht_92 <= _GEN_476;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_93 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_93 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_93 <= _GEN_349;
      end else begin
        pht_93 <= _GEN_477;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_94 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_94 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_94 <= _GEN_350;
      end else begin
        pht_94 <= _GEN_478;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_95 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_95 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_95 <= _GEN_351;
      end else begin
        pht_95 <= _GEN_479;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_96 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_96 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_96 <= _GEN_352;
      end else begin
        pht_96 <= _GEN_480;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_97 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_97 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_97 <= _GEN_353;
      end else begin
        pht_97 <= _GEN_481;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_98 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_98 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_98 <= _GEN_354;
      end else begin
        pht_98 <= _GEN_482;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_99 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_99 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_99 <= _GEN_355;
      end else begin
        pht_99 <= _GEN_483;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_100 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_100 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_100 <= _GEN_356;
      end else begin
        pht_100 <= _GEN_484;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_101 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_101 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_101 <= _GEN_357;
      end else begin
        pht_101 <= _GEN_485;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_102 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_102 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_102 <= _GEN_358;
      end else begin
        pht_102 <= _GEN_486;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_103 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_103 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_103 <= _GEN_359;
      end else begin
        pht_103 <= _GEN_487;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_104 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_104 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_104 <= _GEN_360;
      end else begin
        pht_104 <= _GEN_488;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_105 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_105 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_105 <= _GEN_361;
      end else begin
        pht_105 <= _GEN_489;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_106 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_106 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_106 <= _GEN_362;
      end else begin
        pht_106 <= _GEN_490;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_107 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_107 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_107 <= _GEN_363;
      end else begin
        pht_107 <= _GEN_491;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_108 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_108 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_108 <= _GEN_364;
      end else begin
        pht_108 <= _GEN_492;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_109 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_109 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_109 <= _GEN_365;
      end else begin
        pht_109 <= _GEN_493;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_110 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_110 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_110 <= _GEN_366;
      end else begin
        pht_110 <= _GEN_494;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_111 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_111 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_111 <= _GEN_367;
      end else begin
        pht_111 <= _GEN_495;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_112 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_112 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_112 <= _GEN_368;
      end else begin
        pht_112 <= _GEN_496;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_113 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_113 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_113 <= _GEN_369;
      end else begin
        pht_113 <= _GEN_497;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_114 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_114 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_114 <= _GEN_370;
      end else begin
        pht_114 <= _GEN_498;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_115 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_115 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_115 <= _GEN_371;
      end else begin
        pht_115 <= _GEN_499;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_116 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_116 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_116 <= _GEN_372;
      end else begin
        pht_116 <= _GEN_500;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_117 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_117 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_117 <= _GEN_373;
      end else begin
        pht_117 <= _GEN_501;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_118 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_118 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_118 <= _GEN_374;
      end else begin
        pht_118 <= _GEN_502;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_119 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_119 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_119 <= _GEN_375;
      end else begin
        pht_119 <= _GEN_503;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_120 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_120 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_120 <= _GEN_376;
      end else begin
        pht_120 <= _GEN_504;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_121 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_121 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_121 <= _GEN_377;
      end else begin
        pht_121 <= _GEN_505;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_122 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_122 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_122 <= _GEN_378;
      end else begin
        pht_122 <= _GEN_506;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_123 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_123 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_123 <= _GEN_379;
      end else begin
        pht_123 <= _GEN_507;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_124 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_124 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_124 <= _GEN_380;
      end else begin
        pht_124 <= _GEN_508;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_125 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_125 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_125 <= _GEN_381;
      end else begin
        pht_125 <= _GEN_509;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_126 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_126 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_126 <= _GEN_382;
      end else begin
        pht_126 <= _GEN_510;
      end
    end
    if (reset) begin // @[dut.scala 29:20]
      pht_127 <= 2'h2; // @[dut.scala 29:20]
    end else if (io_reset) begin // @[dut.scala 64:18]
      pht_127 <= 2'h2; // @[dut.scala 67:14]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      if (io_train_taken) begin // @[dut.scala 45:26]
        pht_127 <= _GEN_383;
      end else begin
        pht_127 <= _GEN_511;
      end
    end
    if (reset) begin // @[dut.scala 30:31]
      global_history <= 7'h0; // @[dut.scala 30:31]
    end else if (io_reset) begin // @[dut.scala 64:18]
      global_history <= 7'h0; // @[dut.scala 65:20]
    end else if (io_predict_valid & ~io_reset) begin // @[dut.scala 58:39]
      global_history <= _global_history_T_1; // @[dut.scala 60:20]
    end else if (io_train_valid) begin // @[dut.scala 40:24]
      global_history <= _GEN_640;
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
  pht_0 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  pht_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  pht_2 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  pht_3 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  pht_4 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  pht_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  pht_6 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  pht_7 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  pht_8 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  pht_9 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  pht_10 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  pht_11 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  pht_12 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  pht_13 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  pht_14 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  pht_15 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  pht_16 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  pht_17 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  pht_18 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  pht_19 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  pht_20 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  pht_21 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  pht_22 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  pht_23 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  pht_24 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  pht_25 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  pht_26 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  pht_27 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  pht_28 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  pht_29 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  pht_30 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  pht_31 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  pht_32 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  pht_33 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  pht_34 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  pht_35 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  pht_36 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  pht_37 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  pht_38 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  pht_39 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  pht_40 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  pht_41 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  pht_42 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  pht_43 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  pht_44 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  pht_45 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  pht_46 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  pht_47 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  pht_48 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  pht_49 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  pht_50 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  pht_51 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  pht_52 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  pht_53 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  pht_54 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  pht_55 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  pht_56 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  pht_57 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  pht_58 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  pht_59 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  pht_60 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  pht_61 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  pht_62 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  pht_63 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  pht_64 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  pht_65 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  pht_66 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  pht_67 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  pht_68 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  pht_69 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  pht_70 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  pht_71 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  pht_72 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  pht_73 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  pht_74 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  pht_75 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  pht_76 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  pht_77 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  pht_78 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  pht_79 = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  pht_80 = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  pht_81 = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  pht_82 = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  pht_83 = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  pht_84 = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  pht_85 = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  pht_86 = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  pht_87 = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  pht_88 = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  pht_89 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  pht_90 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  pht_91 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  pht_92 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  pht_93 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  pht_94 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  pht_95 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  pht_96 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  pht_97 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  pht_98 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  pht_99 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  pht_100 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  pht_101 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  pht_102 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  pht_103 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  pht_104 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  pht_105 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  pht_106 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  pht_107 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  pht_108 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  pht_109 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  pht_110 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  pht_111 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  pht_112 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  pht_113 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  pht_114 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  pht_115 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  pht_116 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  pht_117 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  pht_118 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  pht_119 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  pht_120 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  pht_121 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  pht_122 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  pht_123 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  pht_124 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  pht_125 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  pht_126 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  pht_127 = _RAND_127[1:0];
  _RAND_128 = {1{`RANDOM}};
  global_history = _RAND_128[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
