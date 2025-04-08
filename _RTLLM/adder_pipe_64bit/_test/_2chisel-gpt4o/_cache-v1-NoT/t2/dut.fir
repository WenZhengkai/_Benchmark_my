circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_sum : UInt<17>, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 14:23]
    reg stage1_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_carry) @[dut.scala 15:25]
    reg stage1_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_en) @[dut.scala 16:22]
    reg stage2_sum : UInt<17>, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 18:23]
    reg stage2_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_carry) @[dut.scala 19:25]
    reg stage2_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_en) @[dut.scala 20:22]
    reg stage3_sum : UInt<17>, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 22:23]
    reg stage3_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_carry) @[dut.scala 23:25]
    reg stage3_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_en) @[dut.scala 24:22]
    reg stage4_sum : UInt<17>, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 26:23]
    reg o_en_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:25]
    when io.i_en : @[dut.scala 30:18]
      node _stage1_result_T = bits(io.adda, 15, 0) @[dut.scala 32:32]
      node _stage1_result_T_1 = bits(io.addb, 15, 0) @[dut.scala 32:50]
      node stage1_result = add(_stage1_result_T, _stage1_result_T_1) @[dut.scala 32:40]
      stage1_sum <= stage1_result @[dut.scala 33:16]
      node _stage1_carry_T = bits(stage1_result, 16, 16) @[dut.scala 34:34]
      stage1_carry <= _stage1_carry_T @[dut.scala 34:18]
      stage1_en <= UInt<1>("h1") @[dut.scala 35:15]
    when stage1_en : @[dut.scala 38:20]
      node _stage2_result_T = bits(io.adda, 31, 16) @[dut.scala 40:32]
      node _stage2_result_T_1 = bits(io.addb, 31, 16) @[dut.scala 40:51]
      node _stage2_result_T_2 = add(_stage2_result_T, _stage2_result_T_1) @[dut.scala 40:41]
      node _stage2_result_T_3 = add(_stage2_result_T_2, stage1_carry) @[dut.scala 40:60]
      node stage2_result = tail(_stage2_result_T_3, 1) @[dut.scala 40:60]
      stage2_sum <= stage2_result @[dut.scala 41:16]
      node _stage2_carry_T = bits(stage2_result, 16, 16) @[dut.scala 42:34]
      stage2_carry <= _stage2_carry_T @[dut.scala 42:18]
      stage2_en <= UInt<1>("h1") @[dut.scala 43:15]
    when stage2_en : @[dut.scala 46:20]
      node _stage3_result_T = bits(io.adda, 47, 32) @[dut.scala 48:32]
      node _stage3_result_T_1 = bits(io.addb, 47, 32) @[dut.scala 48:51]
      node _stage3_result_T_2 = add(_stage3_result_T, _stage3_result_T_1) @[dut.scala 48:41]
      node _stage3_result_T_3 = add(_stage3_result_T_2, stage2_carry) @[dut.scala 48:60]
      node stage3_result = tail(_stage3_result_T_3, 1) @[dut.scala 48:60]
      stage3_sum <= stage3_result @[dut.scala 49:16]
      node _stage3_carry_T = bits(stage3_result, 16, 16) @[dut.scala 50:34]
      stage3_carry <= _stage3_carry_T @[dut.scala 50:18]
      stage3_en <= UInt<1>("h1") @[dut.scala 51:15]
    when stage3_en : @[dut.scala 54:20]
      node _stage4_result_T = bits(io.adda, 63, 48) @[dut.scala 56:32]
      node _stage4_result_T_1 = bits(io.addb, 63, 48) @[dut.scala 56:51]
      node _stage4_result_T_2 = add(_stage4_result_T, _stage4_result_T_1) @[dut.scala 56:41]
      node _stage4_result_T_3 = add(_stage4_result_T_2, stage3_carry) @[dut.scala 56:60]
      node stage4_result = tail(_stage4_result_T_3, 1) @[dut.scala 56:60]
      stage4_sum <= stage4_result @[dut.scala 57:16]
      o_en_reg <= UInt<1>("h1") @[dut.scala 58:14]
    node _io_result_T = bits(stage3_sum, 15, 0) @[dut.scala 62:42]
    node _io_result_T_1 = bits(stage2_sum, 15, 0) @[dut.scala 62:61]
    node _io_result_T_2 = bits(stage1_sum, 15, 0) @[dut.scala 62:80]
    node io_result_lo = cat(_io_result_T_1, _io_result_T_2) @[Cat.scala 33:92]
    node io_result_hi = cat(stage4_sum, _io_result_T) @[Cat.scala 33:92]
    node _io_result_T_3 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_3 @[dut.scala 62:13]
    io.o_en <= o_en_reg @[dut.scala 63:11]

