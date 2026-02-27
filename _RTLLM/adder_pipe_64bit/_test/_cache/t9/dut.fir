circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:24]
    reg en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg adda_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 25:25]
    reg addb_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 26:25]
    when io.i_en : @[dut.scala 29:17]
      adda_reg <= io.adda @[dut.scala 30:14]
      addb_reg <= io.addb @[dut.scala 31:14]
      en_reg1 <= UInt<1>("h1") @[dut.scala 32:13]
    else :
      en_reg1 <= UInt<1>("h0") @[dut.scala 34:13]
    wire sum1 : UInt<16> @[dut.scala 41:18]
    wire carry1 : UInt<1> @[dut.scala 42:20]
    node stage1_result = cat(carry1, sum1) @[Cat.scala 33:92]
    node _stage1_value_T = bits(adda_reg, 15, 0) @[dut.scala 44:30]
    node _stage1_value_T_1 = bits(addb_reg, 15, 0) @[dut.scala 44:49]
    node stage1_value = add(_stage1_value_T, _stage1_value_T_1) @[dut.scala 44:38]
    node _sum1_T = bits(stage1_value, 15, 0) @[dut.scala 45:23]
    sum1 <= _sum1_T @[dut.scala 45:8]
    node _carry1_T = bits(stage1_value, 16, 16) @[dut.scala 46:25]
    carry1 <= _carry1_T @[dut.scala 46:10]
    reg stage1_reg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 49:27]
    reg adda_high1_reg : UInt<48>, clock with :
      reset => (reset, UInt<48>("h0")) @[dut.scala 50:31]
    reg addb_high1_reg : UInt<48>, clock with :
      reset => (reset, UInt<48>("h0")) @[dut.scala 51:31]
    when en_reg1 : @[dut.scala 53:17]
      stage1_reg <= stage1_result @[dut.scala 54:16]
      node _adda_high1_reg_T = bits(adda_reg, 63, 16) @[dut.scala 55:31]
      adda_high1_reg <= _adda_high1_reg_T @[dut.scala 55:20]
      node _addb_high1_reg_T = bits(addb_reg, 63, 16) @[dut.scala 56:31]
      addb_high1_reg <= _addb_high1_reg_T @[dut.scala 56:20]
      en_reg2 <= UInt<1>("h1") @[dut.scala 57:13]
    else :
      en_reg2 <= UInt<1>("h0") @[dut.scala 59:13]
    wire sum2 : UInt<16> @[dut.scala 63:18]
    wire carry2 : UInt<1> @[dut.scala 64:20]
    node stage2_result = cat(carry2, sum2) @[Cat.scala 33:92]
    node _stage2_value_T = bits(adda_high1_reg, 15, 0) @[dut.scala 66:36]
    node _stage2_value_T_1 = bits(addb_high1_reg, 15, 0) @[dut.scala 66:61]
    node _stage2_value_T_2 = add(_stage2_value_T, _stage2_value_T_1) @[dut.scala 66:44]
    node _stage2_value_T_3 = bits(stage1_reg, 16, 16) @[dut.scala 66:81]
    node _stage2_value_T_4 = add(_stage2_value_T_2, _stage2_value_T_3) @[dut.scala 66:69]
    node stage2_value = tail(_stage2_value_T_4, 1) @[dut.scala 66:69]
    node _sum2_T = bits(stage2_value, 15, 0) @[dut.scala 67:23]
    sum2 <= _sum2_T @[dut.scala 67:8]
    node _carry2_T = bits(stage2_value, 16, 16) @[dut.scala 68:25]
    carry2 <= _carry2_T @[dut.scala 68:10]
    reg stage1_2_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 71:29]
    reg stage2_reg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 72:27]
    reg adda_high2_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 73:31]
    reg addb_high2_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 74:31]
    when en_reg2 : @[dut.scala 76:17]
      node _stage1_2_reg_T = bits(stage1_reg, 15, 0) @[dut.scala 77:31]
      stage1_2_reg <= _stage1_2_reg_T @[dut.scala 77:18]
      stage2_reg <= stage2_result @[dut.scala 78:16]
      node _adda_high2_reg_T = bits(adda_high1_reg, 47, 16) @[dut.scala 79:37]
      adda_high2_reg <= _adda_high2_reg_T @[dut.scala 79:20]
      node _addb_high2_reg_T = bits(addb_high1_reg, 47, 16) @[dut.scala 80:37]
      addb_high2_reg <= _addb_high2_reg_T @[dut.scala 80:20]
      en_reg3 <= UInt<1>("h1") @[dut.scala 81:13]
    else :
      en_reg3 <= UInt<1>("h0") @[dut.scala 83:13]
    wire sum3 : UInt<16> @[dut.scala 87:18]
    wire carry3 : UInt<1> @[dut.scala 88:20]
    node stage3_result = cat(carry3, sum3) @[Cat.scala 33:92]
    node _stage3_value_T = bits(adda_high2_reg, 15, 0) @[dut.scala 90:36]
    node _stage3_value_T_1 = bits(addb_high2_reg, 15, 0) @[dut.scala 90:61]
    node _stage3_value_T_2 = add(_stage3_value_T, _stage3_value_T_1) @[dut.scala 90:44]
    node _stage3_value_T_3 = bits(stage2_reg, 16, 16) @[dut.scala 90:81]
    node _stage3_value_T_4 = add(_stage3_value_T_2, _stage3_value_T_3) @[dut.scala 90:69]
    node stage3_value = tail(_stage3_value_T_4, 1) @[dut.scala 90:69]
    node _sum3_T = bits(stage3_value, 15, 0) @[dut.scala 91:23]
    sum3 <= _sum3_T @[dut.scala 91:8]
    node _carry3_T = bits(stage3_value, 16, 16) @[dut.scala 92:25]
    carry3 <= _carry3_T @[dut.scala 92:10]
    reg stage1_3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 95:29]
    reg stage2_3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 96:29]
    reg stage3_reg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 97:27]
    reg adda_high3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 98:31]
    reg addb_high3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 99:31]
    when en_reg3 : @[dut.scala 101:17]
      stage1_3_reg <= stage1_2_reg @[dut.scala 102:18]
      node _stage2_3_reg_T = bits(stage2_reg, 15, 0) @[dut.scala 103:31]
      stage2_3_reg <= _stage2_3_reg_T @[dut.scala 103:18]
      stage3_reg <= stage3_result @[dut.scala 104:16]
      node _adda_high3_reg_T = bits(adda_high2_reg, 31, 16) @[dut.scala 105:37]
      adda_high3_reg <= _adda_high3_reg_T @[dut.scala 105:20]
      node _addb_high3_reg_T = bits(addb_high2_reg, 31, 16) @[dut.scala 106:37]
      addb_high3_reg <= _addb_high3_reg_T @[dut.scala 106:20]
      en_reg4 <= UInt<1>("h1") @[dut.scala 107:13]
    else :
      en_reg4 <= UInt<1>("h0") @[dut.scala 109:13]
    wire sum4 : UInt<16> @[dut.scala 113:18]
    wire carry4 : UInt<1> @[dut.scala 114:20]
    node stage4_result = cat(carry4, sum4) @[Cat.scala 33:92]
    node _stage4_value_T = add(adda_high3_reg, addb_high3_reg) @[dut.scala 116:37]
    node _stage4_value_T_1 = bits(stage3_reg, 16, 16) @[dut.scala 116:67]
    node _stage4_value_T_2 = add(_stage4_value_T, _stage4_value_T_1) @[dut.scala 116:55]
    node stage4_value = tail(_stage4_value_T_2, 1) @[dut.scala 116:55]
    node _sum4_T = bits(stage4_value, 15, 0) @[dut.scala 117:23]
    sum4 <= _sum4_T @[dut.scala 117:8]
    node _carry4_T = bits(stage4_value, 16, 16) @[dut.scala 118:25]
    carry4 <= _carry4_T @[dut.scala 118:10]
    reg final_result : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 121:29]
    reg o_en_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 122:25]
    when en_reg4 : @[dut.scala 124:17]
      node _final_result_T = bits(stage3_reg, 15, 0) @[dut.scala 125:50]
      node final_result_lo = cat(stage2_3_reg, stage1_3_reg) @[Cat.scala 33:92]
      node final_result_hi = cat(stage4_result, _final_result_T) @[Cat.scala 33:92]
      node _final_result_T_1 = cat(final_result_hi, final_result_lo) @[Cat.scala 33:92]
      final_result <= _final_result_T_1 @[dut.scala 125:18]
      o_en_reg <= UInt<1>("h1") @[dut.scala 126:14]
    else :
      o_en_reg <= UInt<1>("h0") @[dut.scala 128:14]
    io.result <= final_result @[dut.scala 132:13]
    io.o_en <= o_en_reg @[dut.scala 133:11]

