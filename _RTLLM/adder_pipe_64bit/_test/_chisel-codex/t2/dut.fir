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
    reg s0Sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:24]
    reg s0Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:24]
    reg s0A1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:24]
    reg s0B1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:24]
    reg s0A2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 33:24]
    reg s0B2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:24]
    reg s0A3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:24]
    reg s0B3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:24]
    reg s1Sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 41:24]
    reg s1Sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 42:24]
    reg s1Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 43:24]
    reg s1A2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 44:24]
    reg s1B2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 45:24]
    reg s1A3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 46:24]
    reg s1B3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 47:24]
    reg s2Sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 52:24]
    reg s2Sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 53:24]
    reg s2Sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 54:24]
    reg s2Carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 55:24]
    reg s2A3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 56:24]
    reg s2B3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 57:24]
    reg resultReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 62:26]
    when io.i_en : @[dut.scala 65:17]
      node _t0_T = bits(io.adda, 15, 0) @[dut.scala 66:21]
      node _t0_T_1 = bits(io.addb, 15, 0) @[dut.scala 66:39]
      node t0 = add(_t0_T, _t0_T_1) @[dut.scala 66:29]
      node _s0Sum0_T = bits(t0, 15, 0) @[dut.scala 67:18]
      s0Sum0 <= _s0Sum0_T @[dut.scala 67:13]
      node _s0Carry_T = bits(t0, 16, 16) @[dut.scala 68:18]
      s0Carry <= _s0Carry_T @[dut.scala 68:13]
      node _s0A1_T = bits(io.adda, 31, 16) @[dut.scala 70:20]
      s0A1 <= _s0A1_T @[dut.scala 70:10]
      node _s0B1_T = bits(io.addb, 31, 16) @[dut.scala 71:20]
      s0B1 <= _s0B1_T @[dut.scala 71:10]
      node _s0A2_T = bits(io.adda, 47, 32) @[dut.scala 72:20]
      s0A2 <= _s0A2_T @[dut.scala 72:10]
      node _s0B2_T = bits(io.addb, 47, 32) @[dut.scala 73:20]
      s0B2 <= _s0B2_T @[dut.scala 73:10]
      node _s0A3_T = bits(io.adda, 63, 48) @[dut.scala 74:20]
      s0A3 <= _s0A3_T @[dut.scala 74:10]
      node _s0B3_T = bits(io.addb, 63, 48) @[dut.scala 75:20]
      s0B3 <= _s0B3_T @[dut.scala 75:10]
    else :
      s0Sum0 <= UInt<1>("h0") @[dut.scala 77:13]
      s0Carry <= UInt<1>("h0") @[dut.scala 78:13]
      s0A1 <= UInt<1>("h0") @[dut.scala 79:13]
      s0B1 <= UInt<1>("h0") @[dut.scala 80:13]
      s0A2 <= UInt<1>("h0") @[dut.scala 81:13]
      s0B2 <= UInt<1>("h0") @[dut.scala 82:13]
      s0A3 <= UInt<1>("h0") @[dut.scala 83:13]
      s0B3 <= UInt<1>("h0") @[dut.scala 84:13]
    when v0 : @[dut.scala 88:12]
      node _t1_T = add(s0A1, s0B1) @[dut.scala 89:19]
      node t1 = add(_t1_T, s0Carry) @[dut.scala 89:27]
      s1Sum0 <= s0Sum0 @[dut.scala 90:13]
      node _s1Sum1_T = bits(t1, 15, 0) @[dut.scala 91:18]
      s1Sum1 <= _s1Sum1_T @[dut.scala 91:13]
      node _s1Carry_T = bits(t1, 16, 16) @[dut.scala 92:18]
      s1Carry <= _s1Carry_T @[dut.scala 92:13]
      s1A2 <= s0A2 @[dut.scala 94:10]
      s1B2 <= s0B2 @[dut.scala 95:10]
      s1A3 <= s0A3 @[dut.scala 96:10]
      s1B3 <= s0B3 @[dut.scala 97:10]
    else :
      s1Sum0 <= UInt<1>("h0") @[dut.scala 99:13]
      s1Sum1 <= UInt<1>("h0") @[dut.scala 100:13]
      s1Carry <= UInt<1>("h0") @[dut.scala 101:13]
      s1A2 <= UInt<1>("h0") @[dut.scala 102:13]
      s1B2 <= UInt<1>("h0") @[dut.scala 103:13]
      s1A3 <= UInt<1>("h0") @[dut.scala 104:13]
      s1B3 <= UInt<1>("h0") @[dut.scala 105:13]
    when v1 : @[dut.scala 109:12]
      node _t2_T = add(s1A2, s1B2) @[dut.scala 110:19]
      node t2 = add(_t2_T, s1Carry) @[dut.scala 110:27]
      s2Sum0 <= s1Sum0 @[dut.scala 111:13]
      s2Sum1 <= s1Sum1 @[dut.scala 112:13]
      node _s2Sum2_T = bits(t2, 15, 0) @[dut.scala 113:18]
      s2Sum2 <= _s2Sum2_T @[dut.scala 113:13]
      node _s2Carry_T = bits(t2, 16, 16) @[dut.scala 114:18]
      s2Carry <= _s2Carry_T @[dut.scala 114:13]
      s2A3 <= s1A3 @[dut.scala 116:10]
      s2B3 <= s1B3 @[dut.scala 117:10]
    else :
      s2Sum0 <= UInt<1>("h0") @[dut.scala 119:13]
      s2Sum1 <= UInt<1>("h0") @[dut.scala 120:13]
      s2Sum2 <= UInt<1>("h0") @[dut.scala 121:13]
      s2Carry <= UInt<1>("h0") @[dut.scala 122:13]
      s2A3 <= UInt<1>("h0") @[dut.scala 123:13]
      s2B3 <= UInt<1>("h0") @[dut.scala 124:13]
    when v2 : @[dut.scala 128:12]
      node _t3_T = add(s2A3, s2B3) @[dut.scala 129:19]
      node t3 = add(_t3_T, s2Carry) @[dut.scala 129:27]
      node _resultReg_T = bits(t3, 16, 16) @[dut.scala 130:24]
      node _resultReg_T_1 = bits(t3, 15, 0) @[dut.scala 130:32]
      node resultReg_lo = cat(s2Sum1, s2Sum0) @[Cat.scala 33:92]
      node resultReg_hi_hi = cat(_resultReg_T, _resultReg_T_1) @[Cat.scala 33:92]
      node resultReg_hi = cat(resultReg_hi_hi, s2Sum2) @[Cat.scala 33:92]
      node _resultReg_T_2 = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
      resultReg <= _resultReg_T_2 @[dut.scala 130:15]
    else :
      resultReg <= UInt<1>("h0") @[dut.scala 132:15]
    io.result <= resultReg @[dut.scala 135:13]
    io.o_en <= v3 @[dut.scala 136:13]

