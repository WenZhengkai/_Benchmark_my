circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_s0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:22]
    reg a_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s0) @[dut.scala 23:18]
    reg b_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s0) @[dut.scala 24:18]
    when io.i_en : @[dut.scala 26:17]
      a_s0 <= io.adda @[dut.scala 27:10]
      b_s0 <= io.addb @[dut.scala 28:10]
    en_s0 <= io.i_en @[dut.scala 30:9]
    reg en_s1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:24]
    reg a_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s1) @[dut.scala 36:20]
    reg b_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s1) @[dut.scala 37:20]
    reg sum0_s1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_s1) @[dut.scala 38:20]
    reg c1_s1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:24]
    node _add0_T = bits(a_s0, 15, 0) @[dut.scala 41:18]
    node _add0_T_1 = bits(b_s0, 15, 0) @[dut.scala 41:33]
    node _add0_T_2 = add(_add0_T, _add0_T_1) @[dut.scala 41:26]
    node add0 = add(_add0_T_2, UInt<1>("h0")) @[dut.scala 41:41]
    when en_s0 : @[dut.scala 43:15]
      a_s1 <= a_s0 @[dut.scala 44:13]
      b_s1 <= b_s0 @[dut.scala 45:13]
      node _sum0_s1_T = bits(add0, 15, 0) @[dut.scala 46:20]
      sum0_s1 <= _sum0_s1_T @[dut.scala 46:13]
      node _c1_s1_T = bits(add0, 16, 16) @[dut.scala 47:20]
      c1_s1 <= _c1_s1_T @[dut.scala 47:13]
    en_s1 <= en_s0 @[dut.scala 49:9]
    reg en_s2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:25]
    reg a_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s2) @[dut.scala 55:21]
    reg b_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s2) @[dut.scala 56:21]
    reg sum0_s2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_s2) @[dut.scala 57:21]
    reg sum1_s2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum1_s2) @[dut.scala 58:21]
    reg c2_s2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 59:25]
    node _add1_T = bits(a_s1, 31, 16) @[dut.scala 61:18]
    node _add1_T_1 = bits(b_s1, 31, 16) @[dut.scala 61:34]
    node _add1_T_2 = add(_add1_T, _add1_T_1) @[dut.scala 61:27]
    node add1 = add(_add1_T_2, c1_s1) @[dut.scala 61:43]
    when en_s1 : @[dut.scala 63:15]
      a_s2 <= a_s1 @[dut.scala 64:13]
      b_s2 <= b_s1 @[dut.scala 65:13]
      sum0_s2 <= sum0_s1 @[dut.scala 66:13]
      node _sum1_s2_T = bits(add1, 15, 0) @[dut.scala 67:20]
      sum1_s2 <= _sum1_s2_T @[dut.scala 67:13]
      node _c2_s2_T = bits(add1, 16, 16) @[dut.scala 68:20]
      c2_s2 <= _c2_s2_T @[dut.scala 68:13]
    en_s2 <= en_s1 @[dut.scala 70:9]
    reg en_s3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 75:25]
    reg a_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s3) @[dut.scala 76:21]
    reg b_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s3) @[dut.scala 77:21]
    reg sum0_s3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_s3) @[dut.scala 78:21]
    reg sum1_s3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum1_s3) @[dut.scala 79:21]
    reg sum2_s3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum2_s3) @[dut.scala 80:21]
    reg c3_s3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 81:25]
    node _add2_T = bits(a_s2, 47, 32) @[dut.scala 83:18]
    node _add2_T_1 = bits(b_s2, 47, 32) @[dut.scala 83:34]
    node _add2_T_2 = add(_add2_T, _add2_T_1) @[dut.scala 83:27]
    node add2 = add(_add2_T_2, c2_s2) @[dut.scala 83:43]
    when en_s2 : @[dut.scala 85:15]
      a_s3 <= a_s2 @[dut.scala 86:13]
      b_s3 <= b_s2 @[dut.scala 87:13]
      sum0_s3 <= sum0_s2 @[dut.scala 88:13]
      sum1_s3 <= sum1_s2 @[dut.scala 89:13]
      node _sum2_s3_T = bits(add2, 15, 0) @[dut.scala 90:20]
      sum2_s3 <= _sum2_s3_T @[dut.scala 90:13]
      node _c3_s3_T = bits(add2, 16, 16) @[dut.scala 91:20]
      c3_s3 <= _c3_s3_T @[dut.scala 91:13]
    en_s3 <= en_s2 @[dut.scala 93:9]
    reg en_s4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 98:24]
    reg res_s4 : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 99:24]
    node _add3_T = bits(a_s3, 63, 48) @[dut.scala 101:18]
    node _add3_T_1 = bits(b_s3, 63, 48) @[dut.scala 101:34]
    node _add3_T_2 = add(_add3_T, _add3_T_1) @[dut.scala 101:27]
    node add3 = add(_add3_T_2, c3_s3) @[dut.scala 101:43]
    node sum3 = bits(add3, 15, 0) @[dut.scala 102:18]
    node c4 = bits(add3, 16, 16) @[dut.scala 103:18]
    when en_s3 : @[dut.scala 105:15]
      node res_s4_lo = cat(sum1_s3, sum0_s3) @[Cat.scala 33:92]
      node res_s4_hi_hi = cat(c4, sum3) @[Cat.scala 33:92]
      node res_s4_hi = cat(res_s4_hi_hi, sum2_s3) @[Cat.scala 33:92]
      node _res_s4_T = cat(res_s4_hi, res_s4_lo) @[Cat.scala 33:92]
      res_s4 <= _res_s4_T @[dut.scala 106:12]
    en_s4 <= en_s3 @[dut.scala 108:9]
    io.result <= res_s4 @[dut.scala 110:13]
    io.o_en <= en_s4 @[dut.scala 111:13]

