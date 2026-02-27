circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_sum : UInt<17>, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 14:23]
    reg stage1_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_carry) @[dut.scala 15:25]
    reg stage2_sum : UInt<33>, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 16:23]
    reg stage2_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_carry) @[dut.scala 17:25]
    reg stage3_sum : UInt<49>, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 18:23]
    reg stage3_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_carry) @[dut.scala 19:25]
    reg stage4_sum : UInt<65>, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 20:23]
    reg stage1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:26]
    stage1_en <= io.i_en @[dut.scala 23:26]
    reg stage2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    stage2_en <= stage1_en @[dut.scala 24:26]
    reg stage3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:26]
    stage3_en <= stage2_en @[dut.scala 25:26]
    reg stage4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:26]
    stage4_en <= stage3_en @[dut.scala 26:26]
    when io.i_en : @[dut.scala 29:17]
      node _sum_T = bits(io.adda, 15, 0) @[dut.scala 30:22]
      node _sum_T_1 = bits(io.addb, 15, 0) @[dut.scala 30:40]
      node sum = add(_sum_T, _sum_T_1) @[dut.scala 30:30]
      node _stage1_sum_T = bits(sum, 15, 0) @[dut.scala 31:22]
      stage1_sum <= _stage1_sum_T @[dut.scala 31:16]
      node _stage1_carry_T = bits(sum, 16, 16) @[dut.scala 32:24]
      stage1_carry <= _stage1_carry_T @[dut.scala 32:18]
    when stage1_en : @[dut.scala 36:19]
      node _sum_T_2 = bits(io.adda, 31, 16) @[dut.scala 37:22]
      node _sum_T_3 = bits(io.addb, 31, 16) @[dut.scala 37:41]
      node _sum_T_4 = add(_sum_T_2, _sum_T_3) @[dut.scala 37:31]
      node _sum_T_5 = add(_sum_T_4, stage1_carry) @[dut.scala 37:50]
      node sum_1 = tail(_sum_T_5, 1) @[dut.scala 37:50]
      node _stage2_sum_T = bits(sum_1, 15, 0) @[dut.scala 38:26]
      node _stage2_sum_T_1 = cat(_stage2_sum_T, stage1_sum) @[Cat.scala 33:92]
      stage2_sum <= _stage2_sum_T_1 @[dut.scala 38:16]
      node _stage2_carry_T = bits(sum_1, 16, 16) @[dut.scala 39:24]
      stage2_carry <= _stage2_carry_T @[dut.scala 39:18]
    when stage2_en : @[dut.scala 43:19]
      node _sum_T_6 = bits(io.adda, 47, 32) @[dut.scala 44:22]
      node _sum_T_7 = bits(io.addb, 47, 32) @[dut.scala 44:41]
      node _sum_T_8 = add(_sum_T_6, _sum_T_7) @[dut.scala 44:31]
      node _sum_T_9 = add(_sum_T_8, stage2_carry) @[dut.scala 44:50]
      node sum_2 = tail(_sum_T_9, 1) @[dut.scala 44:50]
      node _stage3_sum_T = bits(sum_2, 15, 0) @[dut.scala 45:26]
      node _stage3_sum_T_1 = cat(_stage3_sum_T, stage2_sum) @[Cat.scala 33:92]
      stage3_sum <= _stage3_sum_T_1 @[dut.scala 45:16]
      node _stage3_carry_T = bits(sum_2, 16, 16) @[dut.scala 46:24]
      stage3_carry <= _stage3_carry_T @[dut.scala 46:18]
    when stage3_en : @[dut.scala 50:19]
      node _sum_T_10 = bits(io.adda, 63, 48) @[dut.scala 51:22]
      node _sum_T_11 = bits(io.addb, 63, 48) @[dut.scala 51:41]
      node _sum_T_12 = add(_sum_T_10, _sum_T_11) @[dut.scala 51:31]
      node _sum_T_13 = add(_sum_T_12, stage3_carry) @[dut.scala 51:50]
      node sum_3 = tail(_sum_T_13, 1) @[dut.scala 51:50]
      node _stage4_sum_T = bits(sum_3, 16, 0) @[dut.scala 52:26]
      node _stage4_sum_T_1 = cat(_stage4_sum_T, stage3_sum) @[Cat.scala 33:92]
      stage4_sum <= _stage4_sum_T_1 @[dut.scala 52:16]
    io.result <= stage4_sum @[dut.scala 56:13]
    io.o_en <= stage4_en @[dut.scala 57:11]

