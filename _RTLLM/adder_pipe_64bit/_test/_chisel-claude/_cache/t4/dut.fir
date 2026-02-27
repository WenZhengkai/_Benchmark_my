circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:24]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg adda_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 23:25]
    reg addb_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 24:25]
    wire sum1 : UInt<16> @[dut.scala 27:18]
    wire carry1 : UInt<1> @[dut.scala 28:20]
    wire adda1 : UInt<16> @[dut.scala 29:19]
    wire addb1 : UInt<16> @[dut.scala 30:19]
    wire stage1_result : UInt<17> @[dut.scala 31:27]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:21]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:23]
    reg adda2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:22]
    reg addb2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:22]
    wire stage2_result : UInt<17> @[dut.scala 38:27]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 41:21]
    reg carry3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:23]
    reg adda3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 43:22]
    reg addb3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 44:22]
    wire stage3_result : UInt<17> @[dut.scala 45:27]
    reg sum4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 48:21]
    reg carry4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 49:23]
    reg adda4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 50:22]
    reg addb4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 51:22]
    wire stage4_result : UInt<17> @[dut.scala 52:27]
    reg final_sum : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 55:26]
    en_reg1 <= io.i_en @[dut.scala 58:11]
    en_reg2 <= en_reg1 @[dut.scala 59:11]
    en_reg3 <= en_reg2 @[dut.scala 60:11]
    en_reg4 <= en_reg3 @[dut.scala 61:11]
    when io.i_en : @[dut.scala 64:18]
      adda_reg <= io.adda @[dut.scala 65:14]
      addb_reg <= io.addb @[dut.scala 66:14]
    node _adda1_T = bits(adda_reg, 15, 0) @[dut.scala 70:20]
    adda1 <= _adda1_T @[dut.scala 70:9]
    node _addb1_T = bits(addb_reg, 15, 0) @[dut.scala 71:20]
    addb1 <= _addb1_T @[dut.scala 71:9]
    node _stage1_result_T = add(adda1, addb1) @[dut.scala 72:26]
    stage1_result <= _stage1_result_T @[dut.scala 72:17]
    node _sum1_T = bits(stage1_result, 15, 0) @[dut.scala 73:24]
    sum1 <= _sum1_T @[dut.scala 73:8]
    node _carry1_T = bits(stage1_result, 16, 16) @[dut.scala 74:26]
    carry1 <= _carry1_T @[dut.scala 74:10]
    when en_reg1 : @[dut.scala 77:18]
      sum2 <= sum1 @[dut.scala 78:10]
      node _adda2_T = bits(adda_reg, 31, 16) @[dut.scala 79:22]
      adda2 <= _adda2_T @[dut.scala 79:11]
      node _addb2_T = bits(addb_reg, 31, 16) @[dut.scala 80:22]
      addb2 <= _addb2_T @[dut.scala 80:11]
      carry2 <= carry1 @[dut.scala 81:12]
    node _stage2_result_T = add(adda2, addb2) @[dut.scala 83:26]
    node _stage2_result_T_1 = add(_stage2_result_T, carry2) @[dut.scala 83:35]
    stage2_result <= _stage2_result_T_1 @[dut.scala 83:17]
    when en_reg2 : @[dut.scala 86:18]
      node _sum3_T = bits(stage2_result, 15, 0) @[dut.scala 87:26]
      sum3 <= _sum3_T @[dut.scala 87:10]
      node _adda3_T = bits(adda_reg, 47, 32) @[dut.scala 88:22]
      adda3 <= _adda3_T @[dut.scala 88:11]
      node _addb3_T = bits(addb_reg, 47, 32) @[dut.scala 89:22]
      addb3 <= _addb3_T @[dut.scala 89:11]
      node _carry3_T = bits(stage2_result, 16, 16) @[dut.scala 90:28]
      carry3 <= _carry3_T @[dut.scala 90:12]
    node _stage3_result_T = add(adda3, addb3) @[dut.scala 92:26]
    node _stage3_result_T_1 = add(_stage3_result_T, carry3) @[dut.scala 92:35]
    stage3_result <= _stage3_result_T_1 @[dut.scala 92:17]
    when en_reg3 : @[dut.scala 95:18]
      node _sum4_T = bits(stage3_result, 15, 0) @[dut.scala 96:26]
      sum4 <= _sum4_T @[dut.scala 96:10]
      node _adda4_T = bits(adda_reg, 63, 48) @[dut.scala 97:22]
      adda4 <= _adda4_T @[dut.scala 97:11]
      node _addb4_T = bits(addb_reg, 63, 48) @[dut.scala 98:22]
      addb4 <= _addb4_T @[dut.scala 98:11]
      node _carry4_T = bits(stage3_result, 16, 16) @[dut.scala 99:28]
      carry4 <= _carry4_T @[dut.scala 99:12]
    node _stage4_result_T = add(adda4, addb4) @[dut.scala 101:26]
    node _stage4_result_T_1 = add(_stage4_result_T, carry4) @[dut.scala 101:35]
    stage4_result <= _stage4_result_T_1 @[dut.scala 101:17]
    when en_reg4 : @[dut.scala 104:18]
      node _final_sum_T = bits(stage4_result, 16, 16) @[dut.scala 105:35]
      node _final_sum_T_1 = bits(stage4_result, 15, 0) @[dut.scala 105:54]
      node final_sum_lo = cat(sum3, sum2) @[Cat.scala 33:92]
      node final_sum_hi_hi = cat(_final_sum_T, _final_sum_T_1) @[Cat.scala 33:92]
      node final_sum_hi = cat(final_sum_hi_hi, sum4) @[Cat.scala 33:92]
      node _final_sum_T_2 = cat(final_sum_hi, final_sum_lo) @[Cat.scala 33:92]
      final_sum <= _final_sum_T_2 @[dut.scala 105:15]
    io.result <= final_sum @[dut.scala 109:13]
    io.o_en <= en_reg4 @[dut.scala 110:11]

