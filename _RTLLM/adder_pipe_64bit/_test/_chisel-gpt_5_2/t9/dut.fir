circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_s0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:22]
    reg en_s1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:22]
    reg en_s2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:22]
    reg en_s3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:22]
    en_s0 <= io.i_en @[dut.scala 31:9]
    en_s1 <= en_s0 @[dut.scala 32:9]
    en_s2 <= en_s1 @[dut.scala 33:9]
    en_s3 <= en_s2 @[dut.scala 34:9]
    io.o_en <= en_s3 @[dut.scala 35:11]
    reg a_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s0) @[dut.scala 38:17]
    reg b_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s0) @[dut.scala 39:17]
    reg a_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s1) @[dut.scala 41:17]
    reg b_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s1) @[dut.scala 42:17]
    reg a_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s2) @[dut.scala 44:17]
    reg b_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s2) @[dut.scala 45:17]
    reg a_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s3) @[dut.scala 47:17]
    reg b_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s3) @[dut.scala 48:17]
    a_s0 <= io.adda @[dut.scala 51:8]
    b_s0 <= io.addb @[dut.scala 52:8]
    a_s1 <= a_s0 @[dut.scala 53:8]
    b_s1 <= b_s0 @[dut.scala 54:8]
    a_s2 <= a_s1 @[dut.scala 55:8]
    b_s2 <= b_s1 @[dut.scala 56:8]
    a_s3 <= a_s2 @[dut.scala 57:8]
    b_s3 <= b_s2 @[dut.scala 58:8]
    reg sum0_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 61:25]
    reg sum1_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 62:25]
    reg sum2_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:25]
    reg sum3_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 64:25]
    reg carry0_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 65:25]
    reg carry1_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 66:25]
    reg carry2_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 67:25]
    reg carry3_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 68:25]
    node a0 = bits(a_s0, 15, 0) @[dut.scala 71:16]
    node b0 = bits(b_s0, 15, 0) @[dut.scala 72:16]
    node s0 = add(a0, b0) @[dut.scala 73:15]
    node _sum0_r_T = bits(s0, 15, 0) @[dut.scala 74:17]
    sum0_r <= _sum0_r_T @[dut.scala 74:12]
    node _carry0_r_T = bits(s0, 16, 16) @[dut.scala 75:17]
    carry0_r <= _carry0_r_T @[dut.scala 75:12]
    node a1 = bits(a_s1, 31, 16) @[dut.scala 78:16]
    node b1 = bits(b_s1, 31, 16) @[dut.scala 79:16]
    node _s1_T = add(a1, b1) @[dut.scala 80:15]
    node s1 = add(_s1_T, carry0_r) @[dut.scala 80:21]
    node _sum1_r_T = bits(s1, 15, 0) @[dut.scala 81:17]
    sum1_r <= _sum1_r_T @[dut.scala 81:12]
    node _carry1_r_T = bits(s1, 16, 16) @[dut.scala 82:17]
    carry1_r <= _carry1_r_T @[dut.scala 82:12]
    node a2 = bits(a_s2, 47, 32) @[dut.scala 85:16]
    node b2 = bits(b_s2, 47, 32) @[dut.scala 86:16]
    node _s2_T = add(a2, b2) @[dut.scala 87:15]
    node s2 = add(_s2_T, carry1_r) @[dut.scala 87:21]
    node _sum2_r_T = bits(s2, 15, 0) @[dut.scala 88:17]
    sum2_r <= _sum2_r_T @[dut.scala 88:12]
    node _carry2_r_T = bits(s2, 16, 16) @[dut.scala 89:17]
    carry2_r <= _carry2_r_T @[dut.scala 89:12]
    node a3 = bits(a_s3, 63, 48) @[dut.scala 92:16]
    node b3 = bits(b_s3, 63, 48) @[dut.scala 93:16]
    node _s3_T = add(a3, b3) @[dut.scala 94:15]
    node s3 = add(_s3_T, carry2_r) @[dut.scala 94:21]
    node _sum3_r_T = bits(s3, 15, 0) @[dut.scala 95:17]
    sum3_r <= _sum3_r_T @[dut.scala 95:12]
    node _carry3_r_T = bits(s3, 16, 16) @[dut.scala 96:17]
    carry3_r <= _carry3_r_T @[dut.scala 96:12]
    reg result_r : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 99:25]
    node result_r_lo = cat(sum1_r, sum0_r) @[Cat.scala 33:92]
    node result_r_hi_hi = cat(carry3_r, sum3_r) @[Cat.scala 33:92]
    node result_r_hi = cat(result_r_hi_hi, sum2_r) @[Cat.scala 33:92]
    node _result_r_T = cat(result_r_hi, result_r_lo) @[Cat.scala 33:92]
    result_r <= _result_r_T @[dut.scala 100:12]
    io.result <= result_r @[dut.scala 101:13]

