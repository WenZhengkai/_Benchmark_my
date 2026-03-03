circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:20]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    en1 <= io.i_en @[dut.scala 21:7]
    en2 <= en1 @[dut.scala 22:7]
    en3 <= en2 @[dut.scala 23:7]
    en4 <= en3 @[dut.scala 24:7]
    reg s0_sum : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:24]
    reg s0_cout : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:24]
    reg s0_a1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:22]
    reg s0_b1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 33:22]
    reg s0_a2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:22]
    reg s0_b2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:22]
    reg s0_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:22]
    reg s0_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:22]
    node _add0_T = bits(io.adda, 15, 0) @[dut.scala 39:21]
    node _add0_T_1 = bits(io.addb, 15, 0) @[dut.scala 39:39]
    node add0 = add(_add0_T, _add0_T_1) @[dut.scala 39:29]
    node _s0_sum_T = bits(add0, 15, 0) @[dut.scala 40:18]
    s0_sum <= _s0_sum_T @[dut.scala 40:11]
    node _s0_cout_T = bits(add0, 16, 16) @[dut.scala 41:18]
    s0_cout <= _s0_cout_T @[dut.scala 41:11]
    node _s0_a1_T = bits(io.adda, 31, 16) @[dut.scala 43:19]
    s0_a1 <= _s0_a1_T @[dut.scala 43:9]
    node _s0_b1_T = bits(io.addb, 31, 16) @[dut.scala 44:19]
    s0_b1 <= _s0_b1_T @[dut.scala 44:9]
    node _s0_a2_T = bits(io.adda, 47, 32) @[dut.scala 45:19]
    s0_a2 <= _s0_a2_T @[dut.scala 45:9]
    node _s0_b2_T = bits(io.addb, 47, 32) @[dut.scala 46:19]
    s0_b2 <= _s0_b2_T @[dut.scala 46:9]
    node _s0_a3_T = bits(io.adda, 63, 48) @[dut.scala 47:19]
    s0_a3 <= _s0_a3_T @[dut.scala 47:9]
    node _s0_b3_T = bits(io.addb, 63, 48) @[dut.scala 48:19]
    s0_b3 <= _s0_b3_T @[dut.scala 48:9]
    reg s1_sum : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 53:24]
    reg s1_cout : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:24]
    reg s1_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 56:24]
    reg s1_a2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 57:24]
    reg s1_b2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 58:24]
    reg s1_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 59:24]
    reg s1_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 60:24]
    node _add1_T = cat(UInt<1>("h0"), s0_a1) @[Cat.scala 33:92]
    node _add1_T_1 = cat(UInt<1>("h0"), s0_b1) @[Cat.scala 33:92]
    node _add1_T_2 = add(_add1_T, _add1_T_1) @[dut.scala 62:35]
    node _add1_T_3 = add(_add1_T_2, s0_cout) @[dut.scala 62:59]
    node add1 = tail(_add1_T_3, 1) @[dut.scala 62:59]
    node _s1_sum_T = bits(add1, 15, 0) @[dut.scala 63:18]
    s1_sum <= _s1_sum_T @[dut.scala 63:11]
    node _s1_cout_T = bits(add1, 16, 16) @[dut.scala 64:18]
    s1_cout <= _s1_cout_T @[dut.scala 64:11]
    s1_sum0 <= s0_sum @[dut.scala 66:11]
    s1_a2 <= s0_a2 @[dut.scala 67:11]
    s1_b2 <= s0_b2 @[dut.scala 68:11]
    s1_a3 <= s0_a3 @[dut.scala 69:11]
    s1_b3 <= s0_b3 @[dut.scala 70:11]
    reg s2_sum : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 75:24]
    reg s2_cout : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 76:24]
    reg s2_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 78:24]
    reg s2_sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 79:24]
    reg s2_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 80:24]
    reg s2_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 81:24]
    node _add2_T = cat(UInt<1>("h0"), s1_a2) @[Cat.scala 33:92]
    node _add2_T_1 = cat(UInt<1>("h0"), s1_b2) @[Cat.scala 33:92]
    node _add2_T_2 = add(_add2_T, _add2_T_1) @[dut.scala 83:35]
    node _add2_T_3 = add(_add2_T_2, s1_cout) @[dut.scala 83:59]
    node add2 = tail(_add2_T_3, 1) @[dut.scala 83:59]
    node _s2_sum_T = bits(add2, 15, 0) @[dut.scala 84:18]
    s2_sum <= _s2_sum_T @[dut.scala 84:11]
    node _s2_cout_T = bits(add2, 16, 16) @[dut.scala 85:18]
    s2_cout <= _s2_cout_T @[dut.scala 85:11]
    s2_sum0 <= s1_sum0 @[dut.scala 87:11]
    s2_sum1 <= s1_sum @[dut.scala 88:11]
    s2_a3 <= s1_a3 @[dut.scala 89:11]
    s2_b3 <= s1_b3 @[dut.scala 90:11]
    reg s3_sum : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 95:24]
    reg s3_cout : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 96:24]
    reg s3_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 98:24]
    reg s3_sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 99:24]
    reg s3_sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 100:24]
    node _add3_T = cat(UInt<1>("h0"), s2_a3) @[Cat.scala 33:92]
    node _add3_T_1 = cat(UInt<1>("h0"), s2_b3) @[Cat.scala 33:92]
    node _add3_T_2 = add(_add3_T, _add3_T_1) @[dut.scala 102:35]
    node _add3_T_3 = add(_add3_T_2, s2_cout) @[dut.scala 102:59]
    node add3 = tail(_add3_T_3, 1) @[dut.scala 102:59]
    node _s3_sum_T = bits(add3, 15, 0) @[dut.scala 103:18]
    s3_sum <= _s3_sum_T @[dut.scala 103:11]
    node _s3_cout_T = bits(add3, 16, 16) @[dut.scala 104:18]
    s3_cout <= _s3_cout_T @[dut.scala 104:11]
    s3_sum0 <= s2_sum0 @[dut.scala 106:11]
    s3_sum1 <= s2_sum1 @[dut.scala 107:11]
    s3_sum2 <= s2_sum @[dut.scala 108:11]
    reg resultReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 113:26]
    node resultReg_lo = cat(s3_sum1, s3_sum0) @[Cat.scala 33:92]
    node resultReg_hi_hi = cat(s3_cout, s3_sum) @[Cat.scala 33:92]
    node resultReg_hi = cat(resultReg_hi_hi, s3_sum2) @[Cat.scala 33:92]
    node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
    resultReg <= _resultReg_T @[dut.scala 114:13]
    io.result <= resultReg @[dut.scala 116:13]
    io.o_en <= en4 @[dut.scala 117:13]

