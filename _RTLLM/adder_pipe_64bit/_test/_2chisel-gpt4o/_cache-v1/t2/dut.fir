circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg regA0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 15:22]
    reg regA1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 16:22]
    reg regA2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 17:22]
    reg regA3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 18:22]
    reg regB0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 20:22]
    reg regB1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 21:22]
    reg regB2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 22:22]
    reg regB3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 23:22]
    reg regC0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:22]
    reg regC1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:22]
    reg regC2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:22]
    reg regSum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:24]
    reg regSum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 30:24]
    reg regSum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:24]
    reg regSum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:24]
    reg regSumCarry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 33:28]
    reg regEnable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:26]
    reg regEnableDelayed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 36:33]
    node _chunkA_T = bits(io.adda, 15, 0) @[dut.scala 39:31]
    node _chunkA_T_1 = bits(io.adda, 31, 16) @[dut.scala 39:47]
    node _chunkA_T_2 = bits(io.adda, 47, 32) @[dut.scala 39:64]
    node _chunkA_T_3 = bits(io.adda, 63, 48) @[dut.scala 39:81]
    wire chunkA : UInt<16>[4] @[dut.scala 39:23]
    chunkA[0] <= _chunkA_T @[dut.scala 39:23]
    chunkA[1] <= _chunkA_T_1 @[dut.scala 39:23]
    chunkA[2] <= _chunkA_T_2 @[dut.scala 39:23]
    chunkA[3] <= _chunkA_T_3 @[dut.scala 39:23]
    node _chunkB_T = bits(io.addb, 15, 0) @[dut.scala 40:31]
    node _chunkB_T_1 = bits(io.addb, 31, 16) @[dut.scala 40:47]
    node _chunkB_T_2 = bits(io.addb, 47, 32) @[dut.scala 40:64]
    node _chunkB_T_3 = bits(io.addb, 63, 48) @[dut.scala 40:81]
    wire chunkB : UInt<16>[4] @[dut.scala 40:23]
    chunkB[0] <= _chunkB_T @[dut.scala 40:23]
    chunkB[1] <= _chunkB_T_1 @[dut.scala 40:23]
    chunkB[2] <= _chunkB_T_2 @[dut.scala 40:23]
    chunkB[3] <= _chunkB_T_3 @[dut.scala 40:23]
    when io.i_en : @[dut.scala 43:17]
      regA0 <= chunkA[0] @[dut.scala 44:11]
      regB0 <= chunkB[0] @[dut.scala 45:11]
      regEnable <= io.i_en @[dut.scala 46:15]
    when regEnable : @[dut.scala 48:19]
      node sum0 = add(regA0, regB0) @[dut.scala 49:22]
      node _regSum0_T = bits(sum0, 15, 0) @[dut.scala 50:20]
      regSum0 <= _regSum0_T @[dut.scala 50:13]
      node _regC0_T = bits(sum0, 16, 16) @[dut.scala 51:18]
      regC0 <= _regC0_T @[dut.scala 51:11]
    when regEnable : @[dut.scala 55:19]
      regA1 <= chunkA[1] @[dut.scala 56:11]
      regB1 <= chunkB[1] @[dut.scala 57:11]
      regEnableDelayed <= regEnable @[dut.scala 58:22]
    when regEnableDelayed : @[dut.scala 60:26]
      node _sum1_T = add(regA1, regB1) @[dut.scala 61:22]
      node _sum1_T_1 = add(_sum1_T, regC0) @[dut.scala 61:31]
      node sum1 = tail(_sum1_T_1, 1) @[dut.scala 61:31]
      node _regSum1_T = bits(sum1, 15, 0) @[dut.scala 62:20]
      regSum1 <= _regSum1_T @[dut.scala 62:13]
      node _regC1_T = bits(sum1, 16, 16) @[dut.scala 63:18]
      regC1 <= _regC1_T @[dut.scala 63:11]
    when regEnableDelayed : @[dut.scala 67:26]
      regA2 <= chunkA[2] @[dut.scala 68:11]
      regB2 <= chunkB[2] @[dut.scala 69:11]
    when regEnableDelayed : @[dut.scala 71:26]
      node _sum2_T = add(regA2, regB2) @[dut.scala 72:22]
      node _sum2_T_1 = add(_sum2_T, regC1) @[dut.scala 72:31]
      node sum2 = tail(_sum2_T_1, 1) @[dut.scala 72:31]
      node _regSum2_T = bits(sum2, 15, 0) @[dut.scala 73:20]
      regSum2 <= _regSum2_T @[dut.scala 73:13]
      node _regC2_T = bits(sum2, 16, 16) @[dut.scala 74:18]
      regC2 <= _regC2_T @[dut.scala 74:11]
    when regEnableDelayed : @[dut.scala 78:26]
      regA3 <= chunkA[3] @[dut.scala 79:11]
      regB3 <= chunkB[3] @[dut.scala 80:11]
    when regEnableDelayed : @[dut.scala 82:26]
      node _sum3_T = add(regA3, regB3) @[dut.scala 83:22]
      node _sum3_T_1 = add(_sum3_T, regC2) @[dut.scala 83:31]
      node sum3 = tail(_sum3_T_1, 1) @[dut.scala 83:31]
      node _regSum3_T = bits(sum3, 15, 0) @[dut.scala 84:20]
      regSum3 <= _regSum3_T @[dut.scala 84:13]
      node _regSumCarry_T = bits(sum3, 16, 16) @[dut.scala 85:24]
      regSumCarry <= _regSumCarry_T @[dut.scala 85:17]
    node io_result_lo = cat(regSum1, regSum0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(regSumCarry, regSum3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, regSum2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 89:13]
    io.o_en <= regEnableDelayed @[dut.scala 90:11]

