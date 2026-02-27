circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:23]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    en_reg <= io.i_en @[dut.scala 23:10]
    en_reg2 <= en_reg @[dut.scala 24:11]
    en_reg3 <= en_reg2 @[dut.scala 25:11]
    en_reg4 <= en_reg3 @[dut.scala 26:11]
    io.o_en <= en_reg4 @[dut.scala 29:11]
    reg adda_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 32:25]
    reg addb_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 33:25]
    when io.i_en : @[dut.scala 35:17]
      adda_reg <= io.adda @[dut.scala 36:14]
      addb_reg <= io.addb @[dut.scala 37:14]
    reg carry1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:23]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 43:23]
    reg carry3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:23]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 47:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 48:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 49:21]
    reg sum4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 50:21]
    node _stage1Sum_T = bits(adda_reg, 15, 0) @[dut.scala 53:27]
    node _stage1Sum_T_1 = bits(addb_reg, 15, 0) @[dut.scala 53:46]
    node stage1Sum = add(_stage1Sum_T, _stage1Sum_T_1) @[dut.scala 53:35]
    when en_reg : @[dut.scala 54:16]
      node _sum1_T = bits(stage1Sum, 15, 0) @[dut.scala 55:22]
      sum1 <= _sum1_T @[dut.scala 55:10]
      node _carry1_T = bits(stage1Sum, 16, 16) @[dut.scala 56:24]
      carry1 <= _carry1_T @[dut.scala 56:12]
    node _stage2Sum_T = bits(adda_reg, 31, 16) @[dut.scala 60:27]
    node _stage2Sum_T_1 = bits(addb_reg, 31, 16) @[dut.scala 60:47]
    node _stage2Sum_T_2 = add(_stage2Sum_T, _stage2Sum_T_1) @[dut.scala 60:36]
    node _stage2Sum_T_3 = add(_stage2Sum_T_2, carry1) @[dut.scala 60:56]
    node stage2Sum = tail(_stage2Sum_T_3, 1) @[dut.scala 60:56]
    when en_reg2 : @[dut.scala 61:17]
      node _sum2_T = bits(stage2Sum, 15, 0) @[dut.scala 62:22]
      sum2 <= _sum2_T @[dut.scala 62:10]
      node _carry2_T = bits(stage2Sum, 16, 16) @[dut.scala 63:24]
      carry2 <= _carry2_T @[dut.scala 63:12]
    node _stage3Sum_T = bits(adda_reg, 47, 32) @[dut.scala 67:27]
    node _stage3Sum_T_1 = bits(addb_reg, 47, 32) @[dut.scala 67:47]
    node _stage3Sum_T_2 = add(_stage3Sum_T, _stage3Sum_T_1) @[dut.scala 67:36]
    node _stage3Sum_T_3 = add(_stage3Sum_T_2, carry2) @[dut.scala 67:56]
    node stage3Sum = tail(_stage3Sum_T_3, 1) @[dut.scala 67:56]
    when en_reg3 : @[dut.scala 68:17]
      node _sum3_T = bits(stage3Sum, 15, 0) @[dut.scala 69:22]
      sum3 <= _sum3_T @[dut.scala 69:10]
      node _carry3_T = bits(stage3Sum, 16, 16) @[dut.scala 70:24]
      carry3 <= _carry3_T @[dut.scala 70:12]
    node _stage4Sum_T = bits(adda_reg, 63, 48) @[dut.scala 74:27]
    node _stage4Sum_T_1 = bits(addb_reg, 63, 48) @[dut.scala 74:47]
    node _stage4Sum_T_2 = add(_stage4Sum_T, _stage4Sum_T_1) @[dut.scala 74:36]
    node _stage4Sum_T_3 = add(_stage4Sum_T_2, carry3) @[dut.scala 74:56]
    node stage4Sum = tail(_stage4Sum_T_3, 1) @[dut.scala 74:56]
    when en_reg4 : @[dut.scala 75:17]
      node _sum4_T = bits(stage4Sum, 15, 0) @[dut.scala 76:22]
      sum4 <= _sum4_T @[dut.scala 76:10]
    node _io_result_T = bits(stage4Sum, 16, 16) @[dut.scala 80:29]
    node io_result_lo = cat(sum2, sum1) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, sum4) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum3) @[Cat.scala 33:92]
    node _io_result_T_1 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_1 @[dut.scala 80:13]

