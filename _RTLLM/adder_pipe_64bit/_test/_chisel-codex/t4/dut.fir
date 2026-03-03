circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg v0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:19]
    reg v1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:19]
    reg v2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:19]
    reg v3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:19]
    v0 <= io.i_en @[dut.scala 21:6]
    v1 <= v0 @[dut.scala 22:6]
    v2 <= v1 @[dut.scala 23:6]
    v3 <= v2 @[dut.scala 24:6]
    reg s0_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:25]
    reg s0_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:25]
    reg s0_a1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:25]
    reg s0_b1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:25]
    reg s0_a2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 33:25]
    reg s0_b2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:25]
    reg s0_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:25]
    reg s0_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:25]
    when io.i_en : @[dut.scala 38:17]
      node _add0_T = bits(io.adda, 15, 0) @[dut.scala 39:23]
      node _add0_T_1 = bits(io.addb, 15, 0) @[dut.scala 39:41]
      node add0 = add(_add0_T, _add0_T_1) @[dut.scala 39:31]
      node _s0_sum0_T = bits(add0, 15, 0) @[dut.scala 40:21]
      s0_sum0 <= _s0_sum0_T @[dut.scala 40:14]
      node _s0_carry_T = bits(add0, 16, 16) @[dut.scala 41:21]
      s0_carry <= _s0_carry_T @[dut.scala 41:14]
      node _s0_a1_T = bits(io.adda, 31, 16) @[dut.scala 43:21]
      s0_a1 <= _s0_a1_T @[dut.scala 43:11]
      node _s0_b1_T = bits(io.addb, 31, 16) @[dut.scala 44:21]
      s0_b1 <= _s0_b1_T @[dut.scala 44:11]
      node _s0_a2_T = bits(io.adda, 47, 32) @[dut.scala 45:21]
      s0_a2 <= _s0_a2_T @[dut.scala 45:11]
      node _s0_b2_T = bits(io.addb, 47, 32) @[dut.scala 46:21]
      s0_b2 <= _s0_b2_T @[dut.scala 46:11]
      node _s0_a3_T = bits(io.adda, 63, 48) @[dut.scala 47:21]
      s0_a3 <= _s0_a3_T @[dut.scala 47:11]
      node _s0_b3_T = bits(io.addb, 63, 48) @[dut.scala 48:21]
      s0_b3 <= _s0_b3_T @[dut.scala 48:11]
    reg s1_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 54:25]
    reg s1_sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 55:25]
    reg s1_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 56:25]
    reg s1_a2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 57:25]
    reg s1_b2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 58:25]
    reg s1_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 59:25]
    reg s1_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 60:25]
    when v0 : @[dut.scala 62:12]
      node _add1_T = add(s0_a1, s0_b1) @[dut.scala 63:22]
      node add1 = add(_add1_T, s0_carry) @[dut.scala 63:31]
      s1_sum0 <= s0_sum0 @[dut.scala 64:14]
      node _s1_sum1_T = bits(add1, 15, 0) @[dut.scala 65:21]
      s1_sum1 <= _s1_sum1_T @[dut.scala 65:14]
      node _s1_carry_T = bits(add1, 16, 16) @[dut.scala 66:21]
      s1_carry <= _s1_carry_T @[dut.scala 66:14]
      s1_a2 <= s0_a2 @[dut.scala 68:11]
      s1_b2 <= s0_b2 @[dut.scala 69:11]
      s1_a3 <= s0_a3 @[dut.scala 70:11]
      s1_b3 <= s0_b3 @[dut.scala 71:11]
    reg s2_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 77:25]
    reg s2_sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 78:25]
    reg s2_sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 79:25]
    reg s2_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 80:25]
    reg s2_a3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 81:25]
    reg s2_b3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 82:25]
    when v1 : @[dut.scala 84:12]
      node _add2_T = add(s1_a2, s1_b2) @[dut.scala 85:22]
      node add2 = add(_add2_T, s1_carry) @[dut.scala 85:31]
      s2_sum0 <= s1_sum0 @[dut.scala 86:14]
      s2_sum1 <= s1_sum1 @[dut.scala 87:14]
      node _s2_sum2_T = bits(add2, 15, 0) @[dut.scala 88:21]
      s2_sum2 <= _s2_sum2_T @[dut.scala 88:14]
      node _s2_carry_T = bits(add2, 16, 16) @[dut.scala 89:21]
      s2_carry <= _s2_carry_T @[dut.scala 89:14]
      s2_a3 <= s1_a3 @[dut.scala 91:11]
      s2_b3 <= s1_b3 @[dut.scala 92:11]
    reg resultReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 98:26]
    when v2 : @[dut.scala 100:12]
      node _add3_T = add(s2_a3, s2_b3) @[dut.scala 101:22]
      node add3 = add(_add3_T, s2_carry) @[dut.scala 101:31]
      node sum3 = bits(add3, 15, 0) @[dut.scala 102:20]
      node cOut = bits(add3, 16, 16) @[dut.scala 103:20]
      node resultReg_lo = cat(s2_sum1, s2_sum0) @[Cat.scala 33:92]
      node resultReg_hi_hi = cat(cOut, sum3) @[Cat.scala 33:92]
      node resultReg_hi = cat(resultReg_hi_hi, s2_sum2) @[Cat.scala 33:92]
      node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
      resultReg <= _resultReg_T @[dut.scala 105:15]
    io.result <= resultReg @[dut.scala 108:13]
    io.o_en <= v3 @[dut.scala 109:13]

