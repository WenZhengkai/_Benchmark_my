circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:22]
    reg a0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a0) @[dut.scala 22:18]
    reg b0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b0) @[dut.scala 23:18]
    reg sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 24:22]
    reg c0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:22]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:22]
    reg a1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a1) @[dut.scala 29:18]
    reg b1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b1) @[dut.scala 30:18]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:22]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 32:22]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:22]
    reg a2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a2) @[dut.scala 36:18]
    reg b2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b2) @[dut.scala 37:18]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 38:22]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:22]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:22]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 43:22]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:22]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 47:22]
    reg resR : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 48:22]
    io.result <= resR @[dut.scala 51:13]
    io.o_en <= en4 @[dut.scala 52:13]
    node _T = bits(io.adda, 15, 0) @[dut.scala 64:32]
    node _T_1 = bits(io.addb, 15, 0) @[dut.scala 64:48]
    wire full : UInt<17> @[dut.scala 56:20]
    node _full_T = add(_T, _T_1) @[dut.scala 57:15]
    node _full_T_1 = add(_full_T, UInt<1>("h0")) @[dut.scala 57:20]
    full <= _full_T_1 @[dut.scala 57:10]
    node s0 = bits(full, 15, 0) @[dut.scala 58:10]
    node co0 = bits(full, 16, 16) @[dut.scala 58:23]
    when io.i_en : @[dut.scala 66:17]
      a0 <= io.adda @[dut.scala 67:10]
      b0 <= io.addb @[dut.scala 68:10]
      sum0 <= s0 @[dut.scala 69:10]
      c0 <= co0 @[dut.scala 70:10]
    en0 <= io.i_en @[dut.scala 72:7]
    node _T_2 = bits(a0, 31, 16) @[dut.scala 77:27]
    node _T_3 = bits(b0, 31, 16) @[dut.scala 77:39]
    wire full_1 : UInt<17> @[dut.scala 56:20]
    node _full_T_2 = add(_T_2, _T_3) @[dut.scala 57:15]
    node _full_T_3 = add(_full_T_2, c0) @[dut.scala 57:20]
    full_1 <= _full_T_3 @[dut.scala 57:10]
    node s1 = bits(full_1, 15, 0) @[dut.scala 58:10]
    node co1 = bits(full_1, 16, 16) @[dut.scala 58:23]
    when en0 : @[dut.scala 79:13]
      a1 <= a0 @[dut.scala 80:10]
      b1 <= b0 @[dut.scala 81:10]
      sum1 <= s1 @[dut.scala 82:10]
      c1 <= co1 @[dut.scala 83:10]
    en1 <= en0 @[dut.scala 85:7]
    node _T_4 = bits(a1, 47, 32) @[dut.scala 90:27]
    node _T_5 = bits(b1, 47, 32) @[dut.scala 90:39]
    wire full_2 : UInt<17> @[dut.scala 56:20]
    node _full_T_4 = add(_T_4, _T_5) @[dut.scala 57:15]
    node _full_T_5 = add(_full_T_4, c1) @[dut.scala 57:20]
    full_2 <= _full_T_5 @[dut.scala 57:10]
    node s2 = bits(full_2, 15, 0) @[dut.scala 58:10]
    node co2 = bits(full_2, 16, 16) @[dut.scala 58:23]
    when en1 : @[dut.scala 92:13]
      a2 <= a1 @[dut.scala 93:10]
      b2 <= b1 @[dut.scala 94:10]
      sum2 <= s2 @[dut.scala 95:10]
      c2 <= co2 @[dut.scala 96:10]
    en2 <= en1 @[dut.scala 98:7]
    node _T_6 = bits(a2, 63, 48) @[dut.scala 103:27]
    node _T_7 = bits(b2, 63, 48) @[dut.scala 103:39]
    wire full_3 : UInt<17> @[dut.scala 56:20]
    node _full_T_6 = add(_T_6, _T_7) @[dut.scala 57:15]
    node _full_T_7 = add(_full_T_6, c2) @[dut.scala 57:20]
    full_3 <= _full_T_7 @[dut.scala 57:10]
    node s3 = bits(full_3, 15, 0) @[dut.scala 58:10]
    node co3 = bits(full_3, 16, 16) @[dut.scala 58:23]
    when en2 : @[dut.scala 105:13]
      sum3 <= s3 @[dut.scala 106:10]
      c3 <= co3 @[dut.scala 107:10]
    en3 <= en2 @[dut.scala 109:7]
    when en3 : @[dut.scala 114:13]
      node resR_lo = cat(sum1, sum0) @[Cat.scala 33:92]
      node resR_hi_hi = cat(c3, sum3) @[Cat.scala 33:92]
      node resR_hi = cat(resR_hi_hi, sum2) @[Cat.scala 33:92]
      node _resR_T = cat(resR_hi, resR_lo) @[Cat.scala 33:92]
      resR <= _resR_T @[dut.scala 115:10]
    en4 <= en3 @[dut.scala 117:7]

