circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    en0 <= io.i_en @[dut.scala 21:7]
    en1 <= en0 @[dut.scala 22:7]
    en2 <= en1 @[dut.scala 23:7]
    en3 <= en2 @[dut.scala 24:7]
    reg s0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:19]
    reg c0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:19]
    reg a1_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:21]
    reg b1_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 33:21]
    reg a2_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:21]
    reg b2_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:21]
    reg a3_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:21]
    reg b3_0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:21]
    when io.i_en : @[dut.scala 39:17]
      node _add0_T = bits(io.adda, 15, 0) @[dut.scala 40:23]
      node _add0_T_1 = bits(io.addb, 15, 0) @[dut.scala 40:41]
      node add0 = add(_add0_T, _add0_T_1) @[dut.scala 40:31]
      node _s0_T = bits(add0, 15, 0) @[dut.scala 41:15]
      s0 <= _s0_T @[dut.scala 41:8]
      node _c0_T = bits(add0, 16, 16) @[dut.scala 42:15]
      c0 <= _c0_T @[dut.scala 42:8]
      node _a1_0_T = bits(io.adda, 31, 16) @[dut.scala 44:20]
      a1_0 <= _a1_0_T @[dut.scala 44:10]
      node _b1_0_T = bits(io.addb, 31, 16) @[dut.scala 45:20]
      b1_0 <= _b1_0_T @[dut.scala 45:10]
      node _a2_0_T = bits(io.adda, 47, 32) @[dut.scala 46:20]
      a2_0 <= _a2_0_T @[dut.scala 46:10]
      node _b2_0_T = bits(io.addb, 47, 32) @[dut.scala 47:20]
      b2_0 <= _b2_0_T @[dut.scala 47:10]
      node _a3_0_T = bits(io.adda, 63, 48) @[dut.scala 48:20]
      a3_0 <= _a3_0_T @[dut.scala 48:10]
      node _b3_0_T = bits(io.addb, 63, 48) @[dut.scala 49:20]
      b3_0 <= _b3_0_T @[dut.scala 49:10]
    reg s1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 55:19]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 56:19]
    reg a2_1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 58:21]
    reg b2_1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 59:21]
    reg a3_1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 60:21]
    reg b3_1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 61:21]
    reg s0_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:22]
    when en0 : @[dut.scala 65:13]
      node _add1_T = add(a1_0, b1_0) @[dut.scala 66:21]
      node _add1_T_1 = add(_add1_T, c0) @[dut.scala 66:29]
      node add1 = tail(_add1_T_1, 1) @[dut.scala 66:29]
      node _s1_T = bits(add1, 15, 0) @[dut.scala 67:15]
      s1 <= _s1_T @[dut.scala 67:8]
      node _c1_T = bits(add1, 16, 16) @[dut.scala 68:15]
      c1 <= _c1_T @[dut.scala 68:8]
      a2_1 <= a2_0 @[dut.scala 70:10]
      b2_1 <= b2_0 @[dut.scala 71:10]
      a3_1 <= a3_0 @[dut.scala 72:10]
      b3_1 <= b3_0 @[dut.scala 73:10]
      s0_d1 <= s0 @[dut.scala 75:11]
    reg s2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 81:19]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 82:19]
    reg a3_2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 84:21]
    reg b3_2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 85:21]
    reg s0_d2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 87:22]
    reg s1_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 88:22]
    when en1 : @[dut.scala 90:13]
      node _add2_T = add(a2_1, b2_1) @[dut.scala 91:21]
      node _add2_T_1 = add(_add2_T, c1) @[dut.scala 91:29]
      node add2 = tail(_add2_T_1, 1) @[dut.scala 91:29]
      node _s2_T = bits(add2, 15, 0) @[dut.scala 92:15]
      s2 <= _s2_T @[dut.scala 92:8]
      node _c2_T = bits(add2, 16, 16) @[dut.scala 93:15]
      c2 <= _c2_T @[dut.scala 93:8]
      a3_2 <= a3_1 @[dut.scala 95:10]
      b3_2 <= b3_1 @[dut.scala 96:10]
      s0_d2 <= s0_d1 @[dut.scala 98:11]
      s1_d1 <= s1 @[dut.scala 99:11]
    reg s3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 105:19]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 106:19]
    reg s0_d3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 108:22]
    reg s1_d2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 109:22]
    reg s2_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 110:22]
    when en2 : @[dut.scala 112:13]
      node _add3_T = add(a3_2, b3_2) @[dut.scala 113:21]
      node _add3_T_1 = add(_add3_T, c2) @[dut.scala 113:29]
      node add3 = tail(_add3_T_1, 1) @[dut.scala 113:29]
      node _s3_T = bits(add3, 15, 0) @[dut.scala 114:15]
      s3 <= _s3_T @[dut.scala 114:8]
      node _c3_T = bits(add3, 16, 16) @[dut.scala 115:15]
      c3 <= _c3_T @[dut.scala 115:8]
      s0_d3 <= s0_d2 @[dut.scala 117:11]
      s1_d2 <= s1_d1 @[dut.scala 118:11]
      s2_d1 <= s2 @[dut.scala 119:11]
    reg resultReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 125:26]
    reg oEnReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 126:26]
    oEnReg <= en3 @[dut.scala 128:10]
    when en3 : @[dut.scala 129:13]
      node resultReg_lo = cat(s1_d2, s0_d3) @[Cat.scala 33:92]
      node resultReg_hi_hi = cat(c3, s3) @[Cat.scala 33:92]
      node resultReg_hi = cat(resultReg_hi_hi, s2_d1) @[Cat.scala 33:92]
      node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
      resultReg <= _resultReg_T @[dut.scala 130:15]
    io.result <= resultReg @[dut.scala 133:13]
    io.o_en <= oEnReg @[dut.scala 134:13]

