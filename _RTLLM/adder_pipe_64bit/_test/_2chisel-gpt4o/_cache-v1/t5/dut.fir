circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage0_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    reg stage1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    reg stage2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:26]
    reg stage3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    reg regA : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regA) @[dut.scala 20:17]
    reg regB : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regB) @[dut.scala 21:17]
    reg stage0_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage0_sum) @[dut.scala 23:23]
    reg stage0_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage0_carry) @[dut.scala 24:25]
    reg stage1_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 26:23]
    reg stage1_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_carry) @[dut.scala 27:25]
    reg stage2_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 29:23]
    reg stage2_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_carry) @[dut.scala 30:25]
    reg stage3_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 32:23]
    reg stage3_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_carry) @[dut.scala 33:25]
    reg resultReg : UInt<65>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[dut.scala 36:22]
    reg resultValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 37:28]
    when io.i_en : @[dut.scala 40:17]
      regA <= io.adda @[dut.scala 41:10]
      regB <= io.addb @[dut.scala 42:10]
      stage0_en <= UInt<1>("h1") @[dut.scala 43:15]
    else :
      stage0_en <= UInt<1>("h0") @[dut.scala 45:15]
    when stage0_en : @[dut.scala 49:19]
      node _partialSum_T = bits(regA, 15, 0) @[dut.scala 50:26]
      node _partialSum_T_1 = bits(regB, 15, 0) @[dut.scala 50:41]
      node partialSum = add(_partialSum_T, _partialSum_T_1) @[dut.scala 50:34]
      node _stage0_sum_T = bits(partialSum, 15, 0) @[dut.scala 51:29]
      stage0_sum <= _stage0_sum_T @[dut.scala 51:16]
      node _stage0_carry_T = bits(partialSum, 16, 16) @[dut.scala 52:31]
      stage0_carry <= _stage0_carry_T @[dut.scala 52:18]
      stage1_en <= UInt<1>("h1") @[dut.scala 53:15]
    else :
      stage1_en <= UInt<1>("h0") @[dut.scala 55:15]
    when stage1_en : @[dut.scala 59:19]
      node _partialSum_T_2 = bits(regA, 31, 16) @[dut.scala 60:26]
      node _partialSum_T_3 = bits(regB, 31, 16) @[dut.scala 60:42]
      node _partialSum_T_4 = add(_partialSum_T_2, _partialSum_T_3) @[dut.scala 60:35]
      node _partialSum_T_5 = add(_partialSum_T_4, stage0_carry) @[dut.scala 60:51]
      node partialSum_1 = tail(_partialSum_T_5, 1) @[dut.scala 60:51]
      node _stage1_sum_T = bits(partialSum_1, 15, 0) @[dut.scala 61:29]
      stage1_sum <= _stage1_sum_T @[dut.scala 61:16]
      node _stage1_carry_T = bits(partialSum_1, 16, 16) @[dut.scala 62:31]
      stage1_carry <= _stage1_carry_T @[dut.scala 62:18]
      stage2_en <= UInt<1>("h1") @[dut.scala 63:15]
    else :
      stage2_en <= UInt<1>("h0") @[dut.scala 65:15]
    when stage2_en : @[dut.scala 69:19]
      node _partialSum_T_6 = bits(regA, 47, 32) @[dut.scala 70:26]
      node _partialSum_T_7 = bits(regB, 47, 32) @[dut.scala 70:42]
      node _partialSum_T_8 = add(_partialSum_T_6, _partialSum_T_7) @[dut.scala 70:35]
      node _partialSum_T_9 = add(_partialSum_T_8, stage1_carry) @[dut.scala 70:51]
      node partialSum_2 = tail(_partialSum_T_9, 1) @[dut.scala 70:51]
      node _stage2_sum_T = bits(partialSum_2, 15, 0) @[dut.scala 71:29]
      stage2_sum <= _stage2_sum_T @[dut.scala 71:16]
      node _stage2_carry_T = bits(partialSum_2, 16, 16) @[dut.scala 72:31]
      stage2_carry <= _stage2_carry_T @[dut.scala 72:18]
      stage3_en <= UInt<1>("h1") @[dut.scala 73:15]
    else :
      stage3_en <= UInt<1>("h0") @[dut.scala 75:15]
    when stage3_en : @[dut.scala 79:19]
      node _partialSum_T_10 = bits(regA, 63, 48) @[dut.scala 80:26]
      node _partialSum_T_11 = bits(regB, 63, 48) @[dut.scala 80:42]
      node _partialSum_T_12 = add(_partialSum_T_10, _partialSum_T_11) @[dut.scala 80:35]
      node _partialSum_T_13 = add(_partialSum_T_12, stage2_carry) @[dut.scala 80:51]
      node partialSum_3 = tail(_partialSum_T_13, 1) @[dut.scala 80:51]
      node _stage3_sum_T = bits(partialSum_3, 15, 0) @[dut.scala 81:29]
      stage3_sum <= _stage3_sum_T @[dut.scala 81:16]
      node _stage3_carry_T = bits(partialSum_3, 16, 16) @[dut.scala 82:31]
      stage3_carry <= _stage3_carry_T @[dut.scala 82:18]
      resultValid <= UInt<1>("h1") @[dut.scala 83:17]
    else :
      resultValid <= UInt<1>("h0") @[dut.scala 85:17]
    when resultValid : @[dut.scala 89:21]
      node resultReg_lo = cat(stage1_sum, stage0_sum) @[Cat.scala 33:92]
      node resultReg_hi_hi = cat(stage3_carry, stage3_sum) @[Cat.scala 33:92]
      node resultReg_hi = cat(resultReg_hi_hi, stage2_sum) @[Cat.scala 33:92]
      node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
      resultReg <= _resultReg_T @[dut.scala 90:15]
    io.result <= resultReg @[dut.scala 94:13]
    io.o_en <= resultValid @[dut.scala 95:11]

