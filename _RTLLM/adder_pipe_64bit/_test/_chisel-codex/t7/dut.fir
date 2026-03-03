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
    io.o_en <= v3 @[dut.scala 26:11]
    reg a1_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a1_d1) @[dut.scala 31:18]
    reg b1_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b1_d1) @[dut.scala 32:18]
    reg a2_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a2_d1) @[dut.scala 34:18]
    reg b2_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b2_d1) @[dut.scala 35:18]
    reg a2_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a2_d2) @[dut.scala 36:18]
    reg b2_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b2_d2) @[dut.scala 37:18]
    reg a3_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a3_d1) @[dut.scala 39:18]
    reg b3_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b3_d1) @[dut.scala 40:18]
    reg a3_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a3_d2) @[dut.scala 41:18]
    reg b3_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b3_d2) @[dut.scala 42:18]
    reg a3_d3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), a3_d3) @[dut.scala 43:18]
    reg b3_d3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), b3_d3) @[dut.scala 44:18]
    node _a1_d1_T = bits(io.adda, 31, 16) @[dut.scala 46:19]
    a1_d1 <= _a1_d1_T @[dut.scala 46:9]
    node _b1_d1_T = bits(io.addb, 31, 16) @[dut.scala 47:19]
    b1_d1 <= _b1_d1_T @[dut.scala 47:9]
    node _a2_d1_T = bits(io.adda, 47, 32) @[dut.scala 49:19]
    a2_d1 <= _a2_d1_T @[dut.scala 49:9]
    node _b2_d1_T = bits(io.addb, 47, 32) @[dut.scala 50:19]
    b2_d1 <= _b2_d1_T @[dut.scala 50:9]
    a2_d2 <= a2_d1 @[dut.scala 51:9]
    b2_d2 <= b2_d1 @[dut.scala 52:9]
    node _a3_d1_T = bits(io.adda, 63, 48) @[dut.scala 54:19]
    a3_d1 <= _a3_d1_T @[dut.scala 54:9]
    node _b3_d1_T = bits(io.addb, 63, 48) @[dut.scala 55:19]
    b3_d1 <= _b3_d1_T @[dut.scala 55:9]
    a3_d2 <= a3_d1 @[dut.scala 56:9]
    b3_d2 <= b3_d1 @[dut.scala 57:9]
    a3_d3 <= a3_d2 @[dut.scala 58:9]
    b3_d3 <= b3_d2 @[dut.scala 59:9]
    node _s0_T = bits(io.adda, 15, 0) @[dut.scala 64:19]
    node _s0_T_1 = bits(io.addb, 15, 0) @[dut.scala 64:37]
    node s0 = add(_s0_T, _s0_T_1) @[dut.scala 64:27]
    reg sum0_r : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_r) @[dut.scala 65:21]
    reg carry0_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry0_r) @[dut.scala 66:21]
    node _sum0_r_T = bits(s0, 15, 0) @[dut.scala 67:17]
    sum0_r <= _sum0_r_T @[dut.scala 67:12]
    node _carry0_r_T = bits(s0, 16, 16) @[dut.scala 68:17]
    carry0_r <= _carry0_r_T @[dut.scala 68:12]
    node _s1_T = add(a1_d1, b1_d1) @[dut.scala 73:18]
    node s1 = add(_s1_T, carry0_r) @[dut.scala 73:27]
    reg sum1_r : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum1_r) @[dut.scala 74:21]
    reg carry1_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry1_r) @[dut.scala 75:21]
    node _sum1_r_T = bits(s1, 15, 0) @[dut.scala 76:17]
    sum1_r <= _sum1_r_T @[dut.scala 76:12]
    node _carry1_r_T = bits(s1, 16, 16) @[dut.scala 77:17]
    carry1_r <= _carry1_r_T @[dut.scala 77:12]
    node _s2_T = add(a2_d2, b2_d2) @[dut.scala 82:18]
    node s2 = add(_s2_T, carry1_r) @[dut.scala 82:27]
    reg sum2_r : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum2_r) @[dut.scala 83:21]
    reg carry2_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry2_r) @[dut.scala 84:21]
    node _sum2_r_T = bits(s2, 15, 0) @[dut.scala 85:17]
    sum2_r <= _sum2_r_T @[dut.scala 85:12]
    node _carry2_r_T = bits(s2, 16, 16) @[dut.scala 86:17]
    carry2_r <= _carry2_r_T @[dut.scala 86:12]
    node _s3_T = add(a3_d3, b3_d3) @[dut.scala 91:18]
    node s3 = add(_s3_T, carry2_r) @[dut.scala 91:27]
    reg sum3_r : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum3_r) @[dut.scala 92:21]
    reg carry3_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry3_r) @[dut.scala 93:21]
    node _sum3_r_T = bits(s3, 15, 0) @[dut.scala 94:17]
    sum3_r <= _sum3_r_T @[dut.scala 94:12]
    node _carry3_r_T = bits(s3, 16, 16) @[dut.scala 95:17]
    carry3_r <= _carry3_r_T @[dut.scala 95:12]
    reg sum0_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_d1) @[dut.scala 100:20]
    reg sum0_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_d2) @[dut.scala 101:20]
    reg sum0_d3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum0_d3) @[dut.scala 102:20]
    reg sum1_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum1_d1) @[dut.scala 104:20]
    reg sum1_d2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum1_d2) @[dut.scala 105:20]
    reg sum2_d1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum2_d1) @[dut.scala 107:20]
    sum0_d1 <= sum0_r @[dut.scala 109:11]
    sum0_d2 <= sum0_d1 @[dut.scala 110:11]
    sum0_d3 <= sum0_d2 @[dut.scala 111:11]
    sum1_d1 <= sum1_r @[dut.scala 113:11]
    sum1_d2 <= sum1_d1 @[dut.scala 114:11]
    sum2_d1 <= sum2_r @[dut.scala 116:11]
    node io_result_lo = cat(sum1_d2, sum0_d3) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry3_r, sum3_r) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2_d1) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 118:13]

