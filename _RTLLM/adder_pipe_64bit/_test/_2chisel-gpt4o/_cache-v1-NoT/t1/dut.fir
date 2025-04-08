circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1Reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 14:26]
    reg stage1Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:28]
    reg stage2Reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 16:26]
    reg stage2Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:28]
    reg stage3Reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 18:26]
    reg stage3Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:28]
    reg stage4Reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 20:26]
    reg stage4Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:28]
    reg pipelineEnable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:31]
    when io.i_en : @[dut.scala 26:17]
      node _stage1Sum_T = bits(io.adda, 15, 0) @[dut.scala 27:28]
      node _stage1Sum_T_1 = bits(io.addb, 15, 0) @[dut.scala 27:46]
      node stage1Sum = add(_stage1Sum_T, _stage1Sum_T_1) @[dut.scala 27:36]
      node _stage1Reg_T = bits(stage1Sum, 15, 0) @[dut.scala 28:27]
      stage1Reg <= _stage1Reg_T @[dut.scala 28:15]
      node _stage1Carry_T = bits(stage1Sum, 16, 16) @[dut.scala 29:29]
      stage1Carry <= _stage1Carry_T @[dut.scala 29:17]
    when io.i_en : @[dut.scala 33:17]
      node _stage2Sum_T = bits(io.adda, 31, 16) @[dut.scala 34:28]
      node _stage2Sum_T_1 = bits(io.addb, 31, 16) @[dut.scala 34:47]
      node _stage2Sum_T_2 = add(_stage2Sum_T, _stage2Sum_T_1) @[dut.scala 34:37]
      node _stage2Sum_T_3 = add(_stage2Sum_T_2, stage1Carry) @[dut.scala 34:56]
      node stage2Sum = tail(_stage2Sum_T_3, 1) @[dut.scala 34:56]
      node _stage2Reg_T = bits(stage2Sum, 15, 0) @[dut.scala 35:27]
      stage2Reg <= _stage2Reg_T @[dut.scala 35:15]
      node _stage2Carry_T = bits(stage2Sum, 16, 16) @[dut.scala 36:29]
      stage2Carry <= _stage2Carry_T @[dut.scala 36:17]
    when io.i_en : @[dut.scala 40:17]
      node _stage3Sum_T = bits(io.adda, 47, 32) @[dut.scala 41:28]
      node _stage3Sum_T_1 = bits(io.addb, 47, 32) @[dut.scala 41:47]
      node _stage3Sum_T_2 = add(_stage3Sum_T, _stage3Sum_T_1) @[dut.scala 41:37]
      node _stage3Sum_T_3 = add(_stage3Sum_T_2, stage2Carry) @[dut.scala 41:56]
      node stage3Sum = tail(_stage3Sum_T_3, 1) @[dut.scala 41:56]
      node _stage3Reg_T = bits(stage3Sum, 15, 0) @[dut.scala 42:27]
      stage3Reg <= _stage3Reg_T @[dut.scala 42:15]
      node _stage3Carry_T = bits(stage3Sum, 16, 16) @[dut.scala 43:29]
      stage3Carry <= _stage3Carry_T @[dut.scala 43:17]
    when io.i_en : @[dut.scala 47:17]
      node _stage4Sum_T = bits(io.adda, 63, 48) @[dut.scala 48:28]
      node _stage4Sum_T_1 = bits(io.addb, 63, 48) @[dut.scala 48:47]
      node _stage4Sum_T_2 = add(_stage4Sum_T, _stage4Sum_T_1) @[dut.scala 48:37]
      node _stage4Sum_T_3 = add(_stage4Sum_T_2, stage3Carry) @[dut.scala 48:56]
      node stage4Sum = tail(_stage4Sum_T_3, 1) @[dut.scala 48:56]
      node _stage4Reg_T = bits(stage4Sum, 15, 0) @[dut.scala 49:27]
      stage4Reg <= _stage4Reg_T @[dut.scala 49:15]
      node _stage4Carry_T = bits(stage4Sum, 16, 16) @[dut.scala 50:29]
      stage4Carry <= _stage4Carry_T @[dut.scala 50:17]
    pipelineEnable <= io.i_en @[dut.scala 54:18]
    io.o_en <= pipelineEnable @[dut.scala 55:11]
    node finalSum_lo = cat(stage2Reg, stage1Reg) @[Cat.scala 33:92]
    node finalSum_hi_hi = cat(stage4Carry, stage4Reg) @[Cat.scala 33:92]
    node finalSum_hi = cat(finalSum_hi_hi, stage3Reg) @[Cat.scala 33:92]
    node finalSum = cat(finalSum_hi, finalSum_lo) @[Cat.scala 33:92]
    io.result <= finalSum @[dut.scala 59:13]

