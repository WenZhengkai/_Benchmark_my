circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    adda_reg0 <= io.adda @[dut.scala 14:26]
    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    adda_reg1 <= adda_reg0 @[dut.scala 15:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    adda_reg2 <= adda_reg1 @[dut.scala 16:26]
    reg addb_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    addb_reg0 <= io.addb @[dut.scala 18:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    addb_reg1 <= addb_reg0 @[dut.scala 19:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
    addb_reg2 <= addb_reg1 @[dut.scala 20:26]
    reg en_reg0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    en_reg0 <= io.i_en @[dut.scala 23:24]
    reg en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:24]
    en_reg1 <= en_reg0 @[dut.scala 24:24]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:24]
    en_reg2 <= en_reg1 @[dut.scala 25:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:24]
    en_reg3 <= en_reg2 @[dut.scala 26:24]
    reg carry0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:23]
    reg carry1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:23]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:23]
    reg carry3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 32:23]
    reg sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:21]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 38:21]
    node _stage0_sum_T = bits(io.adda, 15, 0) @[dut.scala 41:27]
    node _stage0_sum_T_1 = bits(io.addb, 15, 0) @[dut.scala 41:45]
    node stage0_sum = add(_stage0_sum_T, _stage0_sum_T_1) @[dut.scala 41:35]
    when io.i_en : @[dut.scala 42:17]
      node _sum0_T = bits(stage0_sum, 15, 0) @[dut.scala 43:25]
      sum0 <= _sum0_T @[dut.scala 43:12]
      node _carry0_T = bits(stage0_sum, 16, 16) @[dut.scala 44:25]
      carry0 <= _carry0_T @[dut.scala 44:12]
    else :
      sum0 <= UInt<1>("h0") @[dut.scala 46:12]
      carry0 <= UInt<1>("h0") @[dut.scala 47:12]
    node _stage1_sum_T = bits(adda_reg0, 31, 16) @[dut.scala 51:29]
    node _stage1_sum_T_1 = bits(addb_reg0, 31, 16) @[dut.scala 51:50]
    node _stage1_sum_T_2 = add(_stage1_sum_T, _stage1_sum_T_1) @[dut.scala 51:38]
    node stage1_sum = add(_stage1_sum_T_2, carry0) @[dut.scala 51:59]
    when en_reg0 : @[dut.scala 52:17]
      node _sum1_T = bits(stage1_sum, 15, 0) @[dut.scala 53:25]
      sum1 <= _sum1_T @[dut.scala 53:12]
      node _carry1_T = bits(stage1_sum, 16, 16) @[dut.scala 54:25]
      carry1 <= _carry1_T @[dut.scala 54:12]
    else :
      sum1 <= UInt<1>("h0") @[dut.scala 56:12]
      carry1 <= UInt<1>("h0") @[dut.scala 57:12]
    node _stage2_sum_T = bits(adda_reg1, 47, 32) @[dut.scala 61:29]
    node _stage2_sum_T_1 = bits(addb_reg1, 47, 32) @[dut.scala 61:50]
    node _stage2_sum_T_2 = add(_stage2_sum_T, _stage2_sum_T_1) @[dut.scala 61:38]
    node stage2_sum = add(_stage2_sum_T_2, carry1) @[dut.scala 61:59]
    when en_reg1 : @[dut.scala 62:17]
      node _sum2_T = bits(stage2_sum, 15, 0) @[dut.scala 63:25]
      sum2 <= _sum2_T @[dut.scala 63:12]
      node _carry2_T = bits(stage2_sum, 16, 16) @[dut.scala 64:25]
      carry2 <= _carry2_T @[dut.scala 64:12]
    else :
      sum2 <= UInt<1>("h0") @[dut.scala 66:12]
      carry2 <= UInt<1>("h0") @[dut.scala 67:12]
    node _stage3_sum_T = bits(adda_reg2, 63, 48) @[dut.scala 71:29]
    node _stage3_sum_T_1 = bits(addb_reg2, 63, 48) @[dut.scala 71:50]
    node _stage3_sum_T_2 = add(_stage3_sum_T, _stage3_sum_T_1) @[dut.scala 71:38]
    node stage3_sum = add(_stage3_sum_T_2, carry2) @[dut.scala 71:59]
    when en_reg2 : @[dut.scala 72:17]
      node _sum3_T = bits(stage3_sum, 15, 0) @[dut.scala 73:25]
      sum3 <= _sum3_T @[dut.scala 73:12]
      node _carry3_T = bits(stage3_sum, 16, 16) @[dut.scala 74:25]
      carry3 <= _carry3_T @[dut.scala 74:12]
    else :
      sum3 <= UInt<1>("h0") @[dut.scala 76:12]
      carry3 <= UInt<1>("h0") @[dut.scala 77:12]
    node io_result_lo = cat(sum1, sum0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry3, sum3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 81:13]
    io.o_en <= en_reg3 @[dut.scala 84:11]

