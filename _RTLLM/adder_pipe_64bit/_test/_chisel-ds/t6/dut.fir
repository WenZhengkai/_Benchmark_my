circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_adda : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 14:28]
    reg stage1_addb : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 15:28]
    reg stage1_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:29]
    reg stage1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:26]
    reg stage2_adda : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 19:28]
    reg stage2_addb : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 20:28]
    reg stage2_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:29]
    reg stage2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:26]
    reg stage3_adda : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 24:28]
    reg stage3_addb : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 25:28]
    reg stage3_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:29]
    reg stage3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:26]
    reg stage4_adda : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:28]
    reg stage4_addb : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 30:28]
    reg stage4_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:29]
    reg stage4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 32:26]
    when io.i_en : @[dut.scala 35:17]
      node _stage1_adda_T = bits(io.adda, 15, 0) @[dut.scala 37:27]
      stage1_adda <= _stage1_adda_T @[dut.scala 37:17]
      node _stage1_addb_T = bits(io.addb, 15, 0) @[dut.scala 38:27]
      stage1_addb <= _stage1_addb_T @[dut.scala 38:17]
      stage1_carry <= UInt<1>("h0") @[dut.scala 39:18]
      stage1_en <= UInt<1>("h1") @[dut.scala 40:15]
      node _stage2_adda_T = bits(io.adda, 31, 16) @[dut.scala 43:27]
      stage2_adda <= _stage2_adda_T @[dut.scala 43:17]
      node _stage2_addb_T = bits(io.addb, 31, 16) @[dut.scala 44:27]
      stage2_addb <= _stage2_addb_T @[dut.scala 44:17]
      node _stage2_carry_T = add(stage1_adda, stage1_addb) @[dut.scala 45:34]
      node _stage2_carry_T_1 = bits(_stage2_carry_T, 16, 16) @[dut.scala 45:49]
      stage2_carry <= _stage2_carry_T_1 @[dut.scala 45:18]
      stage2_en <= stage1_en @[dut.scala 46:15]
      node _stage3_adda_T = bits(io.adda, 47, 32) @[dut.scala 49:27]
      stage3_adda <= _stage3_adda_T @[dut.scala 49:17]
      node _stage3_addb_T = bits(io.addb, 47, 32) @[dut.scala 50:27]
      stage3_addb <= _stage3_addb_T @[dut.scala 50:17]
      node _stage3_carry_T = add(stage2_adda, stage2_addb) @[dut.scala 51:34]
      node _stage3_carry_T_1 = add(_stage3_carry_T, stage2_carry) @[dut.scala 51:49]
      node _stage3_carry_T_2 = bits(_stage3_carry_T_1, 16, 16) @[dut.scala 51:65]
      stage3_carry <= _stage3_carry_T_2 @[dut.scala 51:18]
      stage3_en <= stage2_en @[dut.scala 52:15]
      node _stage4_adda_T = bits(io.adda, 63, 48) @[dut.scala 55:27]
      stage4_adda <= _stage4_adda_T @[dut.scala 55:17]
      node _stage4_addb_T = bits(io.addb, 63, 48) @[dut.scala 56:27]
      stage4_addb <= _stage4_addb_T @[dut.scala 56:17]
      node _stage4_carry_T = add(stage3_adda, stage3_addb) @[dut.scala 57:34]
      node _stage4_carry_T_1 = add(_stage4_carry_T, stage3_carry) @[dut.scala 57:49]
      node _stage4_carry_T_2 = bits(_stage4_carry_T_1, 16, 16) @[dut.scala 57:65]
      stage4_carry <= _stage4_carry_T_2 @[dut.scala 57:18]
      stage4_en <= stage3_en @[dut.scala 58:15]
    else :
      stage1_en <= UInt<1>("h0") @[dut.scala 61:15]
      stage2_en <= UInt<1>("h0") @[dut.scala 62:15]
      stage3_en <= UInt<1>("h0") @[dut.scala 63:15]
      stage4_en <= UInt<1>("h0") @[dut.scala 64:15]
    node _sum1_T = add(stage1_adda, stage1_addb) @[dut.scala 68:26]
    node sum1 = tail(_sum1_T, 1) @[dut.scala 68:26]
    node _sum2_T = add(stage2_adda, stage2_addb) @[dut.scala 69:26]
    node _sum2_T_1 = tail(_sum2_T, 1) @[dut.scala 69:26]
    node _sum2_T_2 = add(_sum2_T_1, stage2_carry) @[dut.scala 69:40]
    node sum2 = tail(_sum2_T_2, 1) @[dut.scala 69:40]
    node _sum3_T = add(stage3_adda, stage3_addb) @[dut.scala 70:26]
    node _sum3_T_1 = tail(_sum3_T, 1) @[dut.scala 70:26]
    node _sum3_T_2 = add(_sum3_T_1, stage3_carry) @[dut.scala 70:40]
    node sum3 = tail(_sum3_T_2, 1) @[dut.scala 70:40]
    node _sum4_T = add(stage4_adda, stage4_addb) @[dut.scala 71:26]
    node _sum4_T_1 = tail(_sum4_T, 1) @[dut.scala 71:26]
    node _sum4_T_2 = add(_sum4_T_1, stage4_carry) @[dut.scala 71:40]
    node sum4 = tail(_sum4_T_2, 1) @[dut.scala 71:40]
    node _io_result_T = bits(sum4, 15, 0) @[dut.scala 74:24]
    node _io_result_T_1 = bits(sum3, 15, 0) @[dut.scala 74:37]
    node _io_result_T_2 = bits(sum2, 15, 0) @[dut.scala 74:50]
    node _io_result_T_3 = bits(sum1, 15, 0) @[dut.scala 74:63]
    node io_result_lo = cat(_io_result_T_2, _io_result_T_3) @[Cat.scala 33:92]
    node io_result_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node _io_result_T_4 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_4 @[dut.scala 74:13]
    io.o_en <= stage4_en @[dut.scala 77:11]

