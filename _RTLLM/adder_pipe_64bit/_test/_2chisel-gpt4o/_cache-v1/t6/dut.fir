circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg s0_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    s0_en <= io.i_en @[dut.scala 18:24]
    reg s1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    s1_en <= s0_en @[dut.scala 19:24]
    reg s2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    s2_en <= s1_en @[dut.scala 20:24]
    reg s3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:24]
    s3_en <= s2_en @[dut.scala 21:24]
    reg s4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    s4_en <= s3_en @[dut.scala 22:24]
    node _stage0_adda_T = bits(io.adda, 15, 0) @[dut.scala 25:43]
    reg stage0_adda : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 25:28]
    stage0_adda <= _stage0_adda_T @[dut.scala 25:28]
    node _stage0_addb_T = bits(io.addb, 15, 0) @[dut.scala 26:43]
    reg stage0_addb : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 26:28]
    stage0_addb <= _stage0_addb_T @[dut.scala 26:28]
    node _stage1_adda_T = bits(io.adda, 31, 16) @[dut.scala 27:43]
    reg stage1_adda : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 27:28]
    stage1_adda <= _stage1_adda_T @[dut.scala 27:28]
    node _stage1_addb_T = bits(io.addb, 31, 16) @[dut.scala 28:43]
    reg stage1_addb : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 28:28]
    stage1_addb <= _stage1_addb_T @[dut.scala 28:28]
    node _stage2_adda_T = bits(io.adda, 47, 32) @[dut.scala 29:43]
    reg stage2_adda : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:28]
    stage2_adda <= _stage2_adda_T @[dut.scala 29:28]
    node _stage2_addb_T = bits(io.addb, 47, 32) @[dut.scala 30:43]
    reg stage2_addb : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 30:28]
    stage2_addb <= _stage2_addb_T @[dut.scala 30:28]
    node _stage3_adda_T = bits(io.adda, 63, 48) @[dut.scala 31:43]
    reg stage3_adda : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:28]
    stage3_adda <= _stage3_adda_T @[dut.scala 31:28]
    node _stage3_addb_T = bits(io.addb, 63, 48) @[dut.scala 32:43]
    reg stage3_addb : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:28]
    stage3_addb <= _stage3_addb_T @[dut.scala 32:28]
    reg stage1_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_carry) @[dut.scala 35:25]
    reg stage1_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 36:25]
    reg stage2_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_carry) @[dut.scala 37:25]
    reg stage2_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 38:25]
    reg stage3_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_carry) @[dut.scala 39:25]
    reg stage3_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 40:25]
    reg stage4_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage4_carry) @[dut.scala 41:25]
    reg stage4_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 42:25]
    node stage0_add = add(stage0_adda, stage0_addb) @[dut.scala 45:32]
    node _stage1_sum_T = bits(stage0_add, 15, 0) @[dut.scala 46:27]
    stage1_sum <= _stage1_sum_T @[dut.scala 46:14]
    node _stage1_carry_T = bits(stage0_add, 16, 16) @[dut.scala 47:29]
    stage1_carry <= _stage1_carry_T @[dut.scala 47:16]
    node _stage1_add_T = add(stage1_adda, stage1_addb) @[dut.scala 50:32]
    node _stage1_add_T_1 = add(_stage1_add_T, stage1_carry) @[dut.scala 50:47]
    node stage1_add = tail(_stage1_add_T_1, 1) @[dut.scala 50:47]
    node _stage2_sum_T = bits(stage1_add, 15, 0) @[dut.scala 51:27]
    stage2_sum <= _stage2_sum_T @[dut.scala 51:14]
    node _stage2_carry_T = bits(stage1_add, 16, 16) @[dut.scala 52:29]
    stage2_carry <= _stage2_carry_T @[dut.scala 52:16]
    node _stage2_add_T = add(stage2_adda, stage2_addb) @[dut.scala 55:32]
    node _stage2_add_T_1 = add(_stage2_add_T, stage2_carry) @[dut.scala 55:47]
    node stage2_add = tail(_stage2_add_T_1, 1) @[dut.scala 55:47]
    node _stage3_sum_T = bits(stage2_add, 15, 0) @[dut.scala 56:27]
    stage3_sum <= _stage3_sum_T @[dut.scala 56:14]
    node _stage3_carry_T = bits(stage2_add, 16, 16) @[dut.scala 57:29]
    stage3_carry <= _stage3_carry_T @[dut.scala 57:16]
    node _stage3_add_T = add(stage3_adda, stage3_addb) @[dut.scala 60:32]
    node _stage3_add_T_1 = add(_stage3_add_T, stage3_carry) @[dut.scala 60:47]
    node stage3_add = tail(_stage3_add_T_1, 1) @[dut.scala 60:47]
    node _stage4_sum_T = bits(stage3_add, 15, 0) @[dut.scala 61:27]
    stage4_sum <= _stage4_sum_T @[dut.scala 61:14]
    node _stage4_carry_T = bits(stage3_add, 16, 16) @[dut.scala 62:29]
    stage4_carry <= _stage4_carry_T @[dut.scala 62:16]
    node io_result_lo = cat(stage2_sum, stage1_sum) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(stage4_carry, stage4_sum) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, stage3_sum) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 65:13]
    io.o_en <= s4_en @[dut.scala 66:11]

